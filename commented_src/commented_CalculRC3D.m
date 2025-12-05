%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                              BIOCAD Program
%                               Release 1.0
%
%   Authors: Vincent Senez
%   Release 1.0 : January 2019
%
%   Routine CalculRC3D called by Compute.m
%
%   Function: Calculation of the values of the electrical elements
%   (Resistor, Capacitance, Voltage generator, Current sources) of the
%   equivalent electrical circuit
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

%function [tlm,fem]=CalculRC3D(tlm,fem)       % Ancienne signature (commentée)
function [tlm,model] = CalculRC3D(tlm,model)  % Nouvelle signature : renvoie tlm et model

%Initialization
global fem_mesh_p;   % fem_mesh_p : coordonnées des sommets (nodes) du maillage (colonnes = nœuds)
global fem_mesh_t;   % fem_mesh_t : informations sur les tétraèdres (numéro de domaine, etc.)
%global fem_mesh_e;  % Ancienne variable globale (commentée, plus utilisée)

% Boucle sur tous les nœuds du maillage
for i = 1:1:size(fem_mesh_p,2)    % i parcourt les indices de nœuds (colonnes de fem_mesh_p)

    % Vérifie si ce nœud i a été utilisé au moins une fois comme nœud incident
    if size(tlm.result{i},2) ~= 0 % si tlm.result{i} n’est pas vide, il y a au moins un segment partant de i
        
        % Parcours des segments associés au nœud i
        % Les informations des segments sont stockées par blocs de 7 cases : [pt_cible, liste_tetras, R1, C1, R2, C2, h]
        for j = 7:7:size(tlm.result{i},2)   % j pointe sur la 7e, 14e, 21e, ... case (= fin de chaque bloc)
            
            % (Sécurité inutile ici car i commence à 1, jamais 0)
            if i == 0
                disp(i);                    % Debug éventuel (ne s’exécute jamais)
            end
            
            % Calcul de la longueur du segment entre le nœud courant i et le nœud cible stocké en {j-6}
            long = sum((fem_mesh_p(:,i) - fem_mesh_p(:, tlm.result{i}{j-6})).^2)^0.5;
            % fem_mesh_p(:,i) : coord du nœud i
            % tlm.result{i}{j-6} : indice du nœud voisin
            % (x1-x2)^2 + (y1-y2)^2 + (z1-z2)^2, puis racine → distance euclidienne

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Interface entre électrodes externes et milieu organique
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              
            % Cas où les DEUX extrémités du segment sont sur la frontière électrode ↔ milieu organique
            if (size(tlm.geom.boundaryEE{i},1) == 1) && ...
               (size(tlm.geom.boundaryEE{ tlm.result{i}{j-6} },1) == 1)
                % Ici, on est sur un segment reliant deux nœuds tous deux situés sur la frontière électrode/électrolyte
                  
                % On stocke dans tlm.result{i}{j} la longueur du segment (h = long dans ce cas-là)
                tlm.result{i}{j} = long;                                      
                
                % On ajoute la moitié de la longueur au compteur de longueur de frontière du nœud i
                tlm.geom.boundaryEE{i} = tlm.geom.boundaryEE{i} + tlm.result{i}{j}/2;
                % Idem pour l’autre nœud du segment
                tlm.geom.boundaryEE{ tlm.result{i}{j-6} } = ...
                    tlm.geom.boundaryEE{ tlm.result{i}{j-6} } + tlm.result{i}{j}/2;
                        
                % On parcourt tous les tétraèdres entourant ce segment
                for k = 1:1:size(tlm.result{i}{j-5},2)
                    % tlm.result{i}{j-5} contient la liste des indices de tétra autour du segment
                    % fem_mesh_t(tetra,1) : donne le domaine du tétraèdre
                    
                    if fem_mesh_t(tlm.result{i}{j-5}(k),1) == tlm.ind.dom.MilOrga
                        % Si le tétra est dans le milieu organique (électrolyte)
                        
                        % On accumule σ * "airvol" côté milieu organique (R1)
                        tlm.result{i}{j-4} = tlm.result{i}{j-4} + ...
                            tlm.dom.sig( fem_mesh_t(tlm.result{i}{j-5}(k),1) ) .* tlm.geom.airvol(i);
                        % On accumule ε * "airvol" côté milieu organique (C1)
                        tlm.result{i}{j-3} = tlm.result{i}{j-3} + ...
                            tlm.dom.eps( fem_mesh_t(tlm.result{i}{j-5}(k),1) ) .* tlm.geom.airvol(i);
                    else
                        % Sinon le tétra est dans l’électrode
                        % On accumule côté électrode (R2, C2)
                        
                        % σ pour la partie électrode
                        tlm.result{i}{j-2} = tlm.result{i}{j-2} + ...
                            tlm.dom.sig( fem_mesh_t(tlm.result{i}{j-5}(k),1) ) .* tlm.geom.airvol(i);
                        % ε pour la partie électrode
                        tlm.result{i}{j-1} = tlm.result{i}{j-1} + ...
                            tlm.dom.eps( fem_mesh_t(tlm.result{i}{j-5}(k),1) ) .* tlm.geom.airvol(i);
                    end
                end
                
                % Si la partie milieu organique ne contient rien (σ=0 ou ε=0)
                % c’est le cas où le segment est en fait complètement dans l’électrode (électrodes très fines)
                if tlm.result{i}{j-4} == 0 || tlm.result{i}{j-3} == 0
                    % On encode ce segment comme étant "dans l’électrode" (h = 1)
                    tlm.result{i}{j} = 1;
                    
                    % On calcule une résistance équivalente R (segment dans l’électrode)
                    tlm.result{i}{j-4} = long^2 / ...
                        sum( tlm.dom.sig( fem_mesh_t(tlm.result{i}{j-5}(:),1) ) .* tlm.geom.airvol(i) ) / 3;
                    
                    % Et une capacité équivalente C pour ce segment
                    tlm.result{i}{j-3} = ...
                        sum( tlm.dom.eps( fem_mesh_t(tlm.result{i}{j-5}(:),1) ) .* tlm.geom.airvol(i) ) ...
                        / long^2 * 3;
                else
                    % Sinon, vraie interface : on calcule R1/C1 côté milieu organique
                    tlm.result{i}{j-4} = long^2 / tlm.result{i}{j-4} / 3;  % R1
                    tlm.result{i}{j-3} = tlm.result{i}{j-3} / long^2 * 3;  % C1
                    
                    % Et R2/C2 côté électrode
                    tlm.result{i}{j-2} = long^2 / tlm.result{i}{j-2} / 3;  % R2
                    tlm.result{i}{j-1} = tlm.result{i}{j-1} / long^2 * 3;  % C2
                end
      
            % Cas où UNE SEULE extrémité est sur la frontière électrode ↔ milieu organique
            elseif (size(tlm.geom.boundaryEE{i},1) == 1) || ...
                   (size(tlm.geom.boundaryEE{ tlm.result{i}{j-6} },1) == 1)
                  
                % On regarde le domaine du premier tétraèdre pour savoir où est majoritairement le segment
                if fem_mesh_t(tlm.result{i}{j-5}(1),1) == tlm.ind.dom.MilOrga
                    tlm.result{i}{j} = 2; % segment dans le milieu organique
                else
                    tlm.result{i}{j} = 1; % segment dans l’électrode
                end
                
                % Résistance équivalente du segment (volume+σ→R)
                tlm.result{i}{j-4} = long^2 / ...
                    sum( tlm.dom.sig( fem_mesh_t(tlm.result{i}{j-5}(:),1) ) .* tlm.geom.airvol(i) ) / 3;
                
                % Capacité équivalente du segment
                tlm.result{i}{j-3} = ...
                    sum( tlm.dom.eps( fem_mesh_t(tlm.result{i}{j-5}(:),1) ) .* tlm.geom.airvol(i) ) ...
                    / long^2 * 3;
            end
              
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Interface cytoplasme 1 ↔ milieu organique
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        
            % Cas où les deux extrémités sont sur la frontière cytoplasme(1)/milieu organique
            if (size(tlm.geom.boundaryEC{1,i},1) == 1) && ...
               (size(tlm.geom.boundaryEC{1, tlm.result{i}{j-6} },1) == 1)

                % Encode la longueur du segment
                tlm.result{i}{j} = long;                                      
                
                % Ajoute la moitié de cette longueur à la mesure de frontière pour chaque nœud
                tlm.geom.boundaryEC{1,i} = tlm.geom.boundaryEC{1,i} + tlm.result{i}{j}/2;
                tlm.geom.boundaryEC{1, tlm.result{i}{j-6} } = ...
                    tlm.geom.boundaryEC{1, tlm.result{i}{j-6} } + tlm.result{i}{j}/2;
                        
                % Parcourt les tétraèdres autour du segment
                for k = 1:1:size(tlm.result{i}{j-5},2)
                    
                    % fem_mesh_t(5, tetra) → ici 5e ligne : codage différent de fem_mesh_t
                    if fem_mesh_t(5, tlm.result{i}{j-5}(k)) == tlm.ind.dom.MilOrga
                        % Tétral dans le milieu organique
                        tlm.result{i}{j-4} = tlm.result{i}{j-4} + ...
                            tlm.dom.sig( fem_mesh_t(5, tlm.result{i}{j-5}(k)) ) .* tlm.geom.airvol(i);
                        tlm.result{i}{j-3} = tlm.result{i}{j-3} + ...
                            tlm.dom.eps( fem_mesh_t(5, tlm.result{i}{j-5}(k)) ) .* tlm.geom.airvol(i);
                    else
                        % Sinon, tétra dans le cytoplasme(1)
                        tlm.result{i}{j-2} = tlm.result{i}{j-2} + ...
                            tlm.dom.sig( fem_mesh_t(5, tlm.result{i}{j-5}(k)) ) .* tlm.geom.airvol(i);
                        tlm.result{i}{j-1} = tlm.result{i}{j-1} + ...
                            tlm.dom.eps( fem_mesh_t(5, tlm.result{i}{j-5}(k)) ) .* tlm.geom.airvol(i);
                    end
                end
                
                % Si le côté cytoplasme(1) n’a rien accumulé : segment effectivement dans l’électrolyte
                if tlm.result{i}{j-2} == 0 || tlm.result{i}{j-1} == 0
                    tlm.result{i}{j} = 4;   % code "segment dans électrolyte"
                    
                    % R équivalente dans le milieu organique
                    tlm.result{i}{j-4} = long^2 / ...
                        sum( tlm.dom.sig( fem_mesh_t(5, tlm.result{i}{j-5}(:)) ) .* tlm.geom.airvol(i) ) / 3;
                    % C équivalente
                    tlm.result{i}{j-3} = ...
                        sum( tlm.dom.eps( fem_mesh_t(5, tlm.result{i}{j-5}(:)) ) .* tlm.geom.airvol(i) ) ...
                        / long^2 * 3;
                else
                    % Sinon, vraie interface cytoplasme(1)/milieu organique
                    % R1/C1 côté milieu organique
                    tlm.result{i}{j-4} = long^2 / tlm.result{i}{j-4} / 3;
                    tlm.result{i}{j-3} = tlm.result{i}{j-3} / long^2 * 3;
                    % R2/C2 côté cytoplasme(1)
                    tlm.result{i}{j-2} = long^2 / tlm.result{i}{j-2} / 3;
                    tlm.result{i}{j-1} = tlm.result{i}{j-1} / long^2 * 3;
                end
          
            % Cas où une seule extrémité est sur la frontière cytoplasme(1)/milieu organique
            elseif (size(tlm.geom.boundaryEC{1,i},1) == 1) || ...
                   (size(tlm.geom.boundaryEC{1, tlm.result{i}{j-6} },1) == 1)
           
                if fem_mesh_t(5, tlm.result{i}{j-5}(1)) == tlm.ind.dom.MilOrga
                    tlm.result{i}{j} = 4;  % segment dans le milieu organique
                else
                    tlm.result{i}{j} = 3;  % segment dans le cytoplasme(1)
                end
                    
                % R équivalente de ce segment
                tlm.result{i}{j-4} = long^2 / ...
                    sum( tlm.dom.sig( fem_mesh_t(5, tlm.result{i}{j-5}(:)) ) .* tlm.geom.airvol(i) ) / 3;
                % C équivalente
                tlm.result{i}{j-3} = ...
                    sum( tlm.dom.eps( fem_mesh_t(5, tlm.result{i}{j-5}(:)) ) .* tlm.geom.airvol(i) ) ...
                    / long^2 * 3;
            end
              
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Interface cytoplasme 2 ↔ milieu organique (cellule 2)
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            if (size(tlm.geom.boundaryEC{2,i},1) == 1) && ...
               (size(tlm.geom.boundaryEC{2, tlm.result{i}{j-6} },1) == 1)

                tlm.result{i}{j} = long;                                     
                tlm.geom.boundaryEC{2,i} = tlm.geom.boundaryEC{2,i} + tlm.result{i}{j}/2;
                tlm.geom.boundaryEC{2, tlm.result{i}{j-6} } = ...
                    tlm.geom.boundaryEC{2, tlm.result{i}{j-6} } + tlm.result{i}{j}/2;
                        
                for k = 1:1:size(tlm.result{i}{j-5},2)
                    if fem_mesh_t(5, tlm.result{i}{j-5}(k)) == tlm.ind.dom.MilOrga
                        % côté milieu organique
                        tlm.result{i}{j-4} = tlm.result{i}{j-4} + ...
                            tlm.dom.sig( fem_mesh_t(5, tlm.result{i}{j-5}(k)) ) .* tlm.geom.airvol(i);
                        tlm.result{i}{j-3} = tlm.result{i}{j-3} + ...
                            tlm.dom.eps( fem_mesh_t(5, tlm.result{i}{j-5}(k)) ) .* tlm.geom.airvol(i);
                    else
                        % côté cytoplasme(2)
                        tlm.result{i}{j-2} = tlm.result{i}{j-2} + ...
                            tlm.dom.sig( fem_mesh_t(5, tlm.result{i}{j-5}(k)) ) .* tlm.geom.airvol(i);
                        tlm.result{i}{j-1} = tlm.result{i}{j-1} + ...
                            tlm.dom.eps( fem_mesh_t(5, tlm.result{i}{j-5}(k)) ) .* tlm.geom.airvol(i);
                    end
                end
                    
                if tlm.result{i}{j-2} == 0 || tlm.result{i}{j-1} == 0
                    tlm.result{i}{j} = 10; % segment pris comme "dans l’électrolyte"
                    tlm.result{i}{j-4} = long^2 / ...
                        sum( tlm.dom.sig( fem_mesh_t(5, tlm.result{i}{j-5}(:)) ) .* tlm.geom.airvol(i) ) / 3;
                    tlm.result{i}{j-3} = ...
                        sum( tlm.dom.eps( fem_mesh_t(5, tlm.result{i}{j-5}(:)) ) .* tlm.geom.airvol(i) ) ...
                        / long^2 * 3;                        
                else
                    tlm.result{i}{j-4} = long^2 / tlm.result{i}{j-4} / 3;
                    tlm.result{i}{j-3} = tlm.result{i}{j-3} / long^2 * 3;
                    tlm.result{i}{j-2} = long^2 / tlm.result{i}{j-2} / 3;
                    tlm.result{i}{j-1} = tlm.result{i}{j-1} / long^2 * 3;
                end
          
            elseif (size(tlm.geom.boundaryEC{2,i},1) == 1) || ...
                   (size(tlm.geom.boundaryEC{2, tlm.result{i}{j-6} },1) == 1)
           
                if fem_mesh_t(5, tlm.result{i}{j-5}(1)) == tlm.ind.dom.MilOrga
                    tlm.result{i}{j} = 10; % segment dans milieu organique
                else
                    tlm.result{i}{j} = 9;  % segment dans cytoplasme(2)
                end
                    
                tlm.result{i}{j-4} = long^2 / ...
                    sum( tlm.dom.sig( fem_mesh_t(5, tlm.result{i}{j-5}(:)) ) .* tlm.geom.airvol(i) ) / 3;
                tlm.result{i}{j-3} = ...
                    sum( tlm.dom.eps( fem_mesh_t(5, tlm.result{i}{j-5}(:)) ) .* tlm.geom.airvol(i) ) ...
                    / long^2 * 3;                     
            end
              
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Interface cytoplasme 1 ↔ noyau(1)
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            if (size(tlm.geom.boundaryEN{1,i},1) == 1) && ...
               (size(tlm.geom.boundaryEN{1, tlm.result{i}{j-6} },1) == 1)

                tlm.result{i}{j} = long;                                     
                tlm.geom.boundaryEN{1,i} = tlm.geom.boundaryEN{1,i} + tlm.result{i}{j}/2;
                tlm.geom.boundaryEN{1, tlm.result{i}{j-6} } = ...
                    tlm.geom.boundaryEN{1, tlm.result{i}{j-6} } + tlm.result{i}{j}/2;
                        
                for k = 1:1:size(tlm.result{i}{j-5},2)
                    if fem_mesh_t(5, tlm.result{i}{j-5}(k)) == tlm.ind.dom.Cytoplasme(1)
                        % côté cytoplasme(1)
                        tlm.result{i}{j-4} = tlm.result{i}{j-4} + ...
                            tlm.dom.sig( fem_mesh_t(5, tlm.result{i}{j-5}(k)) ) .* tlm.geom.airvol(i);
                        tlm.result{i}{j-3} = tlm.result{i}{j-3} + ...
                            tlm.dom.eps( fem_mesh_t(5, tlm.result{i}{j-5}(k)) ) .* tlm.geom.airvol(i);
                    else
                        % côté noyau(1)
                        tlm.result{i}{j-2} = tlm.result{i}{j-2} + ...
                            tlm.dom.sig( fem_mesh_t(5, tlm.result{i}{j-5}(k)) ) .* tlm.geom.airvol(i);
                        tlm.result{i}{j-1} = tlm.result{i}{j-1} + ...
                            tlm.dom.eps( fem_mesh_t(5, tlm.result{i}{j-5}(k)) ) .* tlm.geom.airvol(i);
                    end 
                end
                    
                if tlm.result{i}{j-4} == 0 || tlm.result{i}{j-3} == 0
                    tlm.result{i}{j} = 6;  % segment considéré "dans le noyau(1)"
                    tlm.result{i}{j-4} = long^2 / ...
                        sum( tlm.dom.sig( fem_mesh_t(5, tlm.result{i}{j-5}(:)) ) .* tlm.geom.airvol(i) ) / 3;
                    tlm.result{i}{j-3} = ...
                        sum( tlm.dom.eps( fem_mesh_t(5, tlm.result{i}{j-5}(:)) ) .* tlm.geom.airvol(i) ) ...
                        / long^2 * 3;                        
                else
                    tlm.result{i}{j-4} = long^2 / tlm.result{i}{j-4} / 3;
                    tlm.result{i}{j-3} = tlm.result{i}{j-3} / long^2 * 3;
                    tlm.result{i}{j-2} = long^2 / tlm.result{i}{j-2} / 3;
                    tlm.result{i}{j-1} = tlm.result{i}{j-1} / long^2 * 3;
                end
          
            elseif (size(tlm.geom.boundaryEN{1,i},1) == 1) || ...
                   (size(tlm.geom.boundaryEN{1, tlm.result{i}{j-6} },1) == 1)
           
                if fem_mesh_t(5, tlm.result{i}{j-5}(1)) == tlm.ind.dom.Nucleus(1)
                    tlm.result{i}{j} = 6;  % dans le noyau(1)
                else
                    tlm.result{i}{j} = 5;  % dans le cytoplasme(1)
                end
                    
                tlm.result{i}{j-4} = long^2 / ...
                    sum( tlm.dom.sig( fem_mesh_t(5, tlm.result{i}{j-5}(:)) ) .* tlm.geom.airvol(i) ) / 3;
                tlm.result{i}{j-3} = ...
                    sum( tlm.dom.eps( fem_mesh_t(5, tlm.result{i}{j-5}(:)) ) .* tlm.geom.airvol(i) ) ...
                    / long^2 * 3; 
            end
              
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Interface cytoplasme 2 ↔ noyau(2)
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            if (size(tlm.geom.boundaryEN{2,i},1) == 1) && ...
               (size(tlm.geom.boundaryEN{2, tlm.result{i}{j-6} },1) == 1)

                tlm.result{i}{j} = long;                                     
                tlm.geom.boundaryEN{2,i} = tlm.geom.boundaryEN{2,i} + tlm.result{i}{j}/2;
                tlm.geom.boundaryEN{2, tlm.result{i}{j-6} } = ...
                    tlm.geom.boundaryEN{2, tlm.result{i}{j-6} } + tlm.result{i}{j}/2;
                        
                for k = 1:1:size(tlm.result{i}{j-5},2)
                    if fem_mesh_t(5, tlm.result{i}{j-5}(k)) == tlm.ind.dom.Cytoplasme(2)
                        % côté cytoplasme(2)
                        tlm.result{i}{j-4} = tlm.result{i}{j-4} + ...
                            tlm.dom.sig( fem_mesh_t(5, tlm.result{i}{j-5}(k)) ) .* tlm.geom.airvol(i);
                        tlm.result{i}{j-3} = tlm.result{i}{j-3} + ...
                            tlm.dom.eps( fem_mesh_t(5, tlm.result{i}{j-5}(k)) ) .* tlm.geom.airvol(i);
                    else
                        % côté noyau(2)
                        tlm.result{i}{j-2} = tlm.result{i}{j-2} + ...
                            tlm.dom.sig( fem_mesh_t(5, tlm.result{i}{j-5}(k)) ) .* tlm.geom.airvol(i);
                        tlm.result{i}{j-1} = tlm.result{i}{j-1} + ...
                            tlm.dom.eps( fem_mesh_t(5, tlm.result{i}{j-5}(k)) ) .* tlm.geom.airvol(i);
                    end 
                end
                    
                if tlm.result{i}{j-4} == 0 || tlm.result{i}{j-3} == 0
                    tlm.result{i}{j} = 12; % segment pris comme "dans cytoplasme(2)"
                    tlm.result{i}{j-4} = long^2 / ...
                        sum( tlm.dom.sig( fem_mesh_t(5, tlm.result{i}{j-5}(:)) ) .* tlm.geom.airvol(i) ) / 3;
                    tlm.result{i}{j-3} = ...
                        sum( tlm.dom.eps( fem_mesh_t(5, tlm.result{i}{j-5}(:)) ) .* tlm.geom.airvol(i) ) ...
                        / long^2 * 3;                        
                else
                    tlm.result{i}{j-4} = long^2 / tlm.result{i}{j-4} / 3;
                    tlm.result{i}{j-3} = tlm.result{i}{j-3} / long^2 * 3;
                    tlm.result{i}{j-2} = long^2 / tlm.result{i}{j-2} / 3;
                    tlm.result{i}{j-1} = tlm.result{i}{j-1} / long^2 * 3;
                end
          
            elseif (size(tlm.geom.boundaryEN{2,i},1) == 1) || ...
                   (size(tlm.geom.boundaryEN{2, tlm.result{i}{j-6} },1) == 1)
           
                if fem_mesh_t(5, tlm.result{i}{j-5}(1)) == tlm.ind.dom.Nucleus(2)
                    tlm.result{i}{j} = 12;  % dans noyau(2)
                else
                    tlm.result{i}{j} = 11;  % dans cytoplasme(2)
                end
                    
                tlm.result{i}{j-4} = long^2 / ...
                    sum( tlm.dom.sig( fem_mesh_t(5, tlm.result{i}{j-5}(:)) ) .* tlm.geom.airvol(i) ) / 3;
                tlm.result{i}{j-3} = ...
                    sum( tlm.dom.eps( fem_mesh_t(5, tlm.result{i}{j-5}(:)) ) .* tlm.geom.airvol(i) ) ...
                    / long^2 * 3; 
            end

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Interface cytoplasme 1 ↔ mitochondries(1)
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            if (size(tlm.geom.boundaryEM{1,i},1) == 1) && ...
               (size(tlm.geom.boundaryEM{1, tlm.result{i}{j-6} },1) == 1)

                tlm.result{i}{j} = long;                                     
                tlm.geom.boundaryEM{1,i} = tlm.geom.boundaryEM{1,i} + tlm.result{i}{j}/2;
                tlm.geom.boundaryEM{1, tlm.result{i}{j-6} } = ...
                    tlm.geom.boundaryEM{1, tlm.result{i}{j-6} } + tlm.result{i}{j}/2;
                        
                for k = 1:1:size(tlm.result{i}{j-5},2)
                    if fem_mesh_t(5, tlm.result{i}{j-5}(k)) == tlm.ind.dom.Cytoplasme(1)
                        % côté cytoplasme(1)
                        tlm.result{i}{j-4} = tlm.result{i}{j-4} + ...
                            tlm.dom.sig( fem_mesh_t(5, tlm.result{i}{j-5}(k)) ) .* tlm.geom.airvol(i);
                        tlm.result{i}{j-3} = tlm.result{i}{j-3} + ...
                            tlm.dom.eps( fem_mesh_t(5, tlm.result{i}{j-5}(k)) ) .* tlm.geom.airvol(i);
                    else
                        % côté mitochondrie(1)
                        tlm.result{i}{j-2} = tlm.result{i}{j-2} + ...
                            tlm.dom.sig( fem_mesh_t(5, tlm.result{i}{j-5}(k)) ) .* tlm.geom.airvol(i);
                        tlm.result{i}{j-1} = tlm.result{i}{j-1} + ...
                            tlm.dom.eps( fem_mesh_t(5, tlm.result{i}{j-5}(k)) ) .* tlm.geom.airvol(i);
                    end
                end

                if tlm.result{i}{j-4} == 0 || tlm.result{i}{j-3} == 0
                    tlm.result{i}{j} = 8; % segment pris comme "dans mitochondrie(1)"
                    tlm.result{i}{j-4} = long^2 / ...
                        sum( tlm.dom.sig( fem_mesh_t(5, tlm.result{i}{j-5}(:)) ) .* tlm.geom.airvol(i) ) / 3;
                    tlm.result{i}{j-3} = ...
                        sum( tlm.dom.eps( fem_mesh_t(5, tlm.result{i}{j-5}(:)) ) .* tlm.geom.airvol(i) ) ...
                        / long^2 * 3;                        
                else
                    tlm.result{i}{j-4} = long^2 / tlm.result{i}{j-4} / 3;
                    tlm.result{i}{j-3} = tlm.result{i}{j-3} / long^2 * 3;
                    tlm.result{i}{j-2} = long^2 / tlm.result{i}{j-2} / 3;
                    tlm.result{i}{j-1} = tlm.result{i}{j-1} / long^2 * 3;
                end
          
            elseif (size(tlm.geom.boundaryEM{1,i},1) == 1) || ...
                   (size(tlm.geom.boundaryEM{1, tlm.result{i}{j-6} },1) == 1)
           
                if fem_mesh_t(5, tlm.result{i}{j-5}(1)) == tlm.ind.dom.Mitocho(1)
                    tlm.result{i}{j} = 8;  % dans mitochondrie(1)
                else
                    tlm.result{i}{j} = 7;  % dans cytoplasme(1)
                end
                    
                tlm.result{i}{j-4} = long^2 / ...
                    sum( tlm.dom.sig( fem_mesh_t(5, tlm.result{i}{j-5}(:)) ) .* tlm.geom.airvol(i) ) / 3;
                tlm.result{i}{j-3} = ...
                    sum( tlm.dom.eps( fem_mesh_t(5, tlm.result{i}{j-5}(:)) ) .* tlm.geom.airvol(i) ) ...
                    / long^2 * 3; 
            end

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Interface cytoplasme 2 ↔ mitochondries(2)
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            if (size(tlm.geom.boundaryEM{2,i},1) == 1) && ...
               (size(tlm.geom.boundaryEM{2, tlm.result{i}{j-6} },1) == 1)

                tlm.result{i}{j} = long;                                     
                tlm.geom.boundaryEM{2,i} = tlm.geom.boundaryEM{2,i} + tlm.result{i}{j}/2;
                tlm.geom.boundaryEM{2, tlm.result{i}{j-6} } = ...
                    tlm.geom.boundaryEM{2, tlm.result{i}{j-6} } + tlm.result{i}{j}/2;
                        
                for k = 1:1:size(tlm.result{i}{j-5},2)
                    if fem_mesh_t(5, tlm.result{i}{j-5}(k)) == tlm.ind.dom.Cytoplasme(2)
                        % côté cytoplasme(2)
                        tlm.result{i}{j-4} = tlm.result{i}{j-4} + ...
                            tlm.dom.sig( fem_mesh_t(5, tlm.result{i}{j-5}(k)) ) .* tlm.geom.airvol(i);
                        tlm.result{i}{j-3} = tlm.result{i}{j-3} + ...
                            tlm.dom.eps( fem_mesh_t(5, tlm.result{i}{j-5}(k)) ) .* tlm.geom.airvol(i);
                    else
                        % côté mitochondrie(2)
                        tlm.result{i}{j-2} = tlm.result{i}{j-2} + ...
                            tlm.dom.sig( fem_mesh_t(5, tlm.result{i}{j-5}(k)) ) .* tlm.geom.airvol(i);
                        tlm.result{i}{j-1} = tlm.result{i}{j-1} + ...
                            tlm.dom.eps( fem_mesh_t(5, tlm.result{i}{j-5}(k)) ) .* tlm.geom.airvol(i);
                    end
                end
                    
                if tlm.result{i}{j-4} == 0 || tlm.result{i}{j-3} == 0
                    tlm.result{i}{j} = 14; % segment pris comme "dans mitochondrie(2)"
                    tlm.result{i}{j-4} = long^2 / ...
                        sum( tlm.dom.sig( fem_mesh_t(5, tlm.result{i}{j-5}(:)) ) .* tlm.geom.airvol(i) ) / 3;
                    tlm.result{i}{j-3} = ...
                        sum( tlm.dom.eps( fem_mesh_t(5, tlm.result{i}{j-5}(:)) ) .* tlm.geom.airvol(i) ) ...
                        / long^2 * 3;                        
                else
                    tlm.result{i}{j-4} = long^2 / tlm.result{i}{j-4} / 3;
                    tlm.result{i}{j-3} = tlm.result{i}{j-3} / long^2 * 3;
                    tlm.result{i}{j-2} = long^2 / tlm.result{i}{j-2} / 3;
                    tlm.result{i}{j-1} = tlm.result{i}{j-1} / long^2 * 3;
                end
          
            elseif (size(tlm.geom.boundaryEM{2,i},1) == 1) || ...
                   (size(tlm.geom.boundaryEM{2, tlm.result{i}{j-6} },1) == 1)
           
                if fem_mesh_t(5, tlm.result{i}{j-5}(1)) == tlm.ind.dom.Mitocho(2)
                    tlm.result{i}{j} = 14; % dans mitochondrie(2)
                else
                    tlm.result{i}{j} = 13; % dans cytoplasme(2)
                end
                    
                tlm.result{i}{j-4} = long^2 / ...
                    sum( tlm.dom.sig( fem_mesh_t(5, tlm.result{i}{j-5}(:)) ) .* tlm.geom.airvol(i) ) / 3;
                tlm.result{i}{j-3} = ...
                    sum( tlm.dom.eps( fem_mesh_t(5, tlm.result{i}{j-5}(:)) ) .* tlm.geom.airvol(i) ) ...
                    / long^2 * 3; 
            end
              
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Cas où le segment n’est sur AUCUNE interface
            % (segment entièrement à l’intérieur d’un seul domaine)
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              
            if tlm.result{i}{j} == 0 % h==0 → pas d’interface détectée
                 
                % Résistance volumique "classique"
                if tlm.dom.sig( fem_mesh_t( tlm.result{i}{j-5}(:), 1 ) ) ~= 0 
                    tlm.result{i}{j-4} = ...
                        ( long^2 / ( sum( tlm.dom.sig( fem_mesh_t( tlm.result{i}{j-5}(:),1 ) ) .* ...
                                        tlm.geom.airvol(i) ) ) ) / 3;
                else
                    % σ=0 → résistance infinie, notée -1 pour la suite
                    tlm.result{i}{j-4} = -1;
                end
                  
                % Capacité volumique "classique"
                tlm.result{i}{j-3} = ...
                    ( sum( tlm.dom.eps( fem_mesh_t( tlm.result{i}{j-5}(:),1 ) ) .* ...
                           tlm.geom.airvol(i) ) / long^2 ) * 3;
            end
        end      
    end
end
