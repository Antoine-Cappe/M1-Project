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
%   Routine IniParaNoCell called by Compute.m
%
%   Function: Initialize Geometrical & Physical Parameters for test cases
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function tlm=Calibration(tlm)

if tlm.conf.Test==1         %2D case - without cell - Medium is purely resistive
                            %refine =0
                            
% Name of the output files

    tlm.conf.Name = 'test1';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=0;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 
    
% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;          % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;            % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;            % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;            % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0;         % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;            % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;            % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;            % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;            % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;            % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0;         % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;            % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;            % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;            % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;            % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=0*tlm.var.eps0;       % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=0*tlm.var.eps0;         % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=0*tlm.var.eps0;         % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell

elseif tlm.conf.Test==2         %2D case - without cell - Medium is purely capacitive
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test2';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=0;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA
    
% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0;          % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0;            % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0;            % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;         % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0;      % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0;      % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;      % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell

elseif tlm.conf.Test==3         %2D case - without cell - Medium is resistive & capacitive
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test3';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=0;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;    % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;         % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;      % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0;      % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;      % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==4         %3D case - without cell - Medium is purely resistive 
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test4';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=0;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;          % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;            % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;            % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0;         % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;            % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;            % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;            % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;            % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;            % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0;         % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;            % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;            % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;            % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;            % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=0*tlm.var.eps0;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=0*tlm.var.eps0;                       % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=0*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==5         %3D case - without cell - Medium is purely capacitive 
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test5';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=0;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0;          % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0;            % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0;            % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;         % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0;      % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0;      % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;      % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell

elseif tlm.conf.Test==6         %3D case - without cell - Medium is resistive & capacitive 
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test6';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=0;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;       % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;         % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0;      % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0;      % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;      % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell

elseif tlm.conf.Test==7         %2D case - without cell - Medium is purely resistive & capacitive
                                %refine =1

% Name of the output files

    tlm.conf.Name = 'test7';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=0;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=1;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;         % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0;      % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0;      % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==8         %3D case - without cell - Medium is resistive & capacitive 
                                %refine =1

% Name of the output files

    tlm.conf.Name = 'test8';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=0;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=1;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;       % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;         % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0;      % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0;      % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;      % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum   tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=0*tlm.var.eps0;   % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==9         %2D case - with cell - without membrane - Cell & Medium are resistive & capacitive
                                %(same electrical properties for Cell & Medium)
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test9';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;         % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;      % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell

elseif tlm.conf.Test==10        %3D case - with cell - without membrane - Cell & Medium are resistive & capacitive 
                                %(same electrical properties for Cell & Medium)
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test10';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;         % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;      % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==11        %2D case - with cell - without membrane - Cell & Medium are resistive & capacitive
                                %(same electrical properties for Cell & Medium)
                                %refine =1

% Name of the output files

    tlm.conf.Name = 'test11';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=1;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=0;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 
    
% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=4.5e5;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;      % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=0;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
       
elseif tlm.conf.Test==12        %3D case - with cell - without membrane - Cell & Medium are resistive & capacitive 
                                %(same electrical properties for Cell & Medium)
                                %refine =1

% Name of the output files

    tlm.conf.Name = 'test12';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=1;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=0;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=4.5e5;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;         % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=0;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==13        %2D case - with cell - with membrane - Cell, Membrane & Medium are resistive & capacitive 
                                %(same electrical properties for Cell, Membrane & Medium)
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test13';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=1;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;      % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0.53;      % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;      % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
   
elseif tlm.conf.Test==14        %3D case - with cell - with membrane - Cell, Membrane & Medium are resistive & capacitive 
                                %(same electrical properties for Cell, Membrane & Medium)
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test14';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=1;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;      % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0.53;      % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0 ;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==15        %2D case - with cell - with membrane - Cell, Membrane & Medium are resistive & capacitive
                                %(same electrical properties for Cell, Membrane & Medium)
                                %refine =1

% Name of the output files

    tlm.conf.Name = 'test15';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=1;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=1;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=0;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum
    
    tlm.var.sig.electrode=4.5e5;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;      % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0.53;      % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=0;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==16        %3D case - with cell - with membrane - Cell, Membrane & Medium are resistive & capacitive 
                                %(same electrical properties for Cell, Membrane & Medium)
                                %refine =1

% Name of the output files

    tlm.conf.Name = 'test16';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=1;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=0;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=1;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=1;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=0;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=4.5e5;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;      % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0;         % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0.53;      % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0;         % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=0;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==17        %2D case - with cell & nucleus - without membrane - Cell, Nucleus & Medium are resistive & capacitive
                                %(same electrical properties for Cell, Nucleus & Medium)
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test17';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=1;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;         % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0.53;      % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0.53;      % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;      % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell

elseif tlm.conf.Test==18        %3D case - with cell & nucleus - without membrane - Cell, Nucleus & Medium are resistive & capacitive 
                                %(same electrical properties for Cell, Nucleus & Medium)
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test18';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=1;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;       % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;         % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0.53;      % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0.53;      % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;      % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==19        %2D case - with cell & nucleus - without membrane - Cell, Nucleus & Medium are resistive & capacitive
                                %(same electrical properties for Cell, Nucleus & Medium)
                                %refine =1

% Name of the output files

    tlm.conf.Name = 'test19';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=1;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=1;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=0;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 
    
% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=4.5e5;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;         % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0.53;      % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0.53;      % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=0;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==20        %3D case - with cell & nucleus - without membrane - Cell, Nucleus & Medium are resistive & capacitive 
                                %(same electrical properties for Cell, Nucleus & Medium)
                                %refine =1

% Name of the output files

    tlm.conf.Name = 'test20';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=1;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=0;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=1;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=0;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=4.5e5;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0;         % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0.53;      % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0;         % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0.53;      % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0;         % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=0;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==21        %2D case - with cell & nucleus &  membrane - Cell, Nucleus, Membrane & Medium are resistive & capacitive 
                                %(same electrical properties for Cell, Nucleus, Membrane & Medium)
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test21';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Nucleus=1;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=1;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=0;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;      % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0.53;      % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0.53;      % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0;         % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0.53;      % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0.53;      % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;      % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==22        %3D case - with cell, nucleus & membrane - Cell, Nucleus, Membrane & Medium are resistive & capacitive 
                                %(same electrical properties for Cell, Nucleus, Membrane & Medium)
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test22';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Nucleus=1;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=1;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=0;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=4.5e5;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;      % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0.53;      % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0.53;      % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0.53;      % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0.53;      % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0.53;      % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=0;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==23        %2D case - with cell, nucleus & membrane - Cell, Nucleus, Membrane & Medium are resistive & capacitive
                                %(same electrical properties for Cell, Nucleus, Membrane & Medium)
                                %refine =1

% Name of the output files

    tlm.conf.Name = 'test23';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=1;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=1;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=1;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=0;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=4.5e5;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;      % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0.53;      % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0.53;      % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0.53;      % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0.53;      % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0.53;      % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=0;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
        
elseif tlm.conf.Test==24        %3D case - with cell, nucleus & membrane - Cell, Nucleus, Membrane & Medium are resistive & capacitive 
                                %(same electrical properties for Cell, Nucleus, Membrane & Medium)
                                %refine =1

% Name of the output files

    tlm.conf.Name = 'test24';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=1;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=0;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=1;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=1;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=0;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=4.5e5;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;      % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0.53;      % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0;         % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0.53;      % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0;         % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0.53;      % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0.53;      % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0;         % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0.53;      % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0;         % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=0;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=0*tlm.var.eps0;      % Permittivity (F/m) of the mitochondria membrane of the second cell
        
elseif tlm.conf.Test==25        %2D case - with cell & nucleus & mitochondria &  membrane - Cell, Nucleus, Mitochondria, Membrane & Medium are resistive & capacitive 
                                %(same electrical properties for Cell, Nucleus, Mitochondria, Membrane & Medium)
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test25';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=1;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=1;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=1;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;      % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0.53;      % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0.53;      % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0.53;      % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0.53;      % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0.53;      % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0.53;      % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0.53;      % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0.53;      % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0.53;      % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;      % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==26        %3D case - with cell & nucleus & mitochondria &  membrane - Cell, Nucleus, Mitochondria, Membrane & Medium are resistive & capacitive 
                                %(same electrical properties for Cell, Nucleus, Mitochondria, Membrane & Medium)
                                %refine =0

% Name of the output files

    tlm.conf.Name = 'test26';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=1;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=1;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=1;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=0;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=2;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=0.53;       % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;      % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0.53;      % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0.53;      % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0.53;      % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0.53;      % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0.53;      % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0.53;      % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0.53;      % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0.53;      % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0.53;      % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=80*tlm.var.eps0;      % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the mitochondria membrane of the second cell
    
elseif tlm.conf.Test==27        %2D case - with cell & nucleus & mitochondria &  membrane - Cell, Nucleus, Mitochondria, Membrane & Medium are resistive & capacitive 
                                %(same electrical properties for Cell, Nucleus, Mitochondria, Membrane & Medium)
                                %refine =1

% Name of the output files

    tlm.conf.Name = 'test27';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=2;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=1;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=1;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=1;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=1;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=0;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=4.5e5;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;      % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0.53;      % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0.53;      % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0.53;      % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0.53;      % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0.53;      % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0.53;      % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0.53;      % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0.53;      % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0.53;      % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=0;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the mitochondria membrane of the second cell
        
elseif tlm.conf.Test==28        %3D case - with cell & nucleus & mitochondria &  membrane - Cell, Nucleus, Mitochondria, Membrane & Medium are resistive & capacitive 
                                %(same electrical properties for Cell, Nucleus, Mitochondria, Membrane & Medium)
                                %refine =1

% Name of the output files

    tlm.conf.Name = 'test28';

% Configuration of the Bio-Physical System

    tlm.conf.Dim=3;                     % 2 is for two dimensional analysis, 3 is for three D
    tlm.conf.Milo=1;                    % 1 is for one Medium, 2 is for two mediums
    tlm.conf.Cell=1;                    % 1 if with one cell, 2 with 2 cells, 0 without cell
    tlm.conf.Shape=0;                   % 0 spheroid cell, 1 non_spheroid cell
    tlm.conf.Nucleus=1;                 % 1 if with a nucleus, 0 without a nucleus
    tlm.conf.Mitocho=1;                 % 1 if with a mitochondria, 0 without a mitochondria
    tlm.conf.Parasite=0;                % 1 if we take into account the hydratation layer around the electrodes
    tlm.conf.Membrane=1;                % 1 if we take into account the membrane around the cells and organelles             
    tlm.conf.refine=1;                  % Number of iterations for the refinement of the mesh of the structure
    tlm.conf.calcul=0;                  % Define the type of calculations performed in Biocad: 0/TLM; 1/TLM+FEM; 2/TLM+FEM+ANA 

% Physical Parameters

    tlm.var.eps0=8.854187817e-012;     % Dielectric Permittivity of Vacuum

    tlm.var.sig.electrode=4.5e5;      % Conductivity (S/m) of the metal (electrodes)
    tlm.var.sig.MilOrga=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MilOrgb=0.53;         % Conductivity (S/m) of the external medium (serum)
    tlm.var.sig.MembCel(1)=0.53;      % Conductivity (S/m) of the membrane of the first cell
    tlm.var.sig.Cytoplasme(1)=0.53;   % Conductivity (S/m) of the cytoplasm of the first cell
    tlm.var.sig.Nucleus(1)=0.53;      % Conductivity (S/m) of the nucleus of the first cell
    tlm.var.sig.Mitocho(1)=0.53;      % Conductivity (S/m) of the mitochondria of the first cell
    tlm.var.sig.MembNuc(1)=0.53;      % Conductivity (S/m) of the nucleus membrane of the first cell
    tlm.var.sig.MembMit(1)=0.53;      % Conductivity (S/m) of the mitochondria membrane of the first cell
    tlm.var.sig.MembCel(2)=0.53;      % Conductivity (S/m) of the membrane of the second cell
    tlm.var.sig.Cytoplasme(2)=0.53;   % Conductivity (S/m) of the cytoplasm of the second cell
    tlm.var.sig.Nucleus(2)=0.53;      % Conductivity (S/m) of the nucleus of the second cell
    tlm.var.sig.Mitocho(2)=0.53;      % Conductivity (S/m) of the mitochondria of the second cell
    tlm.var.sig.MembNuc(2)=0.53;      % Conductivity (S/m) of the nucleus membrane of the second cell
    tlm.var.sig.MembMit(2)=0.53;      % Conductivity (S/m) of the mitochondria membrane of the second cell

    tlm.var.eps.electrode=0;                     % Permittivity (F/m) of the metal (electrodes)
    tlm.var.eps.MilOrga=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MilOrgb=80*tlm.var.eps0;        % Permittivity (F/m) of the external medium (serum)
    tlm.var.eps.MembCel(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the first cell
    tlm.var.eps.Cytoplasme(1)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the first cell
    tlm.var.eps.Nucleus(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.Mitocho(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the first cell
    tlm.var.eps.MembMit(1)=80*tlm.var.eps0;     % Permittivity (F/m) of the mitochondria membrane of the first cell
    tlm.var.eps.MembCel(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the membrane of the second cell
    tlm.var.eps.Cytoplasme(2)=80*tlm.var.eps0;  % Permittivity (F/m) of the cytoplasm of the second cell
    tlm.var.eps.Nucleus(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the second cell
    tlm.var.eps.Mitocho(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus of the first cell
    tlm.var.eps.MembNuc(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the nucleus membrane of the second cell
    tlm.var.eps.MembMit(2)=80*tlm.var.eps0;     % Permittivity (F/m) of the mitochondria membrane of the second cell
        
end

% Directories Configuration

if tlm.conf.points==2
    tlm.conf.result=[tlm.conf.result '\nocell\2points\' tlm.conf.Name];
elseif tlm.conf.points==4
    tlm.conf.result=[tlm.conf.result '\nocell\4points\' tlm.conf.Name];
end

% Parameters of the Warburg Element (electrode polarisation)

tlm.var.Vt=0.025;                          % Vt=kT/q
tlm.var.q=1.60219e-19;                     % Charge of the electron
tlm.var.z=1;                               % Valence of ions
tlm.var.n0=93e21;                          % Bulk number concentration of ions in electrolyte (ions/liter)
tlm.var.D=1e-11/1e4;                       % Ion diffusivity (cm^2/s)
tlm.var.j0=2e-9;                           %Exchange current density Au in buffered saline (A/cm^2)
tlm.var.profondeur=1;                      %(m)
tlm.var.Ci=0.07e-12*1e6^2*tlm.var.profondeur;                             %(F/m)
tlm.var.Rt=tlm.var.Vt/tlm.var.j0/tlm.var.z/1e2^2/tlm.var.profondeur;   %(Ohm*m)
tlm.var.Rwf=1e3*tlm.var.Vt/tlm.var.z^2/tlm.var.q/tlm.var.n0/(pi*tlm.var.D)^0.5/1e2^2/tlm.var.profondeur;   %(Ohm*m*Hz^0.5)
tlm.var.Cwf=1/2/pi/tlm.var.Rwf;                 %(F/m/Hz^0.5)

% String definition for Nyquist Plot
data=['   1    Hz';'   10   Hz';'   100  Hz';'   10  KHz';'   100 KHz';'   1   MHz';'   10  MHz';'   100 MHz';'   1   GHz';'   10  GHz'];
tlm.conf.f=cellstr(data);
