%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                              BIOCAD Program
%                               Release 1.0
%
%   Authors: Vincent Senez
%   
%   Release 1.0 : January 2019
%
%   Release 2.0 : January 2025
%
%   Routine IniGeoPhy called by Biocad,
%
%   Function: Initialize Geometrical & Physical Parameters
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function tlm=IniGeoPhy(tlm,model,app)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialise Miscellaneous Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tlm.conf.plist=[];          % tlm.conf.plist & tlm.conf.f are used in SolFem & SolAna
tlm.conf.f=[];
cpt=1;

%for a=log10(tlm.var.frequence.min):1:log10(tlm.var.frequence.max)+1


%A={'1 Hz';'10 Hz';'100 Hz';'1 KHz','10 KHz';'100 KHz','1 MHz';'10 MHz';'100 MHz';'1 GHz';'10 GHz';'100 GHz'}
%for a=log10(tlm.var.frequence.min):1:log10(tlm.var.frequence.max)
 %   if a==log10(tlm.var.frequence.max)
 %       tlm.conf.plist=[tlm.conf.plist 10^a];
 %   else
 %       for b=1:1:tlm.var.frequence.step
 %       
 %           tlm.conf.plist=[tlm.conf.plist b*10^a];
 %           if b==1
 %               if a==0 || a==1 || a==2
 %                   tlm.conf.f(cpt) = cell2mat(cellstr(['   ' num2str(10^a,'%g') ' Hz']));
 %               elseif a==3 || a==4 || a==5
 %                   tlm.conf.f(cpt) = cell2mat(cellstr(['   ' num2str(10^(a-3),'%g') ' KHz']));
 %               elseif a==6 || a==7 || a==8
 %                   tlm.conf.f(cpt) = cell2mat(cellstr(['   ' num2str(10^(a-6),'%g') ' MHz']));
 %               elseif a==9 || a==10 || a==11
 %                   tlm.conf.f(cpt) = cell2mat(cellstr(['   ' num2str(10^(a-9),'%g') ' GHz']));
 %               end
 %           end
 %       end
 %   end
 %   cpt=cpt+1; 
%end

%tlm.conf.f(cpt) = cellstr(['   ' num2str(tlm.var.frequence.max) ' Hz']);

tlm.conf.freq=-1;       % First we simulate the entire frequency range to plot Bode and Nyquist

%tlm.conf.Parasite=0;    % =0 We do not take into account the double layer

% Mise en commentaire de ce qui suit par vsnz le 08/10/2024
% tlm.conf.nam = 'COMSOL 6.2';    % Store version of COMSOL Multiphysics, used in Geom2Dcad & Geom3Dcad
%tlm.conf.ext = '';
%tlm.conf.major = 0;
%tlm.conf.build = 166;
%tlm.conf.rcs = '$Name:  $';
%tlm.conf.da = '$Date: Dec 20 2018, 23:58 $';
% fin de mise en commentaire par vsnz le 08/10/2024

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize Geometrical Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

unit = model.component('comp1').geom('geom1').lengthUnit();

% Facteur de conversion
scale = 1e-6;

% Sauvegarder le scale dans tlm
tlm.var.scale = scale;

if tlm.conf.dim==3
     %geom_component_labels = model.selection.tags;
     geom_component_objects =  model.component('comp1').geom('geom1').feature().tags;

     i=1;

     while i<=size(geom_component_objects,1) %Loop on the geometrical entities contained in geom1
         Name = model.component('comp1').geom('geom1').feature(geom_component_objects(i)).objectNames();

         %Label = mphgetselection(model.selection(geom_component_labels(i))).label;
         Label = model.component('comp1').geom('geom1').feature(Name(1)).label;

         tf=strcmp(Label,'Bioreactor');

         if tf == 1
            BoundingBox=model.component('comp1').geom('geom1').obj(geom_component_objects(i)).getBoundingBox;
            tlm.var.LongueurChambre=(BoundingBox(2)-BoundingBox(1)) * scale;      % Length of the chamber
            tlm.var.LargeurChambre=(BoundingBox(4)-BoundingBox(3)) * scale;       % Width of the chamber
            tlm.var.EpaisseurChambre=(BoundingBox(6)-BoundingBox(5)) * scale;     % Thickness of the chamber
      
            % Origin is always at the center of the Bioreactor
            
            tlm.var.OrigineX=((BoundingBox(2)+BoundingBox(1))/2) * scale;         % Origine of coordinates in X
            tlm.var.OrigineY=((BoundingBox(4)+BoundingBox(3))/2) * scale;         % Origine of coordinates in Y
            tlm.var.OrigineZ=((BoundingBox(6)+BoundingBox(5))/2) * scale;         % Origine of coordinates in Z
         end

         tf=strcmp(Label,'Electrode_1'); %26/02/2025 electrodes are surface and not volume

         if tf == 1
            BoundingBox1=model.component('comp1').geom('geom1').obj(geom_component_objects(i)).getBoundingBox;
            tlm.var.LongueurElectrode=(BoundingBox1(2)-BoundingBox1(1)) * scale;    % Length of the sollicitation electrodes
            tlm.var.LargeurElectrode=(BoundingBox1(4)-BoundingBox1(3)) * scale;    % Width of the sollicitation electrodes
            tlm.var.EpaisseurElectrode=(BoundingBox1(6)-BoundingBox1(5)) * scale;   % Thickness of the sollicitation electrodes
         end

          tf=strcmp(Label,'Electrode_2');

         if tf == 1
            BoundingBox2=model.component('comp1').geom('geom1').obj(geom_component_objects(i)).getBoundingBox;
            tlm.var.LongueurElectrode=(BoundingBox2(2)-BoundingBox2(1)) * scale;    % Length of the sollicitation electrodes
            tlm.var.LargeurElectrode=(BoundingBox2(4)-BoundingBox2(3)) * scale;    % Width of the sollicitation electrodes
            tlm.var.EpaisseurElectrode=(BoundingBox2(6)-BoundingBox2(5)) * scale;   % Thickness of the sollicitation electrodes
         end

         tf=strcmp(Label,'Pt_bioreactor');

         if tf == 1
            Coor_pt_r=model.component('comp1').geom('geom1').obj(geom_component_objects(i)).getVertexCoord;
            tlm.var.pt_bioreactor_x=Coor_pt_r(1) * scale;      % Length of the chamber
            tlm.var.pt_bioreactor_y=Coor_pt_r(2) * scale;       % Width of the chamber
            tlm.var.pt_bioreactor_z=Coor_pt_r(3) * scale;     % Thickness of the chamber
         end

         tf=strcmp(Label,'Pt_electrode_1');

         if tf == 1
            Coor_pt_1=model.component('comp1').geom('geom1').obj(geom_component_objects(i)).getVertexCoord;
            tlm.var.pt_electrode_1_x=Coor_pt_1(1) * scale;      % Length of the chamber
            tlm.var.pt_electrode_1_y=Coor_pt_1(2) * scale;       % Width of the chamber
            tlm.var.pt_electrode_1_z=Coor_pt_1(3) * scale;     % Thickness of the chamber
         end

         tf=strcmp(Label,'Pt_electrode_2');

         if tf == 1
            Coor_pt_2=model.component('comp1').geom('geom1').obj(geom_component_objects(i)).getVertexCoord;
            tlm.var.pt_electrode_2_x=Coor_pt_2(1) * scale;      % Length of the chamber
            tlm.var.pt_electrode_2_y=Coor_pt_2(2) * scale;       % Width of the chamber
            tlm.var.pt_electrode_2_z=Coor_pt_2(3) * scale;     % Thickness of the chamber
         end

         i=i+1;
     end

     tlm.var.EcartementElectrode=(BoundingBox2(1)-BoundingBox1(2)) * scale;  % Spacing between the sollicitation electrodes


     numdom=model.component('comp1').geom('geom1').getNDomains();
     
            
     % Outer Electrode

    % BoundingBox1=model.component('comp1').geom('geom1').obj('blk2').getBoundingBox;

       
   %  tlm.var.LongueurElectrode=BoundingBox1(2)-BoundingBox1(1);    % Length of the sollicitation electrodes
   %  tlm.var.LargeurElectrode=BoundingBox1(4)-BoundingBox1(2);    % Width of the sollicitation electrodes
   %  tlm.var.EpaisseurElectrode=BoundingBox1(6)-BoundingBox1(5);   % Thickness of the sollicitation electrodes

   %  BoundingBox2=model.component('comp1').geom('geom1').obj('blk3').getBoundingBox;

   %  tlm.var.EcartementElectrode=BoundingBox2(1)-BoundingBox1(2);  % Spacing between the sollicitation electrodes
    
     % Inner Electrode (to be implemented vsnz 08/10/2024)

      tlm.var.EpaisseurMesure=500e-9;     % Thickness of the measurement electrodes
      tlm.var.LongueurMesure=10e-6;       % Length of the measurement electrodes
      tlm.var.LargeurMesure=500e-9;       % Length of the measurement electrodes
      tlm.var.EcartementMesure=1000e-9;   % Spacing between the measurement electrodes

     % Reactor
     
     %BoundingBox=model.component('comp1').geom('geom1').obj('blk1').getBoundingBox;

    % tlm.var.LongueurChambre=BoundingBox(2)-BoundingBox(1);      % Length of the chamber
    % tlm.var.LargeurChambre=BoundingBox(4)-BoundingBox(3);       % Width of the chamber
    % tlm.var.EpaisseurChambre=BoundingBox(6)-BoundingBox(5);     % Thickness of the chamber
     
     tlm.var.Epsilon=tlm.var.EpaisseurMesure/2;  % Distance to locate point inside the cytoplasm
     tlm.var.sha0=0.7;                           % 1st Parameter for the parametrization of the cell shape
     tlm.var.sha1=0;                             % 2nd Parameter for the parametrization of the cell shape

     % All Cells (to be implemented vsnz 08/10/2024)
        
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
     
%      if tlm.conf.Cell==0 || tlm.conf.Cell==1
%          tlm.var.DecentrageXCellule(1)=0.0e-6;                               % Lateral X location of the 1st cell by reference to tlm.var.OrigineX
%      else
%          tlm.var.DecentrageXCellule(1)=tlm.var.RayonXCellule(1)+2*tlm.var.Epsilon;     % Lateral X location of the 1st cell by reference to tlm.var.OrigineX
%      end
%      tlm.var.DecentrageYCellule(1)=0e-6;     % Lateral Y location of the 1st cell by reference to tlm.var.OrigineY
%      tlm.var.DecentrageZCellule(1)=4.35e-6;   % Vertical Z location of the 1st cell by reference to tlm.var.OrigineZ

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

     % Miscellanous (est ce encore utile vsnz 08/10/2024)
        
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
%tlm.var.sig.electrode=str2num(tlm.model.material('mat1').propertyGroup('def').getString('electricconductivity'));    % Conductivity (S/m) of the metal (electrodes)
tlm.var.sig.electrode=app.Gold_conduct.Value;    % Conductivity (S/m) of the metal (electrodes)
% Fluid
%tlm.var.sig.MilOrga=str2num(tlm.model.material('mat2').propertyGroup('def').getString('electricconductivity'));      % Conductivity (S/m) of the external medium (serum)
tlm.var.sig.MilOrga=app.CM1_conduct.Value;
tlm.var.sig.MilOrgb=app.CM2_conduct.Value;            % Conductivity (S/m) of the external medium (serum)
% First Cell
tlm.var.sig.MembCel(1)=app.BC1_Mem_conduct.Value;            % Conductivity (S/m) of the membrane of the first cell
tlm.var.sig.Cytoplasme(1)=app.BC1_Cyto_conduct.Value;         % Conductivity (S/m) of the cytoplasm of the first cell
tlm.var.sig.Nucleus(1)=0.5;            % Conductivity (S/m) of the nucleus of the first cell
tlm.var.sig.Mitocho(1)=0.5;            % Conductivity (S/m) of the mitochondria of the first cell
tlm.var.sig.MembNuc(1)=0.5;            % Conductivity (S/m) of the nucleus membrane of the first cell
tlm.var.sig.MembMit(1)=0.5;            % Conductivity (S/m) of the mitochondria membrane of the first cell
% Second Cell
tlm.var.sig.MembCel(2)=app.BC2_Mem_conduct.Value;            % Conductivity (S/m) of the membrane of the second cell
tlm.var.sig.Cytoplasme(2)=app.BC2_Cyto_conduct.Value;         % Conductivity (S/m) of the cytoplasm of the second cell
tlm.var.sig.Nucleus(2)=0.53;            % Conductivity (S/m) of the nucleus of the second cell
tlm.var.sig.Mitocho(2)=0.53;            % Conductivity (S/m) of the mitochondria of the second cell
tlm.var.sig.MembNuc(2)=0.53;            % Conductivity (S/m) of the nucleus membrane of the second cell
tlm.var.sig.MembMit(2)=0.53;            % Conductivity (S/m) of the mitochondria membrane of the second cell

% Permittivity

tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum
    
% Electrodes
%tlm.var.eps.electrode=str2num(tlm.model.material('mat1').propertyGroup('def').getString('relpermittivity'))*tlm.var.eps0;       % Permittivity (F/m) of the metal (electrodes)
tlm.var.eps.electrode=app.Gold_permit.Value*tlm.var.eps0;
% Fluid
%tlm.var.eps.MilOrga=str2num(tlm.model.material('mat2').propertyGroup('def').getString('relpermittivity'))*tlm.var.eps0;         % Permittivity (F/m) of the external medium (serum)
tlm.var.eps.MilOrga=app.CM1_permit.Value*tlm.var.eps0;
tlm.var.eps.MilOrgb=app.CM1_permit.Value*tlm.var.eps0;         % Permittivity (F/m) of the external medium (serum)
% First Cell
tlm.var.eps.MembCel(1)=app.BC1_Mem_permit.Value*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
tlm.var.eps.Cytoplasme(18)=app.BC2_Cyto_permit.Value*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the first cell
tlm.var.eps.Nucleus(1)=80*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
tlm.var.eps.Mitocho(1)=80*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
tlm.var.eps.MembNuc(1)=80*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
tlm.var.eps.MembMit(1)=80*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
% Second Cell
tlm.var.eps.MembCel(2)=app.BC2_Mem_permit.Value*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
tlm.var.eps.Cytoplasme(2)=app.BC2_Cyto_permit.Value*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the second cell
tlm.var.eps.Nucleus(2)=80*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
tlm.var.eps.Mitocho(2)=80*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
tlm.var.eps.MembNuc(2)=80*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
tlm.var.eps.MembMit(2)=80*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell

% Parameters of the Warburg Element (electrode polarisation)
%Mise en commentaire par V Senez 29/01/2025
%tlm.var.Vt=0.025;                          % Vt=kT/q
%tlm.var.q=1.60219e-19;                     % Charge of the electron
%tlm.var.z=1;                               % Valence of ions
%tlm.var.n0=93e21;                          % Bulk number concentration of ions in electrolyte (ions/liter)
%tlm.var.D=1e-11/1e4;                       % Ion diffusivity (cm^2/s)
%tlm.var.j0=2e-9;                           %Exchange current density Au in buffered saline (A/cm^2)
%tlm.var.profondeur=100e-6;                      %(m)
%tlm.var.Ci=0.07e-12*1e6^2*tlm.var.profondeur;                             %(F/m)
%tlm.var.Rt=tlm.var.Vt/tlm.var.j0/tlm.var.z/1e2^2/tlm.var.profondeur;   %(Ohm*m)
%tlm.var.Rwf=1e3*tlm.var.Vt/tlm.var.z^2/tlm.var.q/tlm.var.n0/(pi*tlm.var.D)^0.5/1e2^2/tlm.var.profondeur;   %(Ohm*m*Hz^0.5)
%tlm.var.Cwf=1/2/pi/tlm.var.Rwf;                                           %(F/m/Hz^0.5)
%Fin mise en commentaire par V Senez 29/01/2025
