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
%   tlm.geom.airvol(numdutrg)= sixth of the volume of the tetrahedron
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [tlm,model]=Remplissage3D(tlm,model)

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

for i=1:1:size(fem_mesh_t,1)                        %For each tetrahedron
    for n=1:1:3
        for m=n+1:1:4                               % for each segment
            pt1=fem_mesh_e(n,i)+1;    % Select two nodes
            pt2=fem_mesh_e(m,i)+1;    % Nodes numbering starts at 0 while array adressing should start at 1
%            pt1=fem_mesh_t(n,i);
%            pt2=fem_mesh_t(m,i);
            if pt1>pt2
                temp=pt2;
                pt2=pt1;
                pt1=temp;
            end
            if size(tlm.result{pt1},1)==0           %If the data structure is empty for point pt1
                 tlm.result{pt1}={pt2,i,0,0,0,0,0};            % Add the current segment
            else
                itemp=size(tlm.result{pt1},2);
                temp2=1;
                j=7;
                %Message=sprintf('%f',size(tlm.result{pt1},2))  
                while j<=itemp
                    if tlm.result{pt1}{j-6}==pt2    % If the segment is already in the data structure
                        tlm.result{pt1}{j-5}=[tlm.result{pt1}{j-5},i];       % Add the number of the adjacent element (tetrahedron)                      
                        j=size(tlm.result{pt1},2);  % Goto the end of the loop
                        temp2=0;
                    end 
                    j=j+7;
                end 
                if temp2~=0                         % If the segment is not already in the data structure
                    tlm.result{pt1}=[tlm.result{pt1}, {pt2,i,0,0,0,0,0}];  % Add the segment
                end
            end % if size(tlm.result{pt1},1)==0
        end % for m=n+1:1:4    
    end % for n=1:1:3
end %for i=1:1:size(fem_mesh_t,1) 

% for i=1:1:size(fem_mesh_e,2) %For each triangle at the interface

   % if (tlm.conf.Parasite==1) && ...
   %    ((fem_mesh_t(11,i)==tlm.ind.dom.elec1 && fem_mesh_t(12,i)==tlm.ind.dom.MilOrga) || ...
   %     (fem_mesh_t(11,i)==tlm.ind.dom.MilOrga && fem_mesh_t(12,i)==tlm.ind.dom.elec1) || ...
   %     (fem_mesh_t(11,i)==tlm.ind.dom.elec2 && fem_mesh_t(12,i)==tlm.ind.dom.MilOrga) || ...
   %     (fem_mesh_t(11,i)==tlm.ind.dom.MilOrga && fem_mesh_t(12,i)==tlm.ind.dom.elec2))
      % If the segment is at the interface between the left or right outer electrodes and the electrolyte    
           % tlm.geom.boundaryEE{fem_mesh_t(1,i)}=0;  % At the initialization, the array is empty and its size is 0
           % tlm.geom.boundaryEE{fem_mesh_e(2,i)}=0;
           % tlm.geom.boundaryEE{fem_mesh_e(3,i)}=0;
%    elseif (tlm.conf.Parasite==1) && ...
%       ((fem_mesh_e(11,i)==tlm.ind.dom.elec1 && fem_mesh_e(12,i)==tlm.ind.dom.MilOrgb) || ...
%        (fem_mesh_e(11,i)==tlm.ind.dom.MilOrgb && fem_mesh_e(12,i)==tlm.ind.dom.elec1) || ...
%        (fem_mesh_e(11,i)==tlm.ind.dom.elec2 && fem_mesh_e(12,i)==tlm.ind.dom.MilOrgb) || ...
%        (fem_mesh_e(11,i)==tlm.ind.dom.MilOrgb && fem_mesh_e(12,i)==tlm.ind.dom.elec2))
%       % If the segment is at the interface between the left or right outer electrodes and the electrolyte    
%            tlm.geom.boundaryEE{fem_mesh_e(1,i)}=0;  % At the initialization, the array is empty and its size is 0
%            tlm.geom.boundaryEE{fem_mesh_e(2,i)}=0;
%            tlm.geom.boundaryEE{fem_mesh_e(3,i)}=0;
%    elseif (tlm.conf.Membrane==1) && (tlm.conf.Cell==1) && ... 
%           ((fem_mesh_e(11,i)==tlm.ind.dom.Cytoplasme(1) && fem_mesh_e(12,i)==tlm.ind.dom.MilOrga) || ...
%           (fem_mesh_e(11,i)==tlm.ind.dom.MilOrga && fem_mesh_e(12,i)==tlm.ind.dom.Cytoplasme(1)))
%       % If the segment is at the interface between the cytoplasm and the electrolyte 
%            tlm.geom.boundaryEC{1,fem_mesh_e(1,i)}=0;  % At the initialization, the array is empty and its size is 0
%            tlm.geom.boundaryEC{1,fem_mesh_e(2,i)}=0;
%            tlm.geom.boundaryEC{1,fem_mesh_e(3,i)}=0;
%%    elseif (tlm.conf.Membrane==1) & (tlm.conf.Cell==1) & ... 
%%           ((fem_mesh_e(11,i)==tlm.ind.dom.Cytoplasme(1) & fem_mesh_e(12,i)==tlm.ind.dom.MilOrgb) | ...
%           (fem_mesh_e(11,i)==tlm.ind.dom.MilOrgb & fem_mesh_e(12,i)==tlm.ind.dom.Cytoplasme(1)))
%       % If the segment is at the interface between the cytoplasm and the electrolyte 
%            tlm.geom.boundaryEC{1,fem_mesh_e(1,i)}=0;  % At the initialization, the array is empty and its size is 0
%            tlm.geom.boundaryEC{1,fem_mesh_e(2,i)}=0;
%            tlm.geom.boundaryEC{1,fem_mesh_e(3,i)}=0;
%    elseif (tlm.conf.Membrane==1) && (tlm.conf.Cell==2) && ...
%           ((fem_mesh_e(11,i)==tlm.ind.dom.Cytoplasme(1) && fem_mesh_e(12,i)==tlm.ind.dom.MilOrga) || ...
%           (fem_mesh_e(11,i)==tlm.ind.dom.MilOrga && fem_mesh_e(12,i)==tlm.ind.dom.Cytoplasme(1)))
%       % If the segment is at the interface between the cytoplasm and the electrolyte 
%            tlm.geom.boundaryEC{1,fem_mesh_e(1,i)}=0;  % At the initialization, the array is empty and its size is 0
%            tlm.geom.boundaryEC{1,fem_mesh_e(2,i)}=0;
%            tlm.geom.boundaryEC{1,fem_mesh_e(3,i)}=0;
% %   elseif (tlm.conf.Membrane==1) & (tlm.conf.Cell==2) & ...
 %          ((fem_mesh_e(11,i)==tlm.ind.dom.Cytoplasme(1) & fem_mesh_e(12,i)==tlm.ind.dom.MilOrgb) | ...
 %          (fem_mesh_e(11,i)==tlm.ind.dom.MilOrgb & fem_mesh_e(12,i)==tlm.ind.dom.Cytoplasme(1)))
 %      % If the segment is at the interface between the cytoplasm and the electrolyte 
 %           tlm.geom.boundaryEC{1,fem_mesh_e(1,i)}=0;  % At the initialization, the array is empty and its size is 0
 %           tlm.geom.boundaryEC{1,fem_mesh_e(2,i)}=0;
 %           tlm.geom.boundaryEC{1,fem_mesh_e(3,i)}=0;
%    elseif (tlm.conf.Membrane==1) && (tlm.conf.Cell==2) && ...
%           ((fem_mesh_e(11,i)==tlm.ind.dom.Cytoplasme(2) && fem_mesh_e(12,i)==tlm.ind.dom.MilOrga) || ...
%           (fem_mesh_e(11,i)==tlm.ind.dom.MilOrga && fem_mesh_e(12,i)==tlm.ind.dom.Cytoplasme(2)))
%       % If the segment is at the interface between the cytoplasm and the electrolyte 
%            tlm.geom.boundaryEC{2,fem_mesh_e(1,i)}=0;  % At the initialization, the array is empty and its size is 0
%            tlm.geom.boundaryEC{2,fem_mesh_e(2,i)}=0;
%            tlm.geom.boundaryEC{2,fem_mesh_e(3,i)}=0;
  %  elseif (tlm.conf.Membrane==1) & (tlm.conf.Cell==2) & ...
  %         ((fem_mesh_e(11,i)==tlm.ind.dom.Cytoplasme(2) & fem_mesh_e(12,i)==tlm.ind.dom.MilOrgb) | ...
  %         (fem_mesh_e(11,i)==tlm.ind.dom.MilOrgb & fem_mesh_e(12,i)==tlm.ind.dom.Cytoplasme(2)))
  %     % If the segment is at the interface between the cytoplasm and the electrolyte 
  %          tlm.geom.boundaryEC{2,fem_mesh_e(1,i)}=0;  % At the initialization, the array is empty and its size is 0
  %          tlm.geom.boundaryEC{2,fem_mesh_e(2,i)}=0;
  %          tlm.geom.boundaryEC{2,fem_mesh_e(3,i)}=0;
%    elseif (tlm.conf.Membrane==1) && (tlm.conf.Cell==1) && (tlm.conf.Nucleus==1) && ...
%           ((fem_mesh_e(11,i)==tlm.ind.dom.Cytoplasme(1) && fem_mesh_e(12,i)==tlm.ind.dom.Nucleus(1)) || ...
%          (fem_mesh_e(11,i)==tlm.ind.dom.Nucleus(1) && fem_mesh_e(12,i)==tlm.ind.dom.Cytoplasme(1)))
       % If the segment is at the interface between nucleus1 - cytoplasme1
%            tlm.geom.boundaryEN{1,fem_mesh_e(1,i)}=0;  % At the initialization, the array is empty and its size is 0
%            tlm.geom.boundaryEN{1,fem_mesh_e(2,i)}=0;
%            tlm.geom.boundaryEN{1,fem_mesh_e(3,i)}=0;
%    elseif (tlm.conf.Membrane==1) && (tlm.conf.Cell==2) && (tlm.conf.Nucleus==1) && ...
%           ((fem_mesh_e(11,i)==tlm.ind.dom.Cytoplasme(1) && fem_mesh_e(12,i)==tlm.ind.dom.Nucleus(1)) || ...
%           (fem_mesh_e(11,i)==tlm.ind.dom.Nucleus(1) && fem_mesh_e(12,i)==tlm.ind.dom.Cytoplasme(1)))
       % If the segment is at the interface between nucleus (1) or (2) - cytoplasme (1) or (2)
%            tlm.geom.boundaryEN{1,fem_mesh_e(1,i)}=0;  % At the initialization, the array is empty and its size is 0
%            tlm.geom.boundaryEN{1,fem_mesh_e(2,i)}=0;
%            tlm.geom.boundaryEN{1,fem_mesh_e(3,i)}=0;
%    elseif (tlm.conf.Membrane==1) && (tlm.conf.Cell==2) && (tlm.conf.Nucleus==1) && ...
%           ((fem_mesh_e(11,i)==tlm.ind.dom.Cytoplasme(2) && fem_mesh_e(12,i)==tlm.ind.dom.Nucleus(2)) || ...
%           (fem_mesh_e(11,i)==tlm.ind.dom.Nucleus(2) && fem_mesh_e(12,i)==tlm.ind.dom.Cytoplasme(2)))
%       % If the segment is at the interface between nucleus (1) or (2) - cytoplasme (1) or (2)
%            tlm.geom.boundaryEN{2,fem_mesh_e(1,i)}=0;  % At the initialization, the array is empty and its size is 0
%            tlm.geom.boundaryEN{2,fem_mesh_e(2,i)}=0;
%            tlm.geom.boundaryEN{2,fem_mesh_e(3,i)}=0;
%    elseif (tlm.conf.Membrane==1) && (tlm.conf.Cell==1) && (tlm.conf.Mitocho==1) && ...
%           ((fem_mesh_e(11,i)==tlm.ind.dom.Cytoplasme(1) && fem_mesh_e(12,i)==tlm.ind.dom.Mitocho(1)) || ...
%           (fem_mesh_e(11,i)==tlm.ind.dom.Mitocho(1) && fem_mesh_e(12,i)==tlm.ind.dom.Cytoplasme(1)))
%       % If the segment is at the interface between nucleus(1) - cytoplasme(1)
%            tlm.geom.boundaryEM{1,fem_mesh_e(1,i)}=0;  % At the initialization, the array is empty and its size is 0
%            tlm.geom.boundaryEM{1,fem_mesh_e(2,i)}=0;
%            tlm.geom.boundaryEM{1,fem_mesh_e(3,i)}=0;
%    elseif (tlm.conf.Membrane==1) && (tlm.conf.Cell==2) && (tlm.conf.Mitocho==1) && ...
%           ((fem_mesh_e(11,i)==tlm.ind.dom.Cytoplasme(1) && fem_mesh_e(12,i)==tlm.ind.dom.Mitocho(1)) || ...
%           (fem_mesh_e(11,i)==tlm.ind.dom.Mitocho(1) && fem_mesh_e(12,i)==tlm.ind.dom.Cytoplasme(1)))
       % If the segment is at the interface between nucleus (1) or (2) - cytoplasme (1) or (2)
%            tlm.geom.boundaryEM{1,fem_mesh_e(1,i)}=0;  % At the initialization, the array is empty and its size is 0
%            tlm.geom.boundaryEM{1,fem_mesh_e(2,i)}=0;
%            tlm.geom.boundaryEM{1,fem_mesh_e(3,i)}=0;
%    elseif (tlm.conf.Membrane==1) && (tlm.conf.Cell==2) && (tlm.conf.Mitocho==1) && ...
%           ((fem_mesh_e(11,i)==tlm.ind.dom.Cytoplasme(2) && fem_mesh_e(12,i)==tlm.ind.dom.Mitocho(2)) || ...
%           (fem_mesh_e(11,i)==tlm.ind.dom.Mitocho(2) && fem_mesh_e(12,i)==tlm.ind.dom.Cytoplasme(2)))
       % If the segment is at the interface between nucleus (1) or (2) - cytoplasme (1) or (2)
%            tlm.geom.boundaryEM{2,fem_mesh_e(1,i)}=0;  % At the initialization, the array is empty and its size is 0
%            tlm.geom.boundaryEM{2,fem_mesh_e(2,i)}=0;
%            tlm.geom.boundaryEM{2,fem_mesh_e(3,i)}=0;
%     end
% 
% end

% Calculation of the 1/6 of the volume of each element (tetrahedron)
% because there is 6 edge on a tetrahedron, so the volume will be
% distributed for each edge

for i=1:1:size(fem_mesh_t,1)
    V11=fem_mesh_p(1,fem_mesh_e(1,i)+1)-fem_mesh_p(1,fem_mesh_e(2,i)+1); 
    V12=fem_mesh_p(2,fem_mesh_e(1,i)+1)-fem_mesh_p(2,fem_mesh_e(2,i)+1); 
    V13=fem_mesh_p(3,fem_mesh_e(1,i)+1)-fem_mesh_p(3,fem_mesh_e(2,i)+1);
    V21=fem_mesh_p(1,fem_mesh_e(1,i)+1)-fem_mesh_p(1,fem_mesh_e(3,i)+1);
    V22=fem_mesh_p(2,fem_mesh_e(1,i)+1)-fem_mesh_p(2,fem_mesh_e(3,i)+1);
    V23=fem_mesh_p(3,fem_mesh_e(1,i)+1)-fem_mesh_p(3,fem_mesh_e(3,i)+1);
    V31=fem_mesh_p(1,fem_mesh_e(1,i)+1)-fem_mesh_p(1,fem_mesh_e(4,i)+1);
    V32=fem_mesh_p(2,fem_mesh_e(1,i)+1)-fem_mesh_p(2,fem_mesh_e(4,i)+1);
    V33=fem_mesh_p(3,fem_mesh_e(1,i)+1)-fem_mesh_p(3,fem_mesh_e(4,i)+1);
    MV=[V11 V12 V13;V21 V22 V23;V31 V32 V33];
    tlm.geom.airvol(i)=-det(MV)/36;  % 1/6 of element volume 
end
