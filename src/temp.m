%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                              BIOCAD Program
%                               Release 1.0
%
%   Authors: Vincent Senez
%   
%   Release 1.0 : January 2019
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

function [tlm, model] = temp(tlm, model)

    % Récupération des données de maillage globales
    global fem_mesh_p; % Noeuds (coordonnées)
    global fem_mesh_t; % Éléments (tétraèdres - 5ème ligne = domaine)
    global fem_mesh_e; % Éléments de bordure

    fprintf('\n\t . Recherche des indices du maillage...');

    % --- 1. EXTRACTION DES COORDONNÉES CIBLES (HORS BOUCLE) ---
    % On récupère les coordonnées une seule fois pour gagner en vitesse
    scale = tlm.var.scale;
    
    % Points d'intérêt (basés sur vos Labels COMSOL)
    try
        coord_pt1 = model.component('comp1').geom('geom1').obj('pt1').getVertexCoord() * scale;
        coord_pt2 = model.component('comp1').geom('geom1').obj('pt2').getVertexCoord() * scale;
        coord_pt3 = model.component('comp1').geom('geom1').obj('pt3').getVertexCoord() * scale;
    catch
        error('Erreur : Les points de repère (pt1, pt2, pt3) sont introuvables dans le modèle COMSOL.');
    end

    % --- 2. FONCTION DE RECHERCHE DE NOEUD (VECTORISÉE) ---
    % Cette fonction interne trouve l'indice du nœud le plus proche d'une coordonnée [x;y;z]
    find_node = @(target) find_nearest_node(fem_mesh_p, target);

    % Identification des points clés
    tlm.ind.pt.elec2    = find_node(coord_pt2); % Point sur l'électrode 2
    tlm.ind.pt.elec1    = find_node(coord_pt3); % Point sur l'électrode 1
    tlm.ind.pt.MilOrga  = find_node(coord_pt1); % Point dans le milieu organique

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