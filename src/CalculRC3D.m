%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                              BIOCAD Program
%                               Release 1.0
%
%   Authors: Vincent Senez
%   
%   Release 1.0 : January 2019
%   
%
%   Routine CalculRC3D called by Compute.m
%
%   Function: Calculation of the values of the electrical elements
%   (Resistor, Capacitance, Voltage generator, Current sources) of the
%   equivalent electrical circuit
%
%   Remarks:
%   tlm.result(numeroduptincident)={numduptcible1, numtetra[], R1, C1, R2, C2, h ...}
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

%function [tlm,fem]=CalculRC3D(tlm,fem)
function [tlm,model]=CalculRC3D(tlm,model)

%Initialization

global fem_mesh_p; %coordinates of the vertex
global fem_mesh_t; %domain number of the tetrahedron
%global fem_mesh_e;

for i=1:1:size(fem_mesh_p,2)    % Loop on the number of nodes

    if size(tlm.result{i},2)~=0 % Check whether the node has been selected once as an incident point
        
        for j=7:7:size(tlm.result{i},2)
            if i==0
                disp(i);
            end
            
              long=sum((fem_mesh_p(:,i)-fem_mesh_p(:,tlm.result{i}{j-6})).^2)^0.5; % Calculation of the size between the 2 nodes

 % Interface between solicitation electrodes and organic medium              
              
              if (size(tlm.geom.boundaryEE{i},1)==1) && (size(tlm.geom.boundaryEE{tlm.result{i}{j-6}},1)==1)   % It is an interface between the organic medium (serum) and the outer electrodes
                  
                  % If the segment is at the interface between the left or right outer electrodes - electrolyte
                    tlm.result{i}{j}=long;                                      % Length of the segment
                    tlm.geom.boundaryEE{i}=tlm.geom.boundaryEE{i}+tlm.result{i}{j}/2;
                    tlm.geom.boundaryEE{tlm.result{i}{j-6}}=tlm.geom.boundaryEE{tlm.result{i}{j-6}}+tlm.result{i}{j}/2;
                        
                    for k=1:1:size(tlm.result{i}{j-5},2)                        %loop on the number of tetraedron around this segment
                        if fem_mesh_t(tlm.result{i}{j-5}(k),1)==tlm.ind.dom.MilOrga                          %if tetra is in electrolyte
                            tlm.result{i}{j-4}=tlm.result{i}{j-4}+tlm.dom.sig(fem_mesh_t(tlm.result{i}{j-5}(k),1)).*tlm.geom.airvol(i);
                            tlm.result{i}{j-3}=tlm.result{i}{j-3}+tlm.dom.eps(fem_mesh_t(tlm.result{i}{j-5}(k),1)).*tlm.geom.airvol(i);
                        else                                                                                  %if the tetra is in the electrode
                            tlm.result{i}{j-2}=tlm.result{i}{j-2}+tlm.dom.sig(fem_mesh_t(tlm.result{i}{j-5}(k),1)).*tlm.geom.airvol(i);
                            tlm.result{i}{j-1}=tlm.result{i}{j-1}+tlm.dom.eps(fem_mesh_t(tlm.result{i}{j-5}(k),1)).*tlm.geom.airvol(i);
                        end
                    end
                    
                    if tlm.result{i}{j-4}==0 || tlm.result{i}{j-3}==0  % case of narrow electrodes where nodes i and tlm.result{i}{j-6} are on both sides of the electrodes qnd on the side of the simulation domain
                        tlm.result{i}{j}=1; % this segment is in the electrode (&&&&&&&&&&&&&&&&&&check the effect in EcritNetlist)
                        % Resistance
                        tlm.result{i}{j-4}=long^2/sum(tlm.dom.sig(fem_mesh_t(tlm.result{i}{j-5}(:),1)).*tlm.geom.airvol(i))/3;
                        % Capacit�
                        tlm.result{i}{j-3}=sum(tlm.dom.eps(fem_mesh_t(tlm.result{i}{j-5}(:),1)).*tlm.geom.airvol(i))/long^2*3;
                    else
                        % Resistance R1
                        tlm.result{i}{j-4}=long^2/tlm.result{i}{j-4}/3;
                        % Capacit� C1
                        tlm.result{i}{j-3}=tlm.result{i}{j-3}/long^2*3;
                        % Resistance R2
                        tlm.result{i}{j-2}=long^2/tlm.result{i}{j-2}/3;
                        % Capacit� C2
                        tlm.result{i}{j-1}=tlm.result{i}{j-1}/long^2*3;
                    end
      
              elseif (size(tlm.geom.boundaryEE{i},1)==1) || (size(tlm.geom.boundaryEE{tlm.result{i}{j-6}},1)==1)
                  
                    if fem_mesh_t(tlm.result{i}{j-5}(1),1)==tlm.ind.dom.MilOrga
                        tlm.result{i}{j}=2; %this segment is in the electrolyte
                    else
                        tlm.result{i}{j}=1; %this segment is in the electrode
                    end
                    
                    % Resistance
                    tlm.result{i}{j-4}=long^2/sum(tlm.dom.sig(fem_mesh_t(tlm.result{i}{j-5}(:),1)).*tlm.geom.airvol(i))/3;
                    % Capacit�
                    tlm.result{i}{j-3}=sum(tlm.dom.eps(fem_mesh_t(tlm.result{i}{j-5}(:),1)).*tlm.geom.airvol(i))/long^2*3;
              end
              
% Interface between cytoplasm of first cell and organic medium
                        
              if (size(tlm.geom.boundaryEC{1,i},1)==1) && (size(tlm.geom.boundaryEC{1,tlm.result{i}{j-6}},1)==1)   % It is an interface between the organic medium (serum) and the cytoplasm(1)

                 tlm.result{i}{j}=long;                                      % Length of the segment
                 tlm.geom.boundaryEC{1,i}=tlm.geom.boundaryEC{1,i}+tlm.result{i}{j}/2;
                 tlm.geom.boundaryEC{1,tlm.result{i}{j-6}}=tlm.geom.boundaryEC{1,tlm.result{i}{j-6}}+tlm.result{i}{j}/2;
                        
                 for k=1:1:size(tlm.result{i}{j-5},2) %loop on the number of tetraedra around this segment
                    if fem_mesh_t(5,tlm.result{i}{j-5}(k))==tlm.ind.dom.MilOrga                          %if the tetrahedron is in electrolyte
                        tlm.result{i}{j-4}=tlm.result{i}{j-4}+tlm.dom.sig(fem_mesh_t(5,tlm.result{i}{j-5}(k))).*tlm.geom.airvol(i);
                        tlm.result{i}{j-3}=tlm.result{i}{j-3}+tlm.dom.eps(fem_mesh_t(5,tlm.result{i}{j-5}(k))).*tlm.geom.airvol(i);
                    else                                                                                 %if the tetrahedron is in cytoplasm(1)
                        tlm.result{i}{j-2}=tlm.result{i}{j-2}+tlm.dom.sig(fem_mesh_t(5,tlm.result{i}{j-5}(k))).*tlm.geom.airvol(i);
                        tlm.result{i}{j-1}=tlm.result{i}{j-1}+tlm.dom.eps(fem_mesh_t(5,tlm.result{i}{j-5}(k))).*tlm.geom.airvol(i);
                    end
                 end
                    
                 if tlm.result{i}{j-2}==0 || tlm.result{i}{j-1}==0
                    tlm.result{i}{j}=4; % this segment is in the electrolyte (&&&&&&&&&&&&&&&&&&check the effect in EcritNetlist)
                    % Resistance
                    tlm.result{i}{j-4}=long^2/sum(tlm.dom.sig(fem_mesh_t(5,tlm.result{i}{j-5}(:))).*tlm.geom.airvol(i))/3;
                    % Capacit�
                    tlm.result{i}{j-3}=sum(tlm.dom.eps(fem_mesh_t(5,tlm.result{i}{j-5}(:))).*tlm.geom.airvol(i))/long^2*3;                        
                 else
                    % Resistance R1
                    tlm.result{i}{j-4}=long^2/tlm.result{i}{j-4}/3;
                    % Capacit� C1
                    tlm.result{i}{j-3}=tlm.result{i}{j-3}/long^2*3;
                    % Resistance R2
                    tlm.result{i}{j-2}=long^2/tlm.result{i}{j-2}/3;
                    % Capacit� C2
                    tlm.result{i}{j-1}=tlm.result{i}{j-1}/long^2*3;
                 end
          
              elseif (size(tlm.geom.boundaryEC{1,i},1)==1) || (size(tlm.geom.boundaryEC{1,tlm.result{i}{j-6}},1)==1)
           
                 if fem_mesh_t(5,tlm.result{i}{j-5}(1))==tlm.ind.dom.MilOrga
                     tlm.result{i}{j}=4; %this segment is in the electrolyte
                 else
                     tlm.result{i}{j}=3; %this segment is in the cytoplasm(1)
                 end
                    
                 % Resistance
                 tlm.result{i}{j-4}=long^2/sum(tlm.dom.sig(fem_mesh_t(5,tlm.result{i}{j-5}(:))).*tlm.geom.airvol(i))/3;
                 % Capacit�
                 tlm.result{i}{j-3}=sum(tlm.dom.eps(fem_mesh_t(5,tlm.result{i}{j-5}(:))).*tlm.geom.airvol(i))/long^2*3; 
                    
              end
              
% Interface between cytoplasm of second cell and organic medium

              if (size(tlm.geom.boundaryEC{2,i},1)==1) && (size(tlm.geom.boundaryEC{2,tlm.result{i}{j-6}},1)==1)   % It is an interface between the organic medium (serum) and the cytoplasm(2)

                 tlm.result{i}{j}=long;                                      % Length of the segment
                 tlm.geom.boundaryEC{2,i}=tlm.geom.boundaryEC{2,i}+tlm.result{i}{j}/2;
                 tlm.geom.boundaryEC{2,tlm.result{i}{j-6}}=tlm.geom.boundaryEC{2,tlm.result{i}{j-6}}+tlm.result{i}{j}/2;
                        
                 for k=1:1:size(tlm.result{i}{j-5},2) %loop on the number of tetraedra around this segment
                    if fem_mesh_t(5,tlm.result{i}{j-5}(k))==tlm.ind.dom.MilOrga                          %if the tetrahedron is in electrolyte
                        tlm.result{i}{j-4}=tlm.result{i}{j-4}+tlm.dom.sig(fem_mesh_t(5,tlm.result{i}{j-5}(k))).*tlm.geom.airvol(i);
                        tlm.result{i}{j-3}=tlm.result{i}{j-3}+tlm.dom.eps(fem_mesh_t(5,tlm.result{i}{j-5}(k))).*tlm.geom.airvol(i);
                    else                                                                                 %if the tetrahedron is in cytoplasm(2)
                        tlm.result{i}{j-2}=tlm.result{i}{j-2}+tlm.dom.sig(fem_mesh_t(5,tlm.result{i}{j-5}(k))).*tlm.geom.airvol(i);
                        tlm.result{i}{j-1}=tlm.result{i}{j-1}+tlm.dom.eps(fem_mesh_t(5,tlm.result{i}{j-5}(k))).*tlm.geom.airvol(i);
                    end
                 end
                    
                 if tlm.result{i}{j-2}==0 || tlm.result{i}{j-1}==0
                    tlm.result{i}{j}=10; % this segment is in the electrolyte (&&&&&&&&&&&&&&&&&&check the effect in EcritNetlist)
                    % Resistance
                    tlm.result{i}{j-4}=long^2/sum(tlm.dom.sig(fem_mesh_t(5,tlm.result{i}{j-5}(:))).*tlm.geom.airvol(i))/3;
                    % Capacit�
                    tlm.result{i}{j-3}=sum(tlm.dom.eps(fem_mesh_t(5,tlm.result{i}{j-5}(:))).*tlm.geom.airvol(i))/long^2*3;                        
                 else
                    % Resistance R1
                    tlm.result{i}{j-4}=long^2/tlm.result{i}{j-4}/3;
                    % Capacit� C1
                    tlm.result{i}{j-3}=tlm.result{i}{j-3}/long^2*3;
                    % Resistance R2
                    tlm.result{i}{j-2}=long^2/tlm.result{i}{j-2}/3;
                    % Capacit� C2
                    tlm.result{i}{j-1}=tlm.result{i}{j-1}/long^2*3;
                 end
          
              elseif (size(tlm.geom.boundaryEC{2,i},1)==1) || (size(tlm.geom.boundaryEC{2,tlm.result{i}{j-6}},1)==1)
           
                 if fem_mesh_t(5,tlm.result{i}{j-5}(1))==tlm.ind.dom.MilOrga
                     tlm.result{i}{j}=10; %this segment is in the electrolyte
                 else
                     tlm.result{i}{j}=9; %this segment is in the cytoplasm(2)
                 end
                    
                 % Resistance
                 tlm.result{i}{j-4}=long^2/sum(tlm.dom.sig(fem_mesh_t(5,tlm.result{i}{j-5}(:))).*tlm.geom.airvol(i))/3;
                 % Capacit�
                 tlm.result{i}{j-3}=sum(tlm.dom.eps(fem_mesh_t(5,tlm.result{i}{j-5}(:))).*tlm.geom.airvol(i))/long^2*3; 
                    
              end
              
% Interface between cytoplasm of first cell and nucleus(1)

              if (size(tlm.geom.boundaryEN{1,i},1)==1) && (size(tlm.geom.boundaryEN{1,tlm.result{i}{j-6}},1)==1)   % It is an interface between the nucleus(1) and the cytoplasm(1)

                 tlm.result{i}{j}=long;                                      % Length of the segment
                 tlm.geom.boundaryEN{1,i}=tlm.geom.boundaryEN{1,i}+tlm.result{i}{j}/2;
                 tlm.geom.boundaryEN{1,tlm.result{i}{j-6}}=tlm.geom.boundaryEN{1,tlm.result{i}{j-6}}+tlm.result{i}{j}/2;
                        
                 for k=1:1:size(tlm.result{i}{j-5},2) %loop on the number of tetraedra around this segment
                    if fem_mesh_t(5,tlm.result{i}{j-5}(k))==tlm.ind.dom.Cytoplasme(1)                         %if the tetrahedron is in nucleus(1)
                        tlm.result{i}{j-4}=tlm.result{i}{j-4}+tlm.dom.sig(fem_mesh_t(5,tlm.result{i}{j-5}(k))).*tlm.geom.airvol(i);
                        tlm.result{i}{j-3}=tlm.result{i}{j-3}+tlm.dom.eps(fem_mesh_t(5,tlm.result{i}{j-5}(k))).*tlm.geom.airvol(i);
                    else                                                                                 %if the tetrahedron is in cytoplasm(1)
                        tlm.result{i}{j-2}=tlm.result{i}{j-2}+tlm.dom.sig(fem_mesh_t(5,tlm.result{i}{j-5}(k))).*tlm.geom.airvol(i);
                        tlm.result{i}{j-1}=tlm.result{i}{j-1}+tlm.dom.eps(fem_mesh_t(5,tlm.result{i}{j-5}(k))).*tlm.geom.airvol(i);
                    end 
                 end
                    
                 if tlm.result{i}{j-4}==0 || tlm.result{i}{j-3}==0
                    tlm.result{i}{j}=6; % this segment is in the nucleus(1) (&&&&&&&&&&&&&&&&&&check the effect in EcritNetlist)
                    % Resistance
                    tlm.result{i}{j-4}=long^2/sum(tlm.dom.sig(fem_mesh_t(5,tlm.result{i}{j-5}(:))).*tlm.geom.airvol(i))/3;
                    % Capacit�
                    tlm.result{i}{j-3}=sum(tlm.dom.eps(fem_mesh_t(5,tlm.result{i}{j-5}(:))).*tlm.geom.airvol(i))/long^2*3;                        
                 else
                    % Resistance R1
                    tlm.result{i}{j-4}=long^2/tlm.result{i}{j-4}/3;
                    % Capacit� C1
                    tlm.result{i}{j-3}=tlm.result{i}{j-3}/long^2*3;
                    % Resistance R2
                    tlm.result{i}{j-2}=long^2/tlm.result{i}{j-2}/3;
                    % Capacit� C2
                    tlm.result{i}{j-1}=tlm.result{i}{j-1}/long^2*3;
                 end
          
              elseif (size(tlm.geom.boundaryEN{1,i},1)==1) || (size(tlm.geom.boundaryEN{1,tlm.result{i}{j-6}},1)==1)
           
                  if fem_mesh_t(5,tlm.result{i}{j-5}(1))==tlm.ind.dom.Nucleus(1)
                    tlm.result{i}{j}=6; %this segment is in the nucleus
                  else
                    tlm.result{i}{j}=5; %this segment is in the cytoplasm(1)
                  end
                    
                  % Resistance
                  tlm.result{i}{j-4}=long^2/sum(tlm.dom.sig(fem_mesh_t(5,tlm.result{i}{j-5}(:))).*tlm.geom.airvol(i))/3;
                  % Capacit�
                  tlm.result{i}{j-3}=sum(tlm.dom.eps(fem_mesh_t(5,tlm.result{i}{j-5}(:))).*tlm.geom.airvol(i))/long^2*3; 
                    
              end
              
% Interface between cytoplasm of second cell and nucleus(2)

              if (size(tlm.geom.boundaryEN{2,i},1)==1) && (size(tlm.geom.boundaryEN{2,tlm.result{i}{j-6}},1)==1)   % It is an interface between the nucleus(2) and the cytoplasm(2)

                 tlm.result{i}{j}=long;                                      % Length of the segment
                 tlm.geom.boundaryEN{2,i}=tlm.geom.boundaryEN{2,i}+tlm.result{i}{j}/2;
                 tlm.geom.boundaryEN{2,tlm.result{i}{j-6}}=tlm.geom.boundaryEN{2,tlm.result{i}{j-6}}+tlm.result{i}{j}/2;
                        
                 for k=1:1:size(tlm.result{i}{j-5},2) %loop on the number of tetraedra around this segment
                    if fem_mesh_t(5,tlm.result{i}{j-5}(k))==tlm.ind.dom.Cytoplasme(2)                         %if the tetrahedron is in nucleus(1)
                        tlm.result{i}{j-4}=tlm.result{i}{j-4}+tlm.dom.sig(fem_mesh_t(5,tlm.result{i}{j-5}(k))).*tlm.geom.airvol(i);
                        tlm.result{i}{j-3}=tlm.result{i}{j-3}+tlm.dom.eps(fem_mesh_t(5,tlm.result{i}{j-5}(k))).*tlm.geom.airvol(i);
                    else                                                                                 %if the tetrahedron is in cytoplasm(1)
                        tlm.result{i}{j-2}=tlm.result{i}{j-2}+tlm.dom.sig(fem_mesh_t(5,tlm.result{i}{j-5}(k))).*tlm.geom.airvol(i);
                        tlm.result{i}{j-1}=tlm.result{i}{j-1}+tlm.dom.eps(fem_mesh_t(5,tlm.result{i}{j-5}(k))).*tlm.geom.airvol(i);
                    end 
                 end
                    
                 if tlm.result{i}{j-4}==0 || tlm.result{i}{j-3}==0
                    tlm.result{i}{j}=12; % this segment is in the cytoplasm(2) (&&&&&&&&&&&&&&&&&&check the effect in EcritNetlist)
                    % Resistance
                    tlm.result{i}{j-4}=long^2/sum(tlm.dom.sig(fem_mesh_t(5,tlm.result{i}{j-5}(:))).*tlm.geom.airvol(i))/3;
                    % Capacit�
                    tlm.result{i}{j-3}=sum(tlm.dom.eps(fem_mesh_t(5,tlm.result{i}{j-5}(:))).*tlm.geom.airvol(i))/long^2*3;                        
                 else
                    % Resistance R1
                    tlm.result{i}{j-4}=long^2/tlm.result{i}{j-4}/3;
                    % Capacit� C1
                    tlm.result{i}{j-3}=tlm.result{i}{j-3}/long^2*3;
                    % Resistance R2
                    tlm.result{i}{j-2}=long^2/tlm.result{i}{j-2}/3;
                    % Capacit� C2
                    tlm.result{i}{j-1}=tlm.result{i}{j-1}/long^2*3;
                 end
          
              elseif (size(tlm.geom.boundaryEN{2,i},1)==1) || (size(tlm.geom.boundaryEN{2,tlm.result{i}{j-6}},1)==1)
           
                  if fem_mesh_t(5,tlm.result{i}{j-5}(1))==tlm.ind.dom.Nucleus(2)
                    tlm.result{i}{j}=12; %this segment is in the nucleus(2)
                  else
                    tlm.result{i}{j}=11; %this segment is in the cytoplasm(2)
                  end
                    
                  % Resistance
                  tlm.result{i}{j-4}=long^2/sum(tlm.dom.sig(fem_mesh_t(5,tlm.result{i}{j-5}(:))).*tlm.geom.airvol(i))/3;
                  % Capacit�
                  tlm.result{i}{j-3}=sum(tlm.dom.eps(fem_mesh_t(5,tlm.result{i}{j-5}(:))).*tlm.geom.airvol(i))/long^2*3; 
                    
              end

% Interface between cytoplasm of first cell and mitochondria(1)

              if (size(tlm.geom.boundaryEM{1,i},1)==1) && (size(tlm.geom.boundaryEM{1,tlm.result{i}{j-6}},1)==1)   % It is an interface between the mitochondria(1) and the cytoplasm(1)

                  tlm.result{i}{j}=long;                                      % Length of the segment
                  tlm.geom.boundaryEM{1,i}=tlm.geom.boundaryEM{1,i}+tlm.result{i}{j}/2;
                  tlm.geom.boundaryEM{1,tlm.result{i}{j-6}}=tlm.geom.boundaryEM{1,tlm.result{i}{j-6}}+tlm.result{i}{j}/2;
                        
                  for k=1:1:size(tlm.result{i}{j-5},2) %loop on the number of tetraedra around this segment
                    if fem_mesh_t(5,tlm.result{i}{j-5}(k))==tlm.ind.dom.Cytoplasme(1)                         %if the tetrahedron is in mitochondria(1)
                        tlm.result{i}{j-4}=tlm.result{i}{j-4}+tlm.dom.sig(fem_mesh_t(5,tlm.result{i}{j-5}(k))).*tlm.geom.airvol(i);
                        tlm.result{i}{j-3}=tlm.result{i}{j-3}+tlm.dom.eps(fem_mesh_t(5,tlm.result{i}{j-5}(k))).*tlm.geom.airvol(i);
                    else                                                                                 %if the tetrahedron is in cytoplasm(1)
                        tlm.result{i}{j-2}=tlm.result{i}{j-2}+tlm.dom.sig(fem_mesh_t(5,tlm.result{i}{j-5}(k))).*tlm.geom.airvol(i);
                        tlm.result{i}{j-1}=tlm.result{i}{j-1}+tlm.dom.eps(fem_mesh_t(5,tlm.result{i}{j-5}(k))).*tlm.geom.airvol(i);
                    end
                  end

                  if tlm.result{i}{j-4}==0 || tlm.result{i}{j-3}==0
                    tlm.result{i}{j}=8; % this segment is in the mitochon(1) (&&&&&&&&&&&&&&&&&&check the effect in EcritNetlist)
                    % Resistance
                    tlm.result{i}{j-4}=long^2/sum(tlm.dom.sig(fem_mesh_t(5,tlm.result{i}{j-5}(:))).*tlm.geom.airvol(i))/3;
                    % Capacit�
                    tlm.result{i}{j-3}=sum(tlm.dom.eps(fem_mesh_t(5,tlm.result{i}{j-5}(:))).*tlm.geom.airvol(i))/long^2*3;                        
                  else
                    % Resistance R1
                    tlm.result{i}{j-4}=long^2/tlm.result{i}{j-4}/3;
                    % Capacit� C1
                    tlm.result{i}{j-3}=tlm.result{i}{j-3}/long^2*3;
                    % Resistance R2
                    tlm.result{i}{j-2}=long^2/tlm.result{i}{j-2}/3;
                    % Capacit� C2
                    tlm.result{i}{j-1}=tlm.result{i}{j-1}/long^2*3;
                  end
          
              elseif (size(tlm.geom.boundaryEM{1,i},1)==1) || (size(tlm.geom.boundaryEM{1,tlm.result{i}{j-6}},1)==1)
           
                  if fem_mesh_t(5,tlm.result{i}{j-5}(1))==tlm.ind.dom.Mitocho(1)
                    tlm.result{i}{j}=8; %this segment is in the mitochondria(1)
                  else
                    tlm.result{i}{j}=7; %this segment is in the cytoplasm(1)
                  end
                    
                  % Resistance
                  tlm.result{i}{j-4}=long^2/sum(tlm.dom.sig(fem_mesh_t(5,tlm.result{i}{j-5}(:))).*tlm.geom.airvol(i))/3;
                  % Capacit�
                  tlm.result{i}{j-3}=sum(tlm.dom.eps(fem_mesh_t(5,tlm.result{i}{j-5}(:))).*tlm.geom.airvol(i))/long^2*3; 
                   
              end

% Interface between cytoplasm of second cell and mitochondria(2)

              if (size(tlm.geom.boundaryEM{2,i},1)==1) && (size(tlm.geom.boundaryEM{2,tlm.result{i}{j-6}},1)==1)   % It is an interface between the mitochondria(2) and the cytoplasm(2)

                  tlm.result{i}{j}=long;                                      % Length of the segment
                  tlm.geom.boundaryEM{2,i}=tlm.geom.boundaryEM{2,i}+tlm.result{i}{j}/2;
                  tlm.geom.boundaryEM{2,tlm.result{i}{j-6}}=tlm.geom.boundaryEM{2,tlm.result{i}{j-6}}+tlm.result{i}{j}/2;
                        
                  for k=1:1:size(tlm.result{i}{j-5},2) %loop on the number of tetraedra around this segment
                    if fem_mesh_t(5,tlm.result{i}{j-5}(k))==tlm.ind.dom.Cytoplasme(2)                         %if the tetrahedron is in mitochondria(2)
                        tlm.result{i}{j-4}=tlm.result{i}{j-4}+tlm.dom.sig(fem_mesh_t(5,tlm.result{i}{j-5}(k))).*tlm.geom.airvol(i);
                        tlm.result{i}{j-3}=tlm.result{i}{j-3}+tlm.dom.eps(fem_mesh_t(5,tlm.result{i}{j-5}(k))).*tlm.geom.airvol(i);
                    else                                                                                 %if the tetrahedron is in cytoplasm(2)
                        tlm.result{i}{j-2}=tlm.result{i}{j-2}+tlm.dom.sig(fem_mesh_t(5,tlm.result{i}{j-5}(k))).*tlm.geom.airvol(i);
                        tlm.result{i}{j-1}=tlm.result{i}{j-1}+tlm.dom.eps(fem_mesh_t(5,tlm.result{i}{j-5}(k))).*tlm.geom.airvol(i);
                    end
                  end
                    
                  if tlm.result{i}{j-4}==0 || tlm.result{i}{j-3}==0
                    tlm.result{i}{j}=14; % this segment is in the mitocho(2) (&&&&&&&&&&&&&&&&&&check the effect in EcritNetlist)
                    % Resistance
                    tlm.result{i}{j-4}=long^2/sum(tlm.dom.sig(fem_mesh_t(5,tlm.result{i}{j-5}(:))).*tlm.geom.airvol(i))/3;
                    % Capacit�
                    tlm.result{i}{j-3}=sum(tlm.dom.eps(fem_mesh_t(5,tlm.result{i}{j-5}(:))).*tlm.geom.airvol(i))/long^2*3;                        
                  else
                    % Resistance R1
                    tlm.result{i}{j-4}=long^2/tlm.result{i}{j-4}/3;
                    % Capacit� C1
                    tlm.result{i}{j-3}=tlm.result{i}{j-3}/long^2*3;
                    % Resistance R2
                    tlm.result{i}{j-2}=long^2/tlm.result{i}{j-2}/3;
                    % Capacit� C2
                    tlm.result{i}{j-1}=tlm.result{i}{j-1}/long^2*3;
                  end
          
              elseif (size(tlm.geom.boundaryEM{2,i},1)==1) || (size(tlm.geom.boundaryEM{2,tlm.result{i}{j-6}},1)==1)
           
                  if fem_mesh_t(5,tlm.result{i}{j-5}(1))==tlm.ind.dom.Mitocho(2)
                    tlm.result{i}{j}=14; %this segment is in the mitochondria(2)
                  else
                    tlm.result{i}{j}=13; %this segment is in the cytoplasm(2)
                  end
                    
                  % Resistance
                  tlm.result{i}{j-4}=long^2/sum(tlm.dom.sig(fem_mesh_t(5,tlm.result{i}{j-5}(:))).*tlm.geom.airvol(i))/3;
                  % Capacit�
                  tlm.result{i}{j-3}=sum(tlm.dom.eps(fem_mesh_t(5,tlm.result{i}{j-5}(:))).*tlm.geom.airvol(i))/long^2*3; 
                   
              end
              
              if tlm.result{i}{j}==0 % if we are not at an interface
                 
                  % Resistance
                  
                  if tlm.dom.sig(fem_mesh_t(tlm.result{i}{j-5}(:),1))~=0 
                      tlm.result{i}{j-4}=(long^2/(sum(tlm.dom.sig(fem_mesh_t(tlm.result{i}{j-5}(:),1)).*tlm.geom.airvol(i))))/3;
                  else
                      tlm.result{i}{j-4}=-1;
                  end
                  
                  % Capacit�
                  tlm.result{i}{j-3}=(sum(tlm.dom.eps(fem_mesh_t(tlm.result{i}{j-5}(:),1)).*tlm.geom.airvol(i))/long^2)*3;
                    
              end
        end      
    end
end
