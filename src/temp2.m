%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                              BIOCAD Program
%                               Release 1.0
%
%   Authors: Vincent Senez
%   
%   Release 1.0 : January 2019
%
%   Routine Remplissage3D called by Compute.m
%
%   Function: Set up the data structure for Spice in out.result
%
%   Remarks:
%   tlm.result(numeroduptincident)={numduptcible1, numtetra[], R1, C1, R2, C2, h ...}
%   with h=1 : If the segment is in the outer electrodes ...
%   [... Suite des remarques originales ...]
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [tlm, model] = Remplissage3D(tlm, model)

% Initialization
global fem_mesh_p;
global fem_mesh_t;
% global fem_mesh_e; % Non utilisé dans cette version nettoyée

% On utilise size(..., 2) en supposant que les colonnes représentent les éléments
nb_points = size(fem_mesh_p, 2);
nb_tetras = size(fem_mesh_t, 2); 

% Préallocation des structures
tlm.result = cell(nb_points, 1);
tlm.geom.boundaryEE{nb_points} = {};             
tlm.geom.boundaryEC{2, nb_points} = {};    
tlm.geom.boundaryEN{2, nb_points} = {};    
tlm.geom.boundaryEM{2, nb_points} = {};    
tlm.geom.airvol = zeros(1, nb_tetras);           

% =========================================================================
% 1. CREATION DE LA CONNECTIVITE ARETES -> TETRAEDRES
% =========================================================================

for i = 1:nb_tetras                        
    for n = 1:3
        for m = n+1:4                               
            % Sélection des nœuds (Attention: indices base 0 corrigés en base 1)
            % Correction : on utilise fem_mesh_t au lieu de fem_mesh_e
            pt1 = fem_mesh_t(n, i) + 1;    
            pt2 = fem_mesh_t(m, i) + 1;    
            
            % On s'assure que pt1 < pt2 pour éviter les doublons
            if pt1 > pt2
                temp = pt2;
                pt2 = pt1;
                pt1 = temp;
            end
            
            % Récupération des données actuelles pour le point pt1
            cell_data = tlm.result{pt1};
            
            if isempty(cell_data)           
                % Si la structure est vide, on initialise la première arête
                tlm.result{pt1} = {pt2, i, 0, 0, 0, 0, 0};            
            else
                % Recherche rapide si pt2 existe déjà (remplace la boucle while)
                % Les "pt2" sont stockés tous les 7 éléments (indices 1, 8, 15, ...)
                idx_pt2 = 1:7:length(cell_data);
                found_idx = find([cell_data{idx_pt2}] == pt2, 1);
                
                if ~isempty(found_idx)
                    % L'arête existe déjà : on ajoute juste le numéro du tétraèdre
                    % Le tableau des tétraèdres est stocké juste après pt2 (index + 1)
                    pos_tetra = idx_pt2(found_idx) + 1;
                    tlm.result{pt1}{pos_tetra} = [tlm.result{pt1}{pos_tetra}, i];       
                else
                    % L'arête n'existe pas : on la concatène à la fin
                    tlm.result{pt1} = [tlm.result{pt1}, {pt2, i, 0, 0, 0, 0, 0}];  
                end
            end 
        end   
    end 
end 

% =========================================================================
% 2. CALCUL VECTORISÉ DES VOLUMES (1/6 du volume de chaque tétraèdre)
% =========================================================================

% Extraction simultanée de tous les points pour chaque tétraèdre
p1 = fem_mesh_p(:, fem_mesh_t(1, :) + 1);
p2 = fem_mesh_p(:, fem_mesh_t(2, :) + 1);
p3 = fem_mesh_p(:, fem_mesh_t(3, :) + 1);
p4 = fem_mesh_p(:, fem_mesh_t(4, :) + 1);

% Calcul des vecteurs arêtes issus du point 1
V1 = p1 - p2;
V2 = p1 - p3;
V3 = p1 - p4;

% Calcul du produit vectoriel V2 x V3 (sur chaque colonne)
CrossX = V2(2,:).*V3(3,:) - V2(3,:).*V3(2,:);
CrossY = V2(3,:).*V3(1,:) - V2(1,:).*V3(3,:);
CrossZ = V2(1,:).*V3(2,:) - V2(2,:).*V3(1,:);

% Produit scalaire V1 . (V2 x V3) = Déterminant
det_MV = V1(1,:).*CrossX + V1(2,:).*CrossY + V1(3,:).*CrossZ;

% Le volume d'un tétraèdre est |det|/6. 
% Le code original demandait -(det)/36.
tlm.geom.airvol = -det_MV / 36;  

end