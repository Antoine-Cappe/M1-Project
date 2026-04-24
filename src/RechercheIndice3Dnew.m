%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                              BIOCAD Program
%                               Release 1.0
%
%   Authors: Vincent Senez
%   
%   Release 1.0 : January 2019
%   Refactored  : March 2026
%
%   Routine RechercheIndice3D called by Compute.m 
%
%   Function:   Look for the number of the Point PT1, PT2, PT3, ... in the
%               global mesh, Flag the domains, Fix the conductivity & 
%               & permittivity of each domain
%
%   Remark: RAS 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [tlm,model]=RechercheIndice3Dnew(tlm,model)

% Récupération des données de maillage globales
    global fem_mesh_p; % Noeuds (coordonnées)
    global fem_mesh_t; % Éléments (tétraèdres - 5ème ligne = domaine)
    global fem_mesh_e; % Éléments de bordure

    fprintf('\n\t . Recherche des indices du maillage...');

    % --- 1. EXTRACTION DES COORDONNÉES CIBLES (HORS BOUCLE) ---
    % On récupère les coordonnées une seule fois pour gagner en vitesse
    scale = tlm.var.scale;
    
    % Points d'intérêt : accepte plusieurs conventions de nommage COMSOL.
    coord_pt1 = get_probe_coord(model, {'pt1', 'Pt_bioreactor', 'pt_bioreactor'}, scale);
    coord_pt2 = get_probe_coord(model, {'pt2', 'Pt_electrode_2', 'pt_electrode_2'}, scale);
    coord_pt3 = get_probe_coord(model, {'pt3', 'Pt_electrode_1', 'pt_electrode_1'}, scale);

    % Fallback sur les coordonnées déjà préparées dans tlm.var.
    if isempty(coord_pt1) && isfield(tlm.var, 'pt_bioreactor_x') && isfield(tlm.var, 'pt_bioreactor_y') && isfield(tlm.var, 'pt_bioreactor_z')
        coord_pt1 = [tlm.var.pt_bioreactor_x; tlm.var.pt_bioreactor_y; tlm.var.pt_bioreactor_z];
    end
    if isempty(coord_pt2) && isfield(tlm.var, 'pt_electrode_2_x') && isfield(tlm.var, 'pt_electrode_2_y') && isfield(tlm.var, 'pt_electrode_2_z')
        coord_pt2 = [tlm.var.pt_electrode_2_x; tlm.var.pt_electrode_2_y; tlm.var.pt_electrode_2_z];
    end
    if isempty(coord_pt3) && isfield(tlm.var, 'pt_electrode_1_x') && isfield(tlm.var, 'pt_electrode_1_y') && isfield(tlm.var, 'pt_electrode_1_z')
        coord_pt3 = [tlm.var.pt_electrode_1_x; tlm.var.pt_electrode_1_y; tlm.var.pt_electrode_1_z];
    end

    % Additional fallback from geometry feature labels when point objects are absent.
    if isempty(coord_pt1)
        coord_pt1 = get_feature_center_by_labels(model, {'Central_cavity', 'Bioreactor'}, scale);
    end
    if isempty(coord_pt2)
        coord_pt2 = get_feature_center_by_labels(model, {'CC electrodes', 'PU electrodes', 'Electrode_2', 'Electrode 2'}, scale);
    end
    if isempty(coord_pt3)
        coord_pt3 = get_feature_center_by_labels(model, {'PU electrodes', 'CC electrodes', 'Electrode_1', 'Electrode 1'}, scale);
    end

    % Last-resort fallback from mesh geometry to avoid blocking the run.
    if isempty(coord_pt1)
        if isfield(tlm.var, 'OrigineX') && isfield(tlm.var, 'OrigineY') && isfield(tlm.var, 'OrigineZ')
            coord_pt1 = [tlm.var.OrigineX; tlm.var.OrigineY; tlm.var.OrigineZ];
        else
            coord_pt1 = mean(fem_mesh_p, 2);
        end
        fprintf('\n\t . Warning: bioreactor probe point missing; using fallback center point');
    end

    if isempty(coord_pt2) || isempty(coord_pt3)
        [~, iMinX] = min(fem_mesh_p(1,:));
        [~, iMaxX] = max(fem_mesh_p(1,:));
        if isempty(coord_pt3)
            coord_pt3 = fem_mesh_p(:, iMinX);
        end
        if isempty(coord_pt2)
            coord_pt2 = fem_mesh_p(:, iMaxX);
        end
        fprintf('\n\t . Warning: electrode probe points missing; using mesh X-extremes fallback');
    end

    if isempty(coord_pt1) || isempty(coord_pt2) || isempty(coord_pt3)
        error(['Erreur : points de repère introuvables même après fallback. ', ...
               'Ajoutez des points COMSOL (pt1/pt2/pt3 ou Pt_bioreactor/Pt_electrode_1/Pt_electrode_2), ', ...
               'ou renseignez les coordonnées pt_* dans tlm.var.']);
    end

    % --- 2. FONCTION DE RECHERCHE DE NOEUD (VECTORISÉE) ---
    % Cette fonction interne trouve l'indice du nœud le plus proche d'une coordonnée [x;y;z]
    find_node = @(target) find_nearest_node(fem_mesh_p, target);

    % Identification des points clés
    tlm.ind.pt.elec2    = find_node(coord_pt2); % Point sur l'électrode 2
    tlm.ind.pt.elec1    = find_node(coord_pt3); % Point sur l'électrode 1
    tlm.ind.pt.MilOrga  = find_node(coord_pt1); % Point dans le milieu organique

    % Compatibilité Netlist 4-points : si les points de mesure dédiés ne
    % sont pas définis dans cette géométrie, on crée des points de mesure
    % internes (1/3 et 2/3 entre les électrodes) au lieu des électrodes.
    if ~isfield(tlm.ind.pt, 'mesu1') || isempty(tlm.ind.pt.mesu1)
        % mesu1 at 1/3 from elec1 towards elec2
        coord_elec1 = fem_mesh_p(:, tlm.ind.pt.elec1);
        coord_elec2 = fem_mesh_p(:, tlm.ind.pt.elec2);
        coord_mesu1 = coord_elec1 + (1/3) * (coord_elec2 - coord_elec1);
        tlm.ind.pt.mesu1 = find_node(coord_mesu1);
    end
    if ~isfield(tlm.ind.pt, 'mesu2') || isempty(tlm.ind.pt.mesu2)
        % mesu2 at 2/3 from elec1 towards elec2
        coord_elec1 = fem_mesh_p(:, tlm.ind.pt.elec1);
        coord_elec2 = fem_mesh_p(:, tlm.ind.pt.elec2);
        coord_mesu2 = coord_elec1 + (2/3) * (coord_elec2 - coord_elec1);
        tlm.ind.pt.mesu2 = find_node(coord_mesu2);
    end

    % Identification des points dans les cellules
    if tlm.conf.Cell >= 1
        % Pour la cellule 1, on utilise souvent le même point que l'électrode ou un point dédié
        tlm.ind.pt.Cytoplasme(1) = find_node(coord_pt2); 
        
        % Coordonnées calculées pour Noyau/Mito (selon IniGeoPhy)
        if tlm.conf.Nucleus == 1
            target_nuc = [ (tlm.var.OrigineX + tlm.var.DecentrageYCellule(1) + tlm.var.DecentrageYNoyau(1)); ...
                           (tlm.var.OrigineY + tlm.var.DecentrageXCellule(1) + tlm.var.DecentrageXNoyau(1)); ...
                           (tlm.var.OrigineZ + tlm.var.DecentrageZCellule(1) + tlm.var.DecentrageZNoyau(1)) ];
            tlm.ind.pt.Nucleus(1) = find_node(target_nuc);
        end
    end

    if tlm.conf.Cell == 2
        % Coordonnées centre Cellule 2
        target_c2 = [ (tlm.var.OrigineX + tlm.var.DecentrageYCellule(2)); ...
                      (tlm.var.OrigineY + tlm.var.DecentrageXCellule(2)); ...
                      (tlm.var.OrigineZ + tlm.var.DecentrageZCellule(2)) ];
        tlm.ind.pt.Cytoplasme(2) = find_node(target_c2);
    end

    % --- 3. IDENTIFICATION DES DOMAINES (BOUCLE SUR LES ÉLÉMENTS) ---
    % On parcourt les éléments pour voir à quel domaine (matière) appartient chaque point
    num_elements = size(fem_mesh_t, 1);
    flags = false(1, 15); % Suivi des domaines trouvés

    % Complex-geometry safety net: make sure the domain tables exist even if
    % no probe point is matched during the first pass.
    if ~isfield(tlm, 'dom') || ~isfield(tlm.dom, 'sig') || ~isfield(tlm.dom, 'eps')
        max_domain_id = max(fem_mesh_t(:));
        tlm.dom.sig = zeros(1, max_domain_id);
        tlm.dom.eps = zeros(1, max_domain_id);
        if isfield(tlm.conf, 'complexGeometry') && tlm.conf.complexGeometry == 1
            tlm.dom.sig(:) = tlm.var.sig.CultureMedium;
            tlm.dom.eps(:) = tlm.var.eps.CultureMedium;
        end
    end

    if (isfield(tlm.conf, 'complexGeometry') && tlm.conf.complexGeometry == 1) && (~isfield(tlm.ind, 'dom') || ~isfield(tlm.ind.dom, 'MilOrga'))
        tlm.ind.dom.MilOrga = 3;
    end

    for i = 1:num_elements
        nodes_in_elem = fem_mesh_e(1:4, i); % Les 4 sommets du tétraèdre
        domain_id     = fem_mesh_t(i);   % Le numéro du domaine COMSOL

        % Identification Electrode 2
        if ~flags(1) && any(nodes_in_elem == tlm.ind.pt.elec2)
            tlm.ind.dom.elec2 = domain_id;
            tlm.dom.sig(domain_id) = tlm.var.sig.electrode;
            tlm.dom.eps(domain_id) = tlm.var.eps.electrode;
            flags(1) = true;
        end

        % Identification Electrode 1
        if ~flags(2) && any(nodes_in_elem == tlm.ind.pt.elec1)
            tlm.ind.dom.elec1 = domain_id;
            tlm.dom.sig(domain_id) = tlm.var.sig.electrode;
            tlm.dom.eps(domain_id) = tlm.var.eps.electrode;
            flags(2) = true;
        end

        % Identification Milieu Organique
        if ~flags(11) && any(nodes_in_elem == tlm.ind.pt.MilOrga)
            tlm.ind.dom.MilOrga = domain_id;
            tlm.dom.sig(domain_id) = tlm.var.sig.MilOrga;
            tlm.dom.eps(domain_id) = tlm.var.eps.MilOrga;
            flags(11) = true;
        end

        % Identification Cellules (Cytoplasme)
        for c = 1:tlm.conf.Cell
            if any(nodes_in_elem == tlm.ind.pt.Cytoplasme(c))
                tlm.ind.dom.Cytoplasme(c) = domain_id;
                tlm.dom.sig(domain_id) = tlm.var.sig.Cytoplasme(c);
                tlm.dom.eps(domain_id) = tlm.var.eps.Cytoplasme(c);
            end
        end

        % Sortie anticipée si tout est trouvé (optionnel)
        if all(flags([1, 2, 11])) && (tlm.conf.Cell == 0 || isfield(tlm.ind.dom, 'Cytoplasme'))
             % break; % Décommentez pour plus de vitesse si sûr de vos points
        end
    end

    if isfield(tlm.conf, 'complexGeometry') && tlm.conf.complexGeometry == 1
        [tlm, model] = SetDomainValues(tlm, model);
    end
end

% --- FONCTION AUXILIAIRE DE RECHERCHE ---
function idx = find_nearest_node(mesh_p, target)
    % Calcule la distance euclidienne carrée entre le target et tous les points du maillage
    % mesh_p est 3xN, target est 3x1
    dists = sum((mesh_p - target).^2, 1);
    [min_dist, idx] = min(dists);
    
    % Sécurité : si le point est à plus de 1 micron, on prévient
    if min_dist > (1e-6)^2
        warning('Le nœud le plus proche est très éloigné du point cible (dist^2 = %g)', min_dist);
    end
end

function coord = get_probe_coord(model, candidate_tags, scale)
    coord = [];
    for k = 1:numel(candidate_tags)
        tag = candidate_tags{k};
        try
            coord = model.component('comp1').geom('geom1').obj(tag).getVertexCoord() * scale;
            return;
        catch
            try
                % Some models keep probes as geometry features rather than objects.
                coord = model.component('comp1').geom('geom1').feature(tag).getVertexCoord() * scale;
                return;
            catch
                % Continue until a valid probe object is found.
            end
        end
    end
end

function coord = get_feature_center_by_labels(model, candidate_labels, scale)
    coord = [];
    try
        feat_tags_java = model.component('comp1').geom('geom1').feature.tags;
    catch
        return;
    end

    feat_tags = cell(1, numel(feat_tags_java));
    for k = 1:numel(feat_tags_java)
        feat_tags{k} = char(feat_tags_java(k));
    end

    for k = 1:numel(feat_tags)
        ftag = feat_tags{k};
        try
            flabel = char(model.component('comp1').geom('geom1').feature(ftag).label);
        catch
            continue;
        end

        for m = 1:numel(candidate_labels)
            if strcmpi(strtrim(flabel), strtrim(candidate_labels{m}))
                try
                    bb = model.component('comp1').geom('geom1').feature(ftag).getBoundingBox();
                    coord = [ (bb(1)+bb(2))/2; (bb(3)+bb(4))/2; (bb(5)+bb(6))/2 ] * scale;
                    return;
                catch
                end
            end
        end
    end
end