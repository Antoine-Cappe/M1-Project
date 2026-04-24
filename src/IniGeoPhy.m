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
    
    scale = 1e-6;             % Facteur de conversion
    tlm.var.scale = scale;    % Sauvegarder le scale dans tlm
    
    if tlm.conf.dim == 3
        geom_component_objects = model.component('comp1').geom('geom1').feature().tags;
        
        % Extraction des paramètres géométriques depuis COMSOL
        for i = 1:length(geom_component_objects)
            feat = model.component('comp1').geom('geom1').feature(geom_component_objects(i));
            Label = char(feat.label);
            
            switch Label
                case 'Bioreactor'
                    obj = get_geom_obj_safe(model, geom_component_objects(i));
                    if isempty(obj), continue; end
                    BoundingBox = obj.getBoundingBox();
                    tlm.var.LongueurChambre  = (BoundingBox(2) - BoundingBox(1)) * scale;
                    tlm.var.LargeurChambre   = (BoundingBox(4) - BoundingBox(3)) * scale;
                    tlm.var.EpaisseurChambre = (BoundingBox(6) - BoundingBox(5)) * scale;
                    
                    % Origin is always at the center of the Bioreactor
                    tlm.var.OrigineX = (BoundingBox(2) + BoundingBox(1)) / 2 * scale;
                    tlm.var.OrigineY = (BoundingBox(4) + BoundingBox(3)) / 2 * scale;
                    tlm.var.OrigineZ = (BoundingBox(6) + BoundingBox(5)) / 2 * scale;

                case 'Pt_canal_min'
                    obj = get_geom_obj_safe(model, geom_component_objects(i));
                    if isempty(obj), continue; end
                    Coor_min = obj.getVertexCoord() * scale;
                case 'Pt_canal_max'
                    obj = get_geom_obj_safe(model, geom_component_objects(i));
                    if isempty(obj), continue; end
                    Coor_max = obj.getVertexCoord() * scale;
                    
                case 'Electrode_1'
                    obj = get_geom_obj_safe(model, geom_component_objects(i));
                    if isempty(obj), continue; end
                    BoundingBox1 = obj.getBoundingBox();
                    tlm.var.LongueurElectrode  = (BoundingBox1(2) - BoundingBox1(1)) * scale;
                    tlm.var.LargeurElectrode   = (BoundingBox1(4) - BoundingBox1(3)) * scale;
                    tlm.var.EpaisseurElectrode = (BoundingBox1(6) - BoundingBox1(5)) * scale;
                    
                case 'Electrode_2'
                    obj = get_geom_obj_safe(model, geom_component_objects(i));
                    if isempty(obj), continue; end
                    BoundingBox2 = obj.getBoundingBox();
                    tlm.var.LongueurElectrode  = (BoundingBox2(2) - BoundingBox2(1)) * scale;
                    tlm.var.LargeurElectrode   = (BoundingBox2(4) - BoundingBox2(3)) * scale;
                    tlm.var.EpaisseurElectrode = (BoundingBox2(6) - BoundingBox2(5)) * scale;
                    
                case 'Pt_bioreactor'
                    obj = get_geom_obj_safe(model, geom_component_objects(i));
                    if isempty(obj), continue; end
                    Coor_pt = obj.getVertexCoord();
                    tlm.var.pt_bioreactor_x = Coor_pt(1) * scale;
                    tlm.var.pt_bioreactor_y = Coor_pt(2) * scale;
                    tlm.var.pt_bioreactor_z = Coor_pt(3) * scale;
                    
                case 'Pt_electrode_1'
                    obj = get_geom_obj_safe(model, geom_component_objects(i));
                    if isempty(obj), continue; end
                    Coor_pt = obj.getVertexCoord();
                    tlm.var.pt_electrode_1_x = Coor_pt(1) * scale;
                    tlm.var.pt_electrode_1_y = Coor_pt(2) * scale;
                    tlm.var.pt_electrode_1_z = Coor_pt(3) * scale;
                    
                case 'Pt_electrode_2'
                    obj = get_geom_obj_safe(model, geom_component_objects(i));
                    if isempty(obj), continue; end
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
    tlm.var.sig.electrode = app.Gold_conduct.Value;
    tlm.var.sig.MilOrga   = app.CM1_conduct.Value;
    tlm.var.sig.MilOrgb   = app.CM2_conduct.Value;
    
    % First Cell
    tlm.var.sig.MembCel(1)    = app.BC1_Mem_conduct.Value;
    tlm.var.sig.Cytoplasme(1) = app.BC1_Cyto_conduct.Value;
    % Modified by: Tina - Replace hardcoded nucleus conductivity with UI parameter
    % This allows different cell types (cancer, normal, etc.) to have different nucleus properties
    if isfield(app, 'Nucleus_conduct') && ~isempty(app.Nucleus_conduct.Value)
        tlm.var.sig.Nucleus(1) = app.Nucleus_conduct.Value;
    else
        tlm.var.sig.Nucleus(1) = 0.5;  % Default fallback value [S/m]
    end
    % Modified by: Tina - Replace hardcoded mitochondria conductivity with UI parameter
    % Mitochondria conductivity affects intracellular impedance response
    if isfield(app, 'Mitocho_conduct') && ~isempty(app.Mitocho_conduct.Value)
        tlm.var.sig.Mitocho(1) = app.Mitocho_conduct.Value;
    else
        tlm.var.sig.Mitocho(1) = 0.5;  % Default fallback value [S/m]
    end
    % Modified by: Tina - Replace hardcoded nucleus membrane conductivity with UI parameter
    if isfield(app, 'MembNuc_conduct') && ~isempty(app.MembNuc_conduct.Value)
        tlm.var.sig.MembNuc(1) = app.MembNuc_conduct.Value;
    else
        tlm.var.sig.MembNuc(1) = 0.5;  % Default fallback value [S/m]
    end
    % Modified by: Tina - Replace hardcoded mitochondria membrane conductivity with UI parameter
    if isfield(app, 'MembMit_conduct') && ~isempty(app.MembMit_conduct.Value)
        tlm.var.sig.MembMit(1) = app.MembMit_conduct.Value;
    else
        tlm.var.sig.MembMit(1) = 0.5;  % Default fallback value [S/m]
    end
    
    % Second Cell
    tlm.var.sig.MembCel(2)    = app.BC2_Mem_conduct.Value;
    tlm.var.sig.Cytoplasme(2) = app.BC2_Cyto_conduct.Value;
    % Modified by: Tina - Use same parametrized nucleus conductivity for second cell
    if isfield(app, 'Nucleus_conduct') && ~isempty(app.Nucleus_conduct.Value)
        tlm.var.sig.Nucleus(2) = app.Nucleus_conduct.Value;
    else
        tlm.var.sig.Nucleus(2) = 0.53;  % Default fallback value [S/m]
    end
    % Modified by: Tina - Use same parametrized mitochondria conductivity for second cell
    if isfield(app, 'Mitocho_conduct') && ~isempty(app.Mitocho_conduct.Value)
        tlm.var.sig.Mitocho(2) = app.Mitocho_conduct.Value;
    else
        tlm.var.sig.Mitocho(2) = 0.53;  % Default fallback value [S/m]
    end
    % Modified by: Tina - Use same parametrized nucleus membrane conductivity for second cell
    if isfield(app, 'MembNuc_conduct') && ~isempty(app.MembNuc_conduct.Value)
        tlm.var.sig.MembNuc(2) = app.MembNuc_conduct.Value;
    else
        tlm.var.sig.MembNuc(2) = 0.53;  % Default fallback value [S/m]
    end
    % Modified by: Tina - Use same parametrized mitochondria membrane conductivity for second cell
    if isfield(app, 'MembMit_conduct') && ~isempty(app.MembMit_conduct.Value)
        tlm.var.sig.MembMit(2) = app.MembMit_conduct.Value;
    else
        tlm.var.sig.MembMit(2) = 0.53;  % Default fallback value [S/m]
    end
    
    % --- Permittivities (F/m) ---
    tlm.var.eps0 = 8.854187817e-012; % Dielectric Permittivity of Vacuum
    
    tlm.var.eps.electrode = app.Gold_permit.Value * tlm.var.eps0;
    tlm.var.eps.MilOrga   = app.CM1_permit.Value  * tlm.var.eps0;
    tlm.var.eps.MilOrgb   = app.CM1_permit.Value  * tlm.var.eps0;
    
    % First Cell
    tlm.var.eps.MembCel(1)    = app.BC1_Mem_permit.Value  * tlm.var.eps0;
    tlm.var.eps.Cytoplasme(1) = app.BC1_Cyto_permit.Value * tlm.var.eps0;
    % Modified by: Tina - Replace hardcoded nucleus permittivity with UI parameter [F/m]
    % Nucleus permittivity affects dielectric response and cell polarization impedance
    if isfield(app, 'Nucleus_permit') && ~isempty(app.Nucleus_permit.Value)
        tlm.var.eps.Nucleus(1) = app.Nucleus_permit.Value * tlm.var.eps0;
    else
        tlm.var.eps.Nucleus(1) = 80 * tlm.var.eps0;  % Default fallback relative permittivity = 80
    end
    % Modified by: Tina - Replace hardcoded mitochondria permittivity with UI parameter [F/m]
    if isfield(app, 'Mitocho_permit') && ~isempty(app.Mitocho_permit.Value)
        tlm.var.eps.Mitocho(1) = app.Mitocho_permit.Value * tlm.var.eps0;
    else
        tlm.var.eps.Mitocho(1) = 80 * tlm.var.eps0;  % Default fallback relative permittivity = 80
    end
    % Modified by: Tina - Replace hardcoded nucleus membrane permittivity with UI parameter [F/m]
    if isfield(app, 'MembNuc_permit') && ~isempty(app.MembNuc_permit.Value)
        tlm.var.eps.MembNuc(1) = app.MembNuc_permit.Value * tlm.var.eps0;
    else
        tlm.var.eps.MembNuc(1) = 80 * tlm.var.eps0;  % Default fallback relative permittivity = 80
    end
    % Modified by: Tina - Replace hardcoded mitochondria membrane permittivity with UI parameter [F/m]
    if isfield(app, 'MembMit_permit') && ~isempty(app.MembMit_permit.Value)
        tlm.var.eps.MembMit(1) = app.MembMit_permit.Value * tlm.var.eps0;
    else
        tlm.var.eps.MembMit(1) = 80 * tlm.var.eps0;  % Default fallback relative permittivity = 80
    end
    
    % Second Cell
    tlm.var.eps.MembCel(2)    = app.BC2_Mem_permit.Value  * tlm.var.eps0;
    tlm.var.eps.Cytoplasme(2) = app.BC2_Cyto_permit.Value * tlm.var.eps0;
    % Modified by: Tina - Use same parametrized nucleus permittivity for second cell [F/m]
    if isfield(app, 'Nucleus_permit') && ~isempty(app.Nucleus_permit.Value)
        tlm.var.eps.Nucleus(2) = app.Nucleus_permit.Value * tlm.var.eps0;
    else
        tlm.var.eps.Nucleus(2) = 80 * tlm.var.eps0;  % Default fallback relative permittivity = 80
    end
    % Modified by: Tina - Use same parametrized mitochondria permittivity for second cell [F/m]
    if isfield(app, 'Mitocho_permit') && ~isempty(app.Mitocho_permit.Value)
        tlm.var.eps.Mitocho(2) = app.Mitocho_permit.Value * tlm.var.eps0;
    else
        tlm.var.eps.Mitocho(2) = 80 * tlm.var.eps0;  % Default fallback relative permittivity = 80
    end
    % Modified by: Tina - Use same parametrized nucleus membrane permittivity for second cell [F/m]
    if isfield(app, 'MembNuc_permit') && ~isempty(app.MembNuc_permit.Value)
        tlm.var.eps.MembNuc(2) = app.MembNuc_permit.Value * tlm.var.eps0;
    else
        tlm.var.eps.MembNuc(2) = 80 * tlm.var.eps0;  % Default fallback relative permittivity = 80
    end
    % Modified by: Tina - Use same parametrized mitochondria membrane permittivity for second cell [F/m]
    if isfield(app, 'MembMit_permit') && ~isempty(app.MembMit_permit.Value)
        tlm.var.eps.MembMit(2) = app.MembMit_permit.Value * tlm.var.eps0;
    else
        tlm.var.eps.MembMit(2) = 80 * tlm.var.eps0;  % Default fallback relative permittivity = 80
    end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Complex geometry override: COMSOL TiC / electrode stack model
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Keep the legacy fields for downstream code, but populate them with
        % the explicit geometry parameters defined in the COMSOL model.

        tlm.conf.complexGeometry = 1;

        % Global geometry toggles
        tlm.conf.matrix = 1;
        tlm.conf.electrodes = 1;
        tlm.conf.elec_dl = 1;

        % COMSOL geometric parameters
        tlm.var.channel_h         = 600e-6;
        tlm.var.glass_h           = 1e-3;
        tlm.var.io_w              = 2e-3;
        tlm.var.io_d              = 0.5e-3;
        tlm.var.chamfer           = 1e-3;
        tlm.var.fillet            = 3e-3;
        tlm.var.central_well      = 6.94e-3;
        tlm.var.pattern           = 8.99e-3;
        tlm.var.inlet_diameter    = 0.5e-3;
        tlm.var.marge             = 1e-3;
        tlm.var.TiC_channel_depth = 7.94e-3;
        tlm.var.TiC_height        = 4e-3;
        tlm.var.TiC_width         = 35e-3;
        tlm.var.TiC_depth         = 15e-3;
        tlm.var.ID_inlet_diameter = 0.5e-3;

        % Legacy geometry fields reused by downstream code
        tlm.var.LongueurChambre    = tlm.var.TiC_width;
        tlm.var.LargeurChambre     = tlm.var.TiC_depth;
        tlm.var.EpaisseurChambre   = tlm.var.TiC_height;
        tlm.var.OrigineX           = 0;
        tlm.var.OrigineY           = 0;
        tlm.var.OrigineZ           = tlm.var.EpaisseurChambre / 2;
        tlm.var.LongueurElectrode  = 1500e-6;
        tlm.var.LargeurElectrode   = 500e-6;
        tlm.var.EpaisseurElectrode = 30e-6;
        tlm.var.EcartementElectrode = tlm.var.central_well;
        tlm.var.EpaisseurMesure    = 1.5e-6;
        tlm.var.LongueurMesure     = 30e-6;
        tlm.var.LargeurMesure      = 250e-6;
        tlm.var.EcartementMesure   = tlm.var.inlet_diameter;
        tlm.var.Epsilon            = tlm.var.EpaisseurMesure / 2;
        tlm.var.Center             = 0;

        % Explicit complex-geometry material values from COMSOL
        tlm.var.sig.Glass         = 1e-14;
        tlm.var.eps.Glass         = 4.2 * tlm.var.eps0;
        tlm.var.sig.PDMS          = 1e-12;
        tlm.var.eps.PDMS          = 2.75 * tlm.var.eps0;
        tlm.var.sig.CultureMedium = 1.5;
        tlm.var.eps.CultureMedium = 80 * tlm.var.eps0;
        tlm.var.sig.Matrix        = 1.5;
        tlm.var.eps.Matrix        = 80 * tlm.var.eps0;
        tlm.var.sig.Platinum      = 8.9e6;
        tlm.var.eps.Platinum      = 1 * tlm.var.eps0;
        tlm.var.sig.DoubleLayer   = 1e-12;
        tlm.var.eps.DoubleLayer   = 1700 * tlm.var.eps0;
        tlm.var.sig.Plastic       = 1e-14;
        tlm.var.eps.Plastic       = 4.2 * tlm.var.eps0;

        % Keep the legacy conductivity/permittivity fields aligned with the
        % complex geometry model so the rest of BIOCAD can reuse them.
        tlm.var.sig.electrode = tlm.var.sig.Platinum;
        tlm.var.eps.electrode = tlm.var.eps.Platinum;
        tlm.var.sig.MilOrga   = tlm.var.sig.CultureMedium;
        tlm.var.eps.MilOrga   = tlm.var.eps.CultureMedium;
        tlm.var.sig.MilOrgb   = tlm.var.sig.Matrix;
        tlm.var.eps.MilOrgb   = tlm.var.eps.Matrix;
        tlm.var.v0            = 25e-3;

        fprintf('\n\t\t . Complex geometry parameters loaded: channel_h=%.3g m, glass_h=%.3g m, central_well=%.3g m', ...
            tlm.var.channel_h, tlm.var.glass_h, tlm.var.central_well);
        fprintf('\n\t\t . Complex materials loaded: Glass, PDMS, Culture Medium, Matrix, Platinum, Double Layer, Plastic');

end

function obj = get_geom_obj_safe(model, tag)
    obj = [];
    try
        obj = model.component('comp1').geom('geom1').obj(tag);
    catch
        % Some geometry feature tags do not map to resolvable geometry objects.
    end
end