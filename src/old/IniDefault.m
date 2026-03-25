%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                              BIOCAD Program
%                               Release 2.1
%
%   Authors: Vincent Senez, Benoit Poussard, 
%            Thomas Delmas, Hugo Bertacchini
%   
%   Release 1.0 : July 2003
%   Release 1.1 : December 2004
%   Release 1.2 : July 2005
%   Release 2.0 : December 2005
%   Release 2.1 : July 2006
%
%   Routine IniDefault called by Biocad,
%
%   Function: Initialize some Parameters 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function tlm=IniDefault(tlm)

tlm.conf.dim=2;     % 2D analysis
tlm.conf.Milo=1;    % one inter medium
tlm.conf.Cell=0;    % no cell
tlm.conf.points=4;  % 4 points measurements
tlm.conf.Membrane=0;% no membrane
tlm.conf.Nucleus=0; % no nucleus
tlm.conf.Mitocho=0; % no mitochondria
    
tlm.var.OrigineX=0e-6;             % Origine of coordinates in X
tlm.var.OrigineY=0e-6;             % Origine of coordinates in Y
tlm.var.OrigineZ=0e-6;             % Origine of coordinates in Z