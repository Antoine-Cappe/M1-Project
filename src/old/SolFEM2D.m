%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                              BIOCAD Program
%                               Release 3.1
%
%   Authors: Vincent Senez, Benoit Poussard, 
%            Thomas Delmas, Hugo Bertacchini
%   
%   Release 1.0 : July 2003
%   Release 1.1 : December 2004
%   Release 1.2 : July 2005
%   Release 2.0 : December 2005
%   Release 2.1 : July 2006
%   Release 3.0 : December 2006
%   Release 3.1 : December 2007
%
%   Function : Solve the 2D system by FEM Method
%
%   Called by: Compute.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [tlm,model]=SolFEM2D(tlm,model)

% Initialization

global fem_mesh_p;
global fem_mesh_t;
global fem_mesh_e;

tlm.conf.Name0=tlm.conf.Name;

% Set all parameters for COMSOL MULTIPHYSICS simulation

%clear appl

%appl.mode.class = 'QuasiStatics';
%appl.name = 'emqvw';
%appl.module = 'ACDC';
%appl.shape = {'shlag(2,''lm1'')','shlag(2,''V'')'};
%appl.gporder = {30,4};
%appl.assignsuffix = '_emqvw';

%clear prop

%prop.elemdefault='Lag2';
%prop.analysis='smallcurr';

%clear weakconstr
%weakconstr.value = 'non-ideal';
%weakconstr.dim = {'lm1','tlmx','tlmy','lm2'};
%prop.weakconstr = weakconstr;

%appl.prop = prop;

%clear bnd

%bnd.V0 = {tlm.var.v0,0,0,0};
%bnd.eltype = {'V','nJ0','cont','V0'};
%bnd.wcshape = 1;
%bnd.magtype = {'A0','A0','cont','A0'};

% Define boundary conditions according to the system
if tlm.conf.Cell==111
if tlm.conf.Cell==0 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
    % case without cell
    if tlm.conf.Milo==1
        % case without cell one medium
        if tlm.conf.points==1 % facing electrodes
            if abs(tlm.var.LargeurChambre-tlm.var.LargeurElectrode)<1e-10
                % 10 faces
                bnd.ind = [2,4,2,3,2,3,1,2,2,2];
            else
                % 14 faces 
                bnd.ind = [2,2,2,3,1,3,3,3,4,3,2,3,2,2];
            end
        elseif tlm.conf.points==2 % coplanar
            if abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)>1e-10
                % 20 faces if outer electrode position inside width of the
                % chamber
                bnd.ind = [2,2,2,3,1,3,3,2,3,4,3,3,2,2];
            elseif abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)<1e-10
                if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                    % 10 faces if outer electrodes at the edge of the
                    % chamber and thickness of electrode equal to thickness
                    % of chamber
                    bnd.ind = [1,2,2,3,2,2,3,2,2,4];
                else
                    % 12 faces if outer electrodes at the edge of the chamber
                    bnd.ind = [2,1,2,3,2,3,2,3,4,3,2,2];
                end
            end
        elseif tlm.conf.points==4 % 4 electrodes
            if (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)>1e-10 && ...
                abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)>1e-10)
                % 24 faces if outer electrode not at the edge of the
                % chamber
                bnd.ind = [2,2,2,3,1,3,3,2,3,2,3,3,2,3,2,3,3,2,3,4,3,3,2,2];
            elseif (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)>1e-10 && ...
                abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)<1e-10)
                % 22 faces if outer electrode at the edge of the chamber
                bnd.ind = [2,1,2,3,2,3,2,3,2,3,3,2,3,2,3,3,2,3,4,3,2,2];
            elseif (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10 && ...
                abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)<1e-10)
                % 20 faces if outer electrode at the edge of the chamber
                % and their thickness equal the thickness of the chamber
                bnd.ind = [1,2,2,3,2,2,3,2,3,3,2,3,2,3,3,2,3,2,2,4];
            end
        end
    elseif tlm.conf.Milo==2
        % case without cell two mediums
        if tlm.conf.points==1 % This case is not possible (triple points)
        elseif tlm.conf.points==2 % coplanar
            if abs(2*tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)>1e-10
                % 20 faces if outer electrode position inside width of the
                % chamber
                bnd.ind = [2,2,2,3,1,3,3,2,3,4,3,3,2,2];
            elseif abs(2*tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)<1e-10
                if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                    % 13 faces if outer electrodes at the edge of the
                    % chamber and thickness of electrode equal to thickness
                    % of chamber
                    bnd.ind = [1,2,2,3,2,2,3,2,2,3,2,2,4];
                else
                    % 12 faces if outer electrodes at the edge of the chamber
                    bnd.ind = [2,1,2,3,2,3,2,3,4,3,2,2];
                end
            end
        elseif tlm.conf.points==4 % 4 electrodes
            if (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)>1e-10 && ...
                abs(2*tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)>1e-10)
                % 24 faces if outer electrode not at the edge of the
                % chamber
                bnd.ind = [2,2,2,3,1,3,3,2,3,2,3,3,2,3,2,3,3,2,3,4,3,3,2,2];
            elseif (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)>1e-10 && ...
                abs(2*tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)<1e-10)
                % 22 faces if outer electrode at the edge of the chamber
                bnd.ind = [2,1,2,3,2,3,2,3,2,3,3,2,3,2,3,3,2,3,4,3,2,2];
            elseif (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10 && ...
                abs(2*tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)<1e-10)
                % 23 faces if outer electrode at the edge of the chamber
                % and their thickness equal the thickness of the chamber
                bnd.ind = [1,2,2,3,2,2,3,2,3,3,2,3,2,2,3,2,3,3,2,3,2,2,4];
            end
        end

    end
elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0 
    % case with one cell (without membrane)
    if tlm.conf.points==1 % facing electrodes
        % 18 faces (if spheroid cell)
        bnd.ind = [2,2,2,3,1,3,3,3,4,3,2,3,2,2];
        for inbs=1:1:tlm.var.NbSurfaceCell(1)
            bnd.ind = [ bnd.ind, 3];
        end
    elseif tlm.conf.points==2 % coplanar
        if (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)>1e-10 && ...
            abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)>1e-10)
            % 20 faces if outer electrode position inside width of the
            % chamber
            bnd.ind = [2,2,2,3,1,3,3,2,3,4,3,3,2,2];
            for inbs=1:1:tlm.var.NbSurfaceCell(1)
                bnd.ind = [ bnd.ind, 3];
            end
        elseif (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)>1e-10 && ...
                abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)<1e-10)
                % 12 faces if outer electrodes at the edge of the chamber
                bnd.ind = [2,1,2,3,2,3,2,3,4,3,2,2];
                for inbs=1:1:tlm.var.NbSurfaceCell(1)
                    bnd.ind = [ bnd.ind, 3];
                end
        elseif (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10 && ...
                abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)<1e-10)
                % 14 faces if outer electrodes at the edge of the chamber
                bnd.ind = [1,2,2,3,2,2,3,2,2,4];
                for inbs=1:1:tlm.var.NbSurfaceCell(1)
                    bnd.ind = [ bnd.ind, 3];
                end
        end
    elseif tlm.conf.points==4 % 4 electrodes
        if (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)>1e-10 && ...
            abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)>1e-10)
            % 24 faces if outer electrode not at the edge of the
            % chamber
            bnd.ind = [2,2,2,3,1,3,3,2,3,2,3,3,2,3,2,3,3,2,3,4,3,3,2,2];
            for inbs=1:1:tlm.var.NbSurfaceCell(1)
                bnd.ind = [ bnd.ind, 3];
            end
        elseif (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)>1e-10 && ...
                abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)<1e-10)
            % 22 faces if outer electrode at the edge of the chamber
            bnd.ind = [2,1,2,3,2,3,2,3,2,3,3,2,3,2,3,3,2,3,4,3,2,2];
            for inbs=1:1:tlm.var.NbSurfaceCell(1)
                bnd.ind = [ bnd.ind, 3];
            end
        elseif (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10 && ...
                abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)<1e-10)
            % 20 faces if outer electrode at the edge of the chamber
            % and their thickness equal the thickness of the chamber
            bnd.ind = [1,2,2,3,2,2,3,2,3,3,2,3,2,3,3,2,3,2,2,4];
            for inbs=1:1:tlm.var.NbSurfaceCell(1)
                bnd.ind = [ bnd.ind, 3];
            end
        end
    end
elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0 
    % case with two cells (without membrane)
    bnd.ind = [1,2,2,3,2,2,3,2,3,3,2,3,2,3,3,2,3,2,2,4];
    for inbs=1:1:tlm.var.NbSurfaceCell(1)
        bnd.ind = [ bnd.ind, 3];
    end
    for inbs=1:1:tlm.var.NbSurfaceCell(2)
        bnd.ind = [ bnd.ind, 3];
    end
elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0
    % case with one cell + nucleus (without membrane)
    if tlm.conf.points==1 % facing electrodes
        % 22 faces (if spheroid cell)
        bnd.ind = [2,2,2,3,1,3,3,3,4,3,2,3,2,2];
        for inbs=1:1:tlm.var.NbSurfaceCell(1)
            bnd.ind = [ bnd.ind, 3];
        end
        bnd.ind = [bnd.ind,3,3,3,3];
    elseif tlm.conf.points==2 % coplanar
        if (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)>1e-10 && ...
            abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)>1e-10)
            % 20 faces if outer electrode position inside width of the
            % chamber
            bnd.ind = [2,2,2,3,1,3,3,2,3,4,3,3,2,2];
            for inbs=1:1:tlm.var.NbSurfaceCell(1)
                bnd.ind = [ bnd.ind, 3];
            end
            bnd.ind = [bnd.ind,3,3,3,3];
        elseif (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)>1e-10 && ...
                abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)<1e-10)
                % 12 faces if outer electrodes at the edge of the chamber
                bnd.ind = [2,1,2,3,2,3,2,3,4,3,2,2];
                for inbs=1:1:tlm.var.NbSurfaceCell(1)
                    bnd.ind = [ bnd.ind, 3];
                end
                bnd.ind = [bnd.ind,3,3,3,3];                
        elseif (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10 && ...
                abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)<1e-10)
                % 14 faces if outer electrodes at the edge of the chamber
                bnd.ind = [1,2,2,3,2,2,3,2,2,4];
                for inbs=1:1:tlm.var.NbSurfaceCell(1)
                    bnd.ind = [ bnd.ind, 3];
                end
                bnd.ind = [bnd.ind,3,3,3,3];                
        end        
    elseif tlm.conf.points==4 % 4 electrodes
        if (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)>1e-10 && ...
            abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)>1e-10)
            % 24 faces if outer electrode not at the edge of the
            % chamber
            bnd.ind = [2,2,2,3,1,3,3,2,3,2,3,3,2,3,2,3,3,2,3,4,3,3,2,2];
            for inbs=1:1:tlm.var.NbSurfaceCell(1)
                bnd.ind = [ bnd.ind, 3];
            end
            bnd.ind = [bnd.ind,3,3,3,3];
        elseif (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)>1e-10 && ...
                abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)<1e-10)
            % 22 faces if outer electrode at the edge of the chamber
            bnd.ind = [2,1,2,3,2,3,2,3,2,3,3,2,3,2,3,3,2,3,4,3,2,2];
            for inbs=1:1:tlm.var.NbSurfaceCell(1)
                bnd.ind = [ bnd.ind, 3];
            end
            bnd.ind = [bnd.ind,3,3,3,3];
        elseif (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10 && ...
                abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)<1e-10)
            % 20 faces if outer electrode at the edge of the chamber
            % and their thickness equal the thickness of the chamber
            bnd.ind = [1,2,2,3,2,2,3,2,3,3,2,3,2,3,3,2,3,2,2,4];
            for inbs=1:1:tlm.var.NbSurfaceCell(1)
                bnd.ind = [ bnd.ind, 3];
            end
            bnd.ind = [bnd.ind,3,3,3,3];
        end
    end
elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0
    % case with one cell + nucleus (without membrane)
    bnd.ind = [1,2,2,3,2,2,3,2,3,3,2,3,2,3,3,2,3,2,2,4];
    for inbs=1:1:tlm.var.NbSurfaceCell(1)
        bnd.ind = [ bnd.ind, 3];
    end
    for inbs=1:1:tlm.var.NbSurfaceCell(2)
        bnd.ind = [ bnd.ind, 3];
    end
    bnd.ind = [bnd.ind,3,3,3,3,3,3,3,3];
elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1
    % case with one cell + nucleus + mitochondria (without membrane)
    if tlm.conf.points==1 % facing electrodes
        % 22 faces (if spheroid cell)
        bnd.ind = [2,2,2,3,1,3,3,3,4,3,2,3,2,2];
        for inbs=1:1:tlm.var.NbSurfaceCell(1)
            bnd.ind = [ bnd.ind, 3];
        end
        bnd.ind = [bnd.ind,3,3,3,3,3,3,3,3];
    elseif tlm.conf.points==2 % coplanar
        if (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)>1e-10 && ...
            abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)>1e-10)
            % 20 faces if outer electrode position inside width of the
            % chamber
            bnd.ind = [2,2,2,3,1,3,3,2,3,4,3,3,2,2];
            for inbs=1:1:tlm.var.NbSurfaceCell(1)
                bnd.ind = [ bnd.ind, 3];
            end
            bnd.ind = [bnd.ind,3,3,3,3,3,3,3,3];
        elseif (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)>1e-10 && ...
                abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)<1e-10)
                % 12 faces if outer electrodes at the edge of the chamber
                bnd.ind = [2,1,2,3,2,3,2,3,4,3,2,2];
                for inbs=1:1:tlm.var.NbSurfaceCell(1)
                    bnd.ind = [ bnd.ind, 3];
                end
                bnd.ind = [bnd.ind,3,3,3,3,3,3,3,3];                
        elseif (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10 && ...
                abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)<1e-10)
                % 14 faces if outer electrodes at the edge of the chamber
                bnd.ind = [1,2,2,3,2,2,3,2,2,4];
                for inbs=1:1:tlm.var.NbSurfaceCell(1)
                    bnd.ind = [ bnd.ind, 3];
                end
                bnd.ind = [bnd.ind,3,3,3,3,3,3,3,3];                
        end
    elseif tlm.conf.points==4 % 4 electrodes
        if (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)>1e-10 && ...
            abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)>1e-10)
            % 24 faces if outer electrode not at the edge of the
            % chamber
            bnd.ind = [2,2,2,3,1,3,3,2,3,2,3,3,2,3,2,3,3,2,3,4,3,3,2,2];
            for inbs=1:1:tlm.var.NbSurfaceCell(1)
                bnd.ind = [ bnd.ind, 3];
            end
            bnd.ind = [bnd.ind,3,3,3,3,3,3,3,3];
        elseif (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)>1e-10 && ...
                abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)<1e-10)
            % 22 faces if outer electrode at the edge of the chamber
            bnd.ind = [2,1,2,3,2,3,2,3,2,3,3,2,3,2,3,3,2,3,4,3,2,2];
            for inbs=1:1:tlm.var.NbSurfaceCell(1)
                bnd.ind = [ bnd.ind, 3];
            end
            bnd.ind = [bnd.ind,3,3,3,3,3,3,3,3];
        elseif (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10 && ...
                abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)<1e-10)
            % 20 faces if outer electrode at the edge of the chamber
            % and their thickness equal the thickness of the chamber
            bnd.ind = [1,2,2,3,2,2,3,2,3,3,2,3,2,3,3,2,3,2,2,4];
            for inbs=1:1:tlm.var.NbSurfaceCell(1)
                bnd.ind = [ bnd.ind, 3];
            end
            bnd.ind = [bnd.ind,3,3,3,3,3,3,3,3];
        end
    end
elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1
    % case with one cell + nucleus + mitochondria (without membrane)
    bnd.ind = [1,2,2,3,2,2,3,2,3,3,2,3,2,3,3,2,3,2,2,4];
    for inbs=1:1:tlm.var.NbSurfaceCell(1)
        bnd.ind = [ bnd.ind, 3];
    end
    for inbs=1:1:tlm.var.NbSurfaceCell(2)
        bnd.ind = [ bnd.ind, 3];
    end
    bnd.ind = [bnd.ind,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3];
end
end
%appl.bnd = bnd;

%clear equ
if tlm.conf.Cell==111
if tlm.conf.Cell==0 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
    % case without cell
    if tlm.conf.Milo==1
        equ.epsilonr = {'eps_Electrode','eps_Milorga'};
        equ.sigma = {'sig_Electrode','sig_Milorga'};
    elseif tlm.conf.Milo==2
        equ.epsilonr = {'eps_Electrode','eps_Milorga','eps_Milorgb'};
        equ.sigma = {'sig_Electrode','sig_Milorga','sig_Milorgb'};
    end
elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
    % case with one cell (without membrane)
    equ.epsilonr = {'eps_Electrode','eps_Milorga','eps_Cytoplasme1'};
    equ.sigma = {'sig_Electrode','sig_Milorga','sig_Cytoplasme1'};
elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
    % case with one cell (without membrane)
    equ.epsilonr = {'eps_Electrode','eps_Milorga','eps_Cytoplasme1','eps_Cytoplasme2'};
    equ.sigma = {'sig_Electrode','sig_Milorga','sig_Cytoplasme1','sig_Cytoplasme2'};
elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0
    % case with one cell + nucleus (without membrane)
    equ.epsilonr = {'eps_Electrode','eps_Milorga','eps_Cytoplasme1','eps_Nucleus1'};
    equ.sigma = {'sig_Electrode','sig_Milorga','sig_Cytoplasme1','sig_Nucleus1'};
elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0
    % case with one cell + nucleus (without membrane)
    equ.epsilonr = {'eps_Electrode','eps_Milorga','eps_Cytoplasme1','eps_Cytoplasme2','eps_Nucleus1','eps_Nucleus2'};
    equ.sigma = {'sig_Electrode','sig_Milorga','sig_Cytoplasme1','sig_Cytoplasme2','sig_Nucleus1','sig_Nucleus2'};
elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1
    % case with one cell + nucleus + mitochondria (without membrane)
    equ.epsilonr = {'eps_Electrode','eps_Milorga','eps_Cytoplasme1','eps_Nucleus1','eps_Mitocho1'};
    equ.sigma = {'sig_Electrode','sig_Milorga','sig_Cytoplasme1','sig_Nucleus1','sig_Mitocho1'};
elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1
    % case with one cell + nucleus + mitochondria (without membrane)
    equ.epsilonr = {'eps_Electrode','eps_Milorga','eps_Cytoplasme1','eps_Cytoplasme2','eps_Nucleus1','eps_Nucleus2','eps_Mitocho1','eps_Mitocho2'};
    equ.sigma = {'sig_Electrode','sig_Milorga','sig_Cytoplasme1','sig_Cytoplasme2','sig_Nucleus1','sig_Nucleus2','sig_Mitocho1','sig_Mitocho2'};
end

if tlm.conf.Cell==0 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
    % case without cell
    if tlm.conf.Milo==1
        if tlm.conf.points==1
            equ.ind = [1,2,1];
        elseif tlm.conf.points==2
            equ.ind = [2,1,1];
        elseif tlm.conf.points==4
            equ.ind = [2,1,1,1,1];
        end
    elseif tlm.conf.Milo==2
        if tlm.conf.points==1 % this case is not possible (triple point)
        elseif tlm.conf.points==2
            equ.ind = [1,2,3,1];
        elseif tlm.conf.points==4
            equ.ind = [1,2,1,3,1,1];
        end
    end
elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
    % case with one cell (without membrane)
    if tlm.conf.points==1
        equ.ind = [2,1,1,3];
    elseif tlm.conf.points==2
        equ.ind = [2,1,1,3];
    elseif tlm.conf.points==4
        equ.ind = [2,1,1,1,1,3];
    end
elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
    % case with one cell (without membrane)
    equ.ind = [1,2,1,1,1,3,4];
elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0
    % case with one cell + nucleus (without membrane)
    if tlm.conf.points==1
        equ.ind = [2,1,1,3,4];
    elseif tlm.conf.points==2
        equ.ind = [2,1,1,3,4];
    elseif tlm.conf.points==4
        equ.ind = [2,1,1,1,1,3,4];
    end
elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0
    % case with one cell + nucleus (without membrane)
    equ.ind = [1,2,1,1,1,3,5,4,6];
elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1
    % case with one cell + nucleus + mitochondria (without membrane)
    if tlm.conf.points==1
        equ.ind = [2,1,1,3,4,5];
    elseif tlm.conf.points==2
        equ.ind = [2,1,1,3,4,5];
    elseif tlm.conf.points==4
        equ.ind = [2,1,1,1,1,3,4,5];
    end
elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1
    % case with one cell + nucleus + mitochondria (without membrane)
    equ.ind = [1,2,1,1,1,3,7,5,4,8,6];
end
end
%equ.shape = 2;
%equ.gporder = 2;

%appl.equ = equ;

%fem.shape = {'shlag(2,''V'')' 'shlag(2,''lm1'')'};
%fem.border = 1;
%fem.units.basesystem='SI';
%fem.frame = {'ref'};

if tlm.conf.Cell==0 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
% case without cell
    if tlm.conf.Milo==1
        if tlm.conf.points==1
            tlm.dom.list = [1,2,3];
        elseif tlm.conf.points==2
            tlm.dom.list = [1,2,3];
        elseif tlm.conf.points==4
            tlm.dom.list = [1,2,3,4,5];
        end
    elseif tlm.conf.Milo==2
        if tlm.conf.points==1 % This case is not possible (triple points)
        elseif tlm.conf.points==2
            tlm.dom.list = [1,2,3,4];
        elseif tlm.conf.points==4
            tlm.dom.list = [1,2,3,4,5,6];
        end
    end
elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
    % case with one cell (without membrane)
    if tlm.conf.points==1
        tlm.dom.list = [1,2,3,4];
    elseif tlm.conf.points==2
        tlm.dom.list = [1,2,3,4];
    elseif tlm.conf.points==4
        tlm.dom.list = [1,2,3,4,5,6];
    end
elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
    % case with one cell (without membrane)
    tlm.dom.list = [1,2,3,4,5,6,7];
elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0
% case with one cell + nucleus (without membrane)
    if tlm.conf.points==1
        tlm.dom.list = [1,2,3,4,5];
    elseif tlm.conf.points==2
        tlm.dom.list = [1,2,3,4,5];
    elseif tlm.conf.points==4
        tlm.dom.list = [1,2,3,4,5,6,7];
    end
elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0
% case with one cell + nucleus (without membrane)
    tlm.dom.list = [1,2,3,4,5,6,7,8,9];
elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1
% case with one cell + nucleus + mitochondria (without membrane)
    if tlm.conf.points==1
        tlm.dom.list = [1,2,3,4,5,6];
    elseif tlm.conf.points==2
        tlm.dom.list = [1,2,3,4,5,6];
    elseif tlm.conf.points==4
        tlm.dom.list = [1,2,3,4,5,6,7,8];
    end    
elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1
% case with one cell + nucleus + mitochondria (without membrane)
    tlm.dom.list = [1,2,3,4,5,6,7,8,9,10,11];
end

meshdset1 = model.result.dataset.create('mesh1', 'Mesh');
meshdset1.set('mesh', 'mesh1');
pg1 = model.result.create('pg1', 2);
meshplot1 = pg1.feature.create('mesh1', 'Mesh');
meshplot1.set('data', 'mesh1');
meshplot1.set('filteractive', 'on');
meshplot1.set('elemfilter', 'quality');
meshplot1.set('tetkeep', '0.25');
    figure(3);
    clf('reset');
    colormap(hot(256));

mphplot(model,'pg1');
meshplot1.set('elemfilter','qualityrev');
meshplot1.run;
    figure(4);
    clf('reset');
    colormap(hot(256));

mphplot(model,'pg1');

dat = mpheval(model,'s1','selection',1);
figure(4);
    clf('reset');
    colormap(hot(256));
    mphplot(dat,'index',1,'colortable','thermal');
dat.d2 = dat.d2*1e-3;
mphplot(dat, 'index', 2, 'rangenum', 2, 'mesh', 'off');
hold on;
mphgeom(model, 'geom1', 'facemode', 'off')

%appl.var = {'epsilon0','8.854187817e-12','mu0','4*pi*1e-7'};

%fem.appl{1} = appl;

% Multiphysics

model.physics.create('ec', 'ConductiveMedia', 'geom1'); % the physical equation to solve is defined

% Boundary conditions

model.physics('ec').create('gnd1', 'Ground', 1);        % boundary condition 1 is ground
model.physics('ec').feature('gnd1').selection.set([20]); % select boundary where to apply ground

%model.physics('ec').create('term1', 'Terminal', 2);     % boundary condition 2 is applied voltage
%model.physics('ec').feature('term1').selection.set([3]);% select boundary where to apply voltage
%model.physics('ec').feature('term1').set('TerminalType', 'Voltage');
%model.physics('ec').feature('term1').set('V0', 'tlm.var.v0 [mV]');
%model.physics('ec').feature('term1').set('I0', '10 [mA]');
%model.physics('ec').feature('term1').set('Vinit', '10[mV]');

model.physics('ec').create('ncd1', 'NormalCurrentDensity', 1);
model.physics('ec').feature('ncd1').selection.set([1]);
model.physics('ec').feature('ncd1').set('nJ', '1E-3');


% Analysis Type

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').attach('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'range(100,100,1000)'});
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'auto');
model.sol('sol1').runAll;


%fem=multiphysics(fem);

% Extend mesh

% fem.xmesh=meshextend(fem,'geoms',[1],'eqvars','on','cplbndeq','on','cplbndsh','off');
%fem.xmesh=meshextend(fem);
    
tlm.conf.plist=[];
    
for a=log10(tlm.var.frequence.min):1:log10(tlm.var.frequence.max)
    for b=1:1:tlm.var.frequence.step
        tlm.conf.plist=[tlm.conf.plist b*10^a];
    end
end
    
% Solve the problem using the parametric solver

%fem.sol=femstatic(fem, ...
%            'solcomp',{'V','lm1'}, ...
%            'outcomp',{'V','lm1'}, ...
%            'pname','nu_emqvw', ...
%            'plist',tlm.conf.plist, ...
%            'oldcomp',{});  
            
% Transfer the fem.sol.u vector into matlab arrays to save computing time

fem_sol_u(:,:)=model.sol.u(:,:);

% Start Postprocessing

cpt=1;
ii=0;
ex=round((log10(tlm.var.frequence.max)-log10(tlm.var.frequence.min))/2.);

if tlm.var.frequence.max==10
    ex=0;
end

for a=log10(tlm.var.frequence.min):1:log10(tlm.var.frequence.max)
    
    for b=1:1:tlm.var.frequence.step
            
        f=b*10^a;
        
        if (f==tlm.var.frequence.min || ...
            f==5*10^ex || ...
            f==tlm.var.frequence.max)
        
            tlm.conf.Name=[tlm.conf.Name0 '_' num2str(f) 'Hz']; 
            
%            if (tlm.conf.figure==1)
%                
%                figure(2+2*ii);
%                clf('reset');
%            
%                postplot(fem, ...
%                    'tridata',{'V','cont','internal'}, ...
%                    'triz','V', ...
%                    'triedgestyle','none', ...
%                    'trifacestyle','flat', ...
%                    'trimap','hot(1024)', ...
%                    'arrowdata',{'Jx_emqvw','Jy_emqvw'}, ...
%                    'arrowxspacing',15, ...
%                    'arrowyspacing',15, ...
%                    'arrowtype','arrow', ...
%                    'arrowstyle','proportional', ...
%                    'arrowcolor',[1.0,0.0,0.0], ...
%                    'title',['Surface: Electrical Potential (V)   Arrows: Total Current Density (A/m2)   Frequency: ',num2str(f,'%0.2g'),' Hertz'], ...
%                    'refine',3, ...
%                    'geom','on', ...
%                    'geomnum',1, ...
%                    'solnum',cpt,...
%                    'sdl',{tlm.dom.list}, ...
%                    'axisvisible','on', ...
%                    'axisequal','off', ...
%                    'grid','off');
%                    'axis',[-tlm.var.LargeurChambre/2,tlm.var.LargeurChambre/2,0,tlm.var.EpaisseurChambre,-1,1]);
%            
%                if tlm.conf.save==1
%                    name=[tlm.conf.Name '.emf'];
%                    saveas((2+ii),name);
%                end
%                
%            end
            
            % Save corresponding solution for comparison of the map of V with analytical and Spice calculation
 
            x  = asseminit(fem,'init','x','out','u');
            y = asseminit(fem,'init','y','out','u');

            % Define the table linking the coordinates arrays to the solution array
            % The value of the variable i at node k is stored in
            % fem.sol.u at index table(i,k) fem.sol.u(table(i,k))
            % where k is the location of the node in p.x and p.y

            clear table;
            table=zeros(1,size(fem_mesh_p,2));
            
            for k=1:size(fem_mesh_p,2)
                pos=((x==fem_mesh_p(1,k))&(y==fem_mesh_p(2,k)));
                table(1,k)=find(pos,1);
%               table(2,k)=find(pos&&(ind==2)); this is for 2 ddl
            end
    
            for i=1:1:size(fem_mesh_p,2) %Loop on the total number of physical nodes
                tlm.var.X(i,1)=fem_mesh_p(1,i);
                tlm.var.Y(i,1)=fem_mesh_p(2,i);
                tlm.sol.num(i,1)=real(fem_sol_u(table(1,i),cpt));
            end
            
            if tlm.conf.figure==1
                
                % Define a regular grid

               % xlin1=linspace(-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode,tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode,100);
                xlin1=linspace(-tlm.var.LargeurChambre/2,tlm.var.LargeurChambre/2,100);
                ylin1=linspace(tlm.var.DecentrageZCellule(1)-tlm.var.EpaisseurChambre/2,tlm.var.DecentrageZCellule(1)+tlm.var.EpaisseurChambre/2,100);

                [X1,Y1]= meshgrid(xlin1,ylin1);

                % Interpolate tlm.sol.num(:,1) (FEM data) on the regular (X1,Y1) grid

                Res1=griddata(tlm.var.X(:,1),tlm.var.Y(:,1),tlm.sol.num(:,1),X1,Y1,'cubic');

                % Plot the result

                figure(2+ii);
                clf('reset');
                tlm.conf.fig=tlm.conf.fig+1;
     
                colormap(hot(256));
    
                %with griddata
                surf(X1,Y1,Res1);
%               %with gridfit
%               surf(xlin3,ylin3,Res3);
    
                camlight right;
                lighting phong;
                shading interp

                az=40;
                el=30;
                view(az,el);
 
%               mesh(X1,Y1,Res1);
%               meshc(X1,Y1,Res1);
     
                axis tight; 
                title(['2D Map of the Electric Potential (Volt) at F=',num2str(f,'%0.2g'),' Hertz calculated by FEM']);
                zlabel('Electric Potential   (Volts)');
                ylabel('Y coordinate   (microns)');
                xlabel('X coordinate   (microns)');
                
            end
            
            % Save the results of the simulation in a file xx.fem_cou

            name1=sprintf('%s.fem_cou',tlm.conf.Name);        % Name of the file for the Net List
            fid=fopen(name1, 'w');                     % Open the File

            fprintf(fid, '%s.fem_cou\n',tlm.conf.Name);       % Write the first line of the file which is use as a title of the graphical output
            fprintf(fid, '********************************************************************************\n');            
            fprintf(fid, '*\n');            
            fprintf(fid, '*             2D Map of Electric Potential Calculated by FEM \n'); 
            fprintf(fid, '*                THE FREQUENCY FOR THIS RESULT IS %e HERTZ \n',f); 
            fprintf(fid, '*\n');            
            fprintf(fid, '*                              BIOCAD Program\n');            
            fprintf(fid, '*                               Release 3.1\n');            
            fprintf(fid, '*\n');            
            fprintf(fid, '*   Authors: Vincent Senez, Benoit Poussard, Thomas Delmas, Hugo Bertacchini\n'); 
            fprintf(fid, '*\n');            
            fprintf(fid, '*   Release 1.0 : July 2003\n');     
            fprintf(fid, '*   Release 1.1 : December 2004\n');     
            fprintf(fid, '*   Release 1.2 : July 2005\n');     
            fprintf(fid, '*   Release 2.0 : December 2005\n');     
            fprintf(fid, '*   Release 2.1 : July 2006\n');     
            fprintf(fid, '*   Release 3.0 : December 2006\n');
            fprintf(fid, '*   Release 3.1 : December 2007\n');
            fprintf(fid, '*\n');            
            fprintf(fid, '********************************************************************************\n');

            for i=1:1:size(fem_mesh_p,2)
                fprintf(fid, '%1.10g %1.10g %1.10g\n',tlm.var.X(i,1), tlm.var.Y(i,1), tlm.sol.num(i,1));  
            end
    
            fclose(fid);
            
            ii=ii+1;
            
        end
        
        % Integrate the current density on the electrode (ground)
        
%        I1=postint(fem,'nJ_emqvw', ...
%                       'dl',1, ...
%                       'edim',1, ...
%                       'intorder',4, ...
%                       'geomnum',1, ...
%                       'solnum',cpt, ...
%                       'phase',(0)*pi/180);
                   
        % Calculate the corresponding Impedance
    
        if tlm.conf.points==1               % for 2 points measurement
                
            if abs(tlm.var.LargeurChambre-tlm.var.LargeurElectrode)<1e-10
                I1=postint(fem,'lm1', ...
                       'dl',7, ...
                       'edim',1, ...
                       'intorder',4, ...
                       'geomnum',1, ...
                       'solnum',cpt, ...
                       'phase',(0)*pi/180);
            else
                I1=postint(fem,'lm1', ...
                       'dl',5, ...
                       'edim',1, ...
                       'intorder',4, ...
                       'geomnum',1, ...
                       'solnum',cpt, ...
                       'phase',(0)*pi/180);
            end
            
            pos1=((x==tlm.var.OrigineX)&(y==(tlm.var.OrigineY+tlm.var.EpaisseurChambre-tlm.var.EpaisseurMesure/2)));
            pos2=((x==tlm.var.OrigineX)&(y==(tlm.var.OrigineY+tlm.var.EpaisseurMesure/2)));

            Z=((fem.sol.u(find(pos1,1),cpt)-fem.sol.u(find(pos2,1),cpt))*conj(I1))/(abs(I1)^2);
            
        elseif tlm.conf.points==2               % for 2 points measurement
            
            if tlm.conf.Milo==1
                if abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)>1e-10
                    I1=postint(fem,'lm1', ...
                       'dl',5, ...
                       'edim',1, ...
                       'intorder',4, ...
                       'geomnum',1, ...
                       'solnum',cpt, ...
                       'phase',(0)*pi/180);
                elseif abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)<1e-10
                    if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                        I1=postint(fem,'lm1', ...
                            'dl',1, ...
                            'edim',1, ...
                            'intorder',4, ...
                            'geomnum',1, ...
                            'solnum',cpt, ...
                            'phase',(0)*pi/180);
                    else
                        I1=postint(fem,'lm1', ...
                            'dl',2, ...
                            'edim',1, ...
                            'intorder',4, ...
                            'geomnum',1, ...
                            'solnum',cpt, ...
                            'phase',(0)*pi/180);
                    end
                end
                
            elseif tlm.conf.Milo==2
                
                if abs(2*tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)>1e-10
                    I1=postint(fem,'lm1', ...
                       'dl',5, ...
                       'edim',1, ...
                       'intorder',4, ...
                       'geomnum',1, ...
                       'solnum',cpt, ...
                       'phase',(0)*pi/180);
                elseif abs(2*tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)<1e-10
                    if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                        I1=postint(fem,'lm1', ...
                            'dl',1, ...
                            'edim',1, ...
                            'intorder',4, ...
                            'geomnum',1, ...
                            'solnum',cpt, ...
                            'phase',(0)*pi/180);
                    else
                        I1=postint(fem,'lm1', ...
                            'dl',2, ...
                            'edim',1, ...
                            'intorder',4, ...
                            'geomnum',1, ...
                            'solnum',cpt, ...
                            'phase',(0)*pi/180);
                    end
                end

            end

            pos1=((x==double(tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2))&(y==double(tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2)));
            pos2=((x==tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2)&(y==(tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2)));

            Z=((fem.sol.u(find(pos2,1),cpt)-fem.sol.u(find(pos1,1),cpt))*conj(I1))/(abs(I1)^2);
            
        elseif tlm.conf.points==4           % for 4 points measurement
            
            if tlm.conf.Milo==1
                if (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)>1e-10 && ...
                    abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)>1e-10)
                    I1=postint(fem,'lm1', ...
                       'dl',5, ...
                       'edim',1, ...
                       'intorder',4, ...
                       'geomnum',1, ...
                       'solnum',cpt, ...
                       'phase',(0)*pi/180);
                elseif (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)>1e-10 && ...
                    abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)<1e-10)
                    I1=postint(fem,'lm1', ...
                       'dl',2, ...
                       'edim',1, ...
                       'intorder',4, ...
                       'geomnum',1, ...
                       'solnum',cpt, ...
                       'phase',(0)*pi/180);
                elseif (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10 && ...
                    abs(tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)<1e-10)
                    I1=postint(fem,'lm1', ...
                       'dl',1, ...
                       'edim',1, ...
                       'intorder',4, ...
                       'geomnum',1, ...
                       'solnum',cpt, ...
                       'phase',(0)*pi/180);
                end
            elseif tlm.conf.Milo==2
                if (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)>1e-10 && ...
                    abs(2*tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)>1e-10)
                    I1=postint(fem,'lm1', ...
                       'dl',5, ...
                       'edim',1, ...
                       'intorder',4, ...
                       'geomnum',1, ...
                       'solnum',cpt, ...
                       'phase',(0)*pi/180);
                elseif (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)>1e-10 && ...
                    abs(2*tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)<1e-10)
                    I1=postint(fem,'lm1', ...
                       'dl',2, ...
                       'edim',1, ...
                       'intorder',4, ...
                       'geomnum',1, ...
                       'solnum',cpt, ...
                       'phase',(0)*pi/180);
                elseif (abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10 && ...
                    abs(2*tlm.var.LargeurChambre-tlm.var.EcartementElectrode-2*tlm.var.LargeurElectrode)<1e-10)
                    I1=postint(fem,'lm1', ...
                       'dl',1, ...
                       'edim',1, ...
                       'intorder',4, ...
                       'geomnum',1, ...
                       'solnum',cpt, ...
                       'phase',(0)*pi/180);
                end
            end
            
            pos1=(x==double(tlm.var.OrigineX+tlm.var.EcartementMesure/2+tlm.var.LargeurMesure/2) & y==double(tlm.var.OrigineY+tlm.var.EpaisseurMesure/2));
            pos2=((10*x==10*double(tlm.var.OrigineX-tlm.var.EcartementMesure/2-tlm.var.LargeurMesure/2))&(10*y==10*double(tlm.var.OrigineY+tlm.var.EpaisseurMesure/2)));

            Z=((fem.sol.u(find(pos2,1),cpt)-fem.sol.u(find(pos1,1),cpt))*conj(I1))/(abs(I1)^2);
            
        end
            
        % Save the frequency, magnitude and Phase of the Impedance
        tlm.sol.val(cpt,1)=f;
        tlm.sol.val(cpt,2)=20*log10(abs(Z));
        tlm.sol.val(cpt,3)=angle(Z)*180/pi;
        tlm.sol.val(cpt,7)=real(Z);
        tlm.sol.val(cpt,8)=imag(Z);
        cpt=cpt+1;
        
    end
end

cptmem=cpt-1;
    
% If required, plot various data

if (tlm.conf.figure==1)
    
    % Plot the Bode diagramm for the FEM Calculation
    
    figure(2+ii);
    clf('reset');
    tlm.conf.fig=tlm.conf.fig+1;
    subplot(2,1,1);
    semilogx(tlm.sol.val(:,1),tlm.sol.val(:,2));
    title('Bode Plot from FEM Calculations');
    ylabel('Magnitude (dB)');
    xlabel('Frequency');

    subplot(2,1,2);
    semilogx(tlm.sol.val(:,1),tlm.sol.val(:,3));
    ylabel('Phase (Degrees)');
    xlabel('Frequency');

    % Plot the Nyquist diagramm for the FEM Calculation

    figure(3+ii);
    clf('reset');
    tlm.conf.fig=tlm.conf.fig+1;
    loglog(tlm.sol.val(:,7),-tlm.sol.val(:,8),'-or');

    axis ij;
    axis square;
    axis([0.001 1000 0.001 1000]);

    cpt=0;

    for a=log10(tlm.var.frequence.min):1:log10(tlm.var.frequence.max)
        for b=1:1:tlm.var.frequence.step
            f=b*10^a;
            cpt=cpt+1;
            if (tlm.sol.val(cpt,7)>0.001 && tlm.sol.val(cpt,7)<1000) && ...
               (-tlm.sol.val(cpt,8)>0.001 && -tlm.sol.val(cpt,8)<1000) && (b==1)    
                text(tlm.sol.val(cpt,7),-tlm.sol.val(cpt,8),tlm.conf.f(a));
            elseif (tlm.sol.val(cpt,7)>0.001 && tlm.sol.val(cpt,7)<1000) && ...
                   (-tlm.sol.val(cpt,8)>0.001 && -tlm.sol.val(cpt,8)<1000) && (f==tlm.var.frequence.max)    
                text(tlm.sol.val(cpt,7),-tlm.sol.val(cpt,8),tlm.conf.f(10));
            end
        end
    end

    title('Nyquist Plot from FEM Calculations');
    ylabel('Im(|Z|)   (Ohms)');
    xlabel('Re(|Z|)   (Ohms)');
end

% Save the results of the simulation in a file xx.fem

name1=sprintf('%s.fem',tlm.conf.Name0);        % Name of the file for the Net List
fid=fopen(name1, 'w');                     % Open the File

fprintf(fid, '%s.fem\n',tlm.conf.Name0);       % Write the first line of the file which is use as a title of the graphical output
fprintf(fid, '********************************************************************************\n');            
fprintf(fid, '*\n');            
fprintf(fid, '*                        Bode Diagram Calculated by FEM \n'); 
fprintf(fid, '*\n');            
fprintf(fid, '*                              BIOCAD Program\n');            
fprintf(fid, '*                               Release 3.1\n');            
fprintf(fid, '*\n');            
fprintf(fid, '*   Authors: Vincent Senez, Benoit Poussard, Thomas Delmas, Hugo Bertacchini\n'); 
fprintf(fid, '*\n');            
fprintf(fid, '*   Release 1.0 : July 2003\n');     
fprintf(fid, '*   Release 1.1 : December 2004\n');     
fprintf(fid, '*   Release 1.2 : July 2005\n');     
fprintf(fid, '*   Release 2.0 : December 2005\n');     
fprintf(fid, '*   Release 2.1 : July 2006\n');     
fprintf(fid, '*   Release 3.0 : December 2006\n');     
fprintf(fid, '*   Release 3.1 : December 2007\n');     
fprintf(fid, '*\n');            
fprintf(fid, '********************************************************************************\n');            
fprintf(fid, '*\n');            
fprintf(fid, '* Values:\n');            

for cpt=1:1:cptmem
    fprintf(fid, '%1.3g %1.10g %1.10g\n',tlm.sol.val(cpt,1), tlm.sol.val(cpt,2), tlm.sol.val(cpt,3));  
end

fclose(fid);

tlm.conf.Name=tlm.conf.Name0;

