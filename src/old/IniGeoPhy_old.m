%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                              BIOCAD Program
%                               Release 1.0
%
%   Authors: Vincent Senez
%   
%   Release 1.0 : January 2019
%
%   Routine IniGeoPhy called by Biocad,
%
%   Function: Initialize Geometrical & Physical Parameters
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function tlm=IniGeoPhy(tlm)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialise Miscellaneous Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tlm.conf.plist=[];          % tlm.conf.plist & tlm.conf.f are used in SolFem & SolAna
cpt=1;

for a=log10(tlm.var.frequence.min):1:log10(tlm.var.frequence.max)
    for b=1:1:tlm.var.frequence.step
        tlm.conf.plist=[tlm.conf.plist b*10^a];
        if b==1
            if a==0 || a==1 || a==2
                tlm.conf.f(cpt) = cellstr(['   ' num2str(10^a,'%g') ' Hz']);
            elseif a==3 || a==4 || a==5
                tlm.conf.f(cpt) = cellstr(['   ' num2str(10^(a-3),'%g') ' KHz']);
            elseif a==6 || a==7 || a==8
                tlm.conf.f(cpt) = cellstr(['   ' num2str(10^(a-6),'%g') ' MHz']);
            elseif a==9 || a==10 || a==11
                tlm.conf.f(cpt) = cellstr(['   ' num2str(10^(a-9),'%g') ' GHz']);
            end
        end
    end
    cpt=cpt+1; 
end

tlm.conf.f(cpt) = cellstr(['   ' num2str(tlm.var.frequence.max) ' Hz']);

%tlm.conf.freq=-1;       % First we simulate the entire frequency range to plot Bode and Nyquist

%tlm.conf.Parasite=0;    % =0 We do not take into account the double layer

tlm.conf.nam = 'COMSOL 5.2';    % Store version of COMSOL Multiphysics, used in Geom2Dcad & Geom3Dcad
tlm.conf.ext = '';
tlm.conf.major = 0;
tlm.conf.build = 166;
tlm.conf.rcs = '$Name:  $';
tlm.conf.da = '$Date: Dec 20 2018, 23:58 $';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize Geometrical Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if tlm.conf.dim==2
    
    if tlm.conf.micro==1                % Case of continuous microfluidics

        % Origin

        tlm.var.OrigineX=0e-6;              % Origine of coordinates in X
        tlm.var.OrigineY=0e-6;              % Origine of coordinates in Y
        tlm.var.OrigineZ=0e-6;              % Origine of coordinates in Z
    
        % Outer Electrode
        
        tlm.var.EpaisseurElectrode=10.0e-6;   % Thickness of the sollicitation electrodes 
        tlm.var.LongueurElectrode=100.e-6;    % Length of the sollicitation electrodes
        tlm.var.LargeurElectrode=0.5e-6;    % Width of the sollicitation electrodes
        tlm.var.EcartementElectrode=99e-6;  % Spacing between the sollicitation electrodes
    
        % Inner Electrode
        % Warning: the algorithm do not work for inner electrodes being thinner
        % than 500 nm, narrower than 500 nm and with spacing lower than 500 nm
        % To go smaller, we need to suppress the domains corresponding to these
        % electrodes and replace them by two points on the bottom of the
        % chamber.
    
        tlm.var.EpaisseurMesure=500e-9;     % Thickness of the measurement electrodes
        tlm.var.LongueurMesure=10e-6;       % Length of the measurement electrodes
        tlm.var.LargeurMesure=500e-9;       % Length of the measurement electrodes
        tlm.var.EcartementMesure=1000e-9;   % Spacing between the measurement electrodes

        % Reactor

        tlm.var.LongueurChambre=50e-6;      % Length of the chamber
        tlm.var.LargeurChambre=100e-6;      % Width of the chamber
        tlm.var.EpaisseurChambre=10e-6;     % Thickness of the chamber
        
        tlm.var.Epsilon=tlm.var.EpaisseurMesure/4;  % Distance to locate point inside the cytoplasm    
        tlm.var.sha0=0.7;                           % 1st Parameter for the parametrization of the cell shape
        tlm.var.sha1=0;                             % 2nd Parameter for the parametrization of the cell shape

        % All Cells
        
        tlm.var.EpaisseurMembrane=7e-9;     % Thickness of the cell membrane
        tlm.var.EpaisseurNucleus=1e-9;      % Thickness of the nucleus membrane
        tlm.var.EpaisseurMitochon=1e-9;     % Thickness of the nucleus membrane
    
        % First Cell
        
        tlm.var.Orientation.Cellule(1)=0*pi/4;      % Orientation of the 1st Cell

        tlm.var.RayonXCellule(1)=4.25e-6;    % Radius X of the 1st Cell
        tlm.var.RayonYCellule(1)=4.25e-6;    % Radius Y of the 1st Cell
        tlm.var.RayonZCellule(1)=4.25e-6;    % Radius Z of the 1st Cell
        
        tlm.var.RayonXNoyau(1)=2.0e-6/2;     % Radius X of the Nucleus of the 1st Cell
        tlm.var.RayonYNoyau(1)=2.0e-6/2;     % Radius Y of the Nucleus of the 1st Cell
        tlm.var.RayonZNoyau(1)=2.0e-6/2;     % Radius Z of the Nucleus of the 1st Cell

        tlm.var.RayonXMitoc(1)=0.50e-6/2;    % Radius X of the Mitochondria of the 1st Cell
        tlm.var.RayonYMitoc(1)=0.25e-6/2;    % Radius Y of the Mitochondria of the 1st Cell
        tlm.var.RayonZMitoc(1)=0.25e-6/2;    % Radius Z of the Mitochondria of the 1st Cell
    
        if tlm.conf.Cell==0 || tlm.conf.Cell==1
            tlm.var.DecentrageXCellule(1)=0.0e-6;                               % Lateral X location of the 1st cell by reference to tlm.var.OrigineX
        else
            tlm.var.DecentrageXCellule(1)=tlm.var.RayonXCellule(1)+2*tlm.var.Epsilon;     % Lateral X location of the 1st cell by reference to tlm.var.OrigineX
        end
        tlm.var.DecentrageYCellule(1)=0e-6;     % Lateral Y location of the 1st cell by reference to tlm.var.OrigineY
        %    tlm.var.DecentrageZCellule(1)=tlm.var.EpaisseurChambre/2-0.65e-6;   % Vertical Z location of the 1st cell by reference to tlm.var.OrigineZ
        tlm.var.DecentrageZCellule(1)=tlm.var.EpaisseurChambre/2;   % Vertical Z location of the 1st cell by reference to tlm.var.OrigineZ
    
        tlm.var.DecentrageXNoyau(1)=tlm.var.RayonXCellule(1)/2*cos(tlm.var.Orientation.Cellule(1));  % Lateral X location of the nucleus of the 1st cell by reference to tlm.var.OrigineX+tlm.var.DecentrageXCellule
        tlm.var.DecentrageYNoyau(1)=tlm.var.RayonYCellule(1)/2*sin(tlm.var.Orientation.Cellule(1));  % Lateral Y location of the nucleus of the 1st cell by reference to tlm.var.OrigineY+tlm.var.DecentrageYCellule
        tlm.var.DecentrageZNoyau(1)=tlm.var.RayonZCellule(1)/2*sin(tlm.var.Orientation.Cellule(1));  % Vertical Z location of the nucleus of the 1st cell by reference to tlm.var.OrigineZ+tlm.var.DecentrageZCellule

        tlm.var.DecentrageXMitoc(1)=-tlm.var.RayonXCellule(1)/2*cos(tlm.var.Orientation.Cellule(1));  % Lateral X location of the mitochondria of the 1st cell by reference to tlm.var.OrigineX+tlm.var.DecentrageXCellule
        tlm.var.DecentrageYMitoc(1)=-tlm.var.RayonYCellule(1)/2*sin(tlm.var.Orientation.Cellule(1));  % Lateral Y location of the mitochondria of the 1st cell by reference to tlm.var.OrigineY+tlm.var.DecentrageYCellule
        tlm.var.DecentrageZMitoc(1)=-tlm.var.RayonZCellule(1)/2*sin(tlm.var.Orientation.Cellule(1));  % Vertical Z location of the mitochondria of the 1st cell by reference to tlm.var.OrigineZ+tlm.var.DecentrageZCellule

        % Second Cell
        
        tlm.var.Orientation.Cellule(2)=0;           % Orientation of the 2nd Cell
        
        tlm.var.RayonXCellule(2)=4.25e-6;    % Radius X of the 2nd Cell
        tlm.var.RayonYCellule(2)=4.25e-6;    % Radius Y of the 2nd Cell
        tlm.var.RayonZCellule(2)=4.25e-6;    % Radius Z of the 2nd Cell

        tlm.var.RayonXNoyau(2)=2e-6/2;    % Radius X of the Nucleus of the 2st Cell
        tlm.var.RayonYNoyau(2)=2e-6/2;    % Radius Y of the Nucleus of the 2st Cell
        tlm.var.RayonZNoyau(2)=2e-6/2;    % Radius Z of the Nucleus of the 2st Cell

        tlm.var.RayonXMitoc(2)=0.5e-6/2;    % Radius X of the Mitochondria of the 2st Cell
        tlm.var.RayonYMitoc(2)=0.25e-6/2;    % Radius Y of the Mitochondria of the 2st Cell
        tlm.var.RayonZMitoc(2)=0.25e-6/2;    % Radius Z of the Mitochondria of the 2st Cell
    
        if tlm.conf.Cell==0 || tlm.conf.Cell==1
            tlm.var.DecentrageXCellule(2)=0.0e-6;                               % Lateral X location of the 1st cell by reference to tlm.var.OrigineX
        else
            tlm.var.DecentrageXCellule(2)=-tlm.var.RayonXCellule(1)-2*tlm.var.Epsilon;     % Lateral X location of the 1st cell by reference to tlm.var.OrigineX
        end
        tlm.var.DecentrageYCellule(2)=0e-6;     % Lateral Y location of the 2nd cell by reference to tlm.var.OrigineY
        tlm.var.DecentrageZCellule(2)=5e-6;     % Vertical Z location of the 2nd cell by reference to tlm.var.OrigineZ

        tlm.var.DecentrageXNoyau(2)=tlm.var.RayonXCellule(2)/2*cos(tlm.var.Orientation.Cellule(2));  % Lateral X location of the nucleus of the 2nd cell by reference to tlm.var.OrigineX+tlm.var.DecentrageXCellule
        tlm.var.DecentrageYNoyau(2)=tlm.var.RayonYCellule(2)/2*sin(tlm.var.Orientation.Cellule(2));  % Lateral Y location of the nucleus of the 2nd cell by reference to tlm.var.OrigineY+tlm.var.DecentrageYCellule
        tlm.var.DecentrageZNoyau(2)=tlm.var.RayonZCellule(2)/2*sin(tlm.var.Orientation.Cellule(2));  % Vertical Z location of the nucleus of the 2nd cell by reference to tlm.var.OrigineZ+tlm.var.DecentrageZCellule

        tlm.var.DecentrageXMitoc(2)=-tlm.var.RayonXCellule(2)/2*cos(tlm.var.Orientation.Cellule(2));  % Lateral X location of the mitochondria of the 2nd cell by reference to tlm.var.OrigineX+tlm.var.DecentrageXCellule
        tlm.var.DecentrageYMitoc(2)=-tlm.var.RayonYCellule(2)/2*sin(tlm.var.Orientation.Cellule(2));  % Lateral Y location of the mitochondria of the 2nd cell by reference to tlm.var.OrigineY+tlm.var.DecentrageYCellule
        tlm.var.DecentrageZMitoc(2)=-tlm.var.RayonZCellule(2)/2*sin(tlm.var.Orientation.Cellule(2));  % Vertical Z location of the mitochondria of the 2nd cell by reference to tlm.var.OrigineZ+tlm.var.DecentrageZCellule

        % Miscellanous
        
        if tlm.conf.Milo==1
            tlm.var.Center=0e-6;
        elseif tlm.conf.Milo==2
            tlm.var.LargeurChambre=tlm.var.LargeurChambre/2;
            tlm.var.Center=tlm.var.LargeurChambre/2;% Shift for the two mediums' center
        end   
            
    elseif tlm.conf.micro==2                        % case of digital microfluidics

        % Origin

        tlm.var.OrigineX=0e-6;              % Origine of coordinates in X
        tlm.var.OrigineY=0e-6;              % Origine of coordinates in Y
        tlm.var.OrigineZ=0e-6;              % Origine of coordinates in Z
    
        % Outer Electrode
        
        tlm.var.EpaisseurElectrode=10.0e-6;   % Thickness of the sollicitation electrodes 
        tlm.var.LongueurElectrode=100.e-6;    % Length of the sollicitation electrodes
        tlm.var.LargeurElectrode=0.5e-6;    % Width of the sollicitation electrodes
        tlm.var.EcartementElectrode=99e-6;  % Spacing between the sollicitation electrodes
    
        % Inner Electrode
        % Warning: the algorithm do not work for inner electrodes being thinner
        % than 500 nm, narrower than 500 nm and with spacing lower than 500 nm
        % To go smaller, we need to suppress the domains corresponding to these
        % electrodes and replace them by two points on the bottom of the
        % chamber.
    
        tlm.var.EpaisseurMesure=500e-9;     % Thickness of the measurement electrodes
        tlm.var.LongueurMesure=10e-6;       % Length of the measurement electrodes
        tlm.var.LargeurMesure=100e-6;       % Length of the measurement electrodes
        tlm.var.EcartementMesure=1000e-9;   % Spacing between the measurement electrodes
        tlm.var.EpaisseurDielectric=500e-9;     % Thickness of the dielectric on the measurement electrodes
        tlm.var.LongueurDielectric=10e-6;       % Length of the dielectric on the measurement electrodes
        tlm.var.LargeurDielectric=500e-9;       % Length of the dielectric on the measurement electrodes
        tlm.var.EcartementDielectric=1000e-9;   % Spacing between the dielectric on the measurement electrodes

        % Reactor

        tlm.var.LongueurChambre=50e-6;      % Length of the chamber
        tlm.var.LargeurChambre=100e-6;      % Width of the chamber
        tlm.var.EpaisseurChambre=10e-6;     % Thickness of the chamber
        
        tlm.var.Epsilon=tlm.var.EpaisseurMesure/4;  % Distance to locate point inside the cytoplasm    
        tlm.var.sha0=0.7;                           % 1st Parameter for the parametrization of the cell shape
        tlm.var.sha1=0;                             % 2nd Parameter for the parametrization of the cell shape

        % All Cells
        
        tlm.var.EpaisseurMembrane=7e-9;     % Thickness of the cell membrane
        tlm.var.EpaisseurNucleus=1e-9;      % Thickness of the nucleus membrane
        tlm.var.EpaisseurMitochon=1e-9;     % Thickness of the nucleus membrane
    
        % First Cell
        
        tlm.var.Orientation.Cellule(1)=0*pi/4;      % Orientation of the 1st Cell

        tlm.var.RayonXCellule(1)=4.25e-6;    % Radius X of the 1st Cell
        tlm.var.RayonYCellule(1)=4.25e-6;    % Radius Y of the 1st Cell
        tlm.var.RayonZCellule(1)=4.25e-6;    % Radius Z of the 1st Cell
        
        tlm.var.RayonXNoyau(1)=2.0e-6/2;     % Radius X of the Nucleus of the 1st Cell
        tlm.var.RayonYNoyau(1)=2.0e-6/2;     % Radius Y of the Nucleus of the 1st Cell
        tlm.var.RayonZNoyau(1)=2.0e-6/2;     % Radius Z of the Nucleus of the 1st Cell

        tlm.var.RayonXMitoc(1)=0.50e-6/2;    % Radius X of the Mitochondria of the 1st Cell
        tlm.var.RayonYMitoc(1)=0.25e-6/2;    % Radius Y of the Mitochondria of the 1st Cell
        tlm.var.RayonZMitoc(1)=0.25e-6/2;    % Radius Z of the Mitochondria of the 1st Cell
    
        if tlm.conf.Cell==0 || tlm.conf.Cell==1
            tlm.var.DecentrageXCellule(1)=0.0e-6;                               % Lateral X location of the 1st cell by reference to tlm.var.OrigineX
        else
            tlm.var.DecentrageXCellule(1)=tlm.var.RayonXCellule(1)+2*tlm.var.Epsilon;     % Lateral X location of the 1st cell by reference to tlm.var.OrigineX
        end
        tlm.var.DecentrageYCellule(1)=0e-6;     % Lateral Y location of the 1st cell by reference to tlm.var.OrigineY
        %    tlm.var.DecentrageZCellule(1)=tlm.var.EpaisseurChambre/2-0.65e-6;   % Vertical Z location of the 1st cell by reference to tlm.var.OrigineZ
        tlm.var.DecentrageZCellule(1)=tlm.var.EpaisseurChambre/2;   % Vertical Z location of the 1st cell by reference to tlm.var.OrigineZ
    
        tlm.var.DecentrageXNoyau(1)=tlm.var.RayonXCellule(1)/2*cos(tlm.var.Orientation.Cellule(1));  % Lateral X location of the nucleus of the 1st cell by reference to tlm.var.OrigineX+tlm.var.DecentrageXCellule
        tlm.var.DecentrageYNoyau(1)=tlm.var.RayonYCellule(1)/2*sin(tlm.var.Orientation.Cellule(1));  % Lateral Y location of the nucleus of the 1st cell by reference to tlm.var.OrigineY+tlm.var.DecentrageYCellule
        tlm.var.DecentrageZNoyau(1)=tlm.var.RayonZCellule(1)/2*sin(tlm.var.Orientation.Cellule(1));  % Vertical Z location of the nucleus of the 1st cell by reference to tlm.var.OrigineZ+tlm.var.DecentrageZCellule

        tlm.var.DecentrageXMitoc(1)=-tlm.var.RayonXCellule(1)/2*cos(tlm.var.Orientation.Cellule(1));  % Lateral X location of the mitochondria of the 1st cell by reference to tlm.var.OrigineX+tlm.var.DecentrageXCellule
        tlm.var.DecentrageYMitoc(1)=-tlm.var.RayonYCellule(1)/2*sin(tlm.var.Orientation.Cellule(1));  % Lateral Y location of the mitochondria of the 1st cell by reference to tlm.var.OrigineY+tlm.var.DecentrageYCellule
        tlm.var.DecentrageZMitoc(1)=-tlm.var.RayonZCellule(1)/2*sin(tlm.var.Orientation.Cellule(1));  % Vertical Z location of the mitochondria of the 1st cell by reference to tlm.var.OrigineZ+tlm.var.DecentrageZCellule

        % Second Cell
        
        tlm.var.Orientation.Cellule(2)=0;           % Orientation of the 2nd Cell
        
        tlm.var.RayonXCellule(2)=4.25e-6;    % Radius X of the 2nd Cell
        tlm.var.RayonYCellule(2)=4.25e-6;    % Radius Y of the 2nd Cell
        tlm.var.RayonZCellule(2)=4.25e-6;    % Radius Z of the 2nd Cell

        tlm.var.RayonXNoyau(2)=2e-6/2;    % Radius X of the Nucleus of the 2st Cell
        tlm.var.RayonYNoyau(2)=2e-6/2;    % Radius Y of the Nucleus of the 2st Cell
        tlm.var.RayonZNoyau(2)=2e-6/2;    % Radius Z of the Nucleus of the 2st Cell

        tlm.var.RayonXMitoc(2)=0.5e-6/2;    % Radius X of the Mitochondria of the 2st Cell
        tlm.var.RayonYMitoc(2)=0.25e-6/2;    % Radius Y of the Mitochondria of the 2st Cell
        tlm.var.RayonZMitoc(2)=0.25e-6/2;    % Radius Z of the Mitochondria of the 2st Cell
    
        if tlm.conf.Cell==0 || tlm.conf.Cell==1
            tlm.var.DecentrageXCellule(2)=0.0e-6;                               % Lateral X location of the 1st cell by reference to tlm.var.OrigineX
        else
            tlm.var.DecentrageXCellule(2)=-tlm.var.RayonXCellule(1)-2*tlm.var.Epsilon;     % Lateral X location of the 1st cell by reference to tlm.var.OrigineX
        end
        tlm.var.DecentrageYCellule(2)=0e-6;     % Lateral Y location of the 2nd cell by reference to tlm.var.OrigineY
        tlm.var.DecentrageZCellule(2)=5e-6;     % Vertical Z location of the 2nd cell by reference to tlm.var.OrigineZ

        tlm.var.DecentrageXNoyau(2)=tlm.var.RayonXCellule(2)/2*cos(tlm.var.Orientation.Cellule(2));  % Lateral X location of the nucleus of the 2nd cell by reference to tlm.var.OrigineX+tlm.var.DecentrageXCellule
        tlm.var.DecentrageYNoyau(2)=tlm.var.RayonYCellule(2)/2*sin(tlm.var.Orientation.Cellule(2));  % Lateral Y location of the nucleus of the 2nd cell by reference to tlm.var.OrigineY+tlm.var.DecentrageYCellule
        tlm.var.DecentrageZNoyau(2)=tlm.var.RayonZCellule(2)/2*sin(tlm.var.Orientation.Cellule(2));  % Vertical Z location of the nucleus of the 2nd cell by reference to tlm.var.OrigineZ+tlm.var.DecentrageZCellule

        tlm.var.DecentrageXMitoc(2)=-tlm.var.RayonXCellule(2)/2*cos(tlm.var.Orientation.Cellule(2));  % Lateral X location of the mitochondria of the 2nd cell by reference to tlm.var.OrigineX+tlm.var.DecentrageXCellule
        tlm.var.DecentrageYMitoc(2)=-tlm.var.RayonYCellule(2)/2*sin(tlm.var.Orientation.Cellule(2));  % Lateral Y location of the mitochondria of the 2nd cell by reference to tlm.var.OrigineY+tlm.var.DecentrageYCellule
        tlm.var.DecentrageZMitoc(2)=-tlm.var.RayonZCellule(2)/2*sin(tlm.var.Orientation.Cellule(2));  % Vertical Z location of the mitochondria of the 2nd cell by reference to tlm.var.OrigineZ+tlm.var.DecentrageZCellule

        % Miscellanous
        
        if tlm.conf.Milo==1
            tlm.var.Center=0e-6;
        elseif tlm.conf.Milo==2
            tlm.var.LargeurChambre=tlm.var.LargeurChambre/2;
            tlm.var.Center=tlm.var.LargeurChambre/2;% Shift for the two mediums' center
        end
    
    end
        
elseif tlm.conf.dim==3

     % Origin

     tlm.var.OrigineX=0e-6;              % Origine of coordinates in X
     tlm.var.OrigineY=0e-6;              % Origine of coordinates in Y
     tlm.var.OrigineZ=0e-6;              % Origine of coordinates in Z
            
     % Outer Electrode

     tlm.var.EpaisseurElectrode=10e-6;   % Thickness of the sollicitation electrodes 
     tlm.var.LongueurElectrode=10e-6;    % Length of the sollicitation electrodes
     tlm.var.LargeurElectrode=100e-6;    % Width of the sollicitation electrodes
     tlm.var.EcartementElectrode=98e-6;  % Spacing between the sollicitation electrodes
    
     % Inner Electrode

     tlm.var.EpaisseurMesure=500e-9;     % Thickness of the measurement electrodes
     tlm.var.LongueurMesure=10e-6;       % Length of the measurement electrodes
     tlm.var.LargeurMesure=500e-9;       % Length of the measurement electrodes
     tlm.var.EcartementMesure=1000e-9;   % Spacing between the measurement electrodes

     % Reactor

     tlm.var.LongueurChambre=500e-6;      % Length of the chamber
     tlm.var.LargeurChambre=500e-6;       % Width of the chamber
     tlm.var.EpaisseurChambre=100e-6;     % Thickness of the chamber
     
     tlm.var.Epsilon=tlm.var.EpaisseurMesure/2;  % Distance to locate point inside the cytoplasm
     tlm.var.sha0=0.7;                           % 1st Parameter for the parametrization of the cell shape
     tlm.var.sha1=0;                             % 2nd Parameter for the parametrization of the cell shape

     % All Cells
        
     tlm.var.EpaisseurMembrane=7e-9;     % Thickness of the cell membrane
     tlm.var.EpaisseurNucleus=1e-9;      % Thickness of the nucleus membrane
     tlm.var.EpaisseurMitochon=1e-9;     % Thickness of the nucleus membrane
    
     % First Cell
        
     tlm.var.Orientation.Cellule(1)=0*pi/4;      % Orientation of the 1st Cell

     tlm.var.RayonXCellule(1)=4.25e-6;    % Radius X of the 1st Cell
     tlm.var.RayonYCellule(1)=4.25e-6;    % Radius Y of the 1st Cell
     tlm.var.RayonZCellule(1)=4.25e-6;    % Radius Z of the 1st Cell
        
     tlm.var.RayonXNoyau(1)=2.0e-6/2;     % Radius X of the Nucleus of the 1st Cell
     tlm.var.RayonYNoyau(1)=2.0e-6/2;     % Radius Y of the Nucleus of the 1st Cell
     tlm.var.RayonZNoyau(1)=2.0e-6/2;     % Radius Z of the Nucleus of the 1st Cell

     tlm.var.RayonXMitoc(1)=0.50e-6/2;    % Radius X of the Mitochondria of the 1st Cell
     tlm.var.RayonYMitoc(1)=0.25e-6/2;    % Radius Y of the Mitochondria of the 1st Cell
     tlm.var.RayonZMitoc(1)=0.25e-6/2;    % Radius Z of the Mitochondria of the 1st Cell
     
     if tlm.conf.Cell==0 || tlm.conf.Cell==1
         tlm.var.DecentrageXCellule(1)=0.0e-6;                               % Lateral X location of the 1st cell by reference to tlm.var.OrigineX
     else
         tlm.var.DecentrageXCellule(1)=tlm.var.RayonXCellule(1)+2*tlm.var.Epsilon;     % Lateral X location of the 1st cell by reference to tlm.var.OrigineX
     end
     tlm.var.DecentrageYCellule(1)=0e-6;     % Lateral Y location of the 1st cell by reference to tlm.var.OrigineY
     tlm.var.DecentrageZCellule(1)=4.35e-6;   % Vertical Z location of the 1st cell by reference to tlm.var.OrigineZ

     tlm.var.DecentrageXNoyau(1)=tlm.var.RayonXCellule(1)/2*cos(tlm.var.Orientation.Cellule(1));  % Lateral X location of the nucleus of the 1st cell by reference to tlm.var.OrigineX+tlm.var.DecentrageXCellule
     tlm.var.DecentrageYNoyau(1)=tlm.var.RayonYCellule(1)/2*sin(tlm.var.Orientation.Cellule(1));  % Lateral Y location of the nucleus of the 1st cell by reference to tlm.var.OrigineY+tlm.var.DecentrageYCellule
     tlm.var.DecentrageZNoyau(1)=tlm.var.RayonZCellule(1)/2*sin(tlm.var.Orientation.Cellule(1));  % Vertical Z location of the nucleus of the 1st cell by reference to tlm.var.OrigineZ+tlm.var.DecentrageZCellule

     tlm.var.DecentrageXMitoc(1)=-tlm.var.RayonXCellule(1)/2*cos(tlm.var.Orientation.Cellule(1));  % Lateral X location of the mitochondria of the 1st cell by reference to tlm.var.OrigineX+tlm.var.DecentrageXCellule
     tlm.var.DecentrageYMitoc(1)=-tlm.var.RayonYCellule(1)/2*sin(tlm.var.Orientation.Cellule(1));  % Lateral Y location of the mitochondria of the 1st cell by reference to tlm.var.OrigineY+tlm.var.DecentrageYCellule
     tlm.var.DecentrageZMitoc(1)=-tlm.var.RayonZCellule(1)/2*sin(tlm.var.Orientation.Cellule(1));  % Vertical Z location of the mitochondria of the 1st cell by reference to tlm.var.OrigineZ+tlm.var.DecentrageZCellule

     % Second Cell
        
     tlm.var.Orientation.Cellule(2)=0;           % Orientation of the 2nd Cell
        
     tlm.var.RayonXCellule(2)=4.25e-6;    % Radius X of the 2nd Cell
     tlm.var.RayonYCellule(2)=4.25e-6;    % Radius Y of the 2nd Cell
     tlm.var.RayonZCellule(2)=4.25e-6;    % Radius Z of the 2nd Cell        

     tlm.var.RayonXNoyau(2)=2e-6/2;    % Radius X of the Nucleus of the 2st Cell
     tlm.var.RayonYNoyau(2)=2e-6/2;    % Radius Y of the Nucleus of the 2st Cell
     tlm.var.RayonZNoyau(2)=2e-6/2;    % Radius Z of the Nucleus of the 2st Cell

     tlm.var.RayonXMitoc(2)=0.5e-6/2;    % Radius X of the Mitochondria of the 2st Cell
     tlm.var.RayonYMitoc(2)=0.25e-6/2;    % Radius Y of the Mitochondria of the 2st Cell
     tlm.var.RayonZMitoc(2)=0.25e-6/2;    % Radius Z of the Mitochondria of the 2st Cell
     
     if tlm.conf.Cell==0 || tlm.conf.Cell==1
         tlm.var.DecentrageXCellule(2)=0.0e-6;                               % Lateral X location of the 1st cell by reference to tlm.var.OrigineX
     else
         tlm.var.DecentrageXCellule(2)=-tlm.var.RayonXCellule(1)-2*tlm.var.Epsilon;     % Lateral X location of the 1st cell by reference to tlm.var.OrigineX
     end
     tlm.var.DecentrageYCellule(2)=0e-6;     % Lateral Y location of the 1st cell by reference to tlm.var.OrigineY
     tlm.var.DecentrageZCellule(2)=5e-6;     % Vertical Z location of the 1st cell by reference to tlm.var.OrigineZ

     tlm.var.DecentrageXNoyau(2)=tlm.var.RayonXCellule(2)/2*cos(tlm.var.Orientation.Cellule(2));  % Lateral X location of the nucleus of the 2nd cell by reference to tlm.var.OrigineX+tlm.var.DecentrageXCellule
     tlm.var.DecentrageYNoyau(2)=tlm.var.RayonYCellule(2)/2*sin(tlm.var.Orientation.Cellule(2));  % Lateral Y location of the nucleus of the 2nd cell by reference to tlm.var.OrigineY+tlm.var.DecentrageYCellule
     tlm.var.DecentrageZNoyau(2)=tlm.var.RayonZCellule(2)/2*sin(tlm.var.Orientation.Cellule(2));  % Vertical Z location of the nucleus of the 2nd cell by reference to tlm.var.OrigineZ+tlm.var.DecentrageZCellule

     tlm.var.DecentrageXMitoc(2)=-tlm.var.RayonXCellule(2)/2*cos(tlm.var.Orientation.Cellule(2));  % Lateral X location of the mitochondria of the 2nd cell by reference to tlm.var.OrigineX+tlm.var.DecentrageXCellule
     tlm.var.DecentrageYMitoc(2)=-tlm.var.RayonYCellule(2)/2*sin(tlm.var.Orientation.Cellule(2));  % Lateral Y location of the mitochondria of the 2nd cell by reference to tlm.var.OrigineY+tlm.var.DecentrageYCellule
     tlm.var.DecentrageZMitoc(2)=-tlm.var.RayonZCellule(2)/2*sin(tlm.var.Orientation.Cellule(2));  % Vertical Z location of the mitochondria of the 2nd cell by reference to tlm.var.OrigineZ+tlm.var.DecentrageZCellule

     % Miscellanous
        
     if tlm.conf.Milo==1
        tlm.var.Center=0e-6;
     elseif tlm.conf.Milo==2
        tlm.var.LargeurChambre=tlm.var.LargeurChambre/2;
        tlm.var.Center=tlm.var.LargeurChambre/2;% Shift for the two mediums' center
     end    
        
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialise the Physical Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Conductivities

% Electrodes
tlm.var.sig.electrode=0.5;          % Conductivity (S/m) of the metal (electrodes)
% Fluid
tlm.var.sig.MilOrga=0.5;            % Conductivity (S/m) of the external medium (serum)
tlm.var.sig.MilOrgb=1e6;            % Conductivity (S/m) of the external medium (serum)
% First Cell
tlm.var.sig.MembCel(1)=0.5;            % Conductivity (S/m) of the membrane of the first cell
tlm.var.sig.Cytoplasme(1)=0.5;         % Conductivity (S/m) of the cytoplasm of the first cell
tlm.var.sig.Nucleus(1)=0.5;            % Conductivity (S/m) of the nucleus of the first cell
tlm.var.sig.Mitocho(1)=0.5;            % Conductivity (S/m) of the mitochondria of the first cell
tlm.var.sig.MembNuc(1)=0.5;            % Conductivity (S/m) of the nucleus membrane of the first cell
tlm.var.sig.MembMit(1)=0.5;            % Conductivity (S/m) of the mitochondria membrane of the first cell
% Second Cell
tlm.var.sig.MembCel(2)=0.53;            % Conductivity (S/m) of the membrane of the second cell
tlm.var.sig.Cytoplasme(2)=0.53;         % Conductivity (S/m) of the cytoplasm of the second cell
tlm.var.sig.Nucleus(2)=0.53;            % Conductivity (S/m) of the nucleus of the second cell
tlm.var.sig.Mitocho(2)=0.53;            % Conductivity (S/m) of the mitochondria of the second cell
tlm.var.sig.MembNuc(2)=0.53;            % Conductivity (S/m) of the nucleus membrane of the second cell
tlm.var.sig.MembMit(2)=0.53;            % Conductivity (S/m) of the mitochondria membrane of the second cell

% Permittivity

tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum
    
% Electrodes
tlm.var.eps.electrode=80*tlm.var.eps0;       % Permittivity (F/m) of the metal (electrodes)
% Fluid
tlm.var.eps.MilOrga=80*tlm.var.eps0;         % Permittivity (F/m) of the external medium (serum)
tlm.var.eps.MilOrgb=80*tlm.var.eps0;         % Permittivity (F/m) of the external medium (serum)
% First Cell
tlm.var.eps.MembCel(1)=80*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the first cell
tlm.var.eps.Nucleus(1)=80*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
tlm.var.eps.Mitocho(1)=80*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
tlm.var.eps.MembNuc(1)=80*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
tlm.var.eps.MembMit(1)=80*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
% Second Cell
tlm.var.eps.MembCel(2)=80*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the second cell
tlm.var.eps.Nucleus(2)=80*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
tlm.var.eps.Mitocho(2)=80*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
tlm.var.eps.MembNuc(2)=80*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
tlm.var.eps.MembMit(2)=80*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell

% Parameters of the Warburg Element (electrode polarisation)

tlm.var.Vt=0.025;                          % Vt=kT/q
tlm.var.q=1.60219e-19;                     % Charge of the electron
tlm.var.z=1;                               % Valence of ions
tlm.var.n0=93e21;                          % Bulk number concentration of ions in electrolyte (ions/liter)
tlm.var.D=1e-11/1e4;                       % Ion diffusivity (cm^2/s)
tlm.var.j0=2e-9;                           %Exchange current density Au in buffered saline (A/cm^2)
tlm.var.profondeur=1000000e-6;                      %(m)
tlm.var.Ci=0.07e-12*1e6^2*tlm.var.profondeur;                             %(F/m)
tlm.var.Rt=tlm.var.Vt/tlm.var.j0/tlm.var.z/1e2^2/tlm.var.profondeur;   %(Ohm*m)
tlm.var.Rwf=1e3*tlm.var.Vt/tlm.var.z^2/tlm.var.q/tlm.var.n0/(pi*tlm.var.D)^0.5/1e2^2/tlm.var.profondeur;   %(Ohm*m*Hz^0.5)
tlm.var.Cwf=1/2/pi/tlm.var.Rwf;                                           %(F/m/Hz^0.5)
