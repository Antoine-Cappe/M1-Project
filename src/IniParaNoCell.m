%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                              BIOCAD Program
%                               Release 2.1
%
%   Authors: Vincent Senez, Benoit Poussard, 
%            Thomas Delmas, Hugo Bertacchini
%   
%   Release 1.0 : July 2003
%   Release 1.1 : December 2004
%   Release 1.2 : July 2005
%   Release 2.0 : December 2005
%   Release 2.1 : July 2006
%
%   Routine IniParaNoCell called by Biocad,
%
%   Function: Initialize Geometrical & Physical Parameters for two cell
%             configuration
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function tlm=IniParaNoCell(tlm)

if tlm.conf.dim==2
    
    % Name of the input file
 
    tlm.conf.XLS.Name='profils_2D';     % Name of the XLS file
    tlm.conf.XLS.Sheet='epsiEs001';     % Name of the sheet in the XLS file
    
    % 2 or 4 points Measurement
    
    tlm.conf.points=4;                  % 2 is for 2 points, 4 is for 4 points measurement

    % Excitation Potential 

    tlm.var.v0=0.01;                     % Potential applied to the excitation electrode

    % Plot the Figures

    tlm.var.Figure=1;                    % if =0 no figure for geometry; mesh, fem calculations
    
    % Mesh Type 
    
    tlm.conf.mesh=1;                     % if =1 extra fine, if = 2 Normal, if = 3 extra coarse
    
    % Frequency Range 

    tlm.var.frequence.min=0;                     % Minimum value of the frequency
    tlm.var.frequence.step=1;                    % Value of the frequency increment
    tlm.var.frequence.max=9;                     % Minimum value of the frequency
    
    tlm.var.frequence.b=1;              % f=tlm.var.frequence.step.step*10^tlm.var.frequence

    % Geometrical Parameters

    tlm.var.OrigineX=0e-6;             % Origine of coordinates in X
    tlm.var.OrigineY=0e-6;             % Origine of coordinates in Y
    tlm.var.OrigineZ=0e-6;             % Origine of coordinates in Z
    
    tlm.var.Center=0e-6;               % Shift for the two mediums' center

    tlm.var.EpaisseurElectrode=10e-6;  % Thickness of the sollicitation electrodes 
    tlm.var.LongueurElectrode=10e-6;   % Length of the sollicitation electrodes
    tlm.var.LargeurElectrode=500e-9;  % Width of the sollicitation electrodes
    tlm.var.EcartementElectrode=99e-6; % Spacing between the sollicitation electrodes
    %tlm.var.EcartementElectrode=8e-6; % Spacing between the sollicitation electrodes
    
    tlm.var.EpaisseurMesure=500e-9;    % Thickness of the measurement electrodes
    tlm.var.LongueurMesure=10e-6;      % Length of the measurement electrodes
    tlm.var.LargeurMesure=500e-9;      % Length of the measurement electrodes
    %tlm.var.EcartementMesure=70000e-9;  % Spacing between the measurement electrodes
    tlm.var.EcartementMesure=1000e-9;  % Spacing between the measurement electrodes

    tlm.var.Epsilon=tlm.var.EpaisseurMesure/2;  % Distance to locate point inside the cytoplasm

    tlm.var.LongueurChambre=10e-6;     % Length of the chamber
    tlm.var.LargeurChambre=100e-6;      % Width of the chamber
    %tlm.var.LargeurChambre=10e-6;      % Width of the chamber
    tlm.var.EpaisseurChambre=10e-6;    % Thickness of the chamber

    tlm.var.Orientation.Cellule(1)=0*pi/4;      % Orientation of the 1st Cell
    tlm.var.Orientation.Cellule(2)=0;           % Orientation of the 2nd Cell

    tlm.var.RayonXCellule(1)=4.25e-6;    % Radius X of the 1st Cell
    tlm.var.RayonYCellule(1)=4.25e-6;    % Radius Y of the 1st Cell
    tlm.var.RayonZCellule(1)=4.25e-6;    % Radius Z of the 1st Cell

    tlm.var.RayonXCellule(2)=0e-6;    % Radius X of the 2nd Cell
    tlm.var.RayonYCellule(2)=0e-6;    % Radius Y of the 2nd Cell
    tlm.var.RayonZCellule(2)=0e-6;    % Radius Z of the 2nd Cell

    tlm.var.sha0=0.7;                 % 1st Parameter for the parametrization of the cell shape
    tlm.var.sha1=0;                 % 2nd Parameter for the parametrization of the cell shape

    tlm.var.RayonXNoyau(1)=2.0e-6/2;       % Radius X of the Nucleus of the 1st Cell
    tlm.var.RayonYNoyau(1)=2.0e-6/2;       % Radius Y of the Nucleus of the 1st Cell
    tlm.var.RayonZNoyau(1)=2.0e-6/2;       % Radius Z of the Nucleus of the 1st Cell

    tlm.var.RayonXNoyau(2)=0e-6/2;       % Radius X of the Nucleus of the 2st Cell
    tlm.var.RayonYNoyau(2)=0e-6/2;       % Radius Y of the Nucleus of the 2st Cell
    tlm.var.RayonZNoyau(2)=0e-6/2;       % Radius Z of the Nucleus of the 2st Cell

    tlm.var.RayonXMitoc(1)=0.50e-6/2;       % Radius X of the Mitochondria of the 1st Cell
    tlm.var.RayonYMitoc(1)=0.25e-6/2;       % Radius Y of the Mitochondria of the 1st Cell
    tlm.var.RayonZMitoc(1)=0.25e-6/2;       % Radius Z of the Mitochondria of the 1st Cell

    tlm.var.RayonXMitoc(2)=0e-6/2;       % Radius X of the Mitochondria of the 2st Cell
    tlm.var.RayonYMitoc(2)=0e-6/2;       % Radius Y of the Mitochondria of the 2st Cell
    tlm.var.RayonZMitoc(2)=0e-6/2;       % Radius Z of the Mitochondria of the 2st Cell

    tlm.var.EpaisseurMembrane=7e-9;     % Thickness of the cell membrane
    tlm.var.EpaisseurNucleus=1e-9;       % Thickness of the nucleus membrane
    tlm.var.EpaisseurMitochon=1e-9;      % Thickness of the nucleus membrane

    tlm.var.DecentrageXCellule(1)=0e-6;  % Lateral X location of the 1st cell by reference to tlm.var.OrigineX
    tlm.var.DecentrageYCellule(1)=0e-6;    % Lateral Y location of the 1st cell by reference to tlm.var.OrigineY
    tlm.var.DecentrageZCellule(1)=5.0e-6;  % Vertical Z location of the 1st cell by reference to tlm.var.OrigineZ

    tlm.var.DecentrageXCellule(2)=0e-6;  % Lateral X location of the 1st cell by reference to tlm.var.OrigineX
    tlm.var.DecentrageYCellule(2)=0e-6;     % Lateral Y location of the 1st cell by reference to tlm.var.OrigineY
    tlm.var.DecentrageZCellule(2)=5e-6;     % Vertical Z location of the 1st cell by reference to tlm.var.OrigineZ

    tlm.var.DecentrageXNoyau(1)=tlm.var.RayonXCellule(1)/2*cos(tlm.var.Orientation.Cellule(1));  % Lateral X location of the nucleus of the 1st cell by reference to tlm.var.OrigineX+tlm.var.DecentrageXCellule
    tlm.var.DecentrageYNoyau(1)=tlm.var.RayonYCellule(1)/2*sin(tlm.var.Orientation.Cellule(1));  % Lateral Y location of the nucleus of the 1st cell by reference to tlm.var.OrigineY+tlm.var.DecentrageYCellule
    tlm.var.DecentrageZNoyau(1)=tlm.var.RayonZCellule(1)/2*sin(tlm.var.Orientation.Cellule(1));  % Vertical Z location of the nucleus of the 1st cell by reference to tlm.var.OrigineZ+tlm.var.DecentrageZCellule

    tlm.var.DecentrageXNoyau(2)=tlm.var.RayonXCellule(2)/2*cos(tlm.var.Orientation.Cellule(2));  % Lateral X location of the nucleus of the 2nd cell by reference to tlm.var.OrigineX+tlm.var.DecentrageXCellule
    tlm.var.DecentrageYNoyau(2)=tlm.var.RayonYCellule(2)/2*sin(tlm.var.Orientation.Cellule(2));  % Lateral Y location of the nucleus of the 2nd cell by reference to tlm.var.OrigineY+tlm.var.DecentrageYCellule
    tlm.var.DecentrageZNoyau(2)=tlm.var.RayonZCellule(2)/2*sin(tlm.var.Orientation.Cellule(2));  % Vertical Z location of the nucleus of the 2nd cell by reference to tlm.var.OrigineZ+tlm.var.DecentrageZCellule

    tlm.var.DecentrageXMitoc(1)=-tlm.var.RayonXCellule(1)/2*cos(tlm.var.Orientation.Cellule(1));  % Lateral X location of the mitochondria of the 1st cell by reference to tlm.var.OrigineX+tlm.var.DecentrageXCellule
    tlm.var.DecentrageYMitoc(1)=-tlm.var.RayonYCellule(1)/2*sin(tlm.var.Orientation.Cellule(1));  % Lateral Y location of the mitochondria of the 1st cell by reference to tlm.var.OrigineY+tlm.var.DecentrageYCellule
    tlm.var.DecentrageZMitoc(1)=-tlm.var.RayonZCellule(1)/2*sin(tlm.var.Orientation.Cellule(1));  % Vertical Z location of the mitochondria of the 1st cell by reference to tlm.var.OrigineZ+tlm.var.DecentrageZCellule

    tlm.var.DecentrageXMitoc(2)=-tlm.var.RayonXCellule(2)/2*cos(tlm.var.Orientation.Cellule(2));  % Lateral X location of the mitochondria of the 2nd cell by reference to tlm.var.OrigineX+tlm.var.DecentrageXCellule
    tlm.var.DecentrageYMitoc(2)=-tlm.var.RayonYCellule(2)/2*sin(tlm.var.Orientation.Cellule(2));  % Lateral Y location of the mitochondria of the 2nd cell by reference to tlm.var.OrigineY+tlm.var.DecentrageYCellule
    tlm.var.DecentrageZMitoc(2)=-tlm.var.RayonZCellule(2)/2*sin(tlm.var.Orientation.Cellule(2));  % Vertical Z location of the mitochondria of the 2nd cell by reference to tlm.var.OrigineZ+tlm.var.DecentrageZCellule

elseif tlm.conf.dim==3
    
    % Name of the input file
 
    tlm.conf.XLS.Name='profils_2D';     % Name of the XLS file
    tlm.conf.XLS.Sheet='epsiEs001';     % Name of the sheet in the XLS file
    
    % 2 or 4 points Measurement
    
    tlm.conf.points=4;                  % 2 is for 2 points, 4 is for 4 points measurement

    % Excitation Potential 

    tlm.var.v0=0.01;                     % Potential applied to the excitation electrode

    % Plot the Figures

    tlm.var.Figure=1;                    % if =0 no figure for geometry; mesh, fem calculations

    % Mesh Type 
    
    tlm.conf.mesh=1;                     % if =1 extra fine, if = 2 Normal, if = 3 extra coarse
    
    % Frequency Range 

    tlm.var.frequence.min=0;                     % Minimum value of the frequency
    tlm.var.frequence.step=1;                    % Value of the frequency increment
    tlm.var.frequence.max=9;                     % Minimum value of the frequency
    
    tlm.var.frequence.b=1;              % f=tlm.var.frequence.b*10^tlm.var.frequence
    
    % Geometrical Parameters

    tlm.var.OrigineX=0e-6;             % Origine of coordinates in X
    tlm.var.OrigineY=0e-6;             % Origine of coordinates in Y
    tlm.var.OrigineZ=0e-6;             % Origine of coordinates in Z
    
    tlm.var.Center=0e-6;               % Shift for the two mediums' center

    tlm.var.EpaisseurElectrode=10e-6;  % Thickness of the sollicitation electrodes 
    tlm.var.LongueurElectrode=10e-6;   % Length of the sollicitation electrodes
    tlm.var.LargeurElectrode=500e-9;  % Width of the sollicitation electrodes
    tlm.var.EcartementElectrode=9e-6; % Spacing between the sollicitation electrodes
    %tlm.var.EcartementElectrode=8e-6; % Spacing between the sollicitation electrodes
    
    tlm.var.EpaisseurMesure=500e-9;    % Thickness of the measurement electrodes
    tlm.var.LongueurMesure=10e-6;      % Length of the measurement electrodes
    tlm.var.LargeurMesure=500e-9;      % Length of the measurement electrodes
    %tlm.var.EcartementMesure=70000e-9;  % Spacing between the measurement electrodes
    tlm.var.EcartementMesure=1000e-9;  % Spacing between the measurement electrodes

    tlm.var.Epsilon=tlm.var.EpaisseurMesure/2;  % Distance to locate point inside the cytoplasm

    tlm.var.LongueurChambre=10e-6;     % Length of the chamber
    tlm.var.LargeurChambre=10e-6;      % Width of the chamber
    %tlm.var.LargeurChambre=10e-6;      % Width of the chamber
    tlm.var.EpaisseurChambre=10e-6;    % Thickness of the chamber

    tlm.var.Orientation.Cellule(1)=0*pi/4;      % Orientation of the 1st Cell
    tlm.var.Orientation.Cellule(2)=0;           % Orientation of the 2nd Cell

    tlm.var.RayonXCellule(1)=4.25e-6;    % Radius X of the 1st Cell
    tlm.var.RayonYCellule(1)=4.25e-6;    % Radius Y of the 1st Cell
    tlm.var.RayonZCellule(1)=4.25e-6;    % Radius Z of the 1st Cell

    tlm.var.RayonXCellule(2)=0e-6;    % Radius X of the 2nd Cell
    tlm.var.RayonYCellule(2)=0e-6;    % Radius Y of the 2nd Cell
    tlm.var.RayonZCellule(2)=0e-6;    % Radius Z of the 2nd Cell

    tlm.var.sha0=0.7;                 % 1st Parameter for the parametrization of the cell shape
    tlm.var.sha1=0;                 % 2nd Parameter for the parametrization of the cell shape

    tlm.var.RayonXNoyau(1)=2.0e-6/2;       % Radius X of the Nucleus of the 1st Cell
    tlm.var.RayonYNoyau(1)=2.0e-6/2;       % Radius Y of the Nucleus of the 1st Cell
    tlm.var.RayonZNoyau(1)=2.0e-6/2;       % Radius Z of the Nucleus of the 1st Cell

    tlm.var.RayonXNoyau(2)=0e-6/2;       % Radius X of the Nucleus of the 2st Cell
    tlm.var.RayonYNoyau(2)=0e-6/2;       % Radius Y of the Nucleus of the 2st Cell
    tlm.var.RayonZNoyau(2)=0e-6/2;       % Radius Z of the Nucleus of the 2st Cell

    tlm.var.RayonXMitoc(1)=0.50e-6/2;       % Radius X of the Mitochondria of the 1st Cell
    tlm.var.RayonYMitoc(1)=0.25e-6/2;       % Radius Y of the Mitochondria of the 1st Cell
    tlm.var.RayonZMitoc(1)=0.25e-6/2;       % Radius Z of the Mitochondria of the 1st Cell

    tlm.var.RayonXMitoc(2)=0e-6/2;       % Radius X of the Mitochondria of the 2st Cell
    tlm.var.RayonYMitoc(2)=0e-6/2;       % Radius Y of the Mitochondria of the 2st Cell
    tlm.var.RayonZMitoc(2)=0e-6/2;       % Radius Z of the Mitochondria of the 2st Cell

    tlm.var.EpaisseurMembrane=7e-9;     % Thickness of the cell membrane
    tlm.var.EpaisseurNucleus=1e-9;       % Thickness of the nucleus membrane
    tlm.var.EpaisseurMitochon=1e-9;      % Thickness of the nucleus membrane

    tlm.var.DecentrageXCellule(1)=0e-6;  % Lateral X location of the 1st cell by reference to tlm.var.OrigineX
    tlm.var.DecentrageYCellule(1)=0e-6;    % Lateral Y location of the 1st cell by reference to tlm.var.OrigineY
    tlm.var.DecentrageZCellule(1)=5.0e-6;  % Vertical Z location of the 1st cell by reference to tlm.var.OrigineZ

    tlm.var.DecentrageXCellule(2)=0e-6;  % Lateral X location of the 1st cell by reference to tlm.var.OrigineX
    tlm.var.DecentrageYCellule(2)=0e-6;     % Lateral Y location of the 1st cell by reference to tlm.var.OrigineY
    tlm.var.DecentrageZCellule(2)=5e-6;     % Vertical Z location of the 1st cell by reference to tlm.var.OrigineZ

    tlm.var.DecentrageXNoyau(1)=tlm.var.RayonXCellule(1)/2*cos(tlm.var.Orientation.Cellule(1));  % Lateral X location of the nucleus of the 1st cell by reference to tlm.var.OrigineX+tlm.var.DecentrageXCellule
    tlm.var.DecentrageYNoyau(1)=tlm.var.RayonYCellule(1)/2*sin(tlm.var.Orientation.Cellule(1));  % Lateral Y location of the nucleus of the 1st cell by reference to tlm.var.OrigineY+tlm.var.DecentrageYCellule
    tlm.var.DecentrageZNoyau(1)=tlm.var.RayonZCellule(1)/2*sin(tlm.var.Orientation.Cellule(1));  % Vertical Z location of the nucleus of the 1st cell by reference to tlm.var.OrigineZ+tlm.var.DecentrageZCellule

    tlm.var.DecentrageXNoyau(2)=tlm.var.RayonXCellule(2)/2*cos(tlm.var.Orientation.Cellule(2));  % Lateral X location of the nucleus of the 2nd cell by reference to tlm.var.OrigineX+tlm.var.DecentrageXCellule
    tlm.var.DecentrageYNoyau(2)=tlm.var.RayonYCellule(2)/2*sin(tlm.var.Orientation.Cellule(2));  % Lateral Y location of the nucleus of the 2nd cell by reference to tlm.var.OrigineY+tlm.var.DecentrageYCellule
    tlm.var.DecentrageZNoyau(2)=tlm.var.RayonZCellule(2)/2*sin(tlm.var.Orientation.Cellule(2));  % Vertical Z location of the nucleus of the 2nd cell by reference to tlm.var.OrigineZ+tlm.var.DecentrageZCellule

    tlm.var.DecentrageXMitoc(1)=-tlm.var.RayonXCellule(1)/2*cos(tlm.var.Orientation.Cellule(1));  % Lateral X location of the mitochondria of the 1st cell by reference to tlm.var.OrigineX+tlm.var.DecentrageXCellule
    tlm.var.DecentrageYMitoc(1)=-tlm.var.RayonYCellule(1)/2*sin(tlm.var.Orientation.Cellule(1));  % Lateral Y location of the mitochondria of the 1st cell by reference to tlm.var.OrigineY+tlm.var.DecentrageYCellule
    tlm.var.DecentrageZMitoc(1)=-tlm.var.RayonZCellule(1)/2*sin(tlm.var.Orientation.Cellule(1));  % Vertical Z location of the mitochondria of the 1st cell by reference to tlm.var.OrigineZ+tlm.var.DecentrageZCellule

    tlm.var.DecentrageXMitoc(2)=-tlm.var.RayonXCellule(2)/2*cos(tlm.var.Orientation.Cellule(2));  % Lateral X location of the mitochondria of the 2nd cell by reference to tlm.var.OrigineX+tlm.var.DecentrageXCellule
    tlm.var.DecentrageYMitoc(2)=-tlm.var.RayonYCellule(2)/2*sin(tlm.var.Orientation.Cellule(2));  % Lateral Y location of the mitochondria of the 2nd cell by reference to tlm.var.OrigineY+tlm.var.DecentrageYCellule
    tlm.var.DecentrageZMitoc(2)=-tlm.var.RayonZCellule(2)/2*sin(tlm.var.Orientation.Cellule(2));  % Vertical Z location of the mitochondria of the 2nd cell by reference to tlm.var.OrigineZ+tlm.var.DecentrageZCellule

end

if tlm.conf.Test==1         %2D case - without cell - Medium is purely resistive
                            %refine =0
                            
% Name of the output files

    if tlm.var.Freq<=0
        tlm.conf.Name = 'test1_full';
    else
        tlm.conf.Name = ['test1' '_' num2str(tlm.var.Freq) 'Hz'];
    end

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=0;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 
    
% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;          % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;            % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;            % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;            % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0;         % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;            % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;            % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;            % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;            % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;            % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0;         % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;            % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;            % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;            % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;            % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=0*tlm.var.eps0;       % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=0*tlm.var.eps0;         % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=0*tlm.var.eps0;         % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell

elseif tlm.conf.Test==2         %2D case - without cell - Medium is purely capacitive
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test2';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=0;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA
    
% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0;          % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0;            % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0;            % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;         % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0;      % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0;      % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;      % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell

elseif tlm.conf.Test==3         %2D case - without cell - Medium is resistive & capacitive
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test3';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=0;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;    % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;         % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;      % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0;      % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;      % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==4         %3D case - without cell - Medium is purely resistive 
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test4';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=0;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;          % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;            % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;            % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0;         % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;            % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;            % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;            % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;            % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;            % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0;         % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;            % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;            % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;            % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;            % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=0*tlm.var.eps0;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=0*tlm.var.eps0;                       % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=0*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==5         %3D case - without cell - Medium is purely capacitive 
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test5';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=0;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0;          % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0;            % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0;            % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;         % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0;      % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0;      % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;      % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell

elseif tlm.conf.Test==6         %3D case - without cell - Medium is resistive & capacitive 
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test6';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=0;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;       % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;         % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0;      % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0;      % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;      % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell

elseif tlm.conf.Test==7         %2D case - without cell - Medium is purely resistive & capacitive
                                %refine =1

% Name of the output files

    tlm.conf.Name = 'test7';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=0;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=1;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;         % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0;      % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0;      % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==8         %3D case - without cell - Medium is resistive & capacitive 
                                %refine =1

% Name of the output files

    tlm.conf.Name = 'test8';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=0;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=1;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;       % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;         % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0;      % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0;      % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;      % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum   tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==9         %2D case - with cell - without membrane - Cell & Medium are resistive & capacitive
                                %(same electrical properties for Cell & Medium)
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test9';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;         % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;      % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell

elseif tlm.conf.Test==10        %3D case - with cell - without membrane - Cell & Medium are resistive & capacitive 
                                %(same electrical properties for Cell & Medium)
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test10';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;         % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;      % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==11        %2D case - with cell - without membrane - Cell & Medium are resistive & capacitive
                                %(same electrical properties for Cell & Medium)
                                %refine =1

% Name of the output files

    tlm.conf.Name = 'test11';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=1;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=0;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 
    
% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=4.5e5;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;      % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=0;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
       
elseif tlm.conf.Test==12        %3D case - with cell - without membrane - Cell & Medium are resistive & capacitive 
                                %(same electrical properties for Cell & Medium)
                                %refine =1

% Name of the output files

    tlm.conf.Name = 'test12';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=1;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=0;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=4.5e5;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;         % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=0;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==13        %2D case - with cell - with membrane - Cell, Membrane & Medium are resistive & capacitive 
                                %(same electrical properties for Cell, Membrane & Medium)
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test13';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=1;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;      % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0.53;      % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;      % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
   
elseif tlm.conf.Test==14        %3D case - with cell - with membrane - Cell, Membrane & Medium are resistive & capacitive 
                                %(same electrical properties for Cell, Membrane & Medium)
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test14';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=1;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;      % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0.53;      % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0 ;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==15        %2D case - with cell - with membrane - Cell, Membrane & Medium are resistive & capacitive
                                %(same electrical properties for Cell, Membrane & Medium)
                                %refine =1

% Name of the output files

    tlm.conf.Name = 'test15';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=1;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=1;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=0;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum
    
    tlm.var.sig.electrode=4.5e5;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;      % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0.53;      % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=0;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==16        %3D case - with cell - with membrane - Cell, Membrane & Medium are resistive & capacitive 
                                %(same electrical properties for Cell, Membrane & Medium)
                                %refine =1

% Name of the output files

    tlm.conf.Name = 'test16';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=1;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=1;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=1;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=0;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=4.5e5;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;      % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0.53;      % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=0;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==17        %2D case - with cell & nucleus - without membrane - Cell, Nucleus & Medium are resistive & capacitive
                                %(same electrical properties for Cell, Nucleus & Medium)
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test17';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=1;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;         % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0.53;      % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0.53;      % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;      % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell

elseif tlm.conf.Test==18        %3D case - with cell & nucleus - without membrane - Cell, Nucleus & Medium are resistive & capacitive 
                                %(same electrical properties for Cell, Nucleus & Medium)
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test18';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=1;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;       % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;         % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0.53;      % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0.53;      % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;      % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==19        %2D case - with cell & nucleus - without membrane - Cell, Nucleus & Medium are resistive & capacitive
                                %(same electrical properties for Cell, Nucleus & Medium)
                                %refine =1

% Name of the output files

    tlm.conf.Name = 'test19';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=1;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=1;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=0;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 
    
% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=4.5e5;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;         % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0.53;      % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0.53;      % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=0;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==20        %3D case - with cell & nucleus - without membrane - Cell, Nucleus & Medium are resistive & capacitive 
                                %(same electrical properties for Cell, Nucleus & Medium)
                                %refine =1

% Name of the output files

    tlm.conf.Name = 'test20';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=1;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=1;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=0;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=4.5e5;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;         % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0.53;      % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0.53;      % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=0;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==21        %2D case - with cell & nucleus &  membrane - Cell, Nucleus, Membrane & Medium are resistive & capacitive 
                                %(same electrical properties for Cell, Nucleus, Membrane & Medium)
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test21';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Nucleus=1;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=1;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=0;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;      % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0.53;      % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0.53;      % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0.53;      % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0.53;      % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;      % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==22        %3D case - with cell, nucleus & membrane - Cell, Nucleus, Membrane & Medium are resistive & capacitive 
                                %(same electrical properties for Cell, Nucleus, Membrane & Medium)
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test22';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Nucleus=1;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=1;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=0;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=4.5e5;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;      % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0.53;      % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0.53;      % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0.53;      % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0.53;      % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0.53;      % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=0;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==23        %2D case - with cell, nucleus & membrane - Cell, Nucleus, Membrane & Medium are resistive & capacitive
                                %(same electrical properties for Cell, Nucleus, Membrane & Medium)
                                %refine =1

% Name of the output files

    tlm.conf.Name = 'test23';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=1;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=1;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=1;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=0;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=4.5e5;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;      % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0.53;      % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0.53;      % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0.53;      % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0.53;      % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0.53;      % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=0;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
        
elseif tlm.conf.Test==24        %3D case - with cell, nucleus & membrane - Cell, Nucleus, Membrane & Medium are resistive & capacitive 
                                %(same electrical properties for Cell, Nucleus, Membrane & Medium)
                                %refine =1

% Name of the output files

    tlm.conf.Name = 'test24';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=1;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=1;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=1;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=0;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=4.5e5;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;      % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0.53;      % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0.53;      % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0.53;      % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0.53;      % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0.53;      % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=0;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
        
elseif tlm.conf.Test==25        %2D case - with cell & nucleus & mitochondria &  membrane - Cell, Nucleus, Mitochondria, Membrane & Medium are resistive & capacitive 
                                %(same electrical properties for Cell, Nucleus, Mitochondria, Membrane & Medium)
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test25';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=1;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=1;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=1;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;      % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0.53;      % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0.53;      % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0.53;      % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0.53;      % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0.53;      % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0.53;      % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0.53;      % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0.53;      % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0.53;      % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;      % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==26        %3D case - with cell & nucleus & mitochondria &  membrane - Cell, Nucleus, Mitochondria, Membrane & Medium are resistive & capacitive 
                                %(same electrical properties for Cell, Nucleus, Mitochondria, Membrane & Medium)
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test26';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=1;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=1;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=1;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;       % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;      % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0.53;      % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0.53;      % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0.53;      % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0.53;      % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0.53;      % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0.53;      % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0.53;      % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0.53;      % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0.53;      % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;      % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==27        %2D case - with cell & nucleus & mitochondria &  membrane - Cell, Nucleus, Mitochondria, Membrane & Medium are resistive & capacitive 
                                %(same electrical properties for Cell, Nucleus, Mitochondria, Membrane & Medium)
                                %refine =1

% Name of the output files

    tlm.conf.Name = 'test27';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=1;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=1;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=1;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=1;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=0;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=4.5e5;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;      % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0.53;      % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0.53;      % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0.53;      % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0.53;      % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0.53;      % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0.53;      % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0.53;      % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0.53;      % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0.53;      % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=0;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the mitochondria membrane of the second cell
        
elseif tlm.conf.Test==28        %3D case - with cell & nucleus & mitochondria &  membrane - Cell, Nucleus, Mitochondria, Membrane & Medium are resistive & capacitive 
                                %(same electrical properties for Cell, Nucleus, Mitochondria, Membrane & Medium)
                                %refine =1

% Name of the output files

    tlm.conf.Name = 'test28';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=1;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=1;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=1;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=1;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=0;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=4.5e5;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;      % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0.53;      % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0.53;      % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0.53;      % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0.53;      % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0.53;      % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0.53;      % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0.53;      % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0.53;      % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0.53;      % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=0;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the mitochondria membrane of the second cell
        
end

% Directories Configuration

if tlm.conf.points==2
    tlm.conf.result=[tlm.conf.result '\nocell\2points\' tlm.conf.Name];
elseif tlm.conf.points==4
    tlm.conf.result=[tlm.conf.result '\nocell\4points\' tlm.conf.Name];
end

% Parameters of the Warburg Element (electrode polarisation)

tlm.var.Vt=0.025;                          % Vt=kT/q
tlm.var.q=1.60219e-19;                     % Charge of the electron
tlm.var.z=1;                               % Valence of ions
tlm.var.n0=93e21;                          % Bulk number concentration of ions in electrolyte (ions/liter)
tlm.var.D=1e-11/1e4;                       % Ion diffusivity (cm^2/s)
tlm.var.j0=2e-9;                           %Exchange current density Au in buffered saline (A/cm^2)
tlm.var.profondeur=1;                      %(m)
tlm.var.Ci=0.07e-12*1e6^2*tlm.var.profondeur;                             %(F/m)
tlm.var.Rt=tlm.var.Vt/tlm.var.j0/tlm.var.z/1e2^2/tlm.var.profondeur;   %(Ohm*m)
tlm.var.Rwf=1e3*tlm.var.Vt/tlm.var.z^2/tlm.var.q/tlm.var.n0/(pi*tlm.var.D)^0.5/1e2^2/tlm.var.profondeur;   %(Ohm*m*Hz^0.5)
tlm.var.Cwf=1/2/pi/tlm.var.Rwf;                 %(F/m/Hz^0.5)

% String definition for Nyquist Plot
data=['   1    Hz';'   10   Hz';'   100  Hz';'   10  KHz';'   100 KHz';'   1   MHz';'   10  MHz';'   100 MHz';'   1   GHz';'   10  GHz'];
tlm.conf.f=cellstr(data);
