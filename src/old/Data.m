classdef Data < handle
    %Data represents a simple object as a data container with only one
    %property exposing precomputed data depending on a setting.
    properties (SetObservable = true)
        current_data  % Current Data to plot
       
        % Set the current data to report
        % Valid options are 'peaks', 'membrane' or 'sinc'
        selected_data = 'peaks' %The above comments are exposed shown doc.
    end
    properties (SetAccess = private, Hidden = true)
        peaks %Precomputed peaks data
        membrane %Precomputed membrane data
        sinc %Precomputed sinc data
    end
    events
        dataChanged % The exposed data has changed
        selecterror % An error occurred
    end
    methods
        function obj = Data(varargin) %Initialise the object
            obj.peaks=peaks(35);
            obj.membrane=membrane;
            [x,y] = meshgrid(-8:.5:8);
            r = sqrt(x.^2+y.^2) + eps;
            sinc = sin(r)./r;
            obj.sinc = sinc;
        end
        function data = get.current_data(obj)
            %This code runs upon access of property
            switch obj.selected_data
                case 'peaks'
                    data = obj.peaks;
                case 'membrane'
                    data = obj.membrane;
                case 'sinc'
                    data = obj.sinc;
            end
        end
        function set.selected_data(obj, selection)
            if ismember(selection, ['peaks' 'membrane' 'sinc'])
                obj.selected_data = selection;
                notify(obj,'dataChanged'); %Notify event (and anything listening), that the selected data has changed
            else
                notify(obj,'selecterror')% Notify that an error has occured
                errordlg('Selected data must be ''peaks'', ''membrane'' or ''sinc'''); %Print to command window
            end
        end
    end %method
end %Object