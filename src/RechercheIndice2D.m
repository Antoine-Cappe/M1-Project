%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                              BIOCAD Program
%                               Release 1.0
%
%   Authors: Vincent Senez
%   
%   Release 1.0 : January 2019
%
%   Routine RechercheIndice2D called by Compute.m,
%
%   Function:   Look for the number of the Point PT1, PT2, PT3, ... in the
%               global mesh, Flag the domains, Fix the conductivity & permittivity of
%               each domain
%
%   Remark: RAS
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [tlm,model]=RechercheIndice2D(tlm,model)
%function [tlm,fem]=RechercheIndice2D(tlm,fem)

% Recherche des indices des points aux centres des électrodes et des
% indices des domaines

%Initialization

global fem_mesh_p;
global fem_mesh_t;
global fem_mesh_e;

%Start the search

% Left side of the device where there is the solicitation

XX = tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode;
%YY = tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2;

i=1;
cpt=1;
while i<=size(fem_mesh_p,2)
    if abs(fem_mesh_p(1,i)-XX)<1e-10
        tlm.ind.pt.left(cpt)=i;
        cpt=cpt+1;
%    elseif (abs(fem_mesh_p(1,i)-XX)<1e-10 && abs(fem_mesh_p(2,i)-YY)<1e-10)
%        tlm.ind.pt.left1=i;
    end
    i=i+1;
end

% Left outer electrode where there is the solicitation

%if tlm.conf.points==1
%    XX = tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2;
%    YY = tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2;
%elseif tlm.conf.points==2
%    XX = tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2;
%    YY = tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2;
%elseif tlm.conf.points==4
    XX = tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2;
    YY = tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2;
%end

tlm.ind.pt.elec2=find(abs(fem_mesh_p(1,:)-XX)<1e-10 & abs(fem_mesh_p(2,:)-YY)<1e-10);

if tlm.var.EpaisseurElectrode~=0 %Check that there is thick electrodes
    i=1;
    while i<=size(fem_mesh_t,1) %Loop on the total number of elements (here it is triangle)
        if (fem_mesh_e(1,i)+1==tlm.ind.pt.elec2) || (fem_mesh_e(2,i)+1==tlm.ind.pt.elec2) || (fem_mesh_e(3,i)+1==tlm.ind.pt.elec2)
            tlm.ind.dom.elec2=fem_mesh_t(i,1);                      % Flag the number of the domain
            tlm.dom.sig(fem_mesh_t(i,1))=tlm.var.sig.electrode;    % Fix the conductivity of the domain
            tlm.dom.eps(fem_mesh_t(i,1))=tlm.var.eps.electrode;    % Fix the permittivity of the domain
            i=size(fem_mesh_t,1);                                   % Goto the end of the loop
        end
        i=i+1;
    end
end

if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10 
    for ic=1:1:3
%        if tlm.conf.points==1
%            XX = tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2;
%            YY = tlm.var.OrigineY+ic*tlm.var.EpaisseurElectrode/8;
%        elseif tlm.conf.points==2
%            XX = tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2;
%            YY = tlm.var.OrigineY+ic*tlm.var.EpaisseurElectrode/8;
%        elseif tlm.conf.points==4
            XX = tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2;
            YY = tlm.var.OrigineY+ic*tlm.var.EpaisseurElectrode/8;
%        end

        tlm.ind.pt.elec2sup(ic)=find(abs(fem_mesh_p(1,:)-XX)<1e-10 & abs(fem_mesh_p(2,:)-YY)<1e-10);

%    if tlm.var.EpaisseurElectrode~=0 %Check that there is thick electrodes
%        i=1;
%        while i<=size(fem_mesh_t,2) %Loop on the total number of elements (here it is triangle)
%            if (fem_mesh_t(1,i)==tlm.ind.pt.elec2sup(ic)) || (fem_mesh_t(2,i)==tlm.ind.pt.elec2sup(ic)) || (fem_mesh_t(3,i)==tlm.ind.pt.elec2sup(ic))
%                tlm.ind.dom.elec2sup(ic)=fem_mesh_t(4,i);                      % Flag the number of the domain
%                tlm.dom.sig(fem_mesh_t(4,i))=tlm.var.sig.electrode;    % Fix the conductivity of the domain
%                tlm.dom.eps(fem_mesh_t(4,i))=tlm.var.eps.electrode;    % Fix the permittivity of the domain
%                i=size(fem_mesh_t,2);                                   % Goto the end of the loop
%            end
%            i=i+1;
%        end
%    end

%        if tlm.conf.points==1
%            XX = tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2;
%            YY = tlm.var.OrigineY+(ic+4)*tlm.var.EpaisseurElectrode/8;
%        elseif tlm.conf.points==2
%            XX = tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2;
%            YY = tlm.var.OrigineY+(ic+4)*tlm.var.EpaisseurElectrode/8;
%        elseif tlm.conf.points==4
            XX = tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2;
            YY = tlm.var.OrigineY+(ic+4)*tlm.var.EpaisseurElectrode/8;
%        end

        tlm.ind.pt.elec2sup(3+ic)=find(abs(fem_mesh_p(1,:)-XX)<1e-10 & abs(fem_mesh_p(2,:)-YY)<1e-10);

%if tlm.var.EpaisseurElectrode~=0 %Check that there is thick electrodes
%    i=1;
%    while i<=size(fem_mesh_t,2) %Loop on the total number of elements (here it is triangle)
%        if (fem_mesh_t(1,i)==tlm.ind.pt.elec2b) || (fem_mesh_t(2,i)==tlm.ind.pt.elec2b) || (fem_mesh_t(3,i)==tlm.ind.pt.elec2b)
%            tlm.ind.dom.elec2b=fem_mesh_t(4,i);                      % Flag the number of the domain
%            tlm.dom.sig(fem_mesh_t(4,i))=tlm.var.sig.electrode;    % Fix the conductivity of the domain
%            tlm.dom.eps(fem_mesh_t(4,i))=tlm.var.eps.electrode;    % Fix the permittivity of the domain
%            i=size(fem_mesh_t,2);                                   % Goto the end of the loop
%        end
%        i=i+1;
%    end
%end
    end
end

% Right side of the device where there is the ground

XX = tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode;
%YY = tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2;

i=1;
cpt=1;
while i<=size(fem_mesh_p,2)
    if abs(fem_mesh_p(1,i)-XX)<1e-10
        tlm.ind.pt.right(cpt)=i;
        cpt=cpt+1;
%    elseif (abs(fem_mesh_p(1,i)-XX)<1e-10 && abs(fem_mesh_p(2,i)-YY)<1e-10)
%        tlm.ind.pt.right1=i;
    end
    i=i+1;
end


%Right outer electrode Electrode connected to the ground

%if tlm.conf.points==1
%    XX = tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2;
%    YY = tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2;
%elseif tlm.conf.points==2
%    XX = tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2;
%    YY = tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2;
%elseif tlm.conf.points==4
    XX = tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2;
    YY = tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2;
%end

tlm.ind.pt.elec1=find(abs(fem_mesh_p(1,:)-XX)<1e-10 & abs(fem_mesh_p(2,:)-YY)<1e-10);

if tlm.var.EpaisseurElectrode~=0   %Check that there is thick electrodes
    i=1;
    while i<=size(fem_mesh_t,1)     %Loop on the total number of elements (here it is triangle)
        if (fem_mesh_e(1,i)+1==tlm.ind.pt.elec1) || (fem_mesh_e(2,i)+1==tlm.ind.pt.elec1) || (fem_mesh_e(3,i)+1==tlm.ind.pt.elec1)
            tlm.ind.dom.elec1=fem_mesh_t(i,1);                      % Flag the number of the domain
            tlm.dom.sig(fem_mesh_t(i,1))=tlm.var.sig.electrode;    % Fix the conductivity of the domain
            tlm.dom.eps(fem_mesh_t(i,1))=tlm.var.eps.electrode;    % Fix the permittivity of the domain
            i=size(fem_mesh_t,1);                                   % Goto the end of the loop
        end
        i=i+1;
    end
end

if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10 
    for ic=1:1:3
%        if tlm.conf.points==1
%            XX = tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2;
%            YY = tlm.var.OrigineY+ic*tlm.var.EpaisseurElectrode/8;
%        elseif tlm.conf.points==2
%            XX = tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2;
%            YY = tlm.var.OrigineY+ic*tlm.var.EpaisseurElectrode/8;
%        elseif tlm.conf.points==4
            XX = tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2;
            YY = tlm.var.OrigineY+ic*tlm.var.EpaisseurElectrode/8;
%        end

        tlm.ind.pt.elec1sup(ic)=find(abs(fem_mesh_p(1,:)-XX)<1e-10 & abs(fem_mesh_p(2,:)-YY)<1e-10);

%if tlm.var.EpaisseurElectrode~=0   %Check that there is thick electrodes
%    i=1;
%    while i<=size(fem_mesh_t,2)     %Loop on the total number of elements (here it is triangle)
%        if (fem_mesh_t(1,i)==tlm.ind.pt.elec1a) || (fem_mesh_t(2,i)==tlm.ind.pt.elec1a) || (fem_mesh_t(3,i)==tlm.ind.pt.elec1a)
%            tlm.ind.dom.elec1a=fem_mesh_t(4,i);                      % Flag the number of the domain
%            tlm.dom.sig(fem_mesh_t(4,i))=tlm.var.sig.electrode;    % Fix the conductivity of the domain
%            tlm.dom.eps(fem_mesh_t(4,i))=tlm.var.eps.electrode;    % Fix the permittivity of the domain
%            i=size(fem_mesh_t,2);                                   % Goto the end of the loop
%        end
%        i=i+1;
%    end
%end

%        if tlm.conf.points==1
%            XX = tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2;
%            YY = tlm.var.OrigineY+(4+ic)*tlm.var.EpaisseurElectrode/8;
%        elseif tlm.conf.points==2
%            XX = tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2;
%            YY = tlm.var.OrigineY+(4+ic)*tlm.var.EpaisseurElectrode/8;
%        elseif tlm.conf.points==4
            XX = tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2;
            YY = tlm.var.OrigineY+(4+ic)*tlm.var.EpaisseurElectrode/8;
%        end

        tlm.ind.pt.elec1sup(3+ic)=find(abs(fem_mesh_p(1,:)-XX)<1e-10 & abs(fem_mesh_p(2,:)-YY)<1e-10);

%if tlm.var.EpaisseurElectrode~=0   %Check that there is thick electrodes
%    i=1;
%    while i<=size(fem_mesh_t,2)     %Loop on the total number of elements (here it is triangle)
%        if (fem_mesh_t(1,i)==tlm.ind.pt.elec1b) || (fem_mesh_t(2,i)==tlm.ind.pt.elec1b) || (fem_mesh_t(3,i)==tlm.ind.pt.elec1b)
%            tlm.ind.dom.elec1b=fem_mesh_t(4,i);                      % Flag the number of the domain
%            tlm.dom.sig(fem_mesh_t(4,i))=tlm.var.sig.electrode;    % Fix the conductivity of the domain
%            tlm.dom.eps(fem_mesh_t(4,i))=tlm.var.eps.electrode;    % Fix the permittivity of the domain
%            i=size(fem_mesh_t,2);                                   % Goto the end of the loop
%        end
%        i=i+1;
%    end
%end

    end
end

if tlm.conf.points==4

    %Left inner electrode called MESUR1

    XX = tlm.var.OrigineX-tlm.var.EcartementMesure/2-tlm.var.LargeurMesure/2;
    YY = tlm.var.OrigineY+tlm.var.EpaisseurMesure/2;

    tlm.ind.pt.mesu1=find(abs(fem_mesh_p(1,:)-XX)<1e-10 & abs(fem_mesh_p(2,:)-YY)<1e-10);

    if tlm.var.EpaisseurMesure~=0      %Check that there is thick electrodes
        i=1;
        while i<=size(fem_mesh_t,1)     %Loop on the total number of elements (here it is triangle)
            if (fem_mesh_e(1,i)+1==tlm.ind.pt.mesu1) || (fem_mesh_e(2,i)+1==tlm.ind.pt.mesu1) || (fem_mesh_e(3,i)+1==tlm.ind.pt.mesu1)
                tlm.ind.dom.mesu1=fem_mesh_t(i,1);                      % Flag the number of the domain
                tlm.dom.sig(fem_mesh_t(i,1))=tlm.var.sig.electrode;    % Fix the conductivity of the domain
                tlm.dom.eps(fem_mesh_t(i,1))=tlm.var.eps.electrode;    % Fix the permittivity of the domain
                i=size(fem_mesh_t,1);                                   % Goto the end of the loop
            end
            i=i+1;
        end
    end

    %Right inner electrode called MESUR2

    XX = tlm.var.OrigineX+tlm.var.EcartementMesure/2+tlm.var.LargeurMesure/2;
    YY = tlm.var.OrigineY+tlm.var.EpaisseurMesure/2;

    tlm.ind.pt.mesu2=find(abs(fem_mesh_p(1,:)-XX)<1e-10 & abs(fem_mesh_p(2,:)-YY)<1e-10);

    if tlm.var.EpaisseurMesure~=0  %Check that there is thick electrodes
        i=1;
        while i<=size(fem_mesh_t,1)     %Loop on the total number of elements (here it is triangle)
            if (fem_mesh_e(1,i)+1==tlm.ind.pt.mesu2) || (fem_mesh_e(2,i)+1==tlm.ind.pt.mesu2) || (fem_mesh_e(3,i)+1==tlm.ind.pt.mesu2)
                tlm.ind.dom.mesu2=fem_mesh_t(i,1);                      % Flag the number of the domain
                tlm.dom.sig(fem_mesh_t(i,1))=tlm.var.sig.electrode;    % Fix the conductivity of the domain
                tlm.dom.eps(fem_mesh_t(i,1))=tlm.var.eps.electrode;    % Fix the permittivity of the domain
                i=size(fem_mesh_t,1);                                   % Goto the end of the loop
            end
            i=i+1;
        end
    end
    
end

% The cells

if tlm.conf.Cell==1

    %Cytoplasm of the first cell
    
    XX = tlm.var.OrigineX+tlm.var.DecentrageXCellule(1);
    YY = tlm.var.OrigineY+tlm.var.DecentrageZCellule(1);

    tlm.ind.pt.Cytoplasme1=find(abs(fem_mesh_p(1,:)-XX)<1e-10 & abs(fem_mesh_p(2,:)-YY)<1e-10);

    i=1;
    
    while i<=size(fem_mesh_t,1)     %Loop on the total number of elements (here it is triangle)
        if (fem_mesh_e(1,i)+1==tlm.ind.pt.Cytoplasme1) || (fem_mesh_e(2,i)+1==tlm.ind.pt.Cytoplasme1) || ...
           (fem_mesh_e(3,i)+1==tlm.ind.pt.Cytoplasme1)
            tlm.ind.dom.Cytoplasme(1)=fem_mesh_t(i,1);                  % Flag the number of the domain
            tlm.ind.dom.Cytoplasme(2)=-1;                               % No second cell
            tlm.dom.sig(fem_mesh_t(i,1))=tlm.var.sig.Cytoplasme(1);   % Fix the conductivity of the domain
            tlm.dom.eps(fem_mesh_t(i,1))=tlm.var.eps.Cytoplasme(1);   % Fix the permittivity of the domain
            i=size(fem_mesh_t,1);                                   % Goto the end of the loop
        end
        i=i+1;
    end
    
    %Nucleus of the first cell
    
    if tlm.conf.Nucleus==1

        XX = tlm.var.OrigineX+tlm.var.DecentrageXCellule(1)+sqrt(tlm.var.DecentrageXNoyau(1)^2+tlm.var.DecentrageZNoyau(1)^2)*cos(tlm.var.Orientation.Cellule(1));
        YY = tlm.var.OrigineY+tlm.var.DecentrageZCellule(1)+sqrt(tlm.var.DecentrageXNoyau(1)^2+tlm.var.DecentrageZNoyau(1)^2)*sin(tlm.var.Orientation.Cellule(1));

        i=1;        
 
        while i<=size(fem_mesh_p,2)     %Loop on the total number of nodes to find the right node (PT7 node in Geom2D)
            if (abs(fem_mesh_p(1,i)-XX)<1e-10) && (abs(fem_mesh_p(2,i)-YY)<1e-10)
                    tlm.ind.pt.Nucleus1=i;          % Find the number of the node in the mesh
                    i=size(fem_mesh_p,2);           % Go to the end of the loop
            end
            i=i+1;
        end

% Function find does not work as soon as we rotate the cell (for rotation=pi/2)        tlm.ind.pt.Nucleus1=find(fem_mesh_p(1,:)==XX & fem_mesh_p(2,:)==YY);

        i=1;
    
        while i<=size(fem_mesh_t,1)     %Loop on the total number of elements (here it is triangle)
            if (fem_mesh_e(1,i)+1==tlm.ind.pt.Nucleus1) || (fem_mesh_e(2,i)+1==tlm.ind.pt.Nucleus1) || (fem_mesh_e(3,i)+1==tlm.ind.pt.Nucleus1)
                tlm.ind.dom.Nucleus(1)=fem_mesh_t(i,1);                     % Flag the number of the domain
                tlm.ind.dom.Nucleus(2)=-1;                                  % no second cell
                tlm.dom.sig(fem_mesh_t(i,1))=tlm.var.sig.Nucleus(1);      % Fix the conductivity of the domain
                tlm.dom.eps(fem_mesh_t(i,1))=tlm.var.eps.Nucleus(1);      % Fix the permittivity of the domain
                i=size(fem_mesh_t,1);                                    % Goto the end of the loop
            end
            i=i+1;
        end
    else
        tlm.ind.dom.Nucleus(1)=-1;
    end
    
    if tlm.conf.Mitocho==1

        XX = tlm.var.OrigineX+tlm.var.DecentrageXCellule(1)-sqrt(tlm.var.DecentrageXMitoc(1)^2+tlm.var.DecentrageZMitoc(1)^2)*cos(tlm.var.Orientation.Cellule(1));
        YY = tlm.var.OrigineY+tlm.var.DecentrageZCellule(1)-sqrt(tlm.var.DecentrageXMitoc(1)^2+tlm.var.DecentrageZMitoc(1)^2)*sin(tlm.var.Orientation.Cellule(1));

% Function find does not work as soon as we rotate the cell (for rotation=pi/2)        tlm.ind.pt.Mitocho1=find(fem_mesh_p(1,:)==XX & fem_mesh_p(2,:)==YY);

        i=1;        
 
        while i<=size(fem_mesh_p,2)     %Loop on the total number of nodes to find the right node (PT7 node in Geom2D)
            if (abs(fem_mesh_p(1,i)-XX)<1e-10) && (abs(fem_mesh_p(2,i)-YY)<1e-10)
                    tlm.ind.pt.Mitocho1=i;          % Find the number of the node in the mesh
                    i=size(fem_mesh_p,2);           % Go to the end of the loop
            end
            i=i+1;
        end

        i=1;
    
        while i<=size(fem_mesh_t,1)     %Loop on the total number of elements (here it is triangle)
            if (fem_mesh_e(1,i)+1==tlm.ind.pt.Mitocho1) || (fem_mesh_e(2,i)+1==tlm.ind.pt.Mitocho1) || (fem_mesh_e(3,i)+1==tlm.ind.pt.Mitocho1)
                tlm.ind.dom.Mitocho(1)=fem_mesh_t(i,1);                    % Flag the number of the domain
                tlm.ind.dom.Mitocho(2)=-1;                                 % no second cell
                tlm.dom.sig(fem_mesh_t(i,1))=tlm.var.sig.Mitocho(1);      % Fix the conductivity of the domain
                tlm.dom.eps(fem_mesh_t(i,1))=tlm.var.eps.Mitocho(1);      % Fix the permittivity of the domain
                i=size(fem_mesh_t,1);                                    % Goto the end of the loop
            end
            i=i+1;
        end
    else
        tlm.ind.dom.Mitocho(1)=-1;
    end    
elseif (tlm.conf.Cell==0)
    tlm.ind.dom.Cytoplasme(1)=-1;
    tlm.ind.dom.Nucleus(1)=-1;
    tlm.ind.dom.Mitocho(1)=-1;
    tlm.ind.dom.Cytoplasme(2)=-1;
    tlm.ind.dom.Nucleus(2)=-1;
    tlm.ind.dom.Mitocho(2)=-1;
end

if tlm.conf.Cell==2

    %Cytoplasm of the first cell
    
    XX = tlm.var.OrigineX+tlm.var.DecentrageXCellule(1);
    YY = tlm.var.OrigineY+tlm.var.DecentrageZCellule(1);

    tlm.ind.pt.Cytoplasme1=find(abs(fem_mesh_p(1,:)-XX)<1e-10 & abs(fem_mesh_p(2,:)-YY)<1e-10);

    i=1;
    
    while i<=size(fem_mesh_t,1)     %Loop on the total number of elements (here it is triangle)
        if (fem_mesh_t(1,i)==tlm.ind.pt.Cytoplasme1) || (fem_mesh_t(2,i)==tlm.ind.pt.Cytoplasme1) || ...
           (fem_mesh_t(3,i)==tlm.ind.pt.Cytoplasme1)
            tlm.ind.dom.Cytoplasme(1)=fem_mesh_t(4,i);                 % Flag the number of the domain
            tlm.dom.sig(fem_mesh_t(4,i))=tlm.var.sig.Cytoplasme(1);   % Fix the conductivity of the domain
            tlm.dom.eps(fem_mesh_t(4,i))=tlm.var.eps.Cytoplasme(1);   % Fix the permittivity of the domain
            i=size(fem_mesh_t,2);                                   % Goto the end of the loop
        end
        i=i+1;
    end
    
    %Cytoplasm of the second cell
    
    XX = tlm.var.OrigineX+tlm.var.DecentrageXCellule(2);
    YY = tlm.var.OrigineY+tlm.var.DecentrageZCellule(2);

    tlm.ind.pt.Cytoplasme2=find(abs(fem_mesh_p(1,:)-XX)<1e-10 & abs(fem_mesh_p(2,:)-YY)<1e-10);

    i=1;
    
    while i<=size(fem_mesh_t,1)     %Loop on the total number of elements (here it is triangle)
        if (fem_mesh_t(1,i)==tlm.ind.pt.Cytoplasme2) || (fem_mesh_t(2,i)==tlm.ind.pt.Cytoplasme2) || ...
           (fem_mesh_t(3,i)==tlm.ind.pt.Cytoplasme2)
            tlm.ind.dom.Cytoplasme(2)=fem_mesh_t(4,i);                 % Flag the number of the domain
            tlm.dom.sig(fem_mesh_t(4,i))=tlm.var.sig.Cytoplasme(2);   % Fix the conductivity of the domain
            tlm.dom.eps(fem_mesh_t(4,i))=tlm.var.eps.Cytoplasme(2);   % Fix the permittivity of the domain
            i=size(fem_mesh_t,2);                                   % Goto the end of the loop
        end
        i=i+1;
    end
    
    if tlm.conf.Nucleus==1
        
        %Nucleus of the first cell

        XX = tlm.var.OrigineX+tlm.var.DecentrageXCellule(1)+tlm.var.DecentrageXNoyau(1);
        YY = tlm.var.OrigineY+tlm.var.DecentrageZCellule(1)+tlm.var.DecentrageZNoyau(1);

        tlm.ind.pt.Nucleus1=find(abs(fem_mesh_p(1,:)-XX)<1e-10 & abs(fem_mesh_p(2,:)-YY)<1e-10);

        i=1;
    
        while i<=size(fem_mesh_t,1)     %Loop on the total number of elements (here it is triangle)
            if (fem_mesh_t(1,i)==tlm.ind.pt.Nucleus1) || (fem_mesh_t(2,i)==tlm.ind.pt.Nucleus1) || (fem_mesh_t(3,i)==tlm.ind.pt.Nucleus1)
                tlm.ind.dom.Nucleus1=fem_mesh_t(4,i);                    % Flag the number of the domain
                tlm.dom.sig(fem_mesh_t(4,i))=tlm.var.sig.Nucleus(1);      % Fix the conductivity of the domain
                tlm.dom.eps(fem_mesh_t(4,i))=tlm.var.eps.Nucleus(1);      % Fix the permittivity of the domain
                i=size(fem_mesh_t,2);                                    % Goto the end of the loop
            end
            i=i+1;
        end
        
        %Nucleus of the second cell

        XX = tlm.var.OrigineX+tlm.var.DecentrageXCellule(2)+tlm.var.DecentrageXNoyau(2);
        YY = tlm.var.OrigineY+tlm.var.DecentrageZCellule(2)+tlm.var.DecentrageZNoyau(2);

        tlm.ind.pt.Nucleus2=find(abs(fem_mesh_p(1,:)-XX)<1e-10 & abs(fem_mesh_p(2,:)-YY)<1e-10);

        i=1;
    
        while i<=size(fem_mesh_t,1)     %Loop on the total number of elements (here it is triangle)
            if (fem_mesh_t(1,i)==tlm.ind.pt.Nucleus2) || (fem_mesh_t(2,i)==tlm.ind.pt.Nucleus2) || (fem_mesh_t(3,i)==tlm.ind.pt.Nucleus2)
                tlm.ind.dom.Nucleus(2)=fem_mesh_t(4,i);                    % Flag the number of the domain
                tlm.dom.sig(fem_mesh_t(4,i))=tlm.var.sig.Nucleus(2);      % Fix the conductivity of the domain
                tlm.dom.eps(fem_mesh_t(4,i))=tlm.var.eps.Nucleus(2);      % Fix the permittivity of the domain
                i=size(fem_mesh_t,2);                                    % Goto the end of the loop
            end
            i=i+1;
        end
    else
        tlm.ind.dom.Nucleus(1)=-1;
        tlm.ind.dom.Nucleus(2)=-1;
    end
    
    if tlm.conf.Mitocho==1
        
        %Mitochondria of the first cell

        XX = tlm.var.OrigineX+tlm.var.DecentrageXCellule(1)+tlm.var.DecentrageXMitoc(1);
        YY = tlm.var.OrigineY+tlm.var.DecentrageZCellule(1)+tlm.var.DecentrageZMitoc(1);

        tlm.ind.pt.Mitocho1=find(abs(fem_mesh_p(1,:)-XX)<1e-10 & abs(fem_mesh_p(2,:)-YY)<1e-10);

        i=1;
    
        while i<=size(fem_mesh_t,1)     %Loop on the total number of elements (here it is triangle)
            if (fem_mesh_t(1,i)==tlm.ind.pt.Mitocho1) || (fem_mesh_t(2,i)==tlm.ind.pt.Mitocho1) || (fem_mesh_t(3,i)==tlm.ind.pt.Mitocho1)
                tlm.ind.dom.Mitocho(1)=fem_mesh_t(4,i);                    % Flag the number of the domain
                tlm.dom.sig(fem_mesh_t(4,i))=tlm.var.sig.Mitocho(1);      % Fix the conductivity of the domain
                tlm.dom.eps(fem_mesh_t(4,i))=tlm.var.eps.Mitocho(1);      % Fix the permittivity of the domain
                i=size(fem_mesh_t,2);                                    % Goto the end of the loop
            end
            i=i+1;
        end
        
        %Mitochondria of the second cell

        XX = tlm.var.OrigineX+tlm.var.DecentrageXCellule(2)+tlm.var.DecentrageXMitoc(2);
        YY = tlm.var.OrigineY+tlm.var.DecentrageZCellule(2)+tlm.var.DecentrageZMitoc(2);

        tlm.ind.pt.Mitocho2=find(abs(fem_mesh_p(1,:)-XX)<1e-10 & abs(fem_mesh_p(2,:)-YY)<1e-10);

        i=1;
    
        while i<=size(fem_mesh_t,1)     %Loop on the total number of elements (here it is triangle)
            if (fem_mesh_t(1,i)==tlm.ind.pt.Mitocho2) || (fem_mesh_t(2,i)==tlm.ind.pt.Mitocho2) || (fem_mesh_t(3,i)==tlm.ind.pt.Mitocho2)
                tlm.ind.dom.Mitocho(2)=fem_mesh_t(4,i);                    % Flag the number of the domain
                tlm.dom.sig(fem_mesh_t(4,i))=tlm.var.sig.Mitocho(2);      % Fix the conductivity of the domain
                tlm.dom.eps(fem_mesh_t(4,i))=tlm.var.eps.Mitocho(2);      % Fix the permittivity of the domain
                i=size(fem_mesh_t,2);                                    % Goto the end of the loop
            end
            i=i+1;
        end
    else
        tlm.ind.dom.Mitocho(1)=-1;
        tlm.ind.dom.Mitocho(2)=-1;
    end    
elseif (tlm.conf.Cell==0)
    tlm.ind.dom.Cytoplasme(1)=-1;
    tlm.ind.dom.Nucleus(1)=-1;
    tlm.ind.dom.Mitocho(1)=-1;
    tlm.ind.dom.Cytoplasme(2)=-1;
    tlm.ind.dom.Nucleus(2)=-1;
    tlm.ind.dom.Mitocho(2)=-1;
end

if tlm.conf.Milo==1
    
    % Organic External Medium n. 1

    XX = tlm.var.OrigineX-tlm.var.Center;
    if (tlm.conf.Cell==1 || tlm.conf.Cell==2)
        if tlm.conf.points~=1
            YY = tlm.var.OrigineY+tlm.var.EpaisseurChambre-tlm.var.Epsilon;
        else
            YY = tlm.var.OrigineY+tlm.var.DecentrageZCellule(1)+tlm.var.RayonZCellule(1)+tlm.var.Epsilon;
        end
        
    else
        YY = tlm.var.OrigineY+tlm.var.EpaisseurChambre/2;
    end
    
    tlm.ind.pt.MilOrga=find(abs(fem_mesh_p(1,:)-XX)<1e-10 & abs(fem_mesh_p(2,:)-YY)<1e-10);

    i=1;

    while i<=size(fem_mesh_t,1)         %Loop on the total number of elements (here it is triangle)
        if (fem_mesh_e(1,i)+1==tlm.ind.pt.MilOrga) || (fem_mesh_e(2,i)+1==tlm.ind.pt.MilOrga) || (fem_mesh_e(3,i)+1==tlm.ind.pt.MilOrga)
            tlm.ind.dom.MilOrga=fem_mesh_t(i,1);                % Flag the number of the domain
            tlm.ind.dom.MilOrgb=-1;                             % Flag the number of the domain
            tlm.dom.sig(fem_mesh_t(i,1))=tlm.var.sig.MilOrga;  % Fix the conductivity of the domain
            tlm.dom.eps(fem_mesh_t(i,1))=tlm.var.eps.MilOrga;  % Fix the permittivity of the domain
            i=size(fem_mesh_t,1);                               % Goto the end of the loop
        end
        i=i+1;
    end
    
end

if tlm.conf.Milo==2
    
        % Organic External Medium n. 1

    XX = tlm.var.OrigineX-tlm.var.Center;
    if (tlm.conf.Cell==1 || tlm.conf.Cell==2)
        if tlm.conf.points~=1
            YY = tlm.var.OrigineY+tlm.var.EpaisseurChambre-tlm.var.Epsilon;
        else
            YY = tlm.var.OrigineY+tlm.var.DecentrageZCellule(1)+tlm.var.RayonZCellule(1)+tlm.var.Epsilon;
        end
    else
        YY = tlm.var.OrigineY+tlm.var.EpaisseurChambre/2;
    end
    
    tlm.ind.pt.MilOrga=find(abs(fem_mesh_p(1,:)-XX)<1e-10 & abs(fem_mesh_p(2,:)-YY)<1e-10);

    i=1;

    while i<=size(fem_mesh_t,2)         %Loop on the total number of elements (here it is triangle)
        if (fem_mesh_t(1,i)==tlm.ind.pt.MilOrga) || (fem_mesh_t(2,i)==tlm.ind.pt.MilOrga) || (fem_mesh_t(3,i)==tlm.ind.pt.MilOrga)
            tlm.ind.dom.MilOrga=fem_mesh_t(4,i);                % Flag the number of the domain
            tlm.dom.sig(fem_mesh_t(4,i))=tlm.var.sig.MilOrga;  % Fix the conductivity of the domain
            tlm.dom.eps(fem_mesh_t(4,i))=tlm.var.eps.MilOrga;  % Fix the permittivity of the domain
            i=size(fem_mesh_t,2);                               % Goto the end of the loop
        end
        i=i+1;
    end

    % Organic External Medium n. 2

    XX = tlm.var.OrigineX+tlm.var.Center;
    if (tlm.conf.Cell==1 || tlm.conf.Cell==2)
        if tlm.conf.points~=1
            YY = tlm.var.OrigineY+tlm.var.EpaisseurChambre-tlm.var.Epsilon;
        else
            YY = tlm.var.OrigineY+tlm.var.DecentrageZCellule(2)+tlm.var.RayonZCellule(2)+tlm.var.Epsilon;
        end
    else
        YY = tlm.var.OrigineY+tlm.var.EpaisseurChambre/2;
    end

    tlm.ind.pt.MilOrgb=find(abs(fem_mesh_p(1,:)-XX)<1e-10 & abs(fem_mesh_p(2,:)-YY)<1e-10);

    i=1;

    while i<=size(fem_mesh_t,2)         %Loop on the total number of elements (here it is triangle)
        if (fem_mesh_t(1,i)==tlm.ind.pt.MilOrgb) || (fem_mesh_t(2,i)==tlm.ind.pt.MilOrgb) || (fem_mesh_t(3,i)==tlm.ind.pt.MilOrgb)
            tlm.ind.dom.MilOrgb=fem_mesh_t(4,i);                % Flag the number of the domain
            tlm.dom.sig(fem_mesh_t(4,i))=tlm.var.sig.MilOrgb;  % Fix the conductivity of the domain
            tlm.dom.eps(fem_mesh_t(4,i))=tlm.var.eps.MilOrgb;  % Fix the permittivity of the domain
            i=size(fem_mesh_t,2);                               % Goto the end of the loop
        end
        i=i+1;
    end
    
end