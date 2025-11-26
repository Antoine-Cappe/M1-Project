%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                              BIOCAD Program
%                               Release 1.0
%
%   Authors: Vincent Senez
%   
%   Release 1.0 : January 2019 
%
%   Function : Draw the 3D geometry of the device with COMSOL routines
%
%   Called by : Compute.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [tlm,model]=Geom3Dcad(tlm)

%Check the geometry

%%%%%%%%%%more controls to add

% Create the COMSOL model

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.comments(['sans titre\n\n']); % revoir à quoi cela sert

% definit la directory ou sont sauvés les fichiers
model.modelPath(tlm.conf.store);    

model.component.create('comp1', true);

% set a label for the simaulation model
model.modelNode('comp1').label('Simulation Spectre Impedance Electrique');

% create a 3D geometry called 'geom1'
model.component('comp1').geom.create('geom1', 3);


% Set the length unit
%model.geom('geom1').lengthUnit('mm');

%create a 3D mesh named 'mesh1' for geometry named 'geom1'
%model.mesh.create('mesh1', 'geom1');
model.component('comp1').mesh.create('mesh1');
model.component('comp1').mesh('mesh1').feature().clear();

%model.component('comp1').physics.create('ec', 'ConductiveMedia', 'geom1');

%model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']); %unit in micron
%model.component('comp1').geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);

%model.component('comp1').mesh('mesh1').autoMeshSize(3);
%model.component('comp1').mesh('mesh1').run;


% Define the geometry of the microfluidic chamber 

if tlm.conf.Init==1 % Check Calibration on a simple structure
    
    % Define a parallelepipedic chamber

    % Define all geometrical parameters
    
    model.param.set('LongueurChambre', tlm.var.LongueurChambre);
    model.param.set('LargeurChambre', tlm.var.LargeurChambre);
    model.param.set('EpaisseurChambre', tlm.var.EpaisseurChambre);
    model.param.set('EpaisseurMesure', tlm.var.EpaisseurMesure);
    model.param.set('OrigineX', tlm.var.OrigineX);
    model.param.set('OrigineY', tlm.var.OrigineY);
    model.param.set('OrigineZ', tlm.var.OrigineZ);
    model.param.set('Center', tlm.var.Center);
    model.param.set('LargeurElectrode', tlm.var.LargeurElectrode);
    model.param.set('LargeurMesure', tlm.var.LargeurMesure);
    model.param.set('EpaisseurElectrode', tlm.var.EpaisseurElectrode);
    model.param.set('EcartementElectrode', tlm.var.EcartementElectrode);
    model.param.set('EcartementMesure', tlm.var.EcartementMesure);
    model.param.set('RayonXCellule', tlm.var.RayonXCellule(1));
    model.param.set('RayonYCellule', tlm.var.RayonYCellule(1));
    model.param.set('RayonZCellule', tlm.var.RayonZCellule(1));
    model.param.set('RayonXNoyau', tlm.var.RayonXNoyau(1));
    model.param.set('RayonYNoyau', tlm.var.RayonYNoyau(1));
    model.param.set('RayonZNoyau', tlm.var.RayonZNoyau(1));
    model.param.set('RayonXMitoc', tlm.var.RayonXMitoc(1));
    model.param.set('RayonYMitoc', tlm.var.RayonYMitoc(1));
    model.param.set('RayonZMitoc', tlm.var.RayonZMitoc(1));
    model.param.set('DecentrageXCellule', tlm.var.DecentrageXCellule(1));
    model.param.set('DecentrageYCellule', tlm.var.DecentrageYCellule(1));
    model.param.set('DecentrageZCellule', tlm.var.DecentrageZCellule(1));
    model.param.set('DecentrageXNoyau', tlm.var.DecentrageXNoyau(1));
    model.param.set('DecentrageYNoyau', tlm.var.DecentrageYNoyau(1));
    model.param.set('DecentrageZNoyau', tlm.var.DecentrageZNoyau(1));
    model.param.set('DecentrageXMitoc', tlm.var.DecentrageXMitoc(1));
    model.param.set('DecentrageYMitoc', tlm.var.DecentrageYMitoc(1));
    model.param.set('DecentrageZMitoc', tlm.var.DecentrageZMitoc(1));

    
    fem.sdim={'x','y','z'};
    clear s c p
    
   % Create Parallelepipedic chamber

    model.component('comp1').geom('geom1').create('blk1', 'Block');
    model.component('comp1').geom('geom1').feature('blk1').set('size', {'LongueurChambre' 'LargeurChambre' 'EpaisseurChambre'});
    model.component('comp1').geom('geom1').feature('blk1').set('pos', {'OrigineX-LongueurChambre/2' 'OrigineY-LargeurChambre/2' 'OrigineZ'});
    
   % Create two 3D Electrodes on both sides of the chamber

    model.component('comp1').geom('geom1').create('blk2', 'Block');
    model.component('comp1').geom('geom1').feature('blk2').set('size', {'LargeurElectrode' 'LargeurChambre' 'EpaisseurChambre'});
    model.component('comp1').geom('geom1').feature('blk2').set('pos', {'OrigineX+LongueurChambre/2' 'OrigineY-LargeurChambre/2' 'OrigineZ'});
    
    model.component('comp1').geom('geom1').create('blk3', 'Block');
    model.component('comp1').geom('geom1').feature('blk3').set('size', {'LargeurElectrode' 'LargeurChambre' 'EpaisseurChambre'});
    model.component('comp1').geom('geom1').feature('blk3').set('pos', {'OrigineX-LongueurChambre/2-LargeurElectrode' 'OrigineY-LargeurChambre/2' 'OrigineZ'});

    model.component('comp1').geom('geom1').run('fin');
    
    % Give labels to each domains
    
    model.component('comp1').geom('geom1').feature('blk1').label('CHAMBER');
    model.component('comp1').geom('geom1').feature('blk2').label('ELEC1');
    model.component('comp1').geom('geom1').feature('blk3').label('ELEC2');
    model.component('comp1').geom('geom1').feature('fin').label('UNION');
    
    % Create a point in each domains
    %{le 10/12/2020
    % Left electrode
    model.component('comp1').geom('geom1').create('PT1A0','Point');
    model.component('comp1').geom('geom1').feature('PT1A0').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY, tlm.var.OrigineZ+tlm.var.EpaisseurChambre/2]);
    
    model.component('comp1').geom('geom1').create('PT1AM1','Point');
    model.component('comp1').geom('geom1').feature('PT1AM1').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+tlm.var.EpaisseurChambre/2]);
    
    model.component('comp1').geom('geom1').create('PT1AM2','Point');
    model.component('comp1').geom('geom1').feature('PT1AM2').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+tlm.var.EpaisseurChambre/2]);
    
    model.component('comp1').geom('geom1').create('PT1AM3','Point');
    model.component('comp1').geom('geom1').feature('PT1AM3').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+tlm.var.EpaisseurChambre/2]);
    
    model.component('comp1').geom('geom1').create('PT1AP1','Point');
    model.component('comp1').geom('geom1').feature('PT1AP1').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+tlm.var.EpaisseurChambre/2]);
    
    model.component('comp1').geom('geom1').create('PT1AP2','Point');
    model.component('comp1').geom('geom1').feature('PT1AP2').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+tlm.var.EpaisseurChambre/2]);
    
    model.component('comp1').geom('geom1').create('PT1AP3','Point');
    model.component('comp1').geom('geom1').feature('PT1AP3').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+tlm.var.EpaisseurChambre/2]);
    
    model.component('comp1').geom('geom1').create('PT1B0','Point');
    model.component('comp1').geom('geom1').feature('PT1B0').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY, tlm.var.OrigineZ+3*tlm.var.EpaisseurChambre/8]);
   
    model.component('comp1').geom('geom1').create('PT1BM1','Point');
    model.component('comp1').geom('geom1').feature('PT1BM1').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+3*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1BM2','Point');
    model.component('comp1').geom('geom1').feature('PT1BM2').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+3*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1BM3','Point');
    model.component('comp1').geom('geom1').feature('PT1BM3').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+3*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1BP1','Point');
    model.component('comp1').geom('geom1').feature('PT1BP1').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+3*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1BP2','Point');
    model.component('comp1').geom('geom1').feature('PT1BP2').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+3*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1BP3','Point');
    model.component('comp1').geom('geom1').feature('PT1BP3').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+3*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1C0','Point');
    model.component('comp1').geom('geom1').feature('PT1C0').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY, tlm.var.OrigineZ+2*tlm.var.EpaisseurChambre/8]);
   
    model.component('comp1').geom('geom1').create('PT1CM1','Point');
    model.component('comp1').geom('geom1').feature('PT1CM1').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+2*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1CM2','Point');
    model.component('comp1').geom('geom1').feature('PT1CM2').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+2*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1CM3','Point');
    model.component('comp1').geom('geom1').feature('PT1CM3').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+2*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1CP1','Point');
    model.component('comp1').geom('geom1').feature('PT1CP1').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+2*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1CP2','Point');
    model.component('comp1').geom('geom1').feature('PT1CP2').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+2*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1CP3','Point');
    model.component('comp1').geom('geom1').feature('PT1CP3').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+2*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1D0','Point');
    model.component('comp1').geom('geom1').feature('PT1D0').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY, tlm.var.OrigineZ+1*tlm.var.EpaisseurChambre/8]);
   
    model.component('comp1').geom('geom1').create('PT1DM1','Point');
    model.component('comp1').geom('geom1').feature('PT1DM1').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+1*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1DM2','Point');
    model.component('comp1').geom('geom1').feature('PT1DM2').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+1*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1DM3','Point');
    model.component('comp1').geom('geom1').feature('PT1DM3').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+1*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1DP1','Point');
    model.component('comp1').geom('geom1').feature('PT1DP1').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+1*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1DP2','Point');
    model.component('comp1').geom('geom1').feature('PT1DP2').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+1*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1DP3','Point');
    model.component('comp1').geom('geom1').feature('PT1DP3').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+1*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1E0','Point');
    model.component('comp1').geom('geom1').feature('PT1E0').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY, tlm.var.OrigineZ+5*tlm.var.EpaisseurChambre/8]);
   
    model.component('comp1').geom('geom1').create('PT1EM1','Point');
    model.component('comp1').geom('geom1').feature('PT1EM1').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+5*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1EM2','Point');
    model.component('comp1').geom('geom1').feature('PT1EM2').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+5*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1EM3','Point');
    model.component('comp1').geom('geom1').feature('PT1EM3').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+5*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1EP1','Point');
    model.component('comp1').geom('geom1').feature('PT1EP1').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+5*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1EP2','Point');
    model.component('comp1').geom('geom1').feature('PT1EP2').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+5*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1EP3','Point');
    model.component('comp1').geom('geom1').feature('PT1EP3').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+5*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1F0','Point');
    model.component('comp1').geom('geom1').feature('PT1F0').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY, tlm.var.OrigineZ+6*tlm.var.EpaisseurChambre/8]);
   
    model.component('comp1').geom('geom1').create('PT1FM1','Point');
    model.component('comp1').geom('geom1').feature('PT1FM1').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+6*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1FM2','Point');
    model.component('comp1').geom('geom1').feature('PT1FM2').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+6*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1FM3','Point');
    model.component('comp1').geom('geom1').feature('PT1FM3').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+6*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1FP1','Point');
    model.component('comp1').geom('geom1').feature('PT1FP1').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+6*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1FP2','Point');
    model.component('comp1').geom('geom1').feature('PT1FP2').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+6*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1FP3','Point');
    model.component('comp1').geom('geom1').feature('PT1FP3').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+6*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1G0','Point');
    model.component('comp1').geom('geom1').feature('PT1G0').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY, tlm.var.OrigineZ+7*tlm.var.EpaisseurChambre/8]);
   
    model.component('comp1').geom('geom1').create('PT1GM1','Point');
    model.component('comp1').geom('geom1').feature('PT1GM1').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+7*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1GM2','Point');
    model.component('comp1').geom('geom1').feature('PT1GM2').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+7*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1GM3','Point');
    model.component('comp1').geom('geom1').feature('PT1GM3').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+7*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1GP1','Point');
    model.component('comp1').geom('geom1').feature('PT1GP1').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+7*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1GP2','Point');
    model.component('comp1').geom('geom1').feature('PT1GP2').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+7*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT1GP3','Point');
    model.component('comp1').geom('geom1').feature('PT1GP3').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+7*tlm.var.EpaisseurChambre/8]);
    
    % Right electrode

    model.component('comp1').geom('geom1').create('PT2A0','Point');
    model.component('comp1').geom('geom1').feature('PT2A0').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY, tlm.var.OrigineZ+tlm.var.EpaisseurChambre/2]);
    
    model.component('comp1').geom('geom1').create('PT2AM1','Point');
    model.component('comp1').geom('geom1').feature('PT2AM1').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+tlm.var.EpaisseurChambre/2]);
    
    model.component('comp1').geom('geom1').create('PT2AM2','Point');
    model.component('comp1').geom('geom1').feature('PT2AM2').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+tlm.var.EpaisseurChambre/2]);
    
    model.component('comp1').geom('geom1').create('PT2AM3','Point');
    model.component('comp1').geom('geom1').feature('PT2AM3').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+tlm.var.EpaisseurChambre/2]);
    
    model.component('comp1').geom('geom1').create('PT2AP1','Point');
    model.component('comp1').geom('geom1').feature('PT2AP1').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+tlm.var.EpaisseurChambre/2]);
    
    model.component('comp1').geom('geom1').create('PT2AP2','Point');
    model.component('comp1').geom('geom1').feature('PT2AP2').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+tlm.var.EpaisseurChambre/2]);
    
    model.component('comp1').geom('geom1').create('PT2AP3','Point');
    model.component('comp1').geom('geom1').feature('PT2AP3').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+tlm.var.EpaisseurChambre/2]);
    
    model.component('comp1').geom('geom1').create('PT2B0','Point');
    model.component('comp1').geom('geom1').feature('PT2B0').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY, tlm.var.OrigineZ+3*tlm.var.EpaisseurChambre/8]);
   
    model.component('comp1').geom('geom1').create('PT2BM1','Point');
    model.component('comp1').geom('geom1').feature('PT2BM1').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+3*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2BM2','Point');
    model.component('comp1').geom('geom1').feature('PT2BM2').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+3*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2BM3','Point');
    model.component('comp1').geom('geom1').feature('PT2BM3').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+3*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2BP1','Point');
    model.component('comp1').geom('geom1').feature('PT2BP1').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+3*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2BP2','Point');
    model.component('comp1').geom('geom1').feature('PT2BP2').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+3*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2BP3','Point');
    model.component('comp1').geom('geom1').feature('PT2BP3').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+3*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2C0','Point');
    model.component('comp1').geom('geom1').feature('PT2C0').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY, tlm.var.OrigineZ+2*tlm.var.EpaisseurChambre/8]);
   
    model.component('comp1').geom('geom1').create('PT2CM1','Point');
    model.component('comp1').geom('geom1').feature('PT2CM1').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+2*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2CM2','Point');
    model.component('comp1').geom('geom1').feature('PT2CM2').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+2*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2CM3','Point');
    model.component('comp1').geom('geom1').feature('PT2CM3').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+2*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2CP1','Point');
    model.component('comp1').geom('geom1').feature('PT2CP1').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+2*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2CP2','Point');
    model.component('comp1').geom('geom1').feature('PT2CP2').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+2*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2CP3','Point');
    model.component('comp1').geom('geom1').feature('PT2CP3').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+2*tlm.var.EpaisseurChambre/8]);
    
        model.component('comp1').geom('geom1').create('PT2D0','Point');
    model.component('comp1').geom('geom1').feature('PT2D0').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY, tlm.var.OrigineZ+1*tlm.var.EpaisseurChambre/8]);
   
    model.component('comp1').geom('geom1').create('PT2DM1','Point');
    model.component('comp1').geom('geom1').feature('PT2DM1').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+1*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2DM2','Point');
    model.component('comp1').geom('geom1').feature('PT2DM2').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+1*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2DM3','Point');
    model.component('comp1').geom('geom1').feature('PT2DM3').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+1*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2DP1','Point');
    model.component('comp1').geom('geom1').feature('PT2DP1').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+1*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2DP2','Point');
    model.component('comp1').geom('geom1').feature('PT2DP2').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+1*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2DP3','Point');
    model.component('comp1').geom('geom1').feature('PT2DP3').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+1*tlm.var.EpaisseurChambre/8]);
    
        model.component('comp1').geom('geom1').create('PT2E0','Point');
    model.component('comp1').geom('geom1').feature('PT2E0').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY, tlm.var.OrigineZ+5*tlm.var.EpaisseurChambre/8]);
   
    model.component('comp1').geom('geom1').create('PT2EM1','Point');
    model.component('comp1').geom('geom1').feature('PT2EM1').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+5*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2EM2','Point');
    model.component('comp1').geom('geom1').feature('PT2EM2').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+5*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2EM3','Point');
    model.component('comp1').geom('geom1').feature('PT2EM3').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+5*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2EP1','Point');
    model.component('comp1').geom('geom1').feature('PT2EP1').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+5*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2EP2','Point');
    model.component('comp1').geom('geom1').feature('PT2EP2').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+5*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2EP3','Point');
    model.component('comp1').geom('geom1').feature('PT2EP3').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+5*tlm.var.EpaisseurChambre/8]);
    
        model.component('comp1').geom('geom1').create('PT2F0','Point');
    model.component('comp1').geom('geom1').feature('PT2F0').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY, tlm.var.OrigineZ+6*tlm.var.EpaisseurChambre/8]);
   
    model.component('comp1').geom('geom1').create('PT2FM1','Point');
    model.component('comp1').geom('geom1').feature('PT2FM1').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+6*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2FM2','Point');
    model.component('comp1').geom('geom1').feature('PT2FM2').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+6*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2FM3','Point');
    model.component('comp1').geom('geom1').feature('PT2FM3').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+6*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2FP1','Point');
    model.component('comp1').geom('geom1').feature('PT2FP1').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+6*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2FP2','Point');
    model.component('comp1').geom('geom1').feature('PT2FP2').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+6*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2FP3','Point');
    model.component('comp1').geom('geom1').feature('PT2FP3').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+6*tlm.var.EpaisseurChambre/8]);
    
        model.component('comp1').geom('geom1').create('PT2G0','Point');
    model.component('comp1').geom('geom1').feature('PT2G0').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY, tlm.var.OrigineZ+7*tlm.var.EpaisseurChambre/8]);
   
    model.component('comp1').geom('geom1').create('PT2GM1','Point');
    model.component('comp1').geom('geom1').feature('PT2GM1').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+7*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2GM2','Point');
    model.component('comp1').geom('geom1').feature('PT2GM2').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+7*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2GM3','Point');
    model.component('comp1').geom('geom1').feature('PT2GM3').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY-1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+7*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2GP1','Point');
    model.component('comp1').geom('geom1').feature('PT2GP1').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+1*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+7*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2GP2','Point');
    model.component('comp1').geom('geom1').feature('PT2GP2').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+2*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+7*tlm.var.EpaisseurChambre/8]);
    
    model.component('comp1').geom('geom1').create('PT2GP3','Point');
    model.component('comp1').geom('geom1').feature('PT2GP3').set('p',[tlm.var.OrigineX+tlm.var.LongueurChambre/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+3*tlm.var.LargeurChambre/8, tlm.var.OrigineZ+7*tlm.var.EpaisseurChambre/8]);
    
    % Culture medium
    model.component('comp1').geom('geom1').create('PT3','Point');
    model.component('comp1').geom('geom1').feature('PT3').set('p',[tlm.var.OrigineX, ...
        tlm.var.OrigineY, tlm.var.OrigineZ+tlm.var.EpaisseurChambre-tlm.var.Epsilon]);
    
    % Give labels to each points

    model.component('comp1').geom('geom1').feature('PT1A0').label('PT1A0');
    model.component('comp1').geom('geom1').feature('PT1AM1').label('PT1AM1');
    model.component('comp1').geom('geom1').feature('PT1AM2').label('PT1AM2');
    model.component('comp1').geom('geom1').feature('PT1AM3').label('PT1AM3');
    model.component('comp1').geom('geom1').feature('PT1AP1').label('PT1AP1');
    model.component('comp1').geom('geom1').feature('PT1AP2').label('PT1AP2');
    model.component('comp1').geom('geom1').feature('PT1AP3').label('PT1AP3');
    model.component('comp1').geom('geom1').feature('PT1B0').label('PT1B0');
    model.component('comp1').geom('geom1').feature('PT1BM1').label('PT1BM1');
    model.component('comp1').geom('geom1').feature('PT1BM2').label('PT1BM2');
    model.component('comp1').geom('geom1').feature('PT1BM3').label('PT1BM3');
    model.component('comp1').geom('geom1').feature('PT1BP1').label('PT1BP1');
    model.component('comp1').geom('geom1').feature('PT1BP2').label('PT1BP2');
    model.component('comp1').geom('geom1').feature('PT1BP3').label('PT1BP3');
    model.component('comp1').geom('geom1').feature('PT1C0').label('PT1C0');
    model.component('comp1').geom('geom1').feature('PT1CM1').label('PT1CM1');
    model.component('comp1').geom('geom1').feature('PT1CM2').label('PT1CM2');
    model.component('comp1').geom('geom1').feature('PT1CM3').label('PT1CM3');
    model.component('comp1').geom('geom1').feature('PT1CP1').label('PT1CP1');
    model.component('comp1').geom('geom1').feature('PT1CP2').label('PT1CP2');
    model.component('comp1').geom('geom1').feature('PT1CP3').label('PT1CP3');
    model.component('comp1').geom('geom1').feature('PT1D0').label('PT1D0');
    model.component('comp1').geom('geom1').feature('PT1DM1').label('PT1DM1');
    model.component('comp1').geom('geom1').feature('PT1DM2').label('PT1DM2');
    model.component('comp1').geom('geom1').feature('PT1DM3').label('PT1DM3');
    model.component('comp1').geom('geom1').feature('PT1DP1').label('PT1DP1');
    model.component('comp1').geom('geom1').feature('PT1DP2').label('PT1DP2');
    model.component('comp1').geom('geom1').feature('PT1DP3').label('PT1DP3');
    model.component('comp1').geom('geom1').feature('PT1E0').label('PT1E0');
    model.component('comp1').geom('geom1').feature('PT1EM1').label('PT1EM1');
    model.component('comp1').geom('geom1').feature('PT1EM2').label('PT1EM2');
    model.component('comp1').geom('geom1').feature('PT1EM3').label('PT1EM3');
    model.component('comp1').geom('geom1').feature('PT1EP1').label('PT1EP1');
    model.component('comp1').geom('geom1').feature('PT1F0').label('PT1F0');
    model.component('comp1').geom('geom1').feature('PT1FM1').label('PT1FM1');
    model.component('comp1').geom('geom1').feature('PT1FM2').label('PT1FM2');
    model.component('comp1').geom('geom1').feature('PT1FM3').label('PT1FM3');
    model.component('comp1').geom('geom1').feature('PT1FP1').label('PT1FP1');
    model.component('comp1').geom('geom1').feature('PT1FP2').label('PT1FP2');
    model.component('comp1').geom('geom1').feature('PT1FP3').label('PT1FP3');
    model.component('comp1').geom('geom1').feature('PT1FP2').label('PT1FP2');
    model.component('comp1').geom('geom1').feature('PT1FP3').label('PT1FP3');
    model.component('comp1').geom('geom1').feature('PT1G0').label('PT1G0');
    model.component('comp1').geom('geom1').feature('PT1GM1').label('PT1GM1');
    model.component('comp1').geom('geom1').feature('PT1GM2').label('PT1GM2');
    model.component('comp1').geom('geom1').feature('PT1GM3').label('PT1GM3');
    model.component('comp1').geom('geom1').feature('PT1GP1').label('PT1GP1');
    model.component('comp1').geom('geom1').feature('PT1GP2').label('PT1GP2');
    model.component('comp1').geom('geom1').feature('PT1GP3').label('PT1GP3');
    model.component('comp1').geom('geom1').feature('PT2A0').label('PT2A0');
    model.component('comp1').geom('geom1').feature('PT2AM1').label('PT2AM1');
    model.component('comp1').geom('geom1').feature('PT2AM2').label('PT2AM2');
    model.component('comp1').geom('geom1').feature('PT2AM3').label('PT2AM3');
    model.component('comp1').geom('geom1').feature('PT2AP1').label('PT2AP1');
    model.component('comp1').geom('geom1').feature('PT2AP2').label('PT2AP2');
    model.component('comp1').geom('geom1').feature('PT2AP3').label('PT2AP3');
    model.component('comp1').geom('geom1').feature('PT2B0').label('PT2B0');
    model.component('comp1').geom('geom1').feature('PT2BM1').label('PT2BM1');
    model.component('comp1').geom('geom1').feature('PT2BM2').label('PT2BM2');
    model.component('comp1').geom('geom1').feature('PT2BM3').label('PT2BM3');
    model.component('comp1').geom('geom1').feature('PT2BP1').label('PT2BP1');
    model.component('comp1').geom('geom1').feature('PT2BP2').label('PT2BP2');
    model.component('comp1').geom('geom1').feature('PT2BP3').label('PT2BP3');
    model.component('comp1').geom('geom1').feature('PT2C0').label('PT2C0');
    model.component('comp1').geom('geom1').feature('PT2CM1').label('PT2CM1');
    model.component('comp1').geom('geom1').feature('PT2CM2').label('PT2CM2');
    model.component('comp1').geom('geom1').feature('PT2CM3').label('PT2CM3');
    model.component('comp1').geom('geom1').feature('PT2CP1').label('PT2CP1');
    model.component('comp1').geom('geom1').feature('PT2CP2').label('PT2CP2');
    model.component('comp1').geom('geom1').feature('PT2CP3').label('PT2CP3');
    model.component('comp1').geom('geom1').feature('PT2D0').label('PT2D0');
    model.component('comp1').geom('geom1').feature('PT2DM1').label('PT2DM1');
    model.component('comp1').geom('geom1').feature('PT2DM2').label('PT2DM2');
    model.component('comp1').geom('geom1').feature('PT2DM3').label('PT2DM3');
    model.component('comp1').geom('geom1').feature('PT2DP1').label('PT2DP1');
    model.component('comp1').geom('geom1').feature('PT2DP2').label('PT2DP2');
    model.component('comp1').geom('geom1').feature('PT2DP3').label('PT2DP3');
    model.component('comp1').geom('geom1').feature('PT2E0').label('PT2E0');
    model.component('comp1').geom('geom1').feature('PT2EM1').label('PT2EM1');
    model.component('comp1').geom('geom1').feature('PT2EM2').label('PT2EM2');
    model.component('comp1').geom('geom1').feature('PT2EM3').label('PT2EM3');
    model.component('comp1').geom('geom1').feature('PT2EP1').label('PT2EP1');
    model.component('comp1').geom('geom1').feature('PT2EP2').label('PT2EP2');
    model.component('comp1').geom('geom1').feature('PT2EP3').label('PT2EP3');
    model.component('comp1').geom('geom1').feature('PT2F0').label('PT2F0');
    model.component('comp1').geom('geom1').feature('PT2FM1').label('PT2FM1');
    model.component('comp1').geom('geom1').feature('PT2FM2').label('PT2FM2');
    model.component('comp1').geom('geom1').feature('PT2FM3').label('PT2FM3');
    model.component('comp1').geom('geom1').feature('PT2FP1').label('PT2FP1');
    model.component('comp1').geom('geom1').feature('PT2FP2').label('PT2FP2');
    model.component('comp1').geom('geom1').feature('PT2FP3').label('PT2FP3');
    model.component('comp1').geom('geom1').feature('PT2G0').label('PT2G0');
    model.component('comp1').geom('geom1').feature('PT2GM1').label('PT2GM1');
    model.component('comp1').geom('geom1').feature('PT2GM2').label('PT2GM2');
    model.component('comp1').geom('geom1').feature('PT2GM3').label('PT2GM3');
    model.component('comp1').geom('geom1').feature('PT2GP1').label('PT2GP1');
    model.component('comp1').geom('geom1').feature('PT2GP2').label('PT2GP2');
    model.component('comp1').geom('geom1').feature('PT2GP3').label('PT2GP3');
    model.component('comp1').geom('geom1').feature('PT3').label('PT3');
        %}le 10/12/2020

    % Create materials
    
    model.component('comp1').material.create('mat1', 'Common', 'comp1');
    model.component('comp1').material('mat1').propertyGroup('def').set('electricconductivity', tlm.var.sig.MilOrga);
    model.component('comp1').material('mat1').propertyGroup('def').set('relpermittivity', tlm.var.eps.MilOrga/tlm.var.eps0);
    model.component('comp1').material('mat1').label('MilOrga');
    model.component('comp1').material('mat1').selection.set([2]);

    model.component('comp1').material.create('mat2', 'Common', 'comp1');
    model.component('comp1').material('mat2').propertyGroup('def').set('electricconductivity', tlm.var.sig.electrode);
    model.component('comp1').material('mat2').propertyGroup('def').set('relpermittivity', tlm.var.eps.electrode/tlm.var.eps0);
    model.component('comp1').material('mat2').label('electrode');
    model.component('comp1').material('mat2').selection.set([1 3]);
    
    tlm.conf.fig=tlm.conf.fig+1;
    figure(tlm.conf.fig);
    tlm.conf.fig=tlm.conf.fig+1;
    clf('reset');
    colormap(hot(256));
%    mphgeom(model);
    mphgeom(model,'geom1','domainlabels','off','vertexmode','on','edgelabels','on','facealpha',0.5);
    
    if tlm.conf.save==1
        saveas(tlm.conf.fig-1,'Geometry.emf');
    end
    figure(tlm.conf.fig);
    tlm.conf.fig=tlm.conf.fig+1;

    model.component('comp1').mesh('mesh1').autoMeshSize(tlm.conf.mesh);
    model.mesh('mesh1').run;

%    mphmesh(model);
    mphmesh(model,'mesh1','vertexlabels','on','facealpha',0.5);
    
    if tlm.conf.save==1
        saveas(tlm.conf.fig-1,'Mesh.emf');
    end

else
    % Import the microfluidic chamber geometry

model.geom('geom1').create('imp1', 'Import');
model.geom('geom1').feature('imp1').set('type', 'file');
model.geom('geom1').feature('imp1').set('filename', tlm.conf.step);
model.geom('geom1').run('imp1');

% Import the electrodes geometries

model.geom('geom1').create('imp2', 'Import');
model.geom('geom1').feature('imp2').set('type', 'file');
model.geom('geom1').feature('imp2').set('filename', tlm.conf.gds);
model.geom('geom1').run('imp2');

model.mesh('mesh1').autoMeshSize(tlm.conf.mesh);
model.mesh('mesh1').run;

    figure(1);
    clf('reset');
    mphmesh(model);
    mphmesh(model,'mesh1','vertexlabels','on');

%end
%create a simulation model named 'comp1'
%model.modelNode.create('comp1');

% set a label for the simaulation model
%model.modelNode('comp1').label('Simulation Spectre Impedance Electrique');

% create a 3D geometry called 'geom1'
%model.geom.create('geom1', 3);


%set a label for the geometry named 'geom1'
%model.geom('geom1').label('Integrated Microfluidique Device');

% Set the length unit
%model.geom('geom1').lengthUnit('m');

%create a 2D mesh named 'mesh1' for geometry named 'geom1'
%model.mesh.create('mesh1', 'geom1');





% COMSOL Version

%clear vrsn;

%vrsn.name = tlm.conf.nam;
%vrsn.ext = tlm.conf.ext;
%vrsn.major = tlm.conf.major;
%vrsn.build = tlm.conf.build;
%vrsn.rcs = tlm.conf.rcs;
%vrsn.date = tlm.conf.da;

%fem.version = vrsn;

% New geometry 1
fem.sdim={'x','y','z'};

% Geometry
clear s f c p

%The Chamber
if tlm.conf.Milo==1
    model.geom('geom1').create('blk1', 'Block');
    model.geom('geom1').feature('blk1').set('size', {'LongueurChambre' 'LargeurChambre' 'EpaisseurChambre'});

    model.geom('geom1').feature('blk1').set('pos', {'OrigineX-Center-LargeurChambre/2' 'OrigineY' 'OrigineZ' });
    model.geom('geom1').run;
    
    figure(1);
    tlm.conf.fig=tlm.conf.fig+1;
    clf('reset');
    colormap(hot(256));
    
    mphgeom(model);
    mphgeom(model,'geom1','domainlabels','off','vertexmode','on','edgelabels','on');

%    g1=block3(tlm.var.LongueurChambre,tlm.var.LargeurChambre, ...
%    tlm.var.EpaisseurChambre,'center',[tlm.var.OrigineX  ...
%    tlm.var.OrigineY+tlm.var.Center tlm.var.EpaisseurChambre/2],[0 0 1],0);
end

if tlm.conf.Milo==2
    if (tlm.conf.Cell==0 || tlm.conf.Cell==2)
        g1=block3(tlm.var.LongueurChambre,tlm.var.LargeurChambre, ...
        tlm.var.EpaisseurChambre,'center',[tlm.var.OrigineX  ...
        tlm.var.OrigineY+tlm.var.Center tlm.var.EpaisseurChambre/2],[0 0 1],0);
        g6=block3(tlm.var.LongueurChambre,tlm.var.LargeurChambre, ...
        tlm.var.EpaisseurChambre,'center',[+tlm.var.OrigineX  ...
        tlm.var.OrigineY-tlm.var.Center tlm.var.EpaisseurChambre/2],[0 0 1],0);
    else
        g11=block3(tlm.var.LongueurChambre,tlm.var.LargeurChambre, ...
        tlm.var.EpaisseurChambre,'center',[tlm.var.OrigineX  ...
        tlm.var.OrigineY+tlm.var.Center tlm.var.EpaisseurChambre/2],[0 0 1],0);
        if tlm.conf.Shape==0                    % spheroid cell
            s11=ellipsoid3(tlm.var.RayonXCellule(1), tlm.var.RayonYCellule(1), tlm.var.RayonZCellule(1), 'pos',[tlm.var.OrigineX+tlm.var.DecentrageYCellule(1)  ...
                  tlm.var.OrigineY+tlm.var.DecentrageXCellule(1) tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)],'axis',[0 0 1], 'rot',0);
            s11=rotate(s11,pi/2+tlm.var.Orientation.Cellule(1),[0,0,1],[tlm.var.OrigineX+tlm.var.DecentrageYCellule(1),tlm.var.OrigineY+tlm.var.DecentrageXCellule(1),...
                  tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)]);                                                     % rotate the cell around the y axis [0,1,0]
        end
        g1=geomcomp({g11,s11},'ns',{'g11','s11'},'sf','g11-s11','edge','none');
        g66=block3(tlm.var.LongueurChambre,tlm.var.LargeurChambre, ...
            tlm.var.EpaisseurChambre,'center',[+tlm.var.OrigineX  ...
            tlm.var.OrigineY-tlm.var.Center tlm.var.EpaisseurChambre/2],[0 0 1],0);
        if tlm.conf.Shape==0                    % spheroid cell
            s11=ellipsoid3(tlm.var.RayonXCellule(1), tlm.var.RayonYCellule(1), tlm.var.RayonZCellule(1), 'pos',[tlm.var.OrigineX+tlm.var.DecentrageYCellule(1)  ...
                  tlm.var.OrigineY+tlm.var.DecentrageXCellule(1) tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)],'axis',[0 0 1], 'rot',0);
            s11=rotate(s11,pi/2+tlm.var.Orientation.Cellule(1),[0,0,1],[tlm.var.OrigineX+tlm.var.DecentrageYCellule(1),tlm.var.OrigineY+tlm.var.DecentrageXCellule(1),...
                  tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)]);                                                     % rotate the cell around the y axis [0,1,0]
        end
        g6=geomcomp({g66,s11},'ns',{'g66','s11'},'sf','g66-s11','edge','none');
    end
end

%The left outer electrode
if tlm.conf.points==1
    g2=block3(tlm.var.LongueurElectrode,tlm.var.LargeurElectrode, ...
    tlm.var.EpaisseurMesure,'center',[tlm.var.OrigineX  ...
    tlm.var.OrigineY tlm.var.OrigineZ+tlm.var.EpaisseurMesure/2], ...
    [0 0 1],0);
elseif tlm.conf.points==2
    g2=block3(tlm.var.LongueurElectrode,tlm.var.LargeurElectrode, ...
    tlm.var.EpaisseurElectrode,'center',[tlm.var.OrigineX  ...
    tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2 tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/2], ...
    [0 0 1],0);
elseif tlm.conf.points==4
    model.geom('geom1').create('blk2', 'Block');
    model.geom('geom1').feature('blk2').set('size', {'LongueurElectrode' 'LargeurElectrode' 'EpaisseurElectrode'});

    model.geom('geom1').feature('blk2').set('pos', {'OrigineX-Center-LargeurChambre/2' 'OrigineY' 'OrigineZ' });
    model.geom('geom1').run;

%    g2=block3(tlm.var.LongueurElectrode,tlm.var.LargeurElectrode, ...
%    tlm.var.EpaisseurElectrode,'center',[tlm.var.OrigineX  ...
%    tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2 tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/2], ...
%    [0 0 1],0);
end

%The left inner electrode
if tlm.conf.points==4
    g3=block3(tlm.var.LongueurMesure,tlm.var.LargeurMesure, ...
    tlm.var.EpaisseurMesure,'center',[tlm.var.OrigineX  ...
    tlm.var.OrigineY-tlm.var.EcartementMesure/2-tlm.var.LargeurMesure/2 tlm.var.OrigineZ+tlm.var.EpaisseurMesure/2], ...
    [0 0 1],0);
end

%The right inner electrode
if tlm.conf.points==4
    g4=block3(tlm.var.LongueurMesure,tlm.var.LargeurMesure, ...
    tlm.var.EpaisseurMesure,'center',[tlm.var.OrigineX  ...
    tlm.var.OrigineY+tlm.var.EcartementMesure/2+tlm.var.LargeurMesure/2 tlm.var.OrigineZ+tlm.var.EpaisseurMesure/2], ...
    [0 0 1],0);
end

%The right outer electrode
if tlm.conf.points==1
    g5=block3(tlm.var.LongueurElectrode,tlm.var.LargeurElectrode, ...
    tlm.var.EpaisseurMesure,'center',[tlm.var.OrigineX  ...
    tlm.var.OrigineY tlm.var.OrigineZ+tlm.var.EpaisseurChambre-tlm.var.EpaisseurMesure/2], ...
    [0 0 1],0);
elseif tlm.conf.points==2
    g5=block3(tlm.var.LongueurElectrode,tlm.var.LargeurElectrode, ...
    tlm.var.EpaisseurElectrode,'center',[tlm.var.OrigineX  ...
    tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2 tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/2], ...
    [0 0 1],0);
elseif tlm.conf.points==4
    g5=block3(tlm.var.LongueurElectrode,tlm.var.LargeurElectrode, ...
    tlm.var.EpaisseurElectrode,'center',[tlm.var.OrigineX  ...
    tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2 tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/2], ...
    [0 0 1],0);
end

if tlm.conf.Cell==1 % One Cell

%The first cell 

    if tlm.conf.Shape==0                    % spheroid cell
        
        s1=ellipsoid3(tlm.var.RayonXCellule(1), tlm.var.RayonYCellule(1), tlm.var.RayonZCellule(1), 'pos',[tlm.var.OrigineX+tlm.var.DecentrageYCellule(1)  ...
                      tlm.var.OrigineY+tlm.var.DecentrageXCellule(1) tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)],'axis',[0 0 1], 'rot',0);
        s1=rotate(s1,pi/2+tlm.var.Orientation.Cellule(1),[0,0,1],[tlm.var.OrigineX+tlm.var.DecentrageYCellule(1),tlm.var.OrigineY+tlm.var.DecentrageXCellule(1),...
                  tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)]);                                                     % rotate the cell around the y axis [0,1,0]
       
    elseif tlm.conf.Shape==2                % arbitrary shaped cell
        cd(tlm.conf.result);
        mkdir(tlm.conf.Name);
        cd(tlm.conf.Name);
        [A]= xlsread(tlm.conf.XLS.Name,tlm.conf.XLS.Sheet);
        for i=1:1:61
            point(1,i)=(A(i,1)-A(1,1)-((A(61,1)-A(1,1))/2))*tlm.var.EpaisseurChambre/2;
            point(2,i)=A(i,2)*tlm.var.EpaisseurChambre/2+tlm.var.DecentrageZCellule(1);
        end
        carr={geomspline(point,'Closed','on','SplineMethod','centripetal')};
        E1a=geomcoerce('solid',carr);
        E1b=mirror(E1a,[0,tlm.var.DecentrageZCellule(1)],[0,1]);
        E1=geomcomp({E1a,E1b},'ns',{'E1a','E1b'},'sf','E1a+E1b','edge','none');
        E1=geomdel(E1);
        E1=scale(E1,1,1,0,0);
        E1=move(E1,[tlm.var.DecentrageXCellule(1),0]);
        E2=rect2(tlm.var.OrigineX-tlm.var.LargeurChambre/2,tlm.var.OrigineX+tlm.var.LargeurChambre/2,tlm.var.OrigineY,tlm.var.OrigineY+0.5*tlm.var.EpaisseurChambre);
        E3=geomcomp({E1,E2},'ns',{'E1','E2'},'sf','E1*E2','edge','none');
        E3=move(E3,[0,-tlm.var.DecentrageZCellule(1)]);
        p_wrkpln = geomgetwrkpln('quick',{'xy',tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)});
        s1=revolve(E3,'angles',[0,6.28318530717959],'revaxis',[0 0.6;0 0],'wrkpln',p_wrkpln);
        s1=rotate(s1,pi/2+tlm.var.Orientation.Cellule(1),[0,0,1],[tlm.var.OrigineX+tlm.var.DecentrageYCellule(1),tlm.var.OrigineY+tlm.var.DecentrageXCellule(1),...
                  tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)]);                                                     % rotate the cell around the y axis [0,1,0]
        cd(tlm.conf.src);
    elseif tlm.conf.Shape==1                % non spheroid cell
        rmax=0;
        for i=1:1:36
            r=tlm.var.sha0+tlm.var.sha1*cos(10*i*pi/180)+cos(10*i*pi/180)*cos(10*i*pi/180);
            if r>=rmax
                rmax=r;
%                    display(r);
            end
        end
        for i=1:1:36
            r=tlm.var.sha0+tlm.var.sha1*cos(10*i*pi/180)+cos(10*i*pi/180)*cos(10*i*pi/180);
            point(1,i)=r/rmax*cos(10*i*pi/180)*tlm.var.RayonXCellule(1);
            point(2,i)=r/rmax*sin(10*i*pi/180)*tlm.var.RayonYCellule(1)+tlm.var.DecentrageZCellule(1);
%                if 10*i==90
%                    display(point(1,i));
%                    display(point(2,i));
%                end
        end
        carr={geomspline(point,'Closed','on','SplineMethod','centripetal')};
        E1=geomcoerce('solid',carr);
        E1=geomdel(E1);
        E1=scale(E1,1,1,0,0);
        E1=move(E1,[tlm.var.DecentrageXCellule(1),0]);
        E2=rect2(tlm.var.OrigineX-tlm.var.LargeurChambre/2,tlm.var.OrigineX+tlm.var.LargeurChambre/2,tlm.var.OrigineY,tlm.var.OrigineY+0.5*tlm.var.EpaisseurChambre);
        E3=geomcomp({E1,E2},'ns',{'E1','E2'},'sf','E1*E2','edge','none');
        E3=move(E3,[0,-tlm.var.DecentrageZCellule(1)]);
        p_wrkpln = geomgetwrkpln('quick',{'xy',tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)});
        s1=revolve(E3,'angles',[0,6.28318530717959],'revaxis',[0 0.6;0 0],'wrkpln',p_wrkpln);
        s1=rotate(s1,pi/2+tlm.var.Orientation.Cellule(1),[0,0,1],[tlm.var.OrigineX+tlm.var.DecentrageYCellule(1),tlm.var.OrigineY+tlm.var.DecentrageXCellule(1),...
                  tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)]);                                                     % rotate the cell around the y axis [0,1,0]
    end
    
    tlm.var.NbSurfaceCell(1)=flgeomnbs(s1); % Number of edge (i.e.: line in 2D, surface in 3D) at the cell1 surface
    
%The nucleus of the first cell
    if tlm.conf.Nucleus==1
        s2=ellipsoid3(tlm.var.RayonXNoyau(1),tlm.var.RayonYNoyau(1), tlm.var.RayonZNoyau(1), 'pos',[tlm.var.OrigineX+tlm.var.DecentrageYCellule(1)+tlm.var.DecentrageYNoyau(1)  ...
                      tlm.var.OrigineY+tlm.var.DecentrageXCellule(1)+tlm.var.DecentrageXNoyau(1) tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)+tlm.var.DecentrageZNoyau(1)],'axis',[0 0 1], 'rot',0);
        s2=rotate(s2,tlm.var.Orientation.Cellule(1),[0,1,0],[tlm.var.OrigineX+tlm.var.DecentrageYCellule(1),tlm.var.OrigineY+tlm.var.DecentrageXCellule(1),...
                  tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)]);                                                     % rotate the cell around the y axis [0,1,0]
    end
    
%The mitochondria of the first cell
    if tlm.conf.Mitocho==1
        s3=ellipsoid3(tlm.var.RayonXMitoc(1),tlm.var.RayonYMitoc(1), tlm.var.RayonZMitoc(1), 'pos',[tlm.var.OrigineX+tlm.var.DecentrageYCellule(1)+tlm.var.DecentrageYMitoc(1)  ...
                      tlm.var.OrigineY+tlm.var.DecentrageXCellule(1)+tlm.var.DecentrageXMitoc(1) tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)+tlm.var.DecentrageZMitoc(1)],'axis',[0 0 1], 'rot',pi/4);
        s3=rotate(s3,tlm.var.Orientation.Cellule(1),[0,1,0],[tlm.var.OrigineX+tlm.var.DecentrageYCellule(1),tlm.var.OrigineY+tlm.var.DecentrageXCellule(1),...
                  tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)]);                                                     % rotate the cell around the y axis [0,1,0]
    end
    
elseif (tlm.conf.Cell==2) % Two Cells
    
%The first cell 

    if tlm.conf.Shape==0                    % spheroid cell
        
        s1=ellipsoid3(tlm.var.RayonXCellule(1), tlm.var.RayonYCellule(1), tlm.var.RayonZCellule(1), 'pos',[tlm.var.OrigineX+tlm.var.DecentrageYCellule(1)  ...
                      tlm.var.OrigineY+tlm.var.DecentrageXCellule(1) tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)],'axis',[0 0 1], 'rot',0);
        s1=rotate(s1,pi/2+tlm.var.Orientation.Cellule(1),[0,0,1],[tlm.var.OrigineX+tlm.var.DecentrageYCellule(1),tlm.var.OrigineY+tlm.var.DecentrageXCellule(1),...
                  tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)]);                                                     % rotate the cell around the y axis [0,1,0]
       
    elseif tlm.conf.Shape==2                % arbitrary shaped cell
        cd(tlm.conf.result);
        mkdir(tlm.conf.Name);
        cd(tlm.conf.Name);
        [A]= xlsread(tlm.conf.XLS.Name,tlm.conf.XLS.Sheet);
        for i=1:1:61
            point(1,i)=(A(i,1)-A(1,1)-((A(61,1)-A(1,1))/2))*tlm.var.EpaisseurChambre/2;
            point(2,i)=A(i,2)*tlm.var.EpaisseurChambre/2+tlm.var.DecentrageZCellule(1);
        end
        carr={geomspline(point,'Closed','on','SplineMethod','centripetal')};
        E1a=geomcoerce('solid',carr);
        E1b=mirror(E1a,[0,tlm.var.DecentrageZCellule(1)],[0,1]);
        E1=geomcomp({E1a,E1b},'ns',{'E1a','E1b'},'sf','E1a+E1b','edge','none');
        E1=geomdel(E1);
        E1=scale(E1,1,1,0,0);
        E1=move(E1,[tlm.var.DecentrageXCellule(1),0]);
        E2=rect2(tlm.var.OrigineX-tlm.var.LargeurChambre/2,tlm.var.OrigineX+tlm.var.LargeurChambre/2,tlm.var.OrigineY,tlm.var.OrigineY+0.5*tlm.var.EpaisseurChambre);
        E3=geomcomp({E1,E2},'ns',{'E1','E2'},'sf','E1*E2','edge','none');
        E3=move(E3,[0,-tlm.var.DecentrageZCellule(1)]);
        p_wrkpln = geomgetwrkpln('quick',{'xy',tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)});
        s1=revolve(E3,'angles',[0,6.28318530717959],'revaxis',[0 0.6;0 0],'wrkpln',p_wrkpln);
        s1=rotate(s1,pi/2+tlm.var.Orientation.Cellule(1),[0,0,1],[tlm.var.OrigineX+tlm.var.DecentrageYCellule(1),tlm.var.OrigineY+tlm.var.DecentrageXCellule(1),...
                  tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)]);                                                     % rotate the cell around the y axis [0,1,0]
        cd(tlm.conf.src);
    elseif tlm.conf.Shape==1                % non spheroid cell
        rmax=0;
        for i=1:1:36
            r=tlm.var.sha0+tlm.var.sha1*cos(10*i*pi/180)+cos(10*i*pi/180)*cos(10*i*pi/180);
            if r>=rmax
                rmax=r;
%                    display(r);
            end
        end
        for i=1:1:36
            r=tlm.var.sha0+tlm.var.sha1*cos(10*i*pi/180)+cos(10*i*pi/180)*cos(10*i*pi/180);
            point(1,i)=r/rmax*cos(10*i*pi/180)*tlm.var.RayonXCellule(1);
            point(2,i)=r/rmax*sin(10*i*pi/180)*tlm.var.RayonYCellule(1)+tlm.var.DecentrageZCellule(1);
%                if 10*i==90
%                    display(point(1,i));
%                    display(point(2,i));
%                end
        end
        carr={geomspline(point,'Closed','on','SplineMethod','centripetal')};
        E1=geomcoerce('solid',carr);
        E1=geomdel(E1);
        E1=scale(E1,1,1,0,0);
        E1=move(E1,[tlm.var.DecentrageXCellule(1),0]);
        E2=rect2(tlm.var.OrigineX-tlm.var.LargeurChambre/2,tlm.var.OrigineX+tlm.var.LargeurChambre/2,tlm.var.OrigineY,tlm.var.OrigineY+0.5*tlm.var.EpaisseurChambre);
        E3=geomcomp({E1,E2},'ns',{'E1','E2'},'sf','E1*E2','edge','none');
        E3=move(E3,[0,-tlm.var.DecentrageZCellule(1)]);
        p_wrkpln = geomgetwrkpln('quick',{'xy',tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)});
        s1=revolve(E3,'angles',[0,6.28318530717959],'revaxis',[0 0.6;0 0],'wrkpln',p_wrkpln);
        s1=rotate(s1,pi/2+tlm.var.Orientation.Cellule(1),[0,0,1],[tlm.var.OrigineX+tlm.var.DecentrageYCellule(1),tlm.var.OrigineY+tlm.var.DecentrageXCellule(1),...
                  tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)]);                                                     % rotate the cell around the y axis [0,1,0]
    end
    
    tlm.var.NbSurfaceCell(1)=flgeomnbs(s1); % Number of edge (i.e.: line in 2D, surface in 3D) at the cell1 surface
    
%The nucleus of the first cell
    if tlm.conf.Nucleus==1
        s2=ellipsoid3(tlm.var.RayonXNoyau(1),tlm.var.RayonYNoyau(1), tlm.var.RayonZNoyau(1), 'pos',[tlm.var.OrigineX+tlm.var.DecentrageYCellule(1)+tlm.var.DecentrageYNoyau(1)  ...
                      tlm.var.OrigineY+tlm.var.DecentrageXCellule(1)+tlm.var.DecentrageXNoyau(1) tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)+tlm.var.DecentrageZNoyau(1)],'axis',[0 0 1], 'rot',0);
        s2=rotate(s2,tlm.var.Orientation.Cellule(1),[0,1,0],[tlm.var.OrigineX+tlm.var.DecentrageYCellule(1),tlm.var.OrigineY+tlm.var.DecentrageXCellule(1),...
                  tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)]);                                                     % rotate the cell around the y axis [0,1,0]
    end
    
%The mitochondria of the first cell
    if tlm.conf.Mitocho==1
        s3=ellipsoid3(tlm.var.RayonXMitoc(1),tlm.var.RayonYMitoc(1), tlm.var.RayonZMitoc(1), 'pos',[tlm.var.OrigineX+tlm.var.DecentrageYCellule(1)+tlm.var.DecentrageYMitoc(1)  ...
                      tlm.var.OrigineY+tlm.var.DecentrageXCellule(1)+tlm.var.DecentrageXMitoc(1) tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)+tlm.var.DecentrageZMitoc(1)],'axis',[0 0 1], 'rot',pi/4);
        s3=rotate(s3,tlm.var.Orientation.Cellule(1),[0,1,0],[tlm.var.OrigineX+tlm.var.DecentrageYCellule(1),tlm.var.OrigineY+tlm.var.DecentrageXCellule(1),...
                  tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)]);                                                     % rotate the cell around the y axis [0,1,0]
    end
        
%The second cell 

    if tlm.conf.Shape==0                    % spheroid cell
        
        s4=ellipsoid3(tlm.var.RayonXCellule(2), tlm.var.RayonYCellule(2), tlm.var.RayonZCellule(1), 'pos',[tlm.var.OrigineX+tlm.var.DecentrageYCellule(2)  ...
                      tlm.var.OrigineY+tlm.var.DecentrageXCellule(2) tlm.var.OrigineZ+tlm.var.DecentrageZCellule(2)],'axis',[0 0 1], 'rot',0);
        s4=rotate(s4,pi/2+tlm.var.Orientation.Cellule(2),[0,0,1],[tlm.var.OrigineX+tlm.var.DecentrageYCellule(2),tlm.var.OrigineY+tlm.var.DecentrageXCellule(2),...
                  tlm.var.OrigineZ+tlm.var.DecentrageZCellule(2)]);                                                     % rotate the cell around the y axis [0,1,0]
       
    elseif tlm.conf.Shape==2                % arbitrary shaped cell
        cd(tlm.conf.result);
        mkdir(tlm.conf.Name);
        cd(tlm.conf.Name);
        [A]= xlsread(tlm.conf.XLS.Name,tlm.conf.XLS.Sheet);
        for i=1:1:61
            point(1,i)=(A(i,1)-A(1,1)-((A(61,1)-A(1,1))/2))*tlm.var.EpaisseurChambre/2;
            point(2,i)=A(i,2)*tlm.var.EpaisseurChambre/2+tlm.var.DecentrageZCellule(2);
        end
        carr={geomspline(point,'Closed','on','SplineMethod','centripetal')};
        E4a=geomcoerce('solid',carr);
        E4b=mirror(E4a,[0,tlm.var.DecentrageZCellule(2)],[0,1]);
        E4=geomcomp({E4a,E4b},'ns',{'E4a','E4b'},'sf','E4a+E4b','edge','none');
        E4=geomdel(E4);
        E4=scale(E4,1,1,0,0);
        E4=move(E4,[tlm.var.DecentrageXCellule(2),0]);
        E5=rect2(tlm.var.OrigineX-tlm.var.LargeurChambre/2,tlm.var.OrigineX+tlm.var.LargeurChambre/2,tlm.var.OrigineY,tlm.var.OrigineY+0.5*tlm.var.EpaisseurChambre);
        E6=geomcomp({E4,E5},'ns',{'E4','E5'},'sf','E4*E5','edge','none');
        E6=move(E6,[0,-tlm.var.DecentrageZCellule(2)]);
        p_wrkpln = geomgetwrkpln('quick',{'xy',tlm.var.OrigineZ+tlm.var.DecentrageZCellule(2)});
        s4=revolve(E6,'angles',[0,6.28318530717959],'revaxis',[0 0.6;0 0],'wrkpln',p_wrkpln);
        s4=rotate(s4,pi/2+tlm.var.Orientation.Cellule(2),[0,0,1],[tlm.var.OrigineX+tlm.var.DecentrageYCellule(2),tlm.var.OrigineY+tlm.var.DecentrageXCellule(2),...
                  tlm.var.OrigineZ+tlm.var.DecentrageZCellule(2)]);                                                     % rotate the cell around the y axis [0,1,0]
        cd(tlm.conf.src);
    elseif tlm.conf.Shape==1                % non spheroid cell
        rmax=0;
        for i=1:1:36
            r=tlm.var.sha0+tlm.var.sha1*cos(10*i*pi/180)+cos(10*i*pi/180)*cos(10*i*pi/180);
            if r>=rmax
                rmax=r;
%                    display(r);
            end
        end
        for i=1:1:36
            r=tlm.var.sha0+tlm.var.sha1*cos(10*i*pi/180)+cos(10*i*pi/180)*cos(10*i*pi/180);
            point(1,i)=r/rmax*cos(10*i*pi/180)*tlm.var.RayonXCellule(2);
            point(2,i)=r/rmax*sin(10*i*pi/180)*tlm.var.RayonYCellule(2)+tlm.var.DecentrageZCellule(2);
%                if 10*i==90
%                    display(point(1,i));
%                    display(point(2,i));
%                end
        end
        carr={geomspline(point,'Closed','on','SplineMethod','centripetal')};
        E4=geomcoerce('solid',carr);
        E4=geomdel(E4);
        E4=scale(E4,1,1,0,0);
        E4=move(E4,[tlm.var.DecentrageXCellule(2),0]);
        E5=rect2(tlm.var.OrigineX-tlm.var.LargeurChambre/2,tlm.var.OrigineX+tlm.var.LargeurChambre/2,tlm.var.OrigineY,tlm.var.OrigineY+0.5*tlm.var.EpaisseurChambre);
        E6=geomcomp({E4,E5},'ns',{'E4','E5'},'sf','E4*E5','edge','none');
        E6=move(E6,[0,-tlm.var.DecentrageZCellule(2)]);
        p_wrkpln = geomgetwrkpln('quick',{'xy',tlm.var.OrigineZ+tlm.var.DecentrageZCellule(2)});
        s4=revolve(E6,'angles',[0,6.28318530717959],'revaxis',[0 0.6;0 0],'wrkpln',p_wrkpln);
        s4=rotate(s4,pi/2+tlm.var.Orientation.Cellule(2),[0,0,1],[tlm.var.OrigineX+tlm.var.DecentrageYCellule(2),tlm.var.OrigineY+tlm.var.DecentrageXCellule(2),...
                  tlm.var.OrigineZ+tlm.var.DecentrageZCellule(2)]);                                                     % rotate the cell around the y axis [0,1,0]
    end
    
    tlm.var.NbSurfaceCell(2)=flgeomnbs(s4); % Number of edge (i.e.: line in 2D, surface in 3D) at the cell1 surface
    
%The nucleus of the second cell
    if tlm.conf.Nucleus==1
        s5=ellipsoid3(tlm.var.RayonXNoyau(2),tlm.var.RayonYNoyau(2), tlm.var.RayonZNoyau(2), 'pos',[tlm.var.OrigineX+tlm.var.DecentrageYCellule(2)+tlm.var.DecentrageYNoyau(2)  ...
                      tlm.var.OrigineY+tlm.var.DecentrageXCellule(2)+tlm.var.DecentrageXNoyau(2) tlm.var.OrigineZ+tlm.var.DecentrageZCellule(2)+tlm.var.DecentrageZNoyau(2)],'axis',[0 0 1], 'rot',0);
        s5=rotate(s5,tlm.var.Orientation.Cellule(2),[0,1,0],[tlm.var.OrigineX+tlm.var.DecentrageYCellule(2),tlm.var.OrigineY+tlm.var.DecentrageXCellule(2),...
                  tlm.var.OrigineZ+tlm.var.DecentrageZCellule(2)]);                                                     % rotate the cell around the y axis [0,1,0]
    end
    
%The mitochondria of the second cell
    if tlm.conf.Mitocho==1
        s6=ellipsoid3(tlm.var.RayonXMitoc(2),tlm.var.RayonYMitoc(2), tlm.var.RayonZMitoc(2), 'pos',[tlm.var.OrigineX+tlm.var.DecentrageYCellule(2)+tlm.var.DecentrageYMitoc(2)  ...
                      tlm.var.OrigineY+tlm.var.DecentrageXCellule(2)+tlm.var.DecentrageXMitoc(2) tlm.var.OrigineZ+tlm.var.DecentrageZCellule(2)+tlm.var.DecentrageZMitoc(2)],'axis',[0 0 1], 'rot',pi/4);
        s6=rotate(s6,tlm.var.Orientation.Cellule(2),[0,1,0],[tlm.var.OrigineX+tlm.var.DecentrageYCellule(2),tlm.var.OrigineY+tlm.var.DecentrageXCellule(2),...
                  tlm.var.OrigineZ+tlm.var.DecentrageZCellule(2)]);                                                     % rotate the cell around the y axis [0,1,0]
    end
    
end

if (tlm.conf.Cell==0 && tlm.conf.Milo==1)
    
        if  tlm.conf.points==1 || tlm.conf.points==2
            objs={g1,g2,g5};
            names={'CHAMBER','MESU1','MESU2'};
        elseif tlm.conf.points==4
            objs={g1,g2,g3,g4,g5};
            names={'CHAMBER','ELEC1','MESU1','MESU2','ELEC2'};
        end
        
elseif (tlm.conf.Cell==0 && tlm.conf.Milo==2)
    
        if  tlm.conf.points==1 || tlm.conf.points==2
            objs={g1,g2,g5,g6};
            names={'MEDIUM1','MESU1','MESU2','MEDIUM2'};
        elseif tlm.conf.points==4
            objs={g1,g2,g3,g4,g5,g6};
            names={'MEDIUM1','ELEC1','MESU1','MESU2','ELEC2','MEDIUM2'};
        end
        
elseif (tlm.conf.Cell==1 && tlm.conf.Milo==1)
    
    if (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1)
        if tlm.conf.points==1 || tlm.conf.points==2
            objs={g1,g2,g5,s1,s2,s3};
            names={'CHAMBER','ELEC1','ELEC2','CELL1','NUCLEUS1','MITOCHONDRIA1'};
        elseif tlm.conf.points==4
            objs={g1,g2,g3,g4,g5,s1,s2,s3};
            names={'CHAMBER','ELEC1','ELEC2','MESU1','MESU2','CELL1','NUCLEUS1','MITOCHONDRIA1'};
        end
    elseif (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0)
        if tlm.conf.points==1 || tlm.conf.points==2
            objs={g1,g2,g5,s1,s2};
            names={'CHAMBER','ELEC1','ELEC2','CELL1','NUCLEUS1'};
        elseif tlm.conf.points==4
            objs={g1,g2,g3,g4,g5,s1,s2};
            names={'CHAMBER','ELEC1','ELEC2','MESU1','MESU2','CELL1','NUCLEUS1'};
        end
    else
        if tlm.conf.points==1 || tlm.conf.points==2
            objs={g1,g2,g5,s1};
            names={'CHAMBER','ELEC1','ELEC2','CELL1'};
        elseif tlm.conf.points==4
            objs={g1,g2,g3,g4,g5,s1};
            names={'CHAMBER','ELEC1','ELEC2','MESU1','MESU2','CELL1'};
        end
    end
    
elseif (tlm.conf.Cell==1 && tlm.conf.Milo==2)
    
    if (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1)
        if tlm.conf.points==1 || tlm.conf.points==2
            objs={g1,g2,g3,g6,s1,s2,s3};
            names={'MEDIUM1','ELEC1','ELEC2','MEDIUM2','CELL1','NUCLEUS1','MITOCHONDRIA1'};
        elseif tlm.conf.points==4
            objs={g1,g2,g3,g4,g5,g6,s1,s2,s3};
            names={'MEDIUM1','ELEC1','ELEC2','MESU1','MESU2','MEDIUM2','CELL1','NUCLEUS1','MITOCHONDRIA1'};
        end
    elseif (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0)
        if tlm.conf.points==1 || tlm.conf.points==2
            objs={g1,g2,g3,g6,s1,s2};
            names={'MEDIUM1','ELEC1','ELEC2','MEDIUM2','CELL1','NUCLEUS1'};
        elseif tlm.conf.points==4
            objs={g1,g2,g3,g4,g5,g6,s1,s2};
            names={'MEDIUM1','ELEC1','ELEC2','MESU1','MESU2','MEDIUM2','CELL1','NUCLEUS1'};
        end
    else
        if tlm.conf.points==1 || tlm.conf.points==2
            objs={g1,g2,g5,g6,s1};
            names={'MEDIUM1','ELEC1','ELEC2','MEDIUM2','CELL1'};
        elseif tlm.conf.points==4
            objs={g1,g2,g3,g4,g5,g6,s1};
            names={'MEDIUM1','ELEC1','ELEC2','MESU1','MESU2','MEDIUM2','CELL1'};
        end
    end

elseif (tlm.conf.Cell==2 && tlm.conf.Milo==1)
    
    if (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1)
        if tlm.conf.points==1 || tlm.conf.points==2
            objs={g1,g2,g3,s1,s2,s3,s4,s5,s6};
            names={'CHAMBER','ELEC1','ELEC2','CELL1','NUCLEUS1','MITOCHONDRIA1','CELL2','NUCLEUS2','MITOCHONDRIA2'};
        elseif tlm.conf.points==4
            objs={g1,g2,g3,g4,g5,s1,s2,s3,s4,s5,s6};
            names={'CHAMBER','ELEC1','ELEC2','MESU1','MESU2','CELL1','NUCLEUS1','MITOCHONDRIA1','CELL2','NUCLEUS2','MITOCHONDRIA2'};
        end
    elseif (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0)
        if tlm.conf.points==1 || tlm.conf.points==2
            objs={g1,g2,g3,s1,s2,s4,s5};
            names={'CHAMBER','ELEC1','ELEC2','CELL1','NUCLEUS1','CELL2','NUCLEUS2'};
        elseif tlm.conf.points==4
            objs={g1,g2,g3,g4,g5,s1,s2,s4,s5};
            names={'CHAMBER','ELEC1','ELEC2','MESU1','MESU2','CELL1','NUCLEUS1','CELL2','NUCLEUS2'};
        end
    else
        if tlm.conf.points==1 || tlm.conf.points==2
            objs={g1,g2,g3,s1,s4};
            names={'CHAMBER','ELEC1','ELEC2','CELL1','CELL2'};
        elseif tlm.conf.points==4
            objs={g1,g2,g3,g4,g5,s1,s4};
            names={'CHAMBER','ELEC1','ELEC2','MESU1','MESU2','CELL1','CELL2'};
        end
    end

elseif (tlm.conf.Cell==2 && tlm.conf.Milo==2)
    
    if (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1)
        if tlm.conf.points==1 || tlm.conf.points==2
            objs={g1,g2,g3,g6,s1,s2,s3,s4,s5,s6};
            names={'MEDIUM1','ELEC1','ELEC2','MEDIUM2','CELL1','NUCLEUS1','MITOCHONDRIA1','CELL2','NUCLEUS2','MITOCHONDRIA2'};
        elseif tlm.conf.points==4
            objs={g1,g2,g3,g4,g5,g6,s1,s2,s3,s4,s5,s6};
            names={'MEDIUM1','ELEC1','ELEC2','MESU1','MESU2','MEDIUM2','CELL1','NUCLEUS1','MITOCHONDRIA1','CELL2','NUCLEUS2','MITOCHONDRIA2'};
        end
    elseif (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0)
        if tlm.conf.points==1 || tlm.conf.points==2
            objs={g1,g2,g3,g6,s1,s2,s4,s5};
            names={'MEDIUM1','ELEC1','ELEC2','MEDIUM2','CELL1','NUCLEUS1','CELL2','NUCLEUS2'};
        elseif tlm.conf.points==4
            objs={g1,g2,g3,g4,g5,g6,s1,s2,s4,s5};
            names={'MEDIUM1','ELEC1','ELEC2','MESU1','MESU2','MEDIUM2','CELL1','NUCLEUS1','CELL2','NUCLEUS2'};
        end
    else
        if tlm.conf.points==1 || tlm.conf.points==2
            objs={g1,g2,g3,g6,s1,s4};
            names={'MEDIUM1','ELEC1','ELEC2','MEDIUM2','CELL1','CELL2'};
        elseif tlm.conf.points==4
            objs={g1,g2,g3,g4,g5,g6,s1,s4};
            names={'MEDIUM1','ELEC1','ELEC2','MESU1','MESU2','MEDIUM2','CELL1','CELL2'};
        end
    end

end

s.objs=objs;
s.name=names;

objs={};
name={};
f.objs=objs;
f.name=name;

objs={};
name={};
c.objs=objs;
c.name=name;


%Point in the left outer electrode where there is the solicitation

if tlm.conf.points==1
    PT1=point3(tlm.var.OrigineX,tlm.var.OrigineY, ...
    tlm.var.OrigineZ+tlm.var.EpaisseurMesure/2);
    PT1A=point3(tlm.var.OrigineX-tlm.var.LongueurElectrode/8, ...
    tlm.var.OrigineY,tlm.var.OrigineZ+tlm.var.EpaisseurMesure/2);
    PT1B=point3(tlm.var.OrigineX+tlm.var.LongueurElectrode/8, ...
    tlm.var.OrigineY,tlm.var.OrigineZ+tlm.var.EpaisseurMesure/2);
    PT1C=point3(tlm.var.OrigineX-2*tlm.var.LongueurElectrode/8, ...
    tlm.var.OrigineY,tlm.var.OrigineZ+tlm.var.EpaisseurMesure/2);
    PT1D=point3(tlm.var.OrigineX+2*tlm.var.LongueurElectrode/8, ...
    tlm.var.OrigineY,tlm.var.OrigineZ+tlm.var.EpaisseurMesure/2);
    PT1E=point3(tlm.var.OrigineX-3*tlm.var.LongueurElectrode/8, ...
    tlm.var.OrigineY,tlm.var.OrigineZ+tlm.var.EpaisseurMesure/2);
    PT1F=point3(tlm.var.OrigineX+3*tlm.var.LongueurElectrode/8, ...
    tlm.var.OrigineY,tlm.var.OrigineZ+tlm.var.EpaisseurMesure/2);
elseif tlm.conf.points==2
    if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
        model.geom('geom1').create('PT1','Point');
        model.geom('geom1').feature('PT1').set('p',[tlm.var.OrigineX-tlm.var.LongueurChambre/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY,tlm.var.OrigineZ+tlm.var.EpaisseurChambre/2]);
%        PT1=point3(tlm.var.OrigineX,tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/2);
        for i=-3:1:3
            PT1A{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/8);
            PT1B{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+2*tlm.var.EpaisseurElectrode/8);
            PT1C{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+3*tlm.var.EpaisseurElectrode/8);
            PT1D{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+4*tlm.var.EpaisseurElectrode/8);
            PT1E{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+5*tlm.var.EpaisseurElectrode/8);
            PT1F{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+6*tlm.var.EpaisseurElectrode/8);
            PT1G{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+7*tlm.var.EpaisseurElectrode/8);
        end
    else
        PT1=point3(tlm.var.OrigineX,tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/2);
    end
elseif tlm.conf.points==4
    if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
        PT1=point3(tlm.var.OrigineX,tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/2);
        for i=-3:1:3
            PT1A{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/8);
            PT1B{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+2*tlm.var.EpaisseurElectrode/8);
            PT1C{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+3*tlm.var.EpaisseurElectrode/8);
            PT1D{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+4*tlm.var.EpaisseurElectrode/8);
            PT1E{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+5*tlm.var.EpaisseurElectrode/8);
            PT1F{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+6*tlm.var.EpaisseurElectrode/8);
            PT1G{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+7*tlm.var.EpaisseurElectrode/8);
        end
    else
        PT1=point3(tlm.var.OrigineX,tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/2);
    end
end

%Point in the left inner electrode called MESUR2

if tlm.conf.points==4
    PT2=point3(tlm.var.OrigineX,tlm.var.OrigineY-tlm.var.EcartementMesure/2-tlm.var.LargeurMesure/2, ...
    tlm.var.OrigineZ+tlm.var.EpaisseurMesure/2);
end

%Point in the right inner electrode called MESUR1

if tlm.conf.points==4
    PT3=point3(tlm.var.OrigineX,tlm.var.OrigineY+tlm.var.EcartementMesure/2+tlm.var.LargeurMesure/2, ...
    tlm.var.OrigineZ+tlm.var.EpaisseurMesure/2);
end

%Point in the right outer electrode where we set the ground

if tlm.conf.points==1
    PT4=point3(tlm.var.OrigineX,tlm.var.OrigineY, ...
    tlm.var.OrigineZ+tlm.var.EpaisseurChambre-tlm.var.EpaisseurMesure/2);
    PT4A=point3(tlm.var.OrigineX-1*tlm.var.LongueurElectrode/8, ...
    tlm.var.OrigineY,tlm.var.OrigineZ+tlm.var.EpaisseurChambre-tlm.var.EpaisseurMesure/2);
    PT4B=point3(tlm.var.OrigineX+1*tlm.var.LongueurElectrode/8, ...
    tlm.var.OrigineY,tlm.var.OrigineZ+tlm.var.EpaisseurChambre-tlm.var.EpaisseurMesure/2);
    PT4C=point3(tlm.var.OrigineX-2*tlm.var.LongueurElectrode/8, ...
    tlm.var.OrigineY,tlm.var.OrigineZ+tlm.var.EpaisseurChambre-tlm.var.EpaisseurMesure/2);
    PT4D=point3(tlm.var.OrigineX+2*tlm.var.LongueurElectrode/8, ...
    tlm.var.OrigineY,tlm.var.OrigineZ+tlm.var.EpaisseurChambre-tlm.var.EpaisseurMesure/2);
    PT4E=point3(tlm.var.OrigineX-3*tlm.var.LongueurElectrode/8, ...
    tlm.var.OrigineY,tlm.var.OrigineZ+tlm.var.EpaisseurChambre-tlm.var.EpaisseurMesure/2);
    PT4F=point3(tlm.var.OrigineX+3*tlm.var.LongueurElectrode/8, ...
    tlm.var.OrigineY,tlm.var.OrigineZ+tlm.var.EpaisseurChambre-tlm.var.EpaisseurMesure/2);
elseif tlm.conf.points==2
    if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
        PT4=point3(tlm.var.OrigineX,tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/2);
        for i=-3:1:3
            PT4A{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+tlm.var.EpaisseurChambre/8);
            PT4B{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+2*tlm.var.EpaisseurChambre/8);
            PT4C{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+3*tlm.var.EpaisseurChambre/8);
            PT4D{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+4*tlm.var.EpaisseurChambre/8);
            PT4E{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+5*tlm.var.EpaisseurChambre/8);
            PT4F{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+6*tlm.var.EpaisseurChambre/8);
            PT4G{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+7*tlm.var.EpaisseurChambre/8);
        end
    else
        PT4=point3(tlm.var.OrigineX,tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/2);
    end
elseif tlm.conf.points==4
    if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
        PT4=point3(tlm.var.OrigineX,tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/2);
        for i=-3:1:3
            PT4A{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+tlm.var.EpaisseurChambre/8);
            PT4B{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+2*tlm.var.EpaisseurChambre/8);
            PT4C{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+3*tlm.var.EpaisseurChambre/8);
            PT4D{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+4*tlm.var.EpaisseurChambre/8);
            PT4E{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+5*tlm.var.EpaisseurChambre/8);
            PT4F{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+6*tlm.var.EpaisseurChambre/8);
            PT4G{i+4}=point3(tlm.var.OrigineX+i*tlm.var.LongueurElectrode/8, ...
            tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2,tlm.var.OrigineZ+7*tlm.var.EpaisseurChambre/8);
        end
    else
        PT4=point3(tlm.var.OrigineX,tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/2);
    end
end
    
%Point that should be in the FIRST external organic medium (above the left outer electrode - Please check your configuration!)

if (tlm.conf.Cell==1 || tlm.conf.Cell==2)
    if tlm.conf.points~=1
        PT5=point3(tlm.var.OrigineX,tlm.var.OrigineY-tlm.var.Center,tlm.var.OrigineZ+tlm.var.EpaisseurChambre-tlm.var.Epsilon);
    else
        PT5=point3(tlm.var.OrigineX,tlm.var.OrigineY-tlm.var.Center,tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)+tlm.var.RayonZCellule(1)+tlm.var.Epsilon);
    end
else
    PT5=point3(tlm.var.OrigineX,tlm.var.OrigineY-tlm.var.Center,tlm.var.OrigineZ+tlm.var.EpaisseurChambre/2);
end

%Point that should be in the SECOND external organic medium (above the left outer electrode - Please check your configuration!)

if tlm.conf.Milo==2
    if (tlm.conf.Cell==1 || tlm.conf.Cell==2)
        if tlm.conf.points~=1
            PT12=point3(tlm.var.OrigineX,tlm.var.OrigineY+tlm.var.Center,tlm.var.OrigineZ+tlm.var.EpaisseurChambre-tlm.var.Epsilon);
        else
            PT12=point3(tlm.var.OrigineX,tlm.var.OrigineY+tlm.var.Center,tlm.var.OrigineZ+tlm.var.EpaisseurChambre-tlm.var.Epsilon);
        end
    else
        PT12=point3(tlm.var.OrigineX,tlm.var.OrigineY+tlm.var.Center,tlm.var.OrigineZ+tlm.var.EpaisseurChambre/2);
    end
end

if tlm.conf.Cell==1 % One Cell

%Point that should be in the Cytoplasm of the first cell (please check your configuration)

    PT6=point3(tlm.var.OrigineX+tlm.var.DecentrageYCellule(1), ...
               tlm.var.OrigineY+tlm.var.DecentrageXCellule(1),tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1));
    PT6=rotate(PT6,tlm.var.Orientation.Cellule(1),[0,1,0],[tlm.var.OrigineX+tlm.var.DecentrageYCellule(1),tlm.var.OrigineY+tlm.var.DecentrageXCellule(1),...
                  tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)]);                                                     % rotate the point around the y axis [0,1,0]

%Point in the Nucleus of the first cell

    if tlm.conf.Nucleus==1
        PT7=point3(tlm.var.OrigineX+tlm.var.DecentrageYCellule(1)+tlm.var.DecentrageYNoyau(1), ...
                   tlm.var.OrigineY+tlm.var.DecentrageXCellule(1)+tlm.var.DecentrageXNoyau(1), ...
                   tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)+tlm.var.DecentrageZNoyau(1));
        PT7=rotate(PT7,tlm.var.Orientation.Cellule(1),[0,1,0],[tlm.var.OrigineX+tlm.var.DecentrageYCellule(1),tlm.var.OrigineY+tlm.var.DecentrageXCellule(1),...
                   tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)]);                                                     % rotate the point around the y axis [0,1,0]
    end

%Point in the Mitochondria of the first cell

    if tlm.conf.Mitocho==1
        PT8=point3(tlm.var.OrigineX+tlm.var.DecentrageYCellule(1)+tlm.var.DecentrageYMitoc(1), ...
                   tlm.var.OrigineY+tlm.var.DecentrageXCellule(1)+tlm.var.DecentrageXMitoc(1), ...
                   tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)+tlm.var.DecentrageZMitoc(1));
        PT8=rotate(PT8,tlm.var.Orientation.Cellule(1),[0,1,0],[tlm.var.OrigineX+tlm.var.DecentrageYCellule(1),tlm.var.OrigineY+tlm.var.DecentrageXCellule(1),...
                   tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)]);                                                     % rotate the point around the y axis [0,1,0]
    end
    
elseif tlm.conf.Cell==2 % Two Cells

%Point that should be in the Cytoplasm of the first cell (please check your configuration)

    PT6=point3(tlm.var.OrigineX+tlm.var.DecentrageYCellule(1), ...
               tlm.var.OrigineY+tlm.var.DecentrageXCellule(1),tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1));
    PT6=rotate(PT6,tlm.var.Orientation.Cellule(1),[0,1,0],[tlm.var.OrigineX+tlm.var.DecentrageYCellule(1),tlm.var.OrigineY+tlm.var.DecentrageXCellule(1),...
                   tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)]);                                                     % rotate the point around the y axis [0,1,0]

%Point in the Nucleus of the first cell

    if tlm.conf.Nucleus==1
        PT7=point3(tlm.var.OrigineX+tlm.var.DecentrageYCellule(1)+tlm.var.DecentrageYNoyau(1), ...
                   tlm.var.OrigineY+tlm.var.DecentrageXCellule(1)+tlm.var.DecentrageXNoyau(1), ...
                   tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)+tlm.var.DecentrageZNoyau(1));
        PT7=rotate(PT7,tlm.var.Orientation.Cellule(1),[0,1,0],[tlm.var.OrigineX+tlm.var.DecentrageYCellule(1),tlm.var.OrigineY+tlm.var.DecentrageXCellule(1),...
                   tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)]);                                                     % rotate the point around the y axis [0,1,0]
    end

%Point in the Mitochondria of the first cell

    if tlm.conf.Mitocho==1
        PT8=point3(tlm.var.OrigineX+tlm.var.DecentrageYCellule(1)+tlm.var.DecentrageYMitoc(1), ...
                   tlm.var.OrigineY+tlm.var.DecentrageXCellule(1)+tlm.var.DecentrageXMitoc(1), ...
                   tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)+tlm.var.DecentrageZMitoc(1));
        PT8=rotate(PT8,tlm.var.Orientation.Cellule(1),[0,1,0],[tlm.var.OrigineX+tlm.var.DecentrageYCellule(1),tlm.var.OrigineY+tlm.var.DecentrageXCellule(1),...
                   tlm.var.OrigineZ+tlm.var.DecentrageZCellule(1)]);                                                     % rotate the point around the y axis [0,1,0]
    end
    
%Point that should be in the Cytoplasm of the second cell (please check your configuration)

    PT9=point3(tlm.var.OrigineX+tlm.var.DecentrageYCellule(2), ...
               tlm.var.OrigineY+tlm.var.DecentrageXCellule(2),tlm.var.OrigineZ+tlm.var.DecentrageZCellule(2));
    PT9=rotate(PT9,tlm.var.Orientation.Cellule(2),[0,1,0],[tlm.var.OrigineX+tlm.var.DecentrageYCellule(2),tlm.var.OrigineY+tlm.var.DecentrageXCellule(2),...
                   tlm.var.OrigineZ+tlm.var.DecentrageZCellule(2)]);                                                     % rotate the point around the y axis [0,1,0]

%Point in the Nucleus of the second cell

    if tlm.conf.Nucleus==1
        PT10=point3(tlm.var.OrigineX+tlm.var.DecentrageYCellule(2)+tlm.var.DecentrageYNoyau(2), ...
                    tlm.var.OrigineY+tlm.var.DecentrageXCellule(2)+tlm.var.DecentrageXNoyau(2), ...
                    tlm.var.OrigineZ+tlm.var.DecentrageZCellule(2)+tlm.var.DecentrageZNoyau(2));
        PT10=rotate(PT10,tlm.var.Orientation.Cellule(2),[0,1,0],[tlm.var.OrigineX+tlm.var.DecentrageYCellule(2),tlm.var.OrigineY+tlm.var.DecentrageXCellule(2),...
                   tlm.var.OrigineZ+tlm.var.DecentrageZCellule(2)]);                                                     % rotate the point around the y axis [0,1,0]
    end

%Point in the Mitochondria of the first cell

    if tlm.conf.Mitocho==1
        PT11=point3(tlm.var.OrigineX+tlm.var.DecentrageYCellule(2)+tlm.var.DecentrageYMitoc(2), ...
                    tlm.var.OrigineY+tlm.var.DecentrageXCellule(2)+tlm.var.DecentrageXMitoc(2), ...
                    tlm.var.OrigineZ+tlm.var.DecentrageZCellule(2)+tlm.var.DecentrageZMitoc(2));
        PT11=rotate(PT11,tlm.var.Orientation.Cellule(2),[0,1,0],[tlm.var.OrigineX+tlm.var.DecentrageYCellule(2),tlm.var.OrigineY+tlm.var.DecentrageXCellule(2),...
                   tlm.var.OrigineZ+tlm.var.DecentrageZCellule(2)]);                                                     % rotate the point around the y axis [0,1,0]
    end
    
end

if (tlm.conf.Cell==0 && tlm.conf.Milo==1)
    
    if tlm.conf.points==1
        objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5};
        names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5'};
    elseif tlm.conf.points==2
        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
            objs={PT5, ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
            names={'PT5', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
        else
            objs={PT1,PT4,PT5};
            names={'PT1','PT4','PT5'};
        end
    elseif tlm.conf.points==4   
        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
            objs={PT2,PT3,PT5, ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
            names={'PT2','PT3','PT5', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
        else
            objs={PT1,PT2,PT3,PT4,PT5};
            names={'PT1','PT2','PT3','PT4','PT5'};
        end
    end
    
elseif (tlm.conf.Cell==0 && tlm.conf.Milo==2)
    
    if tlm.conf.points==1 % This case is not possible (triple points)
    elseif tlm.conf.points==2
        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
            objs={PT5,PT12, ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
            names={'PT2','PT3','PT5','PT12', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
        else
            objs={PT1,PT4,PT5,PT12};
            names={'PT1','PT4','PT5','PT12'};
        end
    elseif tlm.conf.points==4
        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
            objs={PT2,PT3,PT5,PT12, ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
            names={'PT2','PT3','PT5','PT12', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
        else
            objs={PT1,PT2,PT3,PT4,PT5,PT12};
            names={'PT1','PT2','PT3','PT4','PT5','PT12'};
        end
    end

elseif (tlm.conf.Cell==1 && tlm.conf.Milo==1)
    
    if (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1)
        if tlm.conf.points==1
            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT8};
            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F''PT6','PT7','PT8'};    
        elseif tlm.conf.points==2
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT5,PT6,PT7,PT8, ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
                names={'PT5','PT6','PT7','PT8', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
            else
                objs={PT1,PT4,PT5,PT6,PT7,PT8};
                names={'PT1','PT2','PT3','PT6','PT7','PT8'};
            end
        elseif tlm.conf.points==4
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT2,PT3,PT5,PT6,PT7,PT8, ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
                names={'PT2','PT3','PT5','PT6','PT7','PT8', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
            else
                objs={PT1,PT2,PT3,PT4,PT5,PT6,PT7,PT8};
                names={'PT1','PT2','PT3','PT4','PT5','PT6','PT7','PT8'};
            end
        end
    elseif (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0)
        if tlm.conf.points==1
            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7};
            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F''PT6','PT7'};    
        elseif tlm.conf.points==2
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT5,PT6,PT7, ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
                names={'PT5','PT6','PT7', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
            else
                objs={PT1,PT4,PT5,PT6,PT7};
                names={'PT1','PT2','PT3','PT6','PT7'};
            end
        elseif tlm.conf.points==4
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT2,PT3,PT5,PT6,PT7, ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
                names={'PT2','PT3','PT5','PT6','PT7', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
            else
                objs={PT1,PT2,PT3,PT4,PT5,PT6,PT7};
                names={'PT1','PT2','PT3','PT4','PT5','PT6','PT7'};
            end
        end
    else
        if tlm.conf.points==1
            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6};
            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT6'};    
        elseif tlm.conf.points==2
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT5,PT6, ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
                names={'PT5','PT6', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
            else
                objs={PT1,PT4,PT5,PT6};
                names={'PT1','PT4','PT5','PT6'};
            end
        elseif tlm.conf.points==4
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT2,PT3,PT5,PT6, ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
                names={'PT2','PT3','PT5','PT6', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
            else
                objs={PT1,PT2,PT3,PT4,PT5,PT6};
                names={'PT1','PT2','PT3','PT4','PT5','PT6'};
            end
        end
    end
    
elseif (tlm.conf.Cell==1 && tlm.conf.Milo==2)
    
    if (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1)
        if tlm.conf.points==1
            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT8,PT12};
            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F''PT6','PT7','PT8','PT12'};    
        elseif tlm.conf.points==2
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT5,PT6,PT7,PT8,PT12, ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
                names={'PT5','PT6','PT7','PT8','PT12', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
            else
                objs={PT1,PT4,PT5,PT6,PT7,PT8,PT12};
                names={'PT1','PT2','PT3','PT6','PT7','PT8','PT12'};
            end
        elseif tlm.conf.points==4
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT2,PT3,PT5,PT6,PT7,PT8,PT12, ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
                names={'PT2','PT3','PT5','PT6','PT7','PT8','PT12', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
            else
                objs={PT1,PT2,PT3,PT4,PT5,PT6,PT7,PT8,PT12};
                names={'PT1','PT2','PT3','PT4','PT5','PT6','PT7','PT8','PT12'};
            end
        end
    elseif (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0)
        if tlm.conf.points==1
            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT12};
            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F''PT6','PT7','PT12'};    
        elseif tlm.conf.points==2
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT5,PT6,PT7,PT12 ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
                names={'PT5','PT6','PT7','PT12', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
            else
                objs={PT1,PT4,PT5,PT6,PT7,PT12};
                names={'PT1','PT2','PT3','PT6','PT7','PT12'};
            end
        elseif tlm.conf.points==4
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT2,PT3,PT5,PT6,PT7,PT12, ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
                names={'PT2','PT3','PT5','PT6','PT7','PT12', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
            else
                objs={PT1,PT2,PT3,PT4,PT5,PT6,PT7,PT12};
                names={'PT1','PT2','PT3','PT4','PT5','PT6','PT7','PT12'};
            end
        end
    else
        if tlm.conf.points==1
            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT12};
            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F''PT6','PT12'};    
        elseif tlm.conf.points==2
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT5,PT6,PT12, ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
                names={'PT5','PT6','PT12', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
            else
                objs={PT1,PT4,PT5,PT6,PT12};
                names={'PT1','PT2','PT3','PT6','PT12'};
            end
        elseif tlm.conf.points==4
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT2,PT3,PT5,PT6,PT12, ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
                names={'PT2','PT3','PT5','PT6','PT12', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
            else
                objs={PT1,PT2,PT3,PT4,PT5,PT6,PT12};
                names={'PT1','PT2','PT3','PT4','PT5','PT6','PT12'};
            end
        end
    end
    
elseif (tlm.conf.Cell==2 && tlm.conf.Milo==1)
    
    if (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1)
        if tlm.conf.points==1
            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT8,PT9,PT10,PT11};
            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT6','PT7','PT8','PT9','PT10','PT11'};    
        elseif tlm.conf.points==2
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT5,PT6,PT7,PT8,PT9,PT10,PT11, ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
                names={'PT5','PT6','PT7','PT8','PT9','PT10','PT11', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
            else
                objs={PT1,PT4,PT5,PT6,PT7,PT8,PT9,PT10,PT11};
                names={'PT1','PT2','PT3','PT6','PT7','PT8','PT9','PT10','PT11'};
            end
        elseif tlm.conf.points==4
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT2,PT3,PT5,PT6,PT7,PT8,PT9,PT10,PT11, ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
                names={'PT2','PT3','PT5','PT6','PT7','PT8','PT9','PT10','PT11', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
            else
                objs={PT1,PT2,PT3,PT4,PT5,PT6,PT7,PT8,PT9,PT10,PT11};
                names={'PT1','PT2','PT3','PT4','PT5','PT6','PT7','PT8','PT9','PT10','PT11'};
            end
        end
    elseif (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0)
        if tlm.conf.points==1
            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT9,PT10};
            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F''PT6','PT7','PT9','PT10'};    
        elseif tlm.conf.points==2
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT5,PT6,PT7,PT9,PT10, ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
                names={'PT5','PT6','PT7','PT9','PT10', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
            else
                objs={PT1,PT4,PT5,PT6,PT7,PT9,PT10};
                names={'PT1','PT2','PT3','PT6','PT7','PT9','PT10'};
            end
        elseif tlm.conf.points==4
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT2,PT3,PT5,PT6,PT7,PT9,PT10, ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
                names={'PT2','PT3','PT5','PT6','PT7','PT9','PT10', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
            else
                objs={PT1,PT2,PT3,PT4,PT5,PT6,PT7,PT9,PT10};
                names={'PT1','PT2','PT3','PT4','PT5','PT6','PT7','PT9','PT10'};
            end
        end
    else
        if tlm.conf.points==1
            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT9};
            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F''PT6','PT9'};    
        elseif tlm.conf.points==2
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT5,PT6,PT9, ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
                names={'PT5','PT6','PT9', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
            else
                objs={PT1,PT4,PT5,PT6,PT9};
                names={'PT1','PT2','PT3','PT6','PT9'};
            end
        elseif tlm.conf.points==4
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT2,PT3,PT5,PT6,PT9, ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
                names={'PT2','PT3','PT5','PT6','PT9', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
            else
                objs={PT1,PT2,PT3,PT4,PT5,PT6,PT9};
                names={'PT1','PT2','PT3','PT4','PT5','PT6','PT9'};
            end
        end
    end

elseif (tlm.conf.Cell==2 && tlm.conf.Milo==2)
    
    if (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1)
        if tlm.conf.points==1
            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT8,PT9,PT10,PT11,PT12};
            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT6','PT7','PT8','PT9','PT10','PT11','PT12'};    
        elseif tlm.conf.points==2
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT5,PT6,PT7,PT8,PT9,PT10,PT11,PT12 ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
                names={'PT5','PT6','PT7','PT8','PT9','PT10','PT11','PT12', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
            else
                objs={PT1,PT4,PT5,PT6,PT7,PT8,PT9,PT10,PT11,PT12};
                names={'PT1','PT2','PT3','PT6','PT7','PT8','PT9','PT10','PT11','PT12'};
            end
        elseif tlm.conf.points==4
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT2,PT3,PT5,PT6,PT7,PT8,PT9,PT10,PT11,PT12 ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
                names={'PT2','PT3','PT5','PT6','PT7','PT8','PT9','PT10','PT11','PT12', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
            else
                objs={PT1,PT2,PT3,PT4,PT5,PT6,PT7,PT8,PT9,PT10,PT11,PT12};
                names={'PT1','PT2','PT3','PT4','PT5','PT6','PT7','PT8','PT9','PT10','PT11','PT12'};
            end
        end
    elseif (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0)
        if tlm.conf.points==1
            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT9,PT10,PT12};
            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F''PT6','PT7','PT9','PT10','PT12'};    
        elseif tlm.conf.points==2
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT5,PT6,PT7,PT9,PT10,PT12 ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
                names={'PT5','PT6','PT7','PT9','PT10','PT12', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
            else
                objs={PT1,PT4,PT5,PT6,PT7,PT9,PT10,PT12};
                names={'PT1','PT2','PT3','PT6','PT7','PT9','PT10','PT12'};
            end
        elseif tlm.conf.points==4
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT2,PT3,PT5,PT6,PT7,PT9,PT10,PT12, ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
                names={'PT2','PT3','PT5','PT6','PT7','PT9','PT10','PT12', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
            else
                objs={PT1,PT2,PT3,PT4,PT5,PT6,PT7,PT9,PT10,PT12};
                names={'PT1','PT2','PT3','PT4','PT5','PT6','PT7','PT9','PT10','PT12'};
            end
        end
    else
        if tlm.conf.points==1
            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT9,PT12};
            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F''PT6','PT9','PT12'};    
        elseif tlm.conf.points==2
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT5,PT6,PT9,PT12, ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
                names={'PT5','PT6','PT9','PT12', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
            else
                objs={PT1,PT4,PT5,PT6,PT9,PT12};
                names={'PT1','PT2','PT3','PT6','PT9','PT12'};
            end
        elseif tlm.conf.points==4
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT2,PT3,PT5,PT6,PT9,PT12, ...
                  PT1A{1},PT1B{1},PT1C{1},PT1D{1},PT1E{1},PT1F{1},PT1G{1},PT4A{1},PT4B{1},PT4C{1},PT4D{1},PT4E{1},PT4F{1},PT4G{1}, ...
                  PT1A{2},PT1B{2},PT1C{2},PT1D{2},PT1E{2},PT1F{2},PT1G{2},PT4A{2},PT4B{2},PT4C{2},PT4D{2},PT4E{2},PT4F{2},PT4G{2}, ...
                  PT1A{3},PT1B{3},PT1C{3},PT1D{3},PT1E{3},PT1F{3},PT1G{3},PT4A{3},PT4B{3},PT4C{3},PT4D{3},PT4E{3},PT4F{3},PT4G{3}, ...
                  PT1A{4},PT1B{4},PT1C{4},PT1D{4},PT1E{4},PT1F{4},PT1G{4},PT4A{4},PT4B{4},PT4C{4},PT4D{4},PT4E{4},PT4F{4},PT4G{4}, ...
                  PT1A{5},PT1B{5},PT1C{5},PT1D{5},PT1E{5},PT1F{5},PT1G{5},PT4A{5},PT4B{5},PT4C{5},PT4D{5},PT4E{5},PT4F{5},PT4G{5}, ...
                  PT1A{6},PT1B{6},PT1C{6},PT1D{6},PT1E{6},PT1F{6},PT1G{6},PT4A{6},PT4B{6},PT4C{6},PT4D{6},PT4E{6},PT4F{6},PT4G{6}, ...
                  PT1A{7},PT1B{7},PT1C{7},PT1D{7},PT1E{7},PT1F{7},PT1G{7},PT4A{7},PT4B{7},PT4C{7},PT4D{7},PT4E{7},PT4F{7},PT4G{7}};
                names={'PT2','PT3','PT5','PT6','PT9','PT12', ...
                   'PT1A1','PT1B1','PT1C1','PT1D1','PT1E1','PT1F1','PT1G1','PT4A1','PT4B1','PT4C1','PT4D1','PT4E1','PT4F1','PT4G1', ...
                   'PT1A2','PT1B2','PT1C2','PT1D2','PT1E2','PT1F2','PT1G2','PT4A2','PT4B2','PT4C2','PT4D2','PT4E2','PT4F2','PT4G2', ...
                   'PT1A3','PT1B3','PT1C3','PT1D3','PT1E3','PT1F3','PT1G3','PT4A3','PT4B3','PT4C3','PT4D3','PT4E3','PT4F3','PT4G3', ...
                   'PT1A4','PT1B4','PT1C4','PT1D4','PT1E4','PT1F4','PT1G4','PT4A4','PT4B4','PT4C4','PT4D4','PT4E4','PT4F4','PT4G4', ...
                   'PT1A5','PT1B5','PT1C5','PT1D5','PT1E5','PT1F5','PT1G5','PT4A5','PT4B5','PT4C5','PT4D5','PT4E5','PT4F5','PT4G5', ...
                   'PT1A6','PT1B6','PT1C6','PT1D6','PT1E6','PT1F6','PT1G6','PT4A6','PT4B6','PT4C6','PT4D6','PT4E6','PT4F6','PT4G6', ...
                   'PT1A7','PT1B7','PT1C7','PT1D7','PT1E7','PT1F7','PT1G7','PT4A7','PT4B7','PT4C7','PT4D7','PT4E7','PT4F7','PT4G7'};
            else
                objs={PT1,PT2,PT3,PT4,PT5,PT6,PT9,PT12};
                names={'PT1','PT2','PT3','PT4','PT5','PT6','PT9','PT12'};
            end
        end
    end

end

p.objs=objs;
p.name=names;

drawstruct=struct('s',s,'f',f,'c',c,'p',p);
fem.draw=drawstruct;
fem.geom=geomcsg(fem);

%Properties of each domains

fem.const={'sig_Electrode',num2str(tlm.var.sig.electrode),'sig_Milorga',num2str(tlm.var.sig.MilOrga),'sig_Milorgb',num2str(tlm.var.sig.MilOrgb),'sig_Cytoplasme1',num2str(tlm.var.sig.Cytoplasme(1)), ...
           'sig_Nucleus1',num2str(tlm.var.sig.Nucleus(1)),'sig_Mitocho1',num2str(tlm.var.sig.Mitocho(1)),'sig_Cytoplasme2',num2str(tlm.var.sig.Cytoplasme(2)), ...
           'sig_Nucleus2',num2str(tlm.var.sig.Nucleus(2)),'sig_Mitocho2',num2str(tlm.var.sig.Mitocho(2)),'eps_Electrode',num2str(tlm.var.eps.electrode/tlm.var.eps0), ...
           'eps_Milorga',num2str(tlm.var.eps.MilOrga/tlm.var.eps0),'eps_Milorgb',num2str(tlm.var.eps.MilOrgb/tlm.var.eps0),'eps_Cytoplasme1',num2str(tlm.var.eps.Cytoplasme(1)/tlm.var.eps0), ...
           'eps_Nucleus1',num2str(tlm.var.eps.Nucleus(1)/tlm.var.eps0),'eps_Mitocho1',num2str(tlm.var.eps.Mitocho(1)/tlm.var.eps0), ...
           'eps_Cytoplasme2',num2str(tlm.var.eps.Cytoplasme(2)/tlm.var.eps0),'eps_Nucleus2',num2str(tlm.var.eps.Nucleus(2)/tlm.var.eps0), ...
           'eps_Mitocho2',num2str(tlm.var.eps.Mitocho(2)/tlm.var.eps0)};


%Plot the geometry
if (tlm.conf.figure==1)
    figure(1);
    clf('reset');
    %geomplot(fem,'Sublabels','off', 'Pointmode','off', 'Facemode','on','Facelabels','on');
    %geomplot(fem,'Sublabels','off', 'Pointlabels','off', 'Pointmode','off','Facemode','off','Facelabels','on','Edgelabels','off'), axis equal
    geomplot(fem,'transparency',1,'camlight','on','renderer','opengl','axisvisible','off','Facemode','off','Facelabels','on');
    if tlm.conf.save==1
        saveas(1,'Geometry.emf');
    end
end

[gd,no,rng,ud,nbs]=geominfo(fem.geom,'out',{'gd' 'no' 'rng' 'ud' 'nbs'},'od',0:3);

% Initialize mesh
if tlm.conf.mesh==1
    
    %Fine
    fem.mesh=meshinit(fem, ...
                  'hmax',[], ...
                  'hmaxfact',0.8, ...
                  'hcutoff',0.02, ...
                  'hgrad',1.45, ...
                  'hcurve',0.5, ...
                  'hnarrow',0.6, ...
                  'hpnt',20, ...
                  'xscale',1.0, ...
                  'yscale',1.0, ...
                  'zscale',1.0, ...
                  'jiggle','on', ...
                  'mlevel','sub', ...
                  'hgradfac',[9,2]);

elseif tlm.conf.mesh==2    
    
    %Normal mesh
    fem.mesh=meshinit(fem, ...
                  'hmax',[], ...
                  'hmaxfact',1, ...
                  'hcutoff',0.035, ...
                  'hgrad',1.5, ...
                  'hcurve',0.4, ...
                  'hnarrow',1, ...
                  'hpnt',20, ...
                  'xscale',1.0, ...
                  'yscale',1.0, ...
                  'zscale',1.0, ...
                  'jiggle','on', ...
                  'mlevel','sub', ...
                  'hgradfac',[9,2]);
elseif tlm.conf.mesh==3
    
    % coarse mesh
    fem.mesh=meshinit(fem, ...
                  'hmax',[], ...
                  'hmaxfact',1.5, ...
                  'hcutoff',0.04, ...
                  'hgrad',1.6, ...
                  'hcurve',0.4, ...
                  'hnarrow',0.4, ...
                  'hpnt',20, ...
                  'xscale',1.0, ...
                  'yscale',1.0, ...
                  'zscale',1.0, ...
                  'jiggle','on', ...
                  'mlevel','sub', ...
                  'hgradfac',[9,2]);

end

% Refine mesh
if tlm.conf.refine~=0
    if tlm.conf.Cell==0 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
    % case without cell
        if tlm.conf.points==1 || tlm.conf.points==2
            tlm.dom.list = [1 3 4 5];
        else
            tlm.dom.list = [1 3 4 5];
        end
    elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
    % case with one cell (without membrane)
        tlm.dom.list = [1 3 4 5 6];
    elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
    % case with two cell (without membrane)
        tlm.dom.list = [1 3 4 5 6 7];
    elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0
    % case with one cell + nucleus (without membrane)
        tlm.dom.list = [1 3 4 5 6 7];
    elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0
    % case with two cell + nucleus (without membrane)
        tlm.dom.list = [1 3 4 5 6 7 8 9];
    elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1
    % case with one cell + nucleus + mitochondria (without membrane)
        tlm.dom.list = [1 3 4 5 6 7 8];
    elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1
    % case with two cell + nucleus + mitochondria (without membrane)
        tlm.dom.list = [1 3 4 5 6 7 8 9 10 11];
    end
    
    for i=1:1:tlm.conf.refine
        fem.mesh=meshrefine(fem,...
    	'out',    {'mesh'},...
    	'Sdl',tlm.dom.list,'rmethod','longest');
    end
end

%Plot the mesh
if (tlm.conf.figure==1)
    figure(1);
    clf('reset');
    
    if tlm.conf.Cell==0 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
    % case without cell
        if tlm.conf.Milo==1
            if tlm.conf.points==1 || tlm.conf.points==2
                tlm.bnd.list = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
            elseif tlm.conf.points==4
                tlm.bnd.list = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30];
            end
        elseif tlm.conf.Milo==2
            if tlm.conf.points==1 || tlm.conf.points==2
                tlm.bnd.list = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21];
            elseif tlm.conf.points==4
                tlm.bnd.list = [1,2,3,4,6,9,10,11,12,13,16,19,20,21,22,23,25,26,27,28,29,30,32,34,35];
            end
        end
    elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
    % case with one cell (without membrane)
        if tlm.conf.Milo==1
            if tlm.conf.points==1
                tlm.bnd.list = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24];
            elseif tlm.conf.points==2
                tlm.bnd.list = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24];
            elseif tlm.conf.points==4
                %tlm.bnd.list = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38];
                tlm.bnd.list = [3,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38];
            end
        end
    elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
    % case with two cell (without membrane)
        tlm.bnd.list = [1,2,3,4,9,10,11,12,13,15,16,17,18,19,21,23,24,25,26,27,28,29,30,31,34,36,37,38,40,41,42,44,45,46];
    elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0
    % case with one cell + nucleus (without membrane)
        tlm.bnd.list = [1,2,3,4,9,10,11,12,13,15,16,17,18,19,21,23,24,25,26,28,29,30,31,32,33,34,36,37,38,40,41,42,44,45,46];
    elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0
    % case with two cell + nucleus (without membrane)
        tlm.bnd.list = [1,2,3,4,9,10,11,12,13,15,16,17,18,19,21,23,24,25,26,27,28,29,30,31,32,33,34,36,38,39,40,41,42,43,44,46,47,48,49,50,51,52,54,55,56,57,58,60,61,62];
    elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1
    % case with one cell + nucleus + mitochondria (without membrane)
        tlm.bnd.list = [1,2,3,4,9,10,11,12,13,15,16,17,18,19,21,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,42,43,44,46,47,48,49,50,52,53,54];
    elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1
    % case with two cell + nucleus + mitochondria (without membrane)
        tlm.bnd.list = [1,2,3,4,9,10,11,12,13,15,16,17,18,19,21,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,42,43,44,46,47,48,49,50,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,76,77,78];
    end
     
    meshplot(fem,'edgemode','off','boundmode','off', ...
              'dedgemode','off','dboundmode','on','dboundcolor','black','curvemode','off','curvecolor','black','Bdl',tlm.bnd.list);

%    meshplot(mesh,'ellogic','x+y>0.8','elkeep',1/100,...
%         'edgemode','off','boundmode','off',...
%         'dedgemode','on','dboundmode','on','curvemode','on')
%    meshplot(fem,'ellogic','x+y>0','elkeep',1/100,'boundcolor','qual','edgemode','off','boundmode','on', ...
%              'dedgemode','off','dboundmode','off','curvemode','on')

    if tlm.conf.save==1
        saveas(1,'Mesh.emf');
    end
end
end
