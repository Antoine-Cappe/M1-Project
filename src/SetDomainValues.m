function [tlm,model]=SetDomainValues(tlm,model)

    % Récupération des données de maillage globales
    global fem_mesh_p; % Noeuds (coordonnées)
    global fem_mesh_t; % Domaines

    fprintf('\n\t . Recherche des indices du maillage ...');

    % --- 1. EXTRACTION DES COORDONNÉES CIBLES (HORS BOUCLE) ---
    % On récupère les coordonnées une seule fois pour gagner en vitesse
    scale = tlm.var.scale;
    
    % Points d'intérêt (basés sur vos Labels COMSOL)
    try
        coord_pt1 = model.component('comp1').geom('geom1').obj('pt1').getVertexCoord() * scale;
        coord_pt2 = model.component('comp1').geom('geom1').obj('pt2').getVertexCoord() * scale;
    catch
        error('Erreur : Les points de repère (pt1, pt2) sont introuvables dans le modèle COMSOL.');
    end

    % --- 2. FONCTION DE RECHERCHE DE NOEUD (VECTORISÉE) ---
    % Cette fonction interne trouve l'indice du nœud le plus proche d'une coordonnée [x;y;z]
    find_node = @(target) find_nearest_node(fem_mesh_p, target);

    % Identification des points clés - A inverser selon la geométrie
    tlm.ind.pt.elec2    = find_node(coord_pt2); % Point sur l'électrode 2
    tlm.ind.pt.elec1    = find_node(coord_pt1); % Point sur l'électrode 1


    % --- 3. RÉCUPÉRATION DES STRUCTURES FIXES VIA SÉLECTIONS COMSOL ---

    if max(fem_mesh_t) == 3
        try
            domaines_MilOrg = double(model.component('comp1').selection('sel1').entities());
            domaines_elec   = double(model.component('comp1').selection('sel2').entities());
        catch
            error('Erreur : Les sélections (MilOrg, Electrode) sont introuvables dans le modèle COMSOL.');
        end

        % Assignation de l'Électrode 
        tlm.dom.sig(domaines_elec) = tlm.var.sig.electrode;
        tlm.dom.eps(domaines_elec) = tlm.var.eps.electrode;
        fprintf('\n\t tlm.dom.sig(domaines_elec) = %g', tlm.var.sig.electrode);

        % Assignation du Milieu Organique (Fluide)
        tlm.dom.sig(domaines_MilOrg) = tlm.var.sig.MilOrga;
        tlm.dom.eps(domaines_MilOrg) = tlm.var.eps.MilOrga;
    else
        try
            domaines_MilOrg = double(model.component('comp1').selection('sel1').entities());
            domaines_PDMS   = double(model.component('comp1').selection('sel2').entities());
            domaines_elec   = double(model.component('comp1').selection('sel3').entities());
            domaines_Glass  = double(model.component('comp1').selection('sel4').entities());
            domaines_Cap    = double(model.component('comp1').selection('sel5').entities());
        catch
            error('Erreur : Les sélections (MilOrg, Electrode, PDMS, Plastic, Glass) sont introuvables dans le modèle COMSOL.');
        end

        % Assignation de l'Électrode 
        tlm.dom.sig(domaines_elec) = tlm.var.sig.electrode;
        tlm.dom.eps(domaines_elec) = tlm.var.eps.electrode;
        fprintf('\n\t tlm.dom.sig(domaines_elec) = %g', tlm.var.sig.electrode);

        % Assignation du Milieu Organique (Fluide)
        tlm.dom.sig(domaines_MilOrg) = tlm.var.sig.MilOrga;
        tlm.dom.eps(domaines_MilOrg) = tlm.var.eps.MilOrga;

        % Assignation du PDMS
        tlm.dom.sig(domaines_PDMS) = tlm.var.sig.PDMS;
        tlm.dom.eps(domaines_PDMS) = tlm.var.eps.PDMS;

        % Assignation du Plastic Cap
        tlm.dom.sig(domaines_Cap) = tlm.var.sig.Plastic_Cap;
        tlm.dom.eps(domaines_Cap) = tlm.var.eps.Plastic_Cap;

        % Assignation du Glass
        tlm.dom.sig(domaines_Glass) = tlm.var.sig.Glass;
        tlm.dom.eps(domaines_Glass) = tlm.var.eps.Glass;
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