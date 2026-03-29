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

function [tlm,model]=RechercheIndice3D(tlm,model)

% Recherche des indices des points aux centres des électrodes et des
% indices des domaines

%Initialization

global fem_mesh_p;
global fem_mesh_t;
global fem_mesh_e;

flag(1:15)=0;     % Flag for a loop below

%Start the search

% Left outer electrode where there is the solicitation
i=1;

while i<=size(fem_mesh_p,2) %Loop on the total number of nodes to find the right node
%    Message=sprintf('%f',i)  

% PT1 node
    if tlm.conf.Init==1
        XX = tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2;
        YY = tlm.var.OrigineY;
        ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurChambre/2;
    end
%    if tlm.conf.points==1
%        XX = tlm.var.OrigineX;
%        YY = tlm.var.OrigineY;
%        ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurMesure/2;
%    elseif tlm.conf.points==2
%        XX = tlm.var.OrigineX;
%        YY = tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2;
%        ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/2;
%    elseif tlm.conf.points==4
%        XX = tlm.var.OrigineX;
%        YY = tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2;
%        ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/2;
%    end
    
    if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
       (abs(fem_mesh_p(2,i)-YY)<1e-10)&&...
       (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
            tlm.ind.pt.elec2=i;     % Find the number of the node in the mesh
    end
    
% PT1A node
    if tlm.conf.points==1
%        XX = tlm.var.OrigineX-tlm.var.LongueurElectrode/8;
%        YY = tlm.var.OrigineY;
%        ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurMesure/2;
        
%        if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%           (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%           (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                tlm.ind.pt.elec2supa(1)=i;     % Find the number of the node in the mesh
%        end

    elseif tlm.conf.points==2
        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
            for ik=-3:1:3
                XX = tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2;
                YY = tlm.var.OrigineY+ik*tlm.var.LargeurChambre/8;
                ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurChambre/2;
                        
                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
                        tlm.ind.pt.elec2supa(4+ik)=i;     % Find the number of the node in the mesh
                end

            end
        end
%    elseif tlm.conf.points==4
%        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
%            for ik=-3:1:3
%                XX = tlm.var.OrigineX+ik*tlm.var.LongueurElectrode/8;
%                YY = tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2;
%                ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/8;
%                
%                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                        tlm.ind.pt.elec2supa(4+ik)=i;     % Find the number of the node in the mesh
%                end

%            end
%        end
    end

 % PT1B node
    if tlm.conf.points==1
%        XX = tlm.var.OrigineX+tlm.var.LongueurElectrode/8;
%        YY = tlm.var.OrigineY;
%        ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurMesure/2;
        
%        if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%           (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%           (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                tlm.ind.pt.elec2supb(1)=i;     % Find the number of the node in the mesh
%        end

    elseif tlm.conf.points==2
        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
            for ik=-3:1:3
                
                XX = tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2;
                YY = tlm.var.OrigineY+ik*tlm.var.LargeurChambre/8;
                ZZ = tlm.var.OrigineZ+3*tlm.var.EpaisseurChambre/8;

                        
                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
                        tlm.ind.pt.elec2supb(4+ik)=i;     % Find the number of the node in the mesh
                end

            end
        end
%    elseif tlm.conf.points==4
%        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
%            for ik=-3:1:3
%                XX = tlm.var.OrigineX+ik*tlm.var.LongueurElectrode/8;
%                YY = tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2;
%                ZZ = tlm.var.OrigineZ+2*tlm.var.EpaisseurElectrode/8;
%                
%                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                        tlm.ind.pt.elec2supb(4+ik)=i;     % Find the number of the node in the mesh
%                end

%            end
%        end
    end

 % PT1C node
    if tlm.conf.points==1
%        XX = tlm.var.OrigineX-2*tlm.var.LongueurElectrode/8;
%        YY = tlm.var.OrigineY;
%        ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurMesure/2;
%        
%        if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%           (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%           (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                tlm.ind.pt.elec2supc(1)=i;     % Find the number of the node in the mesh
%        end

    elseif tlm.conf.points==2
        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
            for ik=-3:1:3
                
                XX = tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2;
                YY = tlm.var.OrigineY+ik*tlm.var.LargeurChambre/8;
                ZZ = tlm.var.OrigineZ+2*tlm.var.EpaisseurChambre/8;

                        
                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
                        tlm.ind.pt.elec2supc(4+ik)=i;     % Find the number of the node in the mesh
                end

            end
        end
%    elseif tlm.conf.points==4
%        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
%            for ik=-3:1:3

%                XX = tlm.var.OrigineX+ik*tlm.var.LongueurElectrode/8;
%                YY = tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2;
%                ZZ = tlm.var.OrigineZ+3*tlm.var.EpaisseurElectrode/8;
                
%                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                        tlm.ind.pt.elec2supc(4+ik)=i;     % Find the number of the node in the mesh
%                end

%            end
%        end
    end

% PT1D node
    if tlm.conf.points==1

%        XX = tlm.var.OrigineX+2*tlm.var.LongueurElectrode/8;
%        YY = tlm.var.OrigineY;
%        ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurMesure/2;
        
%        if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%           (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%           (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                tlm.ind.pt.elec2supd(1)=i;     % Find the number of the node in the mesh
%        end

    elseif tlm.conf.points==2
        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
            for ik=-3:1:3
                
                XX = tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2;
                YY = tlm.var.OrigineY+ik*tlm.var.LargeurChambre/8;
                ZZ = tlm.var.OrigineZ+1*tlm.var.EpaisseurChambre/8;

                        
                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
                        tlm.ind.pt.elec2supd(4+ik)=i;     % Find the number of the node in the mesh
                end

            end
        end
%    elseif tlm.conf.points==4
%        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
%            for ik=-3:1:3

%                XX = tlm.var.OrigineX+ik*tlm.var.LongueurElectrode/8;
%                YY = tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2;
%                ZZ = tlm.var.OrigineZ+4*tlm.var.EpaisseurElectrode/8;
                
%                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                        tlm.ind.pt.elec2supd(4+ik)=i;     % Find the number of the node in the mesh
%                end

%            end
%        end
    end

% PT1E node
    if tlm.conf.points==1

%        XX = tlm.var.OrigineX-3*tlm.var.LongueurElectrode/8;
%        YY = tlm.var.OrigineY;
%        ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurMesure/2;
        
%        if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%           (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%           (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                tlm.ind.pt.elec2supe(1)=i;     % Find the number of the node in the mesh
%        end

    elseif tlm.conf.points==2
        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
            for ik=-3:1:3

                XX = tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2;
                YY = tlm.var.OrigineY+ik*tlm.var.LargeurChambre/8;
                ZZ = tlm.var.OrigineZ+5*tlm.var.EpaisseurChambre/8;

%                        
                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
                        tlm.ind.pt.elec2supe(4+ik)=i;     % Find the number of the node in the mesh
                end

            end
        end
%    elseif tlm.conf.points==4
%        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
%            for ik=-3:1:3

%                XX = tlm.var.OrigineX+ik*tlm.var.LongueurElectrode/8;
%                YY = tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2;
%                ZZ = tlm.var.OrigineZ+5*tlm.var.EpaisseurElectrode/8;
%                
%                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                        tlm.ind.pt.elec2supe(4+ik)=i;     % Find the number of the node in the mesh
%                end

%            end
%        end
    end

% PT1F node
    if tlm.conf.points==1

%        XX = tlm.var.OrigineX+3*tlm.var.LongueurElectrode/8;
%        YY = tlm.var.OrigineY;
%        ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurMesure/2;
%        
%        if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%           (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%           (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                tlm.ind.pt.elec2supf(1)=i;     % Find the number of the node in the mesh
%        end

    elseif tlm.conf.points==2
        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
            for ik=-3:1:3

                XX = tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2;
                YY = tlm.var.OrigineY+ik*tlm.var.LargeurChambre/8;
                ZZ = tlm.var.OrigineZ+6*tlm.var.EpaisseurChambre/8;

                        
                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
                        tlm.ind.pt.elec2supf(4+ik)=i;     % Find the number of the node in the mesh
                end

            end
        end
%    elseif tlm.conf.points==4
%        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
%            for ik=-3:1:3

%                XX = tlm.var.OrigineX+ik*tlm.var.LongueurElectrode/8;
%                YY = tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2;
%                ZZ = tlm.var.OrigineZ+6*tlm.var.EpaisseurElectrode/8;
                
%                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                        tlm.ind.pt.elec2supf(4+ik)=i;     % Find the number of the node in the mesh
%                end

%            end
%        end
    end

% PT1G node
    if tlm.conf.points==1

%        XX = tlm.var.OrigineX;
%        YY = tlm.var.OrigineY;
%        ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurMesure/2;
%        
%        if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%           (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%           (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                tlm.ind.pt.elec2supg(1)=i;     % Find the number of the node in the mesh
%        end

    elseif tlm.conf.points==2
        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
            for ik=-3:1:3

                XX = tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2;
                YY = tlm.var.OrigineY+ik*tlm.var.LargeurChambre/8;
                ZZ = tlm.var.OrigineZ+7*tlm.var.EpaisseurChambre/8;

%                        
                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
                  (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
                        tlm.ind.pt.elec2supg(4+ik)=i;     % Find the number of the node in the mesh
                end

            end
        end
%    elseif tlm.conf.points==4
%        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
%            for ik=-3:1:3

%                XX = tlm.var.OrigineX+ik*tlm.var.LongueurElectrode/8;
%                YY = tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2;
%                ZZ = tlm.var.OrigineZ+7*tlm.var.EpaisseurElectrode/8;
                
%                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                        tlm.ind.pt.elec2supg(4+ik)=i;     % Find the number of the node in the mesh
%                end

%            end
%        end
    end

% PT2 node
%    if tlm.conf.points==4
%        XX = tlm.var.OrigineX;
%        YY = tlm.var.OrigineY-tlm.var.EcartementMesure/2-tlm.var.LargeurMesure/2;
%        ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurMesure/2;
%    end
    
%    if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%       (abs(fem_mesh_p(2,i)-YY)<1e-10)&&...
%       (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%            tlm.ind.pt.mesu2=i;      % Find the number of the node in the mesh
%    end
    
% PT3 node 
%    if tlm.conf.points==4
%        XX = tlm.var.OrigineX;
%        YY = tlm.var.OrigineY+tlm.var.EcartementMesure/2+tlm.var.LargeurMesure/2;
%        ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurMesure/2;
%    end

%    if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%       (abs(fem_mesh_p(2,i)-YY)<1e-10)&&...
%       (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%            tlm.ind.pt.mesu1=i;      % Find the number of the node in the mesh
%    end
    
% PT4 node
    if tlm.conf.Init==1
        XX = tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2;
        YY = tlm.var.OrigineY;
        ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurChambre/2;
    end
%    if tlm.conf.points==1
%        XX = tlm.var.OrigineX;
%        YY = tlm.var.OrigineY;
%        ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurChambre-tlm.var.EpaisseurMesure/2;
%    elseif tlm.conf.points==2
%        XX = tlm.var.OrigineX;
%        YY = tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2;
%        ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/2;
%    elseif tlm.conf.points==4
%        XX = tlm.var.OrigineX;
%        YY = tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2;
%        ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/2;
%    end

    if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
       (abs(fem_mesh_p(2,i)-YY)<1e-10) &&...
       (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
            tlm.ind.pt.elec1=i;       % Find the number of the node in the mesh
    end
    
% PT4A node
    if tlm.conf.points==1

%        XX = tlm.var.OrigineX-1*tlm.var.LongueurElectrode/8;
%        YY = tlm.var.OrigineY;
%        ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurChambre-tlm.var.EpaisseurMesure/2;
        
%        if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%           (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%           (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                tlm.ind.pt.elec1supa(1)=i;     % Find the number of the node in the mesh
%        end

    elseif tlm.conf.points==2
        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
            for ik=-3:1:3

                XX = tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2;
                YY = tlm.var.OrigineY+ik*tlm.var.LargeurChambre/8;
                ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurChambre/2;

                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
                        tlm.ind.pt.elec1supa(4+ik)=i;     % Find the number of the node in the mesh
                end

            end
        end
%    elseif tlm.conf.points==4
%        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
 %           for ik=-3:1:3

%                XX = tlm.var.OrigineX+ik*tlm.var.LongueurElectrode/8;
%                YY = tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2;
%                ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurChambre/8;
%                
%                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                        tlm.ind.pt.elec1supa(4+ik)=i;     % Find the number of the node in the mesh
%                end

%            end
%        end
    end

% PT4B node

    if tlm.conf.points==1
%        XX = tlm.var.OrigineX+1*tlm.var.LongueurElectrode/8;
%        YY = tlm.var.OrigineY;
%        ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurChambre-tlm.var.EpaisseurMesure/2;
        
%        if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%           (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%           (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                tlm.ind.pt.elec1supb(1)=i;     % Find the number of the node in the mesh
%        end

    elseif tlm.conf.points==2
        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
            for ik=-3:1:3

%                XX = tlm.var.OrigineX+ik*tlm.var.LongueurElectrode/8;
%                YY = tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2;
%                ZZ = tlm.var.OrigineZ+2*tlm.var.EpaisseurChambre/8;

                XX = tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2;
                YY = tlm.var.OrigineY+ik*tlm.var.LargeurChambre/8;
                ZZ = tlm.var.OrigineZ+3*tlm.var.EpaisseurChambre/8;

                        
                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
                        tlm.ind.pt.elec1supb(4+ik)=i;     % Find the number of the node in the mesh
                end

            end
        end
%    elseif tlm.conf.points==4
%        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
%            for ik=-3:1:3

%                XX = tlm.var.OrigineX+ik*tlm.var.LongueurElectrode/8;
%                YY = tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2;
%                ZZ = tlm.var.OrigineZ+2*tlm.var.EpaisseurChambre/8;
                
%                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                        tlm.ind.pt.elec1supb(4+ik)=i;     % Find the number of the node in the mesh
%                end

%            end
%        end
    end

 % PT4C node
    if tlm.conf.points==1

%        XX = tlm.var.OrigineX-2*tlm.var.LongueurElectrode/8;
%        YY = tlm.var.OrigineY;
%        ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurChambre-tlm.var.EpaisseurMesure/2;
        
%        if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%           (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%           (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                tlm.ind.pt.elec1supc(1)=i;     % Find the number of the node in the mesh
%        end

    elseif tlm.conf.points==2
        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
            for ik=-3:1:3

                XX = tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2;
                YY = tlm.var.OrigineY+ik*tlm.var.LargeurChambre/8;
                ZZ = tlm.var.OrigineZ+2*tlm.var.EpaisseurChambre/8;
                        
                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
                        tlm.ind.pt.elec1supc(4+ik)=i;     % Find the number of the node in the mesh
                end

            end
        end
%    elseif tlm.conf.points==4
%        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
%            for ik=-3:1:3

%                XX = tlm.var.OrigineX+ik*tlm.var.LongueurElectrode/8;
%                YY = tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2;
%                ZZ = tlm.var.OrigineZ+3*tlm.var.EpaisseurChambre/8;
                
%                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                        tlm.ind.pt.elec1supc(4+ik)=i;     % Find the number of the node in the mesh
%                end

%            end
%        end
    end

% PT4D node
    if tlm.conf.points==1
%        XX = tlm.var.OrigineX+2*tlm.var.LongueurElectrode/8;
%        YY = tlm.var.OrigineY;
%        ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurChambre-tlm.var.EpaisseurMesure/2;
        
%        if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%           (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%           (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                tlm.ind.pt.elec1supd(1)=i;     % Find the number of the node in the mesh
%        end

    elseif tlm.conf.points==2
        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
            for ik=-3:1:3

%                XX = tlm.var.OrigineX+ik*tlm.var.LongueurElectrode/8;
%                YY = tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2;
%                ZZ = tlm.var.OrigineZ+4*tlm.var.EpaisseurChambre/8;

                XX = tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2;
                YY = tlm.var.OrigineY+ik*tlm.var.LargeurChambre/8;
                ZZ = tlm.var.OrigineZ+1*tlm.var.EpaisseurChambre/8;
                       
                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
                        tlm.ind.pt.elec1supd(4+ik)=i;     % Find the number of the node in the mesh
                end

            end
        end
%    elseif tlm.conf.points==4
%        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
%            for ik=-3:1:3

%                XX = tlm.var.OrigineX+ik*tlm.var.LongueurElectrode/8;
%                YY = tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2;
%                ZZ = tlm.var.OrigineZ+4*tlm.var.EpaisseurChambre/8;
                
%                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                        tlm.ind.pt.elec1supd(4+ik)=i;     % Find the number of the node in the mesh
%                end

%            end
%        end
    end

% PT4E node
    if tlm.conf.points==1

%        XX = tlm.var.OrigineX-3*tlm.var.LongueurElectrode/8;
%        YY = tlm.var.OrigineY;
%        ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurChambre-tlm.var.EpaisseurMesure/2;

%        if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%           (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%           (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                tlm.ind.pt.elec1supe(1)=i;     % Find the number of the node in the mesh
%        end

    elseif tlm.conf.points==2
        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
            for ik=-3:1:3

%                XX = tlm.var.OrigineX+ik*tlm.var.LongueurElectrode/8;
%                YY = tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2;
%                ZZ = tlm.var.OrigineZ+5*tlm.var.EpaisseurChambre/8;
                XX = tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2;
                YY = tlm.var.OrigineY+ik*tlm.var.LargeurChambre/8;
                ZZ = tlm.var.OrigineZ+5*tlm.var.EpaisseurChambre/8;
                        
                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
                        tlm.ind.pt.elec1supe(4+ik)=i;     % Find the number of the node in the mesh
                end

            end
        end
%    elseif tlm.conf.points==4
%        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
%            for ik=-3:1:3

%                XX = tlm.var.OrigineX+ik*tlm.var.LongueurElectrode/8;
%                YY = tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2;
%                ZZ = tlm.var.OrigineZ+5*tlm.var.EpaisseurChambre/8;
                
%                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                        tlm.ind.pt.elec1supe(4+ik)=i;     % Find the number of the node in the mesh
%                end

%            end
%        end
    end

% PT4F node
    if tlm.conf.points==1

%        XX = tlm.var.OrigineX+3*tlm.var.LongueurElectrode/8;
%        YY = tlm.var.OrigineY;
%        ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurChambre-tlm.var.EpaisseurMesure/2;
        
%        if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%           (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%           (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                tlm.ind.pt.elec1supf(1)=i;     % Find the number of the node in the mesh
%        end             

    elseif tlm.conf.points==2
        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
            for ik=-3:1:3

%                XX = tlm.var.OrigineX+ik*tlm.var.LongueurElectrode/8;
%                YY = tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2;
%                ZZ = tlm.var.OrigineZ+6*tlm.var.EpaisseurChambre/8;
                XX = tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2;
                YY = tlm.var.OrigineY+ik*tlm.var.LargeurChambre/8;
                ZZ = tlm.var.OrigineZ+6*tlm.var.EpaisseurChambre/8;

                        
                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
                        tlm.ind.pt.elec1supf(4+ik)=i;     % Find the number of the node in the mesh
                end

            end
        end
%    elseif tlm.conf.points==4
%        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
%            for ik=-3:1:3

%                XX = tlm.var.OrigineX+ik*tlm.var.LongueurElectrode/8;
%                YY = tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2;
%                ZZ = tlm.var.OrigineZ+6*tlm.var.EpaisseurChambre/8;
                
%                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                        tlm.ind.pt.elec1supf(4+ik)=i;     % Find the number of the node in the mesh
%                end

%            end
%        end
    end

% PT4G node
    if tlm.conf.points==1

%        XX = tlm.var.OrigineX;
%        YY = tlm.var.OrigineY;
%        ZZ = tlm.var.OrigineZ+tlm.var.EpaisseurMesure/2;
        
%        if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%           (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%           (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                tlm.ind.pt.elec1supg(1)=i;     % Find the number of the node in the mesh
%        end

    elseif tlm.conf.points==2
        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
            for ik=-3:1:3

%                XX = tlm.var.OrigineX+ik*tlm.var.LongueurElectrode/8;
%                YY = tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2;
%                ZZ = tlm.var.OrigineZ+7*tlm.var.EpaisseurChambre/8;
                XX = tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2;
                YY = tlm.var.OrigineY+ik*tlm.var.LargeurChambre/8;
                ZZ = tlm.var.OrigineZ+7*tlm.var.EpaisseurChambre/8;
                        
                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
                        tlm.ind.pt.elec1supg(4+ik)=i;     % Find the number of the node in the mesh
                end

            end
        end
%    elseif tlm.conf.points==4
%        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
%            for ik=-3:1:3

%                XX = tlm.var.OrigineX+ik*tlm.var.LongueurElectrode/8;
%                YY = tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2;
%                ZZ = tlm.var.OrigineZ+7*tlm.var.EpaisseurChambre/8;
                
%                if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%                   (abs(fem_mesh_p(2,i)-YY)<1e-10) && ...
%                   (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%                        tlm.ind.pt.elec1supg(4+ik)=i;     % Find the number of the node in the mesh
%                end

%            end
%        end
    end

% PT5 node
    if tlm.conf.Init==1
        XX= tlm.var.OrigineX;
        YY=tlm.var.OrigineY;
        ZZ=tlm.var.OrigineZ+tlm.var.EpaisseurChambre-tlm.var.Epsilon;
    end
    if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
               (abs(fem_mesh_p(2,i)-YY)<1e-10)&&...
               (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
                    tlm.ind.pt.MilOrga=i;     % Find the number of the node in the mesh
    end
            
%    if (tlm.conf.Cell==1 || tlm.conf.Cell==2)
%        if tlm.conf.points~=1
%            if (abs(fem_mesh_p(1,i)-tlm.var.OrigineX)<1e-10) && ...
%               (abs(fem_mesh_p(2,i)-tlm.var.OrigineY+tlm.var.Center)<1e-10)&&...
%               (abs(fem_mesh_p(3,i)-(tlm.var.OrigineZ+tlm.var.EpaisseurChambre-tlm.var.Epsilon))<1e-10)
%                    tlm.ind.pt.MilOrga=i;     % Find the number of the node in the mesh
%            end
%        else
%            if (abs(fem_mesh_p(1,i)-tlm.var.OrigineX)<1e-10) && ...
%               (abs(fem_mesh_p(2,i)-tlm.var.OrigineY+tlm.var.Center)<1e-10)&&...
%               (abs(fem_mesh_p(3,i)-(tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)+tlm.var.RayonZCellule(1)+tlm.var.Epsilon))<1e-10)
%                    tlm.ind.pt.MilOrga=i;     % Find the number of the node in the mesh
%            end
%        end
%    else

%        if (abs(fem_mesh_p(1,i)-tlm.var.OrigineX)<1e-10) && ...
%           (abs(fem_mesh_p(2,i)-tlm.var.OrigineY+tlm.var.Center)<1e-10)&&...
%           (abs(fem_mesh_p(3,i)-(tlm.var.OrigineZ+tlm.var.EpaisseurChambre/2))<1e-10)
%                tlm.ind.pt.MilOrga=i;     % Find the number of the node in the mesh
%        end

%    end

% PT12 node in withcell3D    
%    if tlm.conf.Milo==2
%        if (tlm.conf.Cell==1 || tlm.conf.Cell==2)
%            if tlm.conf.points~=1
%                if (abs(fem_mesh_p(1,i)-tlm.var.OrigineX)<1e-10) && ...
%                   (abs(fem_mesh_p(2,i)-tlm.var.OrigineY-tlm.var.Center)<1e-10)&&...
%                   (abs(fem_mesh_p(3,i)-(tlm.var.OrigineZ+tlm.var.EpaisseurChambre-tlm.var.Epsilon))<1e-10)
%                        tlm.ind.pt.MilOrgb=i;     % Find the number of the node in the mesh
%                end
%            else
%                if (abs(fem_mesh_p(1,i)-tlm.var.OrigineX)<1e-10) && ...
%                   (abs(fem_mesh_p(2,i)-tlm.var.OrigineY-tlm.var.Center)<1e-10)&&...
%                   (abs(fem_mesh_p(3,i)-(tlm.var.OrigineZ+tlm.var.EpaisseurChambre-tlm.var.Epsilon))<1e-10)
%                        tlm.ind.pt.MilOrgb=i;     % Find the number of the node in the mesh
%                end
%            end
%        else
%            if (abs(fem_mesh_p(1,i)-tlm.var.OrigineX)<1e-10) && ...
%               (abs(fem_mesh_p(2,i)-tlm.var.OrigineY-tlm.var.Center)<1e-10)&&...
%               (abs(fem_mesh_p(3,i)-(tlm.var.OrigineZ+tlm.var.EpaisseurChambre-tlm.var.Epsilon))<1e-10)
%                    tlm.ind.pt.MilOrgb=i;     % Find the number of the node in the mesh
%            end

%        end
%    end
    
% If there is a Cell
    if tlm.conf.Cell==1 % one cell 
        if (abs(fem_mesh_p(1,i)-(tlm.var.OrigineX+tlm.var.DecentrageYCellule(1)))<1e-10) && ...
           (abs(fem_mesh_p(2,i)-(tlm.var.OrigineY+tlm.var.DecentrageXCellule(1)))<1e-10) && ...
           (abs(fem_mesh_p(3,i)-(tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)))<1e-10)
                tlm.ind.pt.Cytoplasme(1)=i;        % Find the number of the node PT6 in the mesh
        end
        % If there is a Nucleus
        if tlm.conf.Nucleus==1
            if (abs(fem_mesh_p(1,i)-(tlm.var.OrigineX+tlm.var.DecentrageYCellule(1)+tlm.var.DecentrageYNoyau(1)))<1e-10) && ...
               (abs(fem_mesh_p(2,i)-(tlm.var.OrigineY+tlm.var.DecentrageXCellule(1)+tlm.var.DecentrageXNoyau(1)))<1e-10) && ...
               (abs(fem_mesh_p(3,i)-(tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)+tlm.var.DecentrageZNoyau(1)))<1e-10)              
                    tlm.ind.pt.Nucleus(1)=i;       % Find the number of the node PT7 in the mesh
            end
        end
        % If there is a Mitochondria
        if tlm.conf.Mitocho==1
            if (abs(fem_mesh_p(1,i)-(tlm.var.OrigineX+tlm.var.DecentrageYCellule(1)+tlm.var.DecentrageYMitoc(1)))<1e-10) && ...
               (abs(fem_mesh_p(2,i)-(tlm.var.OrigineY+tlm.var.DecentrageXCellule(1)+tlm.var.DecentrageXMitoc(1)))<1e-10) && ...
               (abs(fem_mesh_p(3,i)-(tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)+tlm.var.DecentrageZMitoc(1)))<1e-10)              
                    tlm.ind.pt.Mitocho(1)=i;       % Find the number of the node PT8 in the mesh
            end
        end
    end
    
    if tlm.conf.Cell==2 % two cells 
        if (abs(fem_mesh_p(1,i)-(tlm.var.OrigineX+tlm.var.DecentrageYCellule(1)))<1e-10) && ...
           (abs(fem_mesh_p(2,i)-(tlm.var.OrigineY+tlm.var.DecentrageXCellule(1)))<1e-10) && ...
           (abs(fem_mesh_p(3,i)-(tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)))<1e-10)
                tlm.ind.pt.Cytoplasme(1)=i;        % Find the number of the node PT6 in the mesh
        end
        % If there is a Nucleus
        if tlm.conf.Nucleus==1
            if (abs(fem_mesh_p(1,i)-(tlm.var.OrigineX+tlm.var.DecentrageYCellule(1)+tlm.var.DecentrageYNoyau(1)))<1e-10) && ...
               (abs(fem_mesh_p(2,i)-(tlm.var.OrigineY+tlm.var.DecentrageXCellule(1)+tlm.var.DecentrageXNoyau(1)))<1e-10) && ...
               (abs(fem_mesh_p(3,i)-(tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)+tlm.var.DecentrageZNoyau(1)))<1e-10)              
                    tlm.ind.pt.Nucleus(1)=i;       % Find the number of the node PT7 in the mesh
            end
        end
        % If there is a Mitochondria
        if tlm.conf.Mitocho==1
            if (abs(fem_mesh_p(1,i)-(tlm.var.OrigineX+tlm.var.DecentrageYCellule(1)+tlm.var.DecentrageYMitoc(1)))<1e-10) && ...
               (abs(fem_mesh_p(2,i)-(tlm.var.OrigineY+tlm.var.DecentrageXCellule(1)+tlm.var.DecentrageXMitoc(1)))<1e-10) && ...
               (abs(fem_mesh_p(3,i)-(tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)+tlm.var.DecentrageZMitoc(1)))<1e-10)              
                    tlm.ind.pt.Mitocho(1)=i;       % Find the number of the node PT8 in the mesh
            end
        end
        if (abs(fem_mesh_p(1,i)-(tlm.var.OrigineX+tlm.var.DecentrageYCellule(2)))<1e-10) && ...
           (abs(fem_mesh_p(2,i)-(tlm.var.OrigineY+tlm.var.DecentrageXCellule(2)))<1e-10) && ...
           (abs(fem_mesh_p(3,i)-(tlm.var.OrigineZ+tlm.var.DecentrageZCellule(2)))<1e-10)
                tlm.ind.pt.Cytoplasme(2)=i;        % Find the number of the node PT9 in the mesh
        end
        % If there is a Nucleus
        if tlm.conf.Nucleus==1
            if (abs(fem_mesh_p(1,i)-(tlm.var.OrigineX+tlm.var.DecentrageYCellule(2)+tlm.var.DecentrageYNoyau(2)))<1e-10) && ...
               (abs(fem_mesh_p(2,i)-(tlm.var.OrigineY+tlm.var.DecentrageXCellule(2)+tlm.var.DecentrageXNoyau(2)))<1e-10) && ...
               (abs(fem_mesh_p(3,i)-(tlm.var.OrigineZ+tlm.var.DecentrageZCellule(2)+tlm.var.DecentrageZNoyau(2)))<1e-10)              
                    tlm.ind.pt.Nucleus(2)=i;       % Find the number of the node PT10 in the mesh
            end
        end
        % If there is a Mitochondria
        if tlm.conf.Mitocho==1
            if (abs(fem_mesh_p(1,i)-(tlm.var.OrigineX+tlm.var.DecentrageYCellule(2)+tlm.var.DecentrageYMitoc(2)))<1e-10) && ...
               (abs(fem_mesh_p(2,i)-(tlm.var.OrigineY+tlm.var.DecentrageXCellule(2)+tlm.var.DecentrageXMitoc(2)))<1e-10) && ...
               (abs(fem_mesh_p(3,i)-(tlm.var.OrigineZ+tlm.var.DecentrageZCellule(2)+tlm.var.DecentrageZMitoc(2)))<1e-10)              
                    tlm.ind.pt.Mitocho(2)=i;       % Find the number of the node PT11 in the mesh
            end
        end
    end
    i=i+1;
end


i=1;

while i<=size(fem_mesh_t,1) %Loop on the total number of elements (here it is tetrahedra)
%        Message=sprintf('%f',i)  
    
%Left outer electrode Electrode de masse

    if flag(1)==0
        if (fem_mesh_e(1,i)+1==tlm.ind.pt.elec2) || (fem_mesh_e(2,i)+1==tlm.ind.pt.elec2) ||...
           (fem_mesh_e(3,i)+1==tlm.ind.pt.elec2) ||...
           (fem_mesh_e(4,i)+1==tlm.ind.pt.elec2)    
            tlm.ind.dom.elec2=fem_mesh_t(i,1);                      % Flag the number of the domain
            tlm.dom.sig(fem_mesh_t(i,1))=tlm.var.sig.electrode;    % Fix the conductivity of the domain
            tlm.dom.eps(fem_mesh_t(i,1))=tlm.var.eps.electrode;    % Fix the permittivity of the domain
            flag(1)=1;
        end
    end

%Right outer electrode Electrode de masse

    if flag(2)==0
        if (fem_mesh_e(1,i)+1==tlm.ind.pt.elec1) || (fem_mesh_e(2,i)+1==tlm.ind.pt.elec1) ||...
           (fem_mesh_e(3,i)+1==tlm.ind.pt.elec1) ||...
           (fem_mesh_e(4,i)+1==tlm.ind.pt.elec1)
            tlm.ind.dom.elec1=fem_mesh_t(i,1);                      % Flag the number of the domain
            tlm.dom.sig(fem_mesh_t(i,1))=tlm.var.sig.electrode;    % Fix the conductivity of the domain
            tlm.dom.eps(fem_mesh_t(i,1))=tlm.var.eps.electrode;    % Fix the permittivity of the domain
            flag(2)=1;
        end
    end

%Left inner electrode called MESUR1

%    if flag(3)==0
%        if (fem_mesh_t(1,i)==tlm.ind.pt.mesu1) || (fem_mesh_t(2,i)==tlm.ind.pt.mesu1) || (fem_mesh_t(3,i)==tlm.ind.pt.mesu1) ||...
%           (fem_mesh_t(4,i)==tlm.ind.pt.mesu1)   
%            tlm.ind.dom.mesu1=fem_mesh_t(5,i);                      % Flag the number of the domain
%            tlm.dom.sig(fem_mesh_t(5,i))=tlm.var.sig.electrode;    % Fix the conductivity of the domain
%            tlm.dom.eps(fem_mesh_t(5,i))=tlm.var.eps.electrode;    % Fix the permittivity of the domain
%            flag(3)=1;
%        end
%    end

%Right inner electrode called MESUR2

%    if flag(4)==0
%        if (fem_mesh_t(1,i)==tlm.ind.pt.mesu2) || (fem_mesh_t(2,i)==tlm.ind.pt.mesu2) || (fem_mesh_t(3,i)==tlm.ind.pt.mesu2) ||...
%            (fem_mesh_t(4,i)==tlm.ind.pt.mesu2)   
%            tlm.ind.dom.mesu2=fem_mesh_t(5,i);                      % Flag the number of the domain
%            tlm.dom.sig(fem_mesh_t(5,i))=tlm.var.sig.electrode;    % Fix the conductivity of the domain
%            tlm.dom.eps(fem_mesh_t(5,i))=tlm.var.eps.electrode;    % Fix the permittivity of the domain
%            flag(4)=1;
%        end
%    end

% The cells

    if tlm.conf.Cell==0
        flag(5)=1;
        tlm.ind.dom.Cytoplasme(1)=-1;
        flag(6)=1;
        tlm.ind.dom.Nucleus(1)=-1;
        flag(7)=1;
        tlm.ind.dom.Mitocho(1)=-1;
        flag(8)=1;
        tlm.ind.dom.Cytoplasme(2)=-1;
        flag(9)=1;
        tlm.ind.dom.Nucleus(2)=-1;
        flag(10)=1;
        tlm.ind.dom.Mitocho(2)=-1;
    end

    if tlm.conf.Cell==1

    %Cytoplasm of the first cell
        
        if flag(5)==0
            if (fem_mesh_t(1,i)==tlm.ind.pt.Cytoplasme(1)) || (fem_mesh_t(2,i)==tlm.ind.pt.Cytoplasme(1)) || ...
               (fem_mesh_t(3,i)==tlm.ind.pt.Cytoplasme(1)) || (fem_mesh_t(4,i)==tlm.ind.pt.Cytoplasme(1))
                    tlm.ind.dom.Cytoplasme(1)=fem_mesh_t(5,i);                 % Flag the number of the domain
                    tlm.ind.dom.Cytoplasme(2)=-1;                              % no second cell
                    tlm.dom.sig(fem_mesh_t(5,i))=tlm.var.sig.Cytoplasme(1);   % Fix the conductivity of the domain
                    tlm.dom.eps(fem_mesh_t(5,i))=tlm.var.eps.Cytoplasme(1);   % Fix the permittivity of the domain
                    flag(5)=1;
            end
        end
    
    %Nucleus of the first cell
% 
        if tlm.conf.Nucleus==1
     
            if flag(6)==0
                if (fem_mesh_t(1,i)==tlm.ind.pt.Nucleus(1)) || (fem_mesh_t(2,i)==tlm.ind.pt.Nucleus(1)) || ... 
                   (fem_mesh_t(3,i)==tlm.ind.pt.Nucleus(1)) || (fem_mesh_t(4,i)==tlm.ind.pt.Nucleus(1))
                        tlm.ind.dom.Nucleus(1)=fem_mesh_t(5,i);                    % Flag the number of the domain
                        tlm.ind.dom.Nucleus(2)=-1;                                 % no second cell
                        tlm.dom.sig(fem_mesh_t(5,i))=tlm.var.sig.Nucleus(1);      % Fix the conductivity of the domain
                        tlm.dom.eps(fem_mesh_t(5,i))=tlm.var.eps.Nucleus(1);      % Fix the permittivity of the domain
                        flag(6)=1;
                end
            end
        else
            flag(6)=1;
            tlm.ind.dom.Nucleus(1)=-1;
        end
        
    %Mitochondria of the first cell
% 
        if tlm.conf.Mitocho==1
     
            if flag(7)==0
                if (fem_mesh_t(1,i)==tlm.ind.pt.Mitocho(1)) || (fem_mesh_t(2,i)==tlm.ind.pt.Mitocho(1)) || ... 
                   (fem_mesh_t(3,i)==tlm.ind.pt.Mitocho(1)) || (fem_mesh_t(4,i)==tlm.ind.pt.Mitocho(1))
                        tlm.ind.dom.Mitocho(1)=fem_mesh_t(5,i);                    % Flag the number of the domain
                        tlm.ind.dom.Mitocho(2)=-1;                                 % no second cell
                        tlm.dom.sig(fem_mesh_t(5,i))=tlm.var.sig.Mitocho(1);      % Fix the conductivity of the domain
                        tlm.dom.eps(fem_mesh_t(5,i))=tlm.var.eps.Mitocho(1);      % Fix the permittivity of the domain
                        flag(7)=1;
                end
            end
        else
            flag(7)=1;
            tlm.ind.dom.Mitocho(1)=-1;
        end
        
    end

    if tlm.conf.Cell==2

    %Cytoplasm of the first cell
        
        if flag(5)==0
            if (fem_mesh_t(1,i)==tlm.ind.pt.Cytoplasme(1)) || (fem_mesh_t(2,i)==tlm.ind.pt.Cytoplasme(1)) || ...
               (fem_mesh_t(3,i)==tlm.ind.pt.Cytoplasme(1)) ||(fem_mesh_t(4,i)==tlm.ind.pt.Cytoplasme(1))
                    tlm.ind.dom.Cytoplasme(1)=fem_mesh_t(5,i);                 % Flag the number of the domain
                    tlm.dom.sig(fem_mesh_t(5,i))=tlm.var.sig.Cytoplasme(1);   % Fix the conductivity of the domain
                    tlm.dom.eps(fem_mesh_t(5,i))=tlm.var.eps.Cytoplasme(1);   % Fix the permittivity of the domain
                    flag(5)=1;
            end
        end
    
    %Nucleus of the first cell
% 
        if tlm.conf.Nucleus==1
     
            if flag(6)==0
                if (fem_mesh_t(1,i)==tlm.ind.pt.Nucleus(1)) || (fem_mesh_t(2,i)==tlm.ind.pt.Nucleus(1)) || ... 
                   (fem_mesh_t(3,i)==tlm.ind.pt.Nucleus(1)) || (fem_mesh_t(4,i)==tlm.ind.pt.Nucleus(1))
                        tlm.ind.dom.Nucleus(1)=fem_mesh_t(5,i);                    % Flag the number of the domain
                        tlm.dom.sig(fem_mesh_t(5,i))=tlm.var.sig.Nucleus(1);      % Fix the conductivity of the domain
                        tlm.dom.eps(fem_mesh_t(5,i))=tlm.var.eps.Nucleus(1);      % Fix the permittivity of the domain
                        flag(6)=1;
                end
            end
        else
            flag(6)=1;
            tlm.ind.dom.Nucleus(1)=-1;
        end
        
    %Mitochondria of the first cell
% 
        if tlm.conf.Mitocho==1
     
            if flag(7)==0
                if (fem_mesh_t(1,i)==tlm.ind.pt.Mitocho(1)) || (fem_mesh_t(2,i)==tlm.ind.pt.Mitocho(1)) || ... 
                   (fem_mesh_t(3,i)==tlm.ind.pt.Mitocho(1)) || (fem_mesh_t(4,i)==tlm.ind.pt.Mitocho(1))
                        tlm.ind.dom.Mitocho(1)=fem_mesh_t(5,i);                    % Flag the number of the domain
                        tlm.dom.sig(fem_mesh_t(5,i))=tlm.var.sig.Mitocho(1);      % Fix the conductivity of the domain
                        tlm.dom.eps(fem_mesh_t(5,i))=tlm.var.eps.Mitocho(1);      % Fix the permittivity of the domain
                        flag(7)=1;
                end
            end
        else
            flag(7)=1;
            tlm.ind.dom.Mitocho(1)=-1;
        end
     
    %Cytoplasm of the second cell
        
        if flag(8)==0
            if (fem_mesh_t(1,i)==tlm.ind.pt.Cytoplasme(2)) || (fem_mesh_t(2,i)==tlm.ind.pt.Cytoplasme(2)) || ...
               (fem_mesh_t(3,i)==tlm.ind.pt.Cytoplasme(2)) || (fem_mesh_t(4,i)==tlm.ind.pt.Cytoplasme(2))
                    tlm.ind.dom.Cytoplasme(2)=fem_mesh_t(5,i);                 % Flag the number of the domain
                    tlm.dom.sig(fem_mesh_t(5,i))=tlm.var.sig.Cytoplasme(2);   % Fix the conductivity of the domain
                    tlm.dom.eps(fem_mesh_t(5,i))=tlm.var.eps.Cytoplasme(2);   % Fix the permittivity of the domain
                    flag(8)=1;
            end
        end
    
    %Nucleus of the second cell
% 
        if tlm.conf.Nucleus==1
     
            if flag(9)==0
                if (fem_mesh_t(1,i)==tlm.ind.pt.Nucleus(2)) || (fem_mesh_t(2,i)==tlm.ind.pt.Nucleus(2)) || ... 
                   (fem_mesh_t(3,i)==tlm.ind.pt.Nucleus(2)) || (fem_mesh_t(4,i)==tlm.ind.pt.Nucleus(2))
                        tlm.ind.dom.Nucleus(2)=fem_mesh_t(5,i);                    % Flag the number of the domain
                        tlm.dom.sig(fem_mesh_t(5,i))=tlm.var.sig.Nucleus(2);      % Fix the conductivity of the domain
                        tlm.dom.eps(fem_mesh_t(5,i))=tlm.var.eps.Nucleus(2);      % Fix the permittivity of the domain
                        flag(9)=1;
                end
            end
        else
            flag(9)=1;
            tlm.ind.dom.Nucleus(2)=-1;
        end
        
    %Mitochondria of the second cell
% 
        if tlm.conf.Mitocho==1
     
            if flag(10)==0
                if (fem_mesh_t(1,i)==tlm.ind.pt.Mitocho(2)) || (fem_mesh_t(2,i)==tlm.ind.pt.Mitocho(2)) || ... 
                   (fem_mesh_t(3,i)==tlm.ind.pt.Mitocho(2)) || (fem_mesh_t(4,i)==tlm.ind.pt.Mitocho(2))
                        tlm.ind.dom.Mitocho(2)=fem_mesh_t(5,i);                    % Flag the number of the domain
                        tlm.dom.sig(fem_mesh_t(5,i))=tlm.var.sig.Mitocho(2);      % Fix the conductivity of the domain
                        tlm.dom.eps(fem_mesh_t(5,i))=tlm.var.eps.Mitocho(2);      % Fix the permittivity of the domain
                        flag(10)=1;
                end
            end
        else
            flag(10)=1;
            tlm.ind.dom.Mitocho(2)=-1;
        end
     
    end

% Organic External Medium

    if tlm.conf.Milo==1
        if flag(11)==0
            if (fem_mesh_e(1,i)+1==tlm.ind.pt.MilOrga) || (fem_mesh_e(2,i)+1==tlm.ind.pt.MilOrga) || (fem_mesh_e(3,i)+1==tlm.ind.pt.MilOrga) ||...
               (fem_mesh_e(4,i)+1==tlm.ind.pt.MilOrga)     
                    tlm.ind.dom.MilOrga=fem_mesh_t(i,1);                % Flag the number of the domain
                    tlm.ind.dom.MilOrgb=-1;                             % Flag the number of the domain
                    tlm.dom.sig(fem_mesh_t(i,1))=tlm.var.sig.MilOrga;  % Fix the conductivity of the domain
                    tlm.dom.eps(fem_mesh_t(i,1))=tlm.var.eps.MilOrga;  % Fix the permittivity of the domain
                    flag(11)=1;
            end    
        end
    
        if ( flag(1)==1 && flag(2)==1 && flag(3)==1 && flag(4)==1 && flag(5)==1 && flag(6)==1 && flag(7)==1 && ...
             flag(8)==1 && flag(9)==1 && flag(10)==1 && flag(11)==1 )
             i=size(fem_mesh_t,2)+1;
        else
            i=i+1;
        end
    end

    if tlm.conf.Milo==2
        
        if flag(11)==0
            if (fem_mesh_t(1,i)==tlm.ind.pt.MilOrga) || (fem_mesh_t(2,i)==tlm.ind.pt.MilOrga) || (fem_mesh_t(3,i)==tlm.ind.pt.MilOrga) ||...
               (fem_mesh_t(4,i)==tlm.ind.pt.MilOrga)     
                    tlm.ind.dom.MilOrga=fem_mesh_t(5,i);                % Flag the number of the domain
                    tlm.dom.sig(fem_mesh_t(5,i))=tlm.var.sig.MilOrga;  % Fix the conductivity of the domain
                    tlm.dom.eps(fem_mesh_t(5,i))=tlm.var.eps.MilOrga;  % Fix the permittivity of the domain
                    flag(11)=1;
            end    
         end

         if flag(12)==0
            if (fem_mesh_t(1,i)==tlm.ind.pt.MilOrgb) || (fem_mesh_t(2,i)==tlm.ind.pt.MilOrgb) || (fem_mesh_t(3,i)==tlm.ind.pt.MilOrgb) ||...
               (fem_mesh_t(4,i)==tlm.ind.pt.MilOrgb)     
                    tlm.ind.dom.MilOrgb=fem_mesh_t(5,i);                % Flag the number of the domain
                    tlm.dom.sig(fem_mesh_t(5,i))=tlm.var.sig.MilOrgb;  % Fix the conductivity of the domain
                    tlm.dom.eps(fem_mesh_t(5,i))=tlm.var.eps.MilOrgb;  % Fix the permittivity of the domain
                    flag(12)=1;
            end    
         end
         
         if tlm.conf.Milo==2
            if ( flag(1)==1 && flag(2)==1 && flag(3)==1 && flag(4)==1 && flag(5)==1 && flag(6)==1 && flag(7)==1 && ...
                 flag(8)==1 && flag(9)==1 && flag(10)==1 && flag(11)==1 && flag(12)==1)
                    i=size(fem_mesh_t,2)+1;
            else
                    i=i+1;
            end
         end
    end

end