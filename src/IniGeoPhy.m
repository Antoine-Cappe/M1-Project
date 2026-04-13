%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                              BIOCAD Program
%                               Release 1.0
%
%   Authors: Vincent Senez
%   
%   Release 1.0 : January 2019
%   Release 2.0 : January 2025
%   Refactored  : March 2026
%
%   Routine IniGeoPhy called by Biocad,
%   Function: Initialize Geometrical & Physical Parameters
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function tlm = IniGeoPhy(tlm, model, app)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Initialise Miscellaneous Parameters
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    tlm.conf.plist = [];      % Used in SolFem & SolAna
    tlm.conf.f = [];
    tlm.conf.freq = -1;       % First we simulate the entire frequency range to plot Bode and Nyquist
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Initialize Geometrical Parameters
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    scale = 1e-3;             % Facteur de conversion
    tlm.var.scale = scale;    % Sauvegarder le scale dans tlm
    
    if tlm.conf.dim == 3
        geom_component_objects = model.component('comp1').geom('geom1').feature().tags;
        
        % Extraction des paramètres géométriques depuis COMSOL
        for i = 1:length(geom_component_objects)
            feat = model.component('comp1').geom('geom1').feature(geom_component_objects(i));
            Label = char(feat.label);
            
            switch Label
                case 'TiC_PDMS'
                    obj = model.component('comp1').geom('geom1').obj(geom_component_objects(i));
                    BoundingBox = obj.getBoundingBox();
                    tlm.var.LongueurChambre  = (BoundingBox(2) - BoundingBox(1)) * scale;
                    tlm.var.LargeurChambre   = (BoundingBox(4) - BoundingBox(3)) * scale;
                    tlm.var.EpaisseurChambre = (BoundingBox(6) - BoundingBox(5)) * scale;
                    
                    % Origin is always at the center of the Bioreactor
                    tlm.var.OrigineX = (BoundingBox(2) + BoundingBox(1)) / 2 * scale;
                    tlm.var.OrigineY = (BoundingBox(4) + BoundingBox(3)) / 2 * scale;
                    tlm.var.OrigineZ = (BoundingBox(6) + BoundingBox(5)) / 2 * scale;

                case 'Pt_canal_min'
                    obj = model.component('comp1').geom('geom1').obj(geom_component_objects(i));
                    Coor_min = obj.getVertexCoord() * scale;
                case 'Pt_canal_max'
                    obj = model.component('comp1').geom('geom1').obj(geom_component_objects(i));
                    Coor_max = obj.getVertexCoord() * scale;
                    
                case 'Electrode_1'
                    obj = model.component('comp1').geom('geom1').obj(geom_component_objects(i));
                    BoundingBox1 = obj.getBoundingBox();
                    tlm.var.LongueurElectrode  = (BoundingBox1(2) - BoundingBox1(1)) * scale;
                    tlm.var.LargeurElectrode   = (BoundingBox1(4) - BoundingBox1(3)) * scale;
                    tlm.var.EpaisseurElectrode = (BoundingBox1(6) - BoundingBox1(5)) * scale;
                    
                case 'Electrode_2'
                    obj = model.component('comp1').geom('geom1').obj(geom_component_objects(i));
                    BoundingBox2 = obj.getBoundingBox();
                    tlm.var.LongueurElectrode  = (BoundingBox2(2) - BoundingBox2(1)) * scale;
                    tlm.var.LargeurElectrode   = (BoundingBox2(4) - BoundingBox2(3)) * scale;
                    tlm.var.EpaisseurElectrode = (BoundingBox2(6) - BoundingBox2(5)) * scale;
                    
                case 'Pt_bioreactor'
                    obj = model.component('comp1').geom('geom1').obj(geom_component_objects(i));
                    Coor_pt = obj.getVertexCoord();
                    tlm.var.pt_bioreactor_x = Coor_pt(1) * scale;
                    tlm.var.pt_bioreactor_y = Coor_pt(2) * scale;
                    tlm.var.pt_bioreactor_z = Coor_pt(3) * scale;
                    
                case 'Pt_electrode_1'
                    obj = model.component('comp1').geom('geom1').obj(geom_component_objects(i));
                    Coor_pt = obj.getVertexCoord();
                    tlm.var.pt_electrode_1_x = Coor_pt(1) * scale;
                    tlm.var.pt_electrode_1_y = Coor_pt(2) * scale;
                    tlm.var.pt_electrode_1_z = Coor_pt(3) * scale;
                    
                case 'Pt_electrode_2'
                    obj = model.component('comp1').geom('geom1').obj(geom_component_objects(i));
                    Coor_pt = obj.getVertexCoord();
                    tlm.var.pt_electrode_2_x = Coor_pt(1) * scale;
                    tlm.var.pt_electrode_2_y = Coor_pt(2) * scale;
                    tlm.var.pt_electrode_2_z = Coor_pt(3) * scale;
            end
        end

        % --- LOGIQUE HALTÈRE ---
        if exist('Coor_min', 'var') && exist('Coor_max', 'var')
            tlm.var.LongueurChambre = abs(Coor_max(1) - Coor_min(1));
            tlm.var.LargeurChambre  = abs(Coor_max(2) - Coor_min(2));
            % On recentre l'origine sur le tunnel central
            tlm.var.OrigineX = (Coor_max(1) + Coor_min(1)) / 2;
            tlm.var.OrigineY = (Coor_max(2) + Coor_min(2)) / 2;
            tlm.var.OrigineZ = (Coor_max(3) + Coor_min(3)) / 2;
        end
        
        % Ecartement calculé si les deux électrodes ont été trouvées
        if exist('BoundingBox1', 'var') && exist('BoundingBox2', 'var')
            tlm.var.EcartementElectrode = (BoundingBox2(1) - BoundingBox1(2)) * scale; 
        end
        
        % Measurement Electrodes
        tlm.var.EpaisseurMesure  = 500e-9;
        tlm.var.LongueurMesure   = 10e-6;
        tlm.var.LargeurMesure    = 500e-9;
        tlm.var.EcartementMesure = 1000e-9;
        
        % Cell shape parameters
        tlm.var.Epsilon = tlm.var.EpaisseurMesure / 2;
        tlm.var.sha0    = 0.7;
        tlm.var.sha1    = 0;
        
        % Membrane Thicknesses
        tlm.var.EpaisseurMembrane = 7e-9;
        tlm.var.EpaisseurNucleus  = 1e-9;
        tlm.var.EpaisseurMitochon = 1e-9;
        
        % Cell Initialization (Factorised)
        tlm.var.Orientation.Cellule = [0, 0];
        
        for c = 1:2
            % Dimensions
            tlm.var.RayonXCellule(c) = 4.25e-6;
            tlm.var.RayonYCellule(c) = 4.25e-6;
            tlm.var.RayonZCellule(c) = 4.25e-6;
            
            tlm.var.RayonXNoyau(c) = 2.0e-6 / 2;
            tlm.var.RayonYNoyau(c) = 2.0e-6 / 2;
            tlm.var.RayonZNoyau(c) = 2.0e-6 / 2;
            
            tlm.var.RayonXMitoc(c) = 0.50e-6 / 2;
            tlm.var.RayonYMitoc(c) = 0.25e-6 / 2;
            tlm.var.RayonZMitoc(c) = 0.25e-6 / 2;
            
            % Décentrages par défaut (relatifs)
            tlm.var.DecentrageXNoyau(c) =  tlm.var.RayonXCellule(c)/2 * cos(tlm.var.Orientation.Cellule(c));
            tlm.var.DecentrageYNoyau(c) =  tlm.var.RayonYCellule(c)/2 * sin(tlm.var.Orientation.Cellule(c));
            tlm.var.DecentrageZNoyau(c) =  tlm.var.RayonZCellule(c)/2 * sin(tlm.var.Orientation.Cellule(c));
            
            tlm.var.DecentrageXMitoc(c) = -tlm.var.RayonXCellule(c)/2 * cos(tlm.var.Orientation.Cellule(c));
            tlm.var.DecentrageYMitoc(c) = -tlm.var.RayonYCellule(c)/2 * sin(tlm.var.Orientation.Cellule(c));
            tlm.var.DecentrageZMitoc(c) = -tlm.var.RayonZCellule(c)/2 * sin(tlm.var.Orientation.Cellule(c));
        end
        
        % Décentrages absolus spécifiques à chaque cellule
        if tlm.conf.Cell == 0 || tlm.conf.Cell == 1
            tlm.var.DecentrageXCellule(1) = 0.0e-6;
            tlm.var.DecentrageXCellule(2) = 0.0e-6;
        else
            tlm.var.DecentrageXCellule(1) =  tlm.var.RayonXCellule(1) + 2*tlm.var.Epsilon;
            tlm.var.DecentrageXCellule(2) = -tlm.var.RayonXCellule(1) - 2*tlm.var.Epsilon;
        end
        
        tlm.var.DecentrageYCellule(1) = 0e-6;
        tlm.var.DecentrageZCellule(1) = 4.35e-6;
        
        tlm.var.DecentrageYCellule(2) = 0e-6;
        tlm.var.DecentrageZCellule(2) = 5e-6;
        
        % Miscellanous Center Logic
        if tlm.conf.Milo == 1
            tlm.var.Center = 0e-6;
        elseif tlm.conf.Milo == 2
            tlm.var.LargeurChambre = tlm.var.LargeurChambre / 2;
            tlm.var.Center = tlm.var.LargeurChambre / 2;
        end    
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Initialise the Physical Parameters
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % --- Conductivities (S/m) ---
    tlm.var.sig.electrode   = app.Gold_conduct.Value;
    tlm.var.sig.MilOrga     = app.CM1_conduct.Value;
    tlm.var.sig.MilOrgb     = app.CM2_conduct.Value;
    tlm.var.sig.PDMS        = app.PDMS_conduct.Value;
    tlm.var.sig.Plastic_Cap = app.Plastic_Cap_conduct.Value;
    tlm.var.sig.Glass       = app.Glass_conduct.Value;
    
    % First Cell
    tlm.var.sig.MembCel(1)    = app.BC1_Mem_conduct.Value;
    tlm.var.sig.Cytoplasme(1) = app.BC1_Cyto_conduct.Value;
    tlm.var.sig.Nucleus(1)    = 0.5;
    tlm.var.sig.Mitocho(1)    = 0.5;
    tlm.var.sig.MembNuc(1)    = 0.5;
    tlm.var.sig.MembMit(1)    = 0.5;
    
    % Second Cell
    tlm.var.sig.MembCel(2)    = app.BC2_Mem_conduct.Value;
    tlm.var.sig.Cytoplasme(2) = app.BC2_Cyto_conduct.Value;
    tlm.var.sig.Nucleus(2)    = 0.53;
    tlm.var.sig.Mitocho(2)    = 0.53;
    tlm.var.sig.MembNuc(2)    = 0.53;
    tlm.var.sig.MembMit(2)    = 0.53;
    
    % --- Permittivities (F/m) ---
    tlm.var.eps0 = 8.854187817e-012; % Dielectric Permittivity of Vacuum
    
    tlm.var.eps.electrode   = app.Gold_permit.Value * tlm.var.eps0;
    tlm.var.eps.MilOrga     = app.CM1_permit.Value  * tlm.var.eps0;
    tlm.var.eps.MilOrgb     = app.CM2_permit.Value  * tlm.var.eps0;
    tlm.var.eps.PDMS        = app.PDMS_permit.Value  * tlm.var.eps0;
    tlm.var.eps.Plastic_Cap = app.Plastic_Cap_permit.Value * tlm.var.eps0;
    tlm.var.eps.Glass       = app.Glass_permit.Value * tlm.var.eps0;
    
    % First Cell
    tlm.var.eps.MembCel(1)    = app.BC1_Mem_permit.Value  * tlm.var.eps0;
    tlm.var.eps.Cytoplasme(1) = app.BC1_Cyto_permit.Value * tlm.var.eps0; 
    tlm.var.eps.Nucleus(1)    = 80 * tlm.var.eps0;
    tlm.var.eps.Mitocho(1)    = 80 * tlm.var.eps0;
    tlm.var.eps.MembNuc(1)    = 80 * tlm.var.eps0;
    tlm.var.eps.MembMit(1)    = 80 * tlm.var.eps0;
    
    % Second Cell
    tlm.var.eps.MembCel(2)    = app.BC2_Mem_permit.Value  * tlm.var.eps0;
    tlm.var.eps.Cytoplasme(2) = app.BC2_Cyto_permit.Value * tlm.var.eps0;
    tlm.var.eps.Nucleus(2)    = 80 * tlm.var.eps0;
    tlm.var.eps.Mitocho(2)    = 80 * tlm.var.eps0;
    tlm.var.eps.MembNuc(2)    = 80 * tlm.var.eps0;
    tlm.var.eps.MembMit(2)    = 80 * tlm.var.eps0;

end