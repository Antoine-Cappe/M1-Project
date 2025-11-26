%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                              BIOCAD Program
%                               Release 1.0
%
%   Authors: Vincent Senez
%   
%   Release 1.0 : January 2019
%
%   Function : Postprocess the results obtained by the various analysis
%
%   Called by : Biocad
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%function [tlm]=Postprocess(tlm,fil)
function [tlm]=Postprocess(tlm,fil, app,model)

% Close all figure windows
if tlm.conf.fig>0
    for i=tlm.conf.fig:-1:1
        figure(i);
        close(i);
    end
    tlm.conf.fig=0;
end


% Dock figures in Matlab GUI
set(0,'DefaultFigureWindowStyle','docked')

% Clear Mesh generated in 'Compute' file
% model.component('comp1').mesh('mesh1').clearMesh();

% Print on the Command Window of Matlab
Message=sprintf('\n ******* Start PostProcessing');
disp(Message);

if tlm.conf.log==1
    fprintf(fil,'\n ******* Start Postprocessing');
    fprintf(fil,'\n ');
end

% Definition of the Geometrical & Physical Parameters

%if tlm.conf.Initpara==0     % Simple Configurations to test the software 
%    tlm=IniParaNoCell(tlm);       % No Cell - One Medium
%elseif tlm.conf.Initpara==4     % Simple Configurations to test the software 
%    tlm=IniParaTwoMilo(tlm);       % No Cell - Two Mediums 
%elseif tlm.conf.Initpara==1      
%    tlm=IniParaOneSphere(tlm);    % One Spheroid Cell 
%elseif tlm.conf.Initpara==2
%    tlm=IniParaOneNonSphere(tlm); % One Non Spheroid Cell
%elseif tlm.conf.Initpara==3
%    tlm=IniParaTwoSphere(tlm);    % Two Spheroid Cells
%end

Message=sprintf('\n Figures are saved in directory: ''%s''', tlm.conf.store);
disp(Message);

if tlm.conf.log==1
    fprintf(fil,'\n Figures are saved in directory: ''%s''', tlm.conf.store);
    fprintf(fil,'\n ');
end

% Read the various Solutions stored in files xx.chi, xx.fem & xx.ana

if (tlm.conf.dim==2)
    [tlm]=Read2D(tlm,fil);
else
    [tlm,model]=Read3D(tlm,fil,app,model);
end

Message=sprintf('\n ******* End PostProcessing');
disp(Message);
if tlm.conf.log==1
    fprintf(fil,'\n ******* End Postprocessing');
    fprintf(fil,'\n ');
end
