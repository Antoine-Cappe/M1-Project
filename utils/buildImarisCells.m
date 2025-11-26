%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                              BIOCAD Program
%                               Release 1.0
%
%   Authors: Dalmas Eugenie - Arbache Remi
%
%   Release 1.0 : April 2021
%
%   Function : Create the approximated IMS cells to a COMSOL model
%
%   Called by : Biocad
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create the approximated cells from IMARIS to a COMSOL model.
% Inputs:
%   app - Application calling the function
%   isSaved - Bool true if want to create a .mph file copy of the system with the added cells
% Output:
%   systemModel - COMSOL model where the cells are added
function [systemModel] = buildImarisCells(app, isSaved)
    % Verify if IMARIS cells exits from the interface
    if app.cells.filename == ""
        disp("ERROR : Cannot builds cells that does not exist, cells not imported to BIOCAD interface");
        return
    end
    
    % Handle referential shifts
    imsRef = 0; % initialize
    childrenTags = string(app.loadedModel.model.geom('geom1').feature().tags);
    for i = 1:length(childrenTags)
        label = string(app.loadedModel.model.geom('geom1').obj(childrenTags(i)).label);
        if contains(label, "Pt_imaris_referential")
            imsRef = app.loadedModel.model.geom('geom1').feature(childrenTags(i));
        end
    end
    % Check Referential Point existence
    if imsRef ~= 0
        % Referential point defined
        imsRef_prop = mphgetproperties(imsRef);
        imsRef_pos = imsRef_prop.p; % char vector
        imsRef_pos = split(string(imsRef_pos), ','); % string array
        positionShifts = [(str2num(imsRef_pos(1)) - app.DistanceToReferentialEditField_X.Value) ...
            (str2num(imsRef_pos(2)) - app.DistanceToReferentialEditField_Y.Value) ...
            (str2num(imsRef_pos(3)) - app.DistanceToReferentialEditField_Z.Value)];
    else
        % Cannot add cells if no referential is defined : physical component superposition problem
        uilalert(app.UIFigure, "No referential point has been defined, cannot add IMARIS cells.", "", "Modal", true);
        return
    end
    
    % Load a base COMSOL model
    if isSaved
        % Create a copy of the .mph file to save modifications
        source = app.loadedModel.path; % retrieve system model path
        [modelfolder,modelname,~] = fileparts(source); 
        destination = sprintf("%s\\%s_with_%s_imaris_cells.mph", modelfolder, modelname, app.cells.filename); % copy of .mph has the same name with imaris specified, in the same directory
        copyfile(source, destination, 'f'); % copy the .mph file
        systemModel = mphopen(convertStringsToChars(destination));
        disp(destination);
    else
        % System model loaded
        % systemModel = mphload(app.loadedModel.path);
        systemModel = app.loadedModel.model;
    end
    
    % Add ellipsoidal cells to global model (run each cells)
    for i = 1:app.cells.number
        % Get needed properties of loaded IMARIS cells
        position = app.cells.pos;
        axisA = app.cells.direction.A;
        size = app.cells.size;
        
        % Apply referential shifts to the position of each cell
        position.X(i) = position.X(i) + positionShifts(1);
        position.Y(i) = position.Y(i) + positionShifts(2);
        position.Z(i) = position.Z(i) + positionShifts(3);
        
        ellipsoidLabel = convertStringsToChars(sprintf("Cell_%d", i)); % name each ellipsoid to Cell_i
        
        systemModel.component('comp1').geom('geom1').create(ellipsoidLabel, 'Ellipsoid'); % Create cell
        systemModel.component('comp1').geom('geom1').feature(ellipsoidLabel).set('pos', [position.X(i) position.Y(i) position.Z(i)]);  % Position
        systemModel.component('comp1').geom('geom1').feature(ellipsoidLabel).set('axistype', 'cartesian');
        systemModel.component('comp1').geom('geom1').feature(ellipsoidLabel).set('axis', axisA{i});   % axis A orientation vector
        systemModel.component('comp1').geom('geom1').feature(ellipsoidLabel).set('semiaxes', [size.Y(i) size.Z(i) size.X(i)]);  % Ellipsoid length on (B,C,A) axis respectively
        
        % Build the created ellipsoid in model
        systemModel.component('comp1').geom('geom1').run(ellipsoidLabel);
        
        % Create gravity center point of each cell
        pointLabel = convertStringsToChars(sprintf("Point_cell_%d", i)); % name each point to Point_Cell_i
        systemModel.component('comp1').geom('geom1').create(pointLabel, 'Point');
        systemModel.component('comp1').geom('geom1').feature(pointLabel).set('p', [position.X(i) position.Y(i) position.Z(i)]);  % Position
        systemModel.component('comp1').geom('geom1').run(pointLabel);
    end 
    
    if isSaved
        % Update application model information
        app.loadedModel.model = systemModel;
        app.loadedModel.path = convertStringsToChars(destination);
        app.loadedModel.filename = convertStringsToChars(sprintf("%s_with_%s_imaris_cells.mph", modelname, app.cells.filename));
        mphsave(systemModel, destination); % save model with cells to .mph copy file
        
        uialert(app.UIFigure, sprintf("Succesfully copied model to %s file and added IMARIS cells to COMSOL model.", app.loadedModel.filename), "Action completed", "Icon", "success", "Modal", true);
        return
    end
    uialert(app.UIFigure, sprintf("Succesfully added IMARIS cells to COMSOL model.", app.loadedModel.filename), "Action completed", "Icon", "success", "Modal", true);
end
