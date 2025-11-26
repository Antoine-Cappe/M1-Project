%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                              BIOCAD Program
%                               Release 1.0
%
%   Authors: Vincent Senez
%   
%   Release 1.0 : January 2019
%
%   Called by: Compute.m
%
%   Function: Write in the log file the values of the Geometrical & 
%             Physical Parameters of the System
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function WritePara(tlm,fil)
 
    fprintf(fil,'\n\n System:');
    fprintf(fil,'\n\t Space Dimension: %u, \t Fluid: %u,',tlm.conf.dim,tlm.conf.Milo);
    fprintf(fil,'\n\t Number of Cell: %u, \t Cell Shape: %d, \t Nucleus: %u, \t Mitochondria: %u',tlm.conf.Cell,tlm.conf.Shape,tlm.conf.Nucleus,tlm.conf.Mitocho);
    fprintf(fil,'\n\t Probe: %u',tlm.conf.points);
    
    if tlm.conf.Init==1

        fprintf(fil,'\n\n Geometry:');
        fprintf(fil,'\n\t Reactor:');
        fprintf(fil,'\n\t Length: %u, \t Width: %u, \t Thickness: %u',tlm.var.LongueurChambre,tlm.var.LargeurChambre,tlm.var.EpaisseurChambre);
    fprintf(fil,'\n\t Outer Electrode:');
    fprintf(fil,'\n\t Length: %u, \t Width: %u, \t Thickness: %u, \t Spacing: %u',tlm.var.LongueurElectrode,tlm.var.LargeurElectrode, ...
                                                                                  tlm.var.EpaisseurElectrode,tlm.var.EcartementElectrode);
    fprintf(fil,'\n\t Inner Electrode:');
    fprintf(fil,'\n\t Length: %u, \t Width: %u, \t Thickness: %u, \t Spacing: %u',tlm.var.LongueurMesure,tlm.var.LargeurMesure, ...
                                                                                  tlm.var.EpaisseurMesure,tlm.var.EcartementMesure);
    fprintf(fil,'\n\t First Cell:');
    fprintf(fil,'\n\t Cytoplasm Radius/ X: %u, \t Y: %u, \t Z: %u',tlm.var.RayonXCellule(1),tlm.var.RayonYCellule(1),tlm.var.RayonZCellule(1));
    fprintf(fil,'\n\t Nucleus Radius/ X: %u, \t Y: %u, \t Z: %u',tlm.var.RayonXNoyau(1),tlm.var.RayonYNoyau(1),tlm.var.RayonZNoyau(1));
    fprintf(fil,'\n\t Mitochondria Radius/ X: %u, \t Y: %u, \t Z: %u',tlm.var.RayonXMitoc(1),tlm.var.RayonYMitoc(1),tlm.var.RayonZMitoc(1));
    fprintf(fil,'\n\t Membranes Thickness/ Cytoplasm: %u, Nucleus: %u, Mitochondria: %u',tlm.var.EpaisseurMembrane,tlm.var.EpaisseurNucleus, ...
                                                                                         tlm.var.EpaisseurMitochon);
    fprintf(fil,'\n\t Second Cell:');
    fprintf(fil,'\n\t Cytoplasm Radius/ X: %u, \t Y: %u, \t Z: %u',tlm.var.RayonXCellule(2),tlm.var.RayonYCellule(2),tlm.var.RayonZCellule(2));
    fprintf(fil,'\n\t Nucleus Radius/ X: %u, \t Y: %u, \t Z: %u',tlm.var.RayonXNoyau(2),tlm.var.RayonYNoyau(2),tlm.var.RayonZNoyau(2));
    fprintf(fil,'\n\t Mitochondria Radius/ X: %u, \t Y: %u, \t Z: %u',tlm.var.RayonXMitoc(2),tlm.var.RayonYMitoc(2),tlm.var.RayonZMitoc(2));
    fprintf(fil,'\n\t Membranes Thickness/ Cytoplasm: %u, Nucleus: %u, Mitochondria: %u',tlm.var.EpaisseurMembrane,tlm.var.EpaisseurNucleus, ...
                                                                                         tlm.var.EpaisseurMitochon);

    fprintf(fil,'\n\n Physical Parameters:');
    fprintf(fil,'\n\t First Fluid/ Conductivity: %u, \t Permittivity: %u',tlm.var.sig.MilOrga,tlm.var.eps.MilOrga);
    fprintf(fil,'\n\t Second Fluid/ Conductivity: %u, \t Permittivity: %u',tlm.var.sig.MilOrgb,tlm.var.eps.MilOrgb);
    fprintf(fil,'\n\t Electrode/ Conductivity: %u, \t Permittivity: %u',tlm.var.sig.electrode,tlm.var.eps.electrode);
    fprintf(fil,'\n\t First Cell:');
    fprintf(fil,'\n\t Cytoplasm Membrane/ Conductivity: %u, \t Permittivity: %u',tlm.var.sig.MembCel(1),tlm.var.eps.MembCel(1));
    fprintf(fil,'\n\t Cytoplasm/ Conductivity: %u, \t Permittivity: %u',tlm.var.sig.Cytoplasme(1),tlm.var.eps.Cytoplasme(1));
    fprintf(fil,'\n\t Nucleus Membrane/ Conductivity: %u, \t Permittivity: %u',tlm.var.sig.MembNuc(1),tlm.var.eps.MembNuc(1));
    fprintf(fil,'\n\t Nucleus/ Conductivity: %u, \t Permittivity: %u',tlm.var.sig.Nucleus(1),tlm.var.eps.Nucleus(1));
    fprintf(fil,'\n\t Mitochondria Membrane/ Conductivity: %u, \t Permittivity: %u',tlm.var.sig.MembMit(1),tlm.var.eps.MembMit(1));
    fprintf(fil,'\n\t Mitochondria/ Conductivity: %u, \t Permittivity: %u',tlm.var.sig.Mitocho(1),tlm.var.eps.Mitocho(1));
    fprintf(fil,'\n\t Second Cell:');
    fprintf(fil,'\n\t Cytoplasm Membrane/ Conductivity: %u, \t Permittivity: %u',tlm.var.sig.MembCel(2),tlm.var.eps.MembCel(2));
    fprintf(fil,'\n\t Cytoplasm/ Conductivity: %u, \t Permittivity: %u',tlm.var.sig.Cytoplasme(2),tlm.var.eps.Cytoplasme(2));
    fprintf(fil,'\n\t Nucleus Membrane/ Conductivity: %u, \t Permittivity: %u',tlm.var.sig.MembNuc(2),tlm.var.eps.MembNuc(2));
    fprintf(fil,'\n\t Nucleus/ Conductivity: %u, \t Permittivity: %u',tlm.var.sig.Nucleus(2),tlm.var.eps.Nucleus(2));
    fprintf(fil,'\n\t Mitochondria Membrane/ Conductivity: %u, \t Permittivity: %u',tlm.var.sig.MembMit(2),tlm.var.eps.MembMit(2));
    fprintf(fil,'\n\t Mitochondria/ Conductivity: %u, \t Permittivity: %u',tlm.var.sig.Mitocho(2),tlm.var.eps.Mitocho(2));
    
    end

    fprintf(fil,'\n\n Mesh:');
    fprintf(fil,'\n\t Mesh Density: %u',tlm.conf.mesh);
    
    fprintf(fil,'\n\n Solve:');
    fprintf(fil,'\n\t Frequency Min (Hz): %u, \t Frequency Max (Hz): %u, \t Points per Decade: %u',tlm.var.frequence.min,tlm.var.frequence.max,tlm.var.frequence.step);
    fprintf(fil,'\n\t Voltage (Volt): %u',tlm.var.v0);
    fprintf(fil,'\n\t Method: %u',tlm.conf.calcul);

    fprintf(fil,'\n\n Miscellanous:');
    fprintf(fil,'\n');
    
%    tlm.conf.XLS.Name='profils_2D';     % Name of the XLS file
%    tlm.conf.XLS.Sheet='epsiEs001';     % Name of the sheet in the XLS file
%    
%
    % Plot the Figures
%
%    tlm.var.Figure=1;                    % if =0 no figure for geometry; mesh, fem calculations
%        
    % Frequency Range 
%
%    tlm.var.frequence.min=0;                     % Minimum value of the frequency
%    tlm.var.frequence.step=1;                    % Value of the frequency increment
%    tlm.var.frequence.max=9;                     % Minimum value of the frequency
%    
%    tlm.var.frequence.b=1;              %
%    f=tlm.var.frequence.step.step*10^tlm.var.frequence%
%
    % Geometrical Parameters
%
%    tlm.var.OrigineX=0e-6;             % Origine of coordinates in X
%    tlm.var.OrigineY=0e-6;             % Origine of coordinates in Y
%    tlm.var.OrigineZ=0e-6;             % Origine of coordinates in Z
    
%    tlm.var.Center=0e-6;               % Shift for the two mediums' center

%    tlm.var.EpaisseurElectrode=10e-6;  % Thickness of the sollicitation electrodes 
%    tlm.var.LongueurElectrode=10e-6;   % Length of the sollicitation electrodes
%    tlm.var.LargeurElectrode=500e-9;  % Width of the sollicitation electrodes
%    tlm.var.EcartementElectrode=99e-6; % Spacing between the sollicitation electrodes
%    %tlm.var.EcartementElectrode=8e-6; % Spacing between the sollicitation electrodes
    
%    tlm.var.EpaisseurMesure=500e-9;    % Thickness of the measurement electrodes
%    tlm.var.LongueurMesure=10e-6;      % Length of the measurement electrodes
%    tlm.var.LargeurMesure=500e-9;      % Length of the measurement electrodes
%    %tlm.var.EcartementMesure=70000e-9;  % Spacing between the measurement electrodes
%    tlm.var.EcartementMesure=1000e-9;  % Spacing between the measurement electrodes

%    tlm.var.Epsilon=tlm.var.EpaisseurMesure/2;  % Distance to locate point inside the cytoplasm

%    tlm.var.LongueurChambre=10e-6;     % Length of the chamber
%    tlm.var.LargeurChambre=100e-6;      % Width of the chamber
%    %tlm.var.LargeurChambre=10e-6;      % Width of the chamber
%    tlm.var.EpaisseurChambre=10e-6;    % Thickness of the chamber

%    tlm.var.Orientation.Cellule(1)=0*pi/4;      % Orientation of the 1st Cell
%    tlm.var.Orientation.Cellule(2)=0;           % Orientation of the 2nd Cell

%    tlm.var.RayonXCellule(1)=4.25e-6;    % Radius X of the 1st Cell
%    tlm.var.RayonYCellule(1)=4.25e-6;    % Radius Y of the 1st Cell
%    tlm.var.RayonZCellule(1)=4.25e-6;    % Radius Z of the 1st Cell

%    tlm.var.RayonXCellule(2)=0e-6;    % Radius X of the 2nd Cell
%    tlm.var.RayonYCellule(2)=0e-6;    % Radius Y of the 2nd Cell
%    tlm.var.RayonZCellule(2)=0e-6;    % Radius Z of the 2nd Cell

%    tlm.var.sha0=0.7;                 % 1st Parameter for the parametrization of the cell shape
%    tlm.var.sha1=0;                 % 2nd Parameter for the parametrization of the cell shape

%    tlm.var.RayonXNoyau(1)=2.0e-6/2;       % Radius X of the Nucleus of the 1st Cell
%    tlm.var.RayonYNoyau(1)=2.0e-6/2;       % Radius Y of the Nucleus of the 1st Cell
%    tlm.var.RayonZNoyau(1)=2.0e-6/2;       % Radius Z of the Nucleus of the 1st Cell

%    tlm.var.RayonXNoyau(2)=0e-6/2;       % Radius X of the Nucleus of the 2st Cell
%    tlm.var.RayonYNoyau(2)=0e-6/2;       % Radius Y of the Nucleus of the 2st Cell
%    tlm.var.RayonZNoyau(2)=0e-6/2;       % Radius Z of the Nucleus of the 2st Cell

%    tlm.var.RayonXMitoc(1)=0.50e-6/2;       % Radius X of the Mitochondria of the 1st Cell
%    tlm.var.RayonYMitoc(1)=0.25e-6/2;       % Radius Y of the Mitochondria of the 1st Cell
%    tlm.var.RayonZMitoc(1)=0.25e-6/2;       % Radius Z of the Mitochondria of the 1st Cell

%    tlm.var.RayonXMitoc(2)=0e-6/2;       % Radius X of the Mitochondria of the 2st Cell
%    tlm.var.RayonYMitoc(2)=0e-6/2;       % Radius Y of the Mitochondria of the 2st Cell
%    tlm.var.RayonZMitoc(2)=0e-6/2;       % Radius Z of the Mitochondria of the 2st Cell

%    tlm.var.EpaisseurMembrane=7e-9;     % Thickness of the cell membrane
%    tlm.var.EpaisseurNucleus=1e-9;       % Thickness of the nucleus membrane
%    tlm.var.EpaisseurMitochon=1e-9;      % Thickness of the nucleus membrane

%    tlm.var.DecentrageXCellule(1)=0e-6;  % Lateral X location of the 1st cell by reference to tlm.var.OrigineX
%    tlm.var.DecentrageYCellule(1)=0e-6;    % Lateral Y location of the 1st cell by reference to tlm.var.OrigineY
%    tlm.var.DecentrageZCellule(1)=5.0e-6;  % Vertical Z location of the 1st cell by reference to tlm.var.OrigineZ

%    tlm.var.DecentrageXCellule(2)=0e-6;  % Lateral X location of the 1st cell by reference to tlm.var.OrigineX
%    tlm.var.DecentrageYCellule(2)=0e-6;     % Lateral Y location of the 1st cell by reference to tlm.var.OrigineY
%    tlm.var.DecentrageZCellule(2)=5e-6;     % Vertical Z location of the 1st cell by reference to tlm.var.OrigineZ

%    tlm.var.DecentrageXNoyau(1)=tlm.var.RayonXCellule(1)/2*cos(tlm.var.Orientation.Cellule(1));  % Lateral X location of the nucleus of the 1st cell by reference to tlm.var.OrigineX+tlm.var.DecentrageXCellule
%    tlm.var.DecentrageYNoyau(1)=tlm.var.RayonYCellule(1)/2*sin(tlm.var.Orientation.Cellule(1));  % Lateral Y location of the nucleus of the 1st cell by reference to tlm.var.OrigineY+tlm.var.DecentrageYCellule
%    tlm.var.DecentrageZNoyau(1)=tlm.var.RayonZCellule(1)/2*sin(tlm.var.Orientation.Cellule(1));  % Vertical Z location of the nucleus of the 1st cell by reference to tlm.var.OrigineZ+tlm.var.DecentrageZCellule

%    tlm.var.DecentrageXNoyau(2)=tlm.var.RayonXCellule(2)/2*cos(tlm.var.Orientation.Cellule(2));  % Lateral X location of the nucleus of the 2nd cell by reference to tlm.var.OrigineX+tlm.var.DecentrageXCellule
%    tlm.var.DecentrageYNoyau(2)=tlm.var.RayonYCellule(2)/2*sin(tlm.var.Orientation.Cellule(2));  % Lateral Y location of the nucleus of the 2nd cell by reference to tlm.var.OrigineY+tlm.var.DecentrageYCellule
%    tlm.var.DecentrageZNoyau(2)=tlm.var.RayonZCellule(2)/2*sin(tlm.var.Orientation.Cellule(2));  % Vertical Z location of the nucleus of the 2nd cell by reference to tlm.var.OrigineZ+tlm.var.DecentrageZCellule

%    tlm.var.DecentrageXMitoc(1)=-tlm.var.RayonXCellule(1)/2*cos(tlm.var.Orientation.Cellule(1));  % Lateral X location of the mitochondria of the 1st cell by reference to tlm.var.OrigineX+tlm.var.DecentrageXCellule
%    tlm.var.DecentrageYMitoc(1)=-tlm.var.RayonYCellule(1)/2*sin(tlm.var.Orientation.Cellule(1));  % Lateral Y location of the mitochondria of the 1st cell by reference to tlm.var.OrigineY+tlm.var.DecentrageYCellule
%    tlm.var.DecentrageZMitoc(1)=-tlm.var.RayonZCellule(1)/2*sin(tlm.var.Orientation.Cellule(1));  % Vertical Z location of the mitochondria of the 1st cell by reference to tlm.var.OrigineZ+tlm.var.DecentrageZCellule

%    tlm.var.DecentrageXMitoc(2)=-tlm.var.RayonXCellule(2)/2*cos(tlm.var.Orientation.Cellule(2));  % Lateral X location of the mitochondria of the 2nd cell by reference to tlm.var.OrigineX+tlm.var.DecentrageXCellule
%    tlm.var.DecentrageYMitoc(2)=-tlm.var.RayonYCellule(2)/2*sin(tlm.var.Orientation.Cellule(2));  % Lateral Y location of the mitochondria of the 2nd cell by reference to tlm.var.OrigineY+tlm.var.DecentrageYCellule
%    tlm.var.DecentrageZMitoc(2)=-tlm.var.RayonZCellule(2)/2*sin(tlm.var.Orientation.Cellule(2));  % Vertical Z location of the mitochondria of the 2nd cell by reference to tlm.var.OrigineZ+tlm.var.DecentrageZCellule

%if tlm.conf.Test==1         %2D case - without cell - Medium is purely resistive
%                            %refine =0
                            
% Name of the output files

%    if tlm.var.Freq<=0
%        tlm.conf.Name = 'test1_full';
%    else
%        tlm.conf.Name = ['test1' '_' num2str(tlm.var.Freq) 'Hz'];
%    end

% Configuration of the Bio-Physical System

%    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
%    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
%    tlm.conf.Cell=0;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
%    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
%    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
%    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
%    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
%    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
%    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
%    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 
%    
% Physical Parameters

%    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of
%    Vacuum%

%    tlm.var.sig.electrode=0.53;          % Conductivity (S/m) of the metal (electrodes)
%    tlm.var.sig.MilOrga=0.53;            % Conductivity (S/m) of the external medium (serum)
%    tlm.var.sig.MilOrgb=0.53;            % Conductivity (S/m) of the external medium (serum)
%    tlm.var.sig.MembCel(1)=0;            % Conductivity (S/m) of the membrane of the first cell
%    tlm.var.sig.Cytoplasme(1)=0;         % Conductivity (S/m) of the cytoplasm of the first cell
%    tlm.var.sig.Nucleus(1)=0;            % Conductivity (S/m) of the nucleus of the first cell
%    tlm.var.sig.Mitocho(1)=0;            % Conductivity (S/m) of the mitochondria of the first cell
%    tlm.var.sig.MembNuc(1)=0;            % Conductivity (S/m) of the nucleus membrane of the first cell
%    tlm.var.sig.MembMit(1)=0;            % Conductivity (S/m) of the mitochondria membrane of the first cell
%    tlm.var.sig.MembCel(2)=0;            % Conductivity (S/m) of the membrane of the second cell
%    tlm.var.sig.Cytoplasme(2)=0;         % Conductivity (S/m) of the cytoplasm of the second cell
%    tlm.var.sig.Nucleus(2)=0;            % Conductivity (S/m) of the nucleus of the second cell
%    tlm.var.sig.Mitocho(2)=0;            % Conductivity (S/m) of the mitochondria of the second cell
%    tlm.var.sig.MembNuc(2)=0;            % Conductivity (S/m) of the nucleus membrane of the second cell
%    tlm.var.sig.MembMit(2)=0;            % Conductivity (S/m) of the mitochondria membrane of the second cell

%    tlm.var.eps.electrode=0*tlm.var.eps0;       % Permittivity (F/m) of the metal (electrodes)
%    tlm.var.eps.MilOrga=0*tlm.var.eps0;         % Permittivity (F/m) of the external medium (serum)
%    tlm.var.eps.MilOrgb=0*tlm.var.eps0;         % Permittivity (F/m) of the external medium (serum)
%    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
%    tlm.var.eps.Cytoplasme(1)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the first cell
%    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
%    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
%    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
%    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
%    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
%    tlm.var.eps.Cytoplasme(2)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the second cell
%    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
%    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
%    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
%    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell

end