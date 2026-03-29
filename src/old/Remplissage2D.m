%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                              BIOCAD Program
%                               Release 1.0
%
%   Authors: Vincent Senez
%   
%   Release 1.0 : January 2019
%
%   Routine Remplissage2D called by Compute.m
%
%   Function: Set up the data structure for Spice in tlm.result
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

function [tlm,model]=Remplissage2D(tlm,model)
%function [tlm,fem]=Remplissage2D(tlm,fem)

%Initialization

global fem_mesh_p;
global fem_mesh_t;
global fem_mesh_e;

%tlm.result(:)=[];
tlm.result=cell(size(fem_mesh_p,2),100);
%tlm.result{size(fem_mesh_p,2)}={};
tlm.geom.boundaryEE{size(fem_mesh_p,2)}={};      % boudary point electrode/milOrga
tlm.geom.boundaryEC{2,size(fem_mesh_p,2)}={};    % boudary point  cytoplasme/milOrga
tlm.geom.boundaryEN{2,size(fem_mesh_p,2)}={};    % boudary point cytoplasme/nucleus
tlm.geom.boundaryEM{2,size(fem_mesh_p,2)}={};    % boudary point cytoplasme/mitochondria
tlm.geom.airvol(size(fem_mesh_t,2))=0;           % third of the surface of the triangle in 2D, Sixth of the volume of the tetrahedra in 3D
%out.airvol(1:size(fem.mesh.t,2))=0;     


for i=1:1:size(fem_mesh_t,1) % For each element (here it is triangle)
    for n=1:1:2
        for m=n+1:1:3
            pt1=fem_mesh_e(n,i)+1;    % Select two nodes
            pt2=fem_mesh_e(m,i)+1;    % Nodes numbering starts at 0 while array adressing should start at 1
%            pt1=fem_mesh_e(n,i);    % Select two nodes
%            pt2=fem_mesh_e(m,i);
            if pt1>pt2
                temp=pt2;
                pt2=pt1;
                pt1=temp;
            end
            if size(tlm.result{pt1},1)==0               % If the data structure is empty for point pt1
                tlm.result{pt1}={pt2,i,0,0,0,0,0,0};    % Add the current segment
            else
                temp=size(tlm.result{pt1},2);
                temp2=1;
                j=8;
                while j<=temp
                    if tlm.result{pt1}{j-7}==pt2        % If the segment is already in the data structure
                        tlm.result{pt1}{j-5}=i;         % Add the number of the adjacent element (triangle)
                        if (tlm.conf.Parasite==1)  && (((fem_mesh_t(i,1)==tlm.ind.dom.MilOrga)  && ... ;Check the domain number of each triangle (see Remarks above)
                           (fem_mesh_t(tlm.result{pt1}{j-6},1)==tlm.ind.dom.elec1)) || ...
                           ((fem_mesh_t(tlm.result{pt1}{j-6},1)==tlm.ind.dom.MilOrga)  && (fem_mesh_t(i,1)==tlm.ind.dom.elec1)) || ...
                           ((fem_mesh_t(i,1)==tlm.ind.dom.MilOrga)  && (fem_mesh_t(tlm.result{pt1}{j-6},1)==tlm.ind.dom.elec2)) || ...
                           ((fem_mesh_t(tlm.result{pt1}{j-6},1)==tlm.ind.dom.MilOrga)  && (fem_mesh_t(i,1)==tlm.ind.dom.elec2)))
                            % If the segment is at the interface between the left or right outer electrodes - electrolyte
                            tlm.geom.boundaryEE{pt2}=0; % At the initialization, the array is empty and its size is 0
                            tlm.geom.boundaryEE{pt1}=0;
                        end
                        if (tlm.conf.Parasite==1)  && (((fem_mesh_t(i,1)==tlm.ind.dom.MilOrgb)  && ... ;Check the domain number of each triangle (see Remarks above)
                           (fem_mesh_t(tlm.result{pt1}{j-6},1)==tlm.ind.dom.elec1)) || ...
                           ((fem_mesh_t(tlm.result{pt1}{j-6},1)==tlm.ind.dom.MilOrgb)  && (fem_mesh_t(i,1)==tlm.ind.dom.elec1)) || ...
                           ((fem_mesh_t(i,1)==tlm.ind.dom.MilOrgb)  && (fem_mesh_t(tlm.result{pt1}{j-6},1)==tlm.ind.dom.elec2)) || ...
                           ((fem_mesh_t(tlm.result{pt1}{j-6},1)==tlm.ind.dom.MilOrgb)  && (fem_mesh_t(i,1)==tlm.ind.dom.elec2)))
                            % If the segment is at the interface between the left or right outer electrodes - electrolyte
                            tlm.geom.boundaryEE{pt2}=0; % At the initialization, the array is empty and its size is 0
                            tlm.geom.boundaryEE{pt1}=0;
                        end
                        if (tlm.conf.Membrane==1)  && (tlm.conf.Cell==1)  && (((fem_mesh_t(i,1)==tlm.ind.dom.MilOrga)  && ... % Check the domain number of each triangle (see Remarks above)
                           (fem_mesh_t(tlm.result{pt1}{j-6},1)==tlm.ind.dom.Cytoplasme(1))) || ...
                           ((fem_mesh_t(tlm.result{pt1}{j-6},1)==tlm.ind.dom.MilOrga)  && (fem_mesh_t(i,1)==tlm.ind.dom.Cytoplasme(1))))
                            % If the segment is at the interface between
                            % the cytoplasme1 - electrolyte 
                            tlm.geom.boundaryEC{1,pt2}=0; % At the initialization, the array is empty and its size is 0
                            tlm.geom.boundaryEC{1,pt1}=0;
                        end
                        if (tlm.conf.Membrane==1)  && (tlm.conf.Cell==2)  && (((fem_mesh_t(i,1)==tlm.ind.dom.MilOrga)  && ... % Check the domain number of each triangle (see Remarks above)
                           (fem_mesh_t(tlm.result{pt1}{j-6},1)==tlm.ind.dom.Cytoplasme(1))) || ...
                           ((fem_mesh_t(tlm.result{pt1}{j-6},1)==tlm.ind.dom.MilOrga)  && (fem_mesh_t(i,1)==tlm.ind.dom.Cytoplasme(1))))
                            % If the segment is at the interface between
                            % the cytoplasme1 - electrolyte 
                            tlm.geom.boundaryEC{1,pt2}=0; % At the initialization, the array is empty and its size is 0
                            tlm.geom.boundaryEC{1,pt1}=0;
                        end
                        if (tlm.conf.Membrane==1)  && (tlm.conf.Cell==2)  && (((fem_mesh_t(i,1)==tlm.ind.dom.MilOrga)  && ... % Check the domain number of each triangle (see Remarks above)
                           (fem_mesh_t(tlm.result{pt1}{j-6},1)==tlm.ind.dom.Cytoplasme(2))) || ...
                           ((fem_mesh_t(tlm.result{pt1}{j-6},1)==tlm.ind.dom.MilOrga)  && (fem_mesh_t(i,1)==tlm.ind.dom.Cytoplasme(2))))
                            % If the segment is at the interface between
                            % the cytoplasme1 - electrolyte 
                            tlm.geom.boundaryEC{2,pt2}=0; % At the initialization, the array is empty and its size is 0
                            tlm.geom.boundaryEC{2,pt1}=0;
                        end
                        if (tlm.conf.Membrane==1)  && (tlm.conf.Cell==1)  && (tlm.conf.Nucleus==1)  && ... % Check the domain number of each triangle (see Remarks above)
                           (((fem_mesh_t(i,1)==tlm.ind.dom.Nucleus(1))  && ... 
                           (fem_mesh_t(tlm.result{pt1}{j-6},1)==tlm.ind.dom.Cytoplasme(1))) || ...
                           ((fem_mesh_t(tlm.result{pt1}{j-6},1)==tlm.ind.dom.Nucleus(1))  && (fem_mesh_t(i,1)==tlm.ind.dom.Cytoplasme(1))))
                            % If the segment is at the interface between
                            %  nucleus1 - cytoplasme1
                            tlm.geom.boundaryEN{1,pt2}=0; % At the initialization, the array is empty and its size is 0
                            tlm.geom.boundaryEN{1,pt1}=0;
                        end 
                        if (tlm.conf.Membrane==1)  && (tlm.conf.Cell==2)  && (tlm.conf.Nucleus==1)  && ... % Check the domain number of each triangle (see Remarks above)
                           (((fem_mesh_t(i,1)==tlm.ind.dom.Nucleus(1))  && (fem_mesh_t(tlm.result{pt1}{j-6},1)==tlm.ind.dom.Cytoplasme(1))) || ...
                           ((fem_mesh_t(tlm.result{pt1}{j-6},1)==tlm.ind.dom.Nucleus(1))  && (fem_mesh_t(i,1)==tlm.ind.dom.Cytoplasme(1))))
                            % If the segment is at the interface between
                            %  nucleus1 - cytoplasme1 or nucleus2 - cytoplasme2
                            tlm.geom.boundaryEN{1,pt2}=0; % At the initialization, the array is empty and its size is 0
                            tlm.geom.boundaryEN{1,pt1}=0;
                        end
                        if (tlm.conf.Membrane==1)  && (tlm.conf.Cell==2)  && (tlm.conf.Nucleus==1)  && ... % Check the domain number of each triangle (see Remarks above)
                           (((fem_mesh_t(i,1)==tlm.ind.dom.Nucleus(2))  && (fem_mesh_t(tlm.result{pt1}{j-6},1)==tlm.ind.dom.Cytoplasme(2))) || ...
                           ((fem_mesh_t(tlm.result{pt1}{j-6},1)==tlm.ind.dom.Nucleus(2))  && (fem_mesh_t(i,1)==tlm.ind.dom.Cytoplasme(2))))
                            % If the segment is at the interface between
                            %  nucleus1 - cytoplasme1 or nucleus2 - cytoplasme2
                            tlm.geom.boundaryEN{2,pt2}=0; % At the initialization, the array is empty and its size is 0
                            tlm.geom.boundaryEN{2,pt1}=0;
                        end
                        if (tlm.conf.Membrane==1)  && (tlm.conf.Cell==1)  && (tlm.conf.Mitocho==1)  && ... % Check the domain number of each triangle (see Remarks above)
                           (((fem_mesh_t(i,1)==tlm.ind.dom.Mitocho(1))  && ... 
                           (fem_mesh_t(tlm.result{pt1}{j-6},1)==tlm.ind.dom.Cytoplasme(1))) || ...
                           ((fem_mesh_t(tlm.result{pt1}{j-6},1)==tlm.ind.dom.Mitocho(1))  && (fem_mesh_t(i,1)==tlm.ind.dom.Cytoplasme(1))))
                            % If the segment is at the interface between
                            %  nucleus1 - cytoplasme1
                            tlm.geom.boundaryEM{1,pt2}=0; % At the initialization, the array is empty and its size is 0
                            tlm.geom.boundaryEM{1,pt1}=0;
                        end
                        if (tlm.conf.Membrane==1)  && (tlm.conf.Cell==2)  && (tlm.conf.Mitocho==1)  && ... % Check the domain number of each triangle (see Remarks above)
                           (((fem_mesh_t(i,1)==tlm.ind.dom.Mitocho(1))  && (fem_mesh_t(tlm.result{pt1}{j-6},1)==tlm.ind.dom.Cytoplasme(1))) || ...
                           ((fem_mesh_t(tlm.result{pt1}{j-6},1)==tlm.ind.dom.Mitocho(1))  && (fem_mesh_t(i,1)==tlm.ind.dom.Cytoplasme(1))))
                            % If the segment is at the interface between
                            %  mitochondria1 - cytoplasme1 or mitochondria2 - cytoplasme2
                            tlm.geom.boundaryEM{1,pt2}=0; % At the initialization, the array is empty and its size is 0
                            tlm.geom.boundaryEM{1,pt1}=0;
                        end
                        if (tlm.conf.Membrane==1)  && (tlm.conf.Cell==2)  && (tlm.conf.Mitocho==1)  && ... % Check the domain number of each triangle (see Remarks above)
                           (((fem_mesh_t(i,1)==tlm.ind.dom.Mitocho(2))  && (fem_mesh_t(tlm.result{pt1}{j-6},1)==tlm.ind.dom.Cytoplasme(2))) || ...
                           ((fem_mesh_t(tlm.result{pt1}{j-6},1)==tlm.ind.dom.Mitocho(2))  && (fem_mesh_t(i,1)==tlm.ind.dom.Cytoplasme(2))))
                            % If the segment is at the interface between
                            %  mitochondria1 - cytoplasme1 or mitochondria2 - cytoplasme2
                            tlm.geom.boundaryEM{2,pt2}=0; % At the initialization, the array is empty and its size is 0
                            tlm.geom.boundaryEM{2,pt1}=0;
                        end
                        j=temp;                         % Goto the end of the loop
                        temp2=0;
                    end
                    j=j+8;
                end
                if temp2~=0                             % If the segment is not already in the data structure
                    tlm.result{pt1}=[tlm.result{pt1}, {pt2,i,0,0,0,0,0,0}];     % Add the segment
                end
            end
        end
    end
end

% Calculation of the third of the surface of each element (triangle)
% because there is three edges for each triangle

for i=1:1:size(fem_mesh_t,1)%ici aussi décalage de 1 pour prendreen compte que les vertex sont notés à partir de zero
    dx1=fem_mesh_p(1,fem_mesh_e(2,i)+1)-fem_mesh_p(1,fem_mesh_e(1,i)+1);
    dx2=fem_mesh_p(1,fem_mesh_e(3,i)+1)-fem_mesh_p(1,fem_mesh_e(1,i)+1);
    dy1=fem_mesh_p(2,fem_mesh_e(2,i)+1)-fem_mesh_p(2,fem_mesh_e(1,i)+1);
    dy2=fem_mesh_p(2,fem_mesh_e(3,i)+1)-fem_mesh_p(2,fem_mesh_e(1,i)+1);
    tlm.geom.airvol(i)=abs(dx1.*dy2-dy1.*dx2)/2/3;
end