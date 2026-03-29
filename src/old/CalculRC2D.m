%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                              BIOCAD Program
%                               Release 1.0
%
%   Authors: Vincent Senez
%   
%   Release 1.0 : January 2019
%
%   Routine CalculRC2D called by Compute.m
%
%   Function: Calculation of the values of the electrical elements
%   (Resistor, Capacitance, Voltage generator, Current sources) of the
%   equivalent electrical circuit
%
%   Remarks:
%   tlm.result(numeroduptincident)={numduptcible1, trgdroite1, trggauche1, R1, C1, R2, C2, h ...}
%   with h=1 : If the segment is in the outer electrodes and one edge is in contact with the organic medium (serum) 
%          2 : If the segment is in the organic medium and one edge is in contact with the outer electrodes 
%          3 : If the segment is in the cytoplasm(1) and one edge is in contact with the organic medium (serum) 
%          4 : If the segment is in the organic medium and one edge is in contact with the cytoplasm(1) 
%          5 : If the segment is in the cytoplasm(1) and one edge is in contact with the nucleus(1) 
%          6 : If the segment is in the nucleus(1) and one edge is in contact with the cytoplasm(1)
%          7 : If the segment is in the cytoplasm(1) and one edge is in contact with the mitochon(1) 
%          8 : If the segment is in the mitochon(1) and one edge is in contact with the cytoplasm(1)
%          9 : If the segment is in the cytoplasm(2) and one edge is in contact with the organic medium
%         10 : If the segment is in the organic medium and one edge is in contact with the cytoplasm(2) 
%         11 : If the segment is in the cytoplasm(2) and one edge is in contact with the nucleus(2) 
%         12 : If the segment is in the nucleus(2) and one edge is in contact with the cytoplasm(2)
%         13 : If the segment is in the cytoplasm(2) and one edge is in contact with the mitochon(2) 
%         14 : If the segment is in the mitochon(2) and one edge is in contact with the cytoplasm(2)
%          Length of the segment : If the segment is at the interface (for parasitics with ST2)
%
%   tlm.geom.boundaryEE{numdupt}=0  or length of the segment if the node is at the interface between the 
%                                   outer electrodes - organic medium (serum) (for the parasitics with ST1)
%   tlm.geom.boundaryEC{numcell,numdupt}=0  or length of the segment if the node is at the interface between the 
%                                   cytoplasm(1) or (2) - organic medium (serum)
%   tlm.geom.boundaryEN{numcell,numdupt}=0  or length of the segment if the node is at the interface between the 
%                                   nucleus(1) or (2) - cytoplasm (1) or (2)
%   tlm.geom.boundaryEM{numcell,numdupt}=0  or length of the segment if the node is at the interface between the 
%                                   mitochondria(1) or (2) - cytoplasm(1) or (2)
%
%   tlm.geom.airvol(numdutrg)= third of the surface of the triangle
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [tlm,model]=CalculRC2D(tlm,model)
%function [tlm,fem]=CalculRC2D(tlm,fem)

%Initialization

global fem_mesh_p;
global fem_mesh_t;
global fem_mesh_e;

for i=1:1:size(fem_mesh_p,2)                % Loop on the number of nodes

    if size(tlm.result{i},2)~=0             % Check whether the node has been selected once as an incident point
        
        for j=8:8:size(tlm.result{i},2)
            
            if tlm.result{i}{j-5}~=0        % If it is not on the edge of the structure (there is a triangle on both side)
                
                long=sum((fem_mesh_p(:,i)-fem_mesh_p(:,tlm.result{i}{j-7})).^2)^0.5;    % Calculation of the size between the 2 nodes
                
 % Interface between solicitation electrodes and organic medium
 
                if (size(tlm.geom.boundaryEE{i},1)==1) || (size(tlm.geom.boundaryEE{tlm.result{i}{j-7}},1)==1) % It is an interface between the organic medium (serum) and the outer electrodes
                    
                    % If it is close to parasitics
                    
                    if ((fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.MilOrga) && ...
                        (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.elec1)) || ...
                        ((fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.elec1) && ...
                        (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.MilOrga)) ||...
                        ((fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.MilOrga) && ...
                        (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.elec2)) || ...
                        ((fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.elec2) && ...
                        (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.MilOrga))
                    
                        % If the segment is at the interface between the
                        % outer electrodes & the organic medium
                        tlm.result{i}{j}=long;                                      % Length of the segment
                        tlm.geom.boundaryEE{i}=tlm.geom.boundaryEE{i}+tlm.result{i}{j}/2;
                        tlm.geom.boundaryEE{tlm.result{i}{j-7}}=tlm.geom.boundaryEE{tlm.result{i}{j-7}}+tlm.result{i}{j}/2; %Half of the segment is added on each node at the interface
                        
                    elseif ((fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.MilOrgb) && ...
                        (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.elec1)) || ...
                        ((fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.elec1) && ...
                        (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.MilOrgb)) || ...
                        ((fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.MilOrgb) && ...
                        (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.elec2)) || ...
                        ((fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.elec2) && ...
                        (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.MilOrgb))
                    
                        % If the segment is at the interface between the outer electrodes & the organic medium

                        tlm.result{i}{j}=long;                                      % Length of the segment
                        tlm.geom.boundaryEE{i}=tlm.geom.boundaryEE{i}+tlm.result{i}{j}/2;
                        tlm.geom.boundaryEE{tlm.result{i}{j-7}}=tlm.geom.boundaryEE{tlm.result{i}{j-7}}+tlm.result{i}{j}/2; %Half of the segment is added on each node at the interface

                    elseif (fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.elec1) || ...
                           (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.elec1) || ...
                           (fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.elec2) || ...
                           (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.elec2)

                       tlm.result{i}{j}=1;                                         % This segment is in the electrodes
                    else
                        tlm.result{i}{j}=2;                                         % This segment is in the organic medium
                    end
                    
                end
                                
% Interface between cytoplasm of first cell and organic medium

                if (size(tlm.geom.boundaryEC{1,i},1)==1) || (size(tlm.geom.boundaryEC{1,tlm.result{i}{j-7}},1)==1)  % It is an interface between the organic medium (serum) and the cytoplasm(1)
               
                  
                    if ((fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.MilOrga) && ...
                        (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.Cytoplasme(1))) || ...
                        ((fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.Cytoplasme(1)) && ...
                        (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.MilOrga))
                        % If the segment is at the interface between  cytoplasm(1) & the organic medium
                     
                        tlm.result{i}{j}=long;                                      % Length of the segment
                        tlm.geom.boundaryEC{1,i}=tlm.geom.boundaryEC{1,i}+tlm.result{i}{j}/2;
                        tlm.geom.boundaryEC{1,tlm.result{i}{j-7}}=tlm.geom.boundaryEC{1,tlm.result{i}{j-7}}+tlm.result{i}{j}/2; %Half of the segment is added on each node at the interface
                     
                    elseif (fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.Cytoplasme(1)) || ...
                           (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.Cytoplasme(1))
                        tlm.result{i}{j}=3;                                         % This segment is in the cytoplasm (1) or (2)
                    else
                        tlm.result{i}{j}=4;                                         % This segment is in the organic medium
                    end 
               
               end
               
% Interface between cytoplasm of second cell and organic medium

               if (size(tlm.geom.boundaryEC{2,i},1)==1) || (size(tlm.geom.boundaryEC{2,tlm.result{i}{j-7}},1)==1)  % It is an interface between the organic medium (serum) and the cytoplasm(2)
               
                  
                    if ((fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.MilOrga) && ...
                        (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.Cytoplasme(2))) || ...
                        ((fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.Cytoplasme(2)) && ...
                        (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.MilOrga))
                        % If the segment is at the interface between  cytoplasm(2) & the organic medium
                     
                        tlm.result{i}{j}=long;                                      % Length of the segment
                        tlm.geom.boundaryEC{2,i}=tlm.geom.boundaryEC{2,i}+tlm.result{i}{j}/2;
                        tlm.geom.boundaryEC{2,tlm.result{i}{j-7}}=tlm.geom.boundaryEC{2,tlm.result{i}{j-7}}+tlm.result{i}{j}/2; %Half of the segment is added on each node at the interface
                     
                    elseif (fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.Cytoplasme(2)) || ...
                           (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.Cytoplasme(2))
                        tlm.result{i}{j}=9;                                         % This segment is in the cytoplasm(2)
                    else
                        tlm.result{i}{j}=10;                                         % This segment is in the organic medium
                    end 
               
               end
               
% Interface between cytoplasm of first cell and nucleus(1)

                if (size(tlm.geom.boundaryEN{1,i},1)==1) || (size(tlm.geom.boundaryEN{1,tlm.result{i}{j-7}},1)==1)  
               
              
                    if ((fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.Nucleus(1)) && ...
                        (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.Cytoplasme(1))) || ...
                        ((fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.Cytoplasme(1)) && ...
                        (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.Nucleus(1)))
                        
                        % If the segment is at the interface between the cytoplasme & nucleus
                     
                        tlm.result{i}{j}=long;                                      % Length of the segment
                        tlm.geom.boundaryEN{1,i}=tlm.geom.boundaryEN{1,i}+tlm.result{i}{j}/2;
                        tlm.geom.boundaryEN{1,tlm.result{i}{j-7}}=tlm.geom.boundaryEN{1,tlm.result{i}{j-7}}+tlm.result{i}{j}/2; %Half of the segment is added on each node at the interface
                     
                    elseif (fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.Cytoplasme(1)) || ...
                           (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.Cytoplasme(1))
                           
                        tlm.result{i}{j}=5;                                         % This segment is in the cytoplasme(1)
                    else
                        tlm.result{i}{j}=6;                                         % This segment is in nucleus
                    end 
               
                end
                
% Interface between cytoplasm of second cell and nucleus(2)

                if (size(tlm.geom.boundaryEN{2,i},1)==1) || (size(tlm.geom.boundaryEN{2,tlm.result{i}{j-7}},1)==1)  
               
              
                    if ((fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.Nucleus(2)) && ...
                        (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.Cytoplasme(2))) || ...
                        ((fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.Cytoplasme(2)) && ...
                        (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.Nucleus(2)))
                    
                        % If the segment is at the interface between the cytoplasme & nucleus
                     
                        tlm.result{i}{j}=long;                                      % Length of the segment
                        tlm.geom.boundaryEN{2,i}=tlm.geom.boundaryEN{2,i}+tlm.result{i}{j}/2;
                        tlm.geom.boundaryEN{2,tlm.result{i}{j-7}}=tlm.geom.boundaryEN{2,tlm.result{i}{j-7}}+tlm.result{i}{j}/2; %Half of the segment is added on each node at the interface
                     
                    elseif (fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.Cytoplasme(2)) || ...
                           (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.Cytoplasme(2))
                           
                        tlm.result{i}{j}=11;                                         % This segment is in the cytoplasme(2)
                    else
                        tlm.result{i}{j}=12;                                         % This segment is in nucleus
                    end 
               
                end

% Interface between cytoplasm of first cell and mitochondria(1)

                if (size(tlm.geom.boundaryEM{1,i},1)==1) || (size(tlm.geom.boundaryEM{1,tlm.result{i}{j-7}},1)==1)  
               
              
                    if ((fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.Mitocho(1)) && ...
                        (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.Cytoplasme(1))) || ...
                        ((fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.Cytoplasme(1)) && ...
                        (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.Mitocho(1)))
                    % If the segment is at the interface between the cytoplasme & the mitochondria
                     
                        tlm.result{i}{j}=long;                                      % Length of the segment
                        tlm.geom.boundaryEM{1,i}=tlm.geom.boundaryEM{1,i}+tlm.result{i}{j}/2;
                        tlm.geom.boundaryEM{1,tlm.result{i}{j-7}}=tlm.geom.boundaryEM{1,tlm.result{i}{j-7}}+tlm.result{i}{j}/2; %Half of the segment is added on each node at the interface
                     
                    elseif (fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.Cytoplasme(1)) || ...
                           (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.Cytoplasme(1))
                           
                        tlm.result{i}{j}=7;                                         % This segment is in the cytoplasme(1)
                    else
                        tlm.result{i}{j}=8;                                         % This segment is in mitochondria(1)
                    end 
               
                end
                
% Interface between cytoplasm of second cell and mitochondria(2)

                if (size(tlm.geom.boundaryEM{2,i},1)==1) || (size(tlm.geom.boundaryEM{2,tlm.result{i}{j-7}},1)==1)  
               
              
                    if ((fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.Mitocho(2)) && ...
                       (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.Cytoplasme(2))) || ...
                       ((fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.Cytoplasme(2)) && ...
                        (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.Mitocho(2)))
                    % If the segment is at the interface between the cytoplasme & the mitochondria
                     
                        tlm.result{i}{j}=long;                                      % Length of the segment
                        tlm.geom.boundaryEM{2,i}=tlm.geom.boundaryEM{2,i}+tlm.result{i}{j}/2;
                        tlm.geom.boundaryEM{2,tlm.result{i}{j-7}}=tlm.geom.boundaryEM{2,tlm.result{i}{j-7}}+tlm.result{i}{j}/2; %Half of the segment is added on each node at the interface
                     
                    elseif (fem_mesh_t(tlm.result{i}{j-6},1)==tlm.ind.dom.Cytoplasme(2)) || ...
                           (fem_mesh_t(tlm.result{i}{j-5},1)==tlm.ind.dom.Cytoplasme(2))
                        tlm.result{i}{j}=13;                                         % This segment is in the cytoplasme
                    else
                        tlm.result{i}{j}=14;                                         % This segment is in mitochondria
                    end 
               
                end
                
                aire1=tlm.geom.airvol(tlm.result{i}{j-6});                             % First adjacent triangle
                dom1=fem_mesh_t(tlm.result{i}{j-6},1);
                aire2=tlm.geom.airvol(tlm.result{i}{j-5});                             % Second adjacent triangle
                dom2=fem_mesh_t(tlm.result{i}{j-5},1);
                
                if (tlm.result{i}{j}~=0) && (tlm.result{i}{j}<1)                     % The values of the capacitor & resistor at the interface are calculated
                    
                    if (dom1==tlm.ind.dom.MilOrga) || ((dom1==tlm.ind.dom.Cytoplasme(1))&&(dom2~=tlm.ind.dom.MilOrga)) || ...
                       ((dom1==tlm.ind.dom.Cytoplasme(2))&&(dom2~=tlm.ind.dom.MilOrga))   
                        %if dom1 is the "outer" domain : electrolite for
                        %the cell and cytoplasm for organelle
                        % Resistor
                        if tlm.dom.sig(dom2)~=0
                            tlm.result{i}{j-2}=(long^2/(tlm.dom.sig(dom2)*aire2))/2;
                        else
                            tlm.result{i}{j-2}=-1;
                        end
                        if tlm.dom.sig(dom1)~=0
                            tlm.result{i}{j-4}=(long^2/(tlm.dom.sig(dom1)*aire1))/2;
                        else
                            tlm.result{i}{j-4}=-1;
                        end
                        % Capacitor
                        tlm.result{i}{j-1}=((tlm.dom.eps(dom2)*aire2)/long^2)*2;
                        tlm.result{i}{j-3}=((tlm.dom.eps(dom1)*aire1)/long^2)*2;
                    else
                        % Resistor
                        if tlm.dom.sig(dom2)~=0
                            tlm.result{i}{j-4}=(long^2/(tlm.dom.sig(dom2)*aire2))/2;
                        else
                            tlm.result{i}{j-4}=-1;
                        end
                        if tlm.dom.sig(dom1)~=0
                            tlm.result{i}{j-2}=(long^2/(tlm.dom.sig(dom1)*aire1))/2;
                        else
                            tlm.result{i}{j-2}=-1;
                        end
                        % Capacitor
                        tlm.result{i}{j-3}=((tlm.dom.eps(dom2)*aire2)/long^2)*2;
                        tlm.result{i}{j-1}=((tlm.dom.eps(dom1)*aire1)/long^2)*2;
                    end
                    
                else                                                                %
                    % Resistor
                    if (tlm.dom.sig(dom1)~=0 || tlm.dom.sig(dom2)~=0)
                        tlm.result{i}{j-4}=long^2/(tlm.dom.sig(dom1)*aire1+tlm.dom.sig(dom2)*aire2)/2;
                    elseif (tlm.dom.sig(dom1)==0 && tlm.dom.sig(dom2)==0)
                        tlm.result{i}{j-4}=-1;
                    end
                    % Capacitor
                    tlm.result{i}{j-3}=(tlm.dom.eps(dom1)*aire1+tlm.dom.eps(dom2)*aire2)/long^2*2;
                end
                
            else                                                                        % If it is on the edge of the structure
                
                 long=sum((fem_mesh_p(:,i)-fem_mesh_p(:,tlm.result{i}{j-7})).^2)^0.5;   % Distance between the 2 nodes
                 aire1=tlm.geom.airvol(tlm.result{i}{j-6});
                 dom1=fem_mesh_t(tlm.result{i}{j-6},1);

                 if (dom1==tlm.ind.dom.elec1 || ...
                     dom1==tlm.ind.dom.elec2) 
                     tlm.result{i}{j}=1;
                 elseif dom1==tlm.ind.dom.MilOrga
                     tlm.result{i}{j}=2;
                 end
             
                 % Resistor
                 disp(dom1);
                 if tlm.dom.sig(dom1)~=0 
                     tlm.result{i}{j-4}=long^2/tlm.dom.sig(dom1)/aire1/2;
                 else
                     tlm.result{i}{j-4}=-1;
                 end
                 % Capacitor
                 tlm.result{i}{j-3}=tlm.dom.eps(dom1)*aire1/long^2*2;
            end
            
        end
        
    end
    
end