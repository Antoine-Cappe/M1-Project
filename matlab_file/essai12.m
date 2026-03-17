function out = model
%
% essai12.m
%
% Model exported on Feb 7 2025, 16:53 by COMSOL 5.6.0.341.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('C:\Users\Vincent Senez\BIOCAD-2_Projet_YES_toulouse');

model.label('geometry_finale_mph_capa_5.6ter.mph');

model.component.create('comp1', true);

model.component('comp1').geom.create('geom1', 3);

model.component('comp1').mesh.create('mesh1');

model.component('comp1').geom('geom1').angularUnit('rad');
model.component('comp1').geom('geom1').create('blk1', 'Block');
model.component('comp1').geom('geom1').feature('blk1').label('Bioreactor_1');
model.component('comp1').geom('geom1').feature('blk1').set('selresult', true);
model.component('comp1').geom('geom1').feature('blk1').set('pos', {'-45e-6' '0' '0'});
model.component('comp1').geom('geom1').feature('blk1').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk1').set('size', {'90e-6' '80e-6' '100e-6'});
model.component('comp1').geom('geom1').create('blk2', 'Block');
model.component('comp1').geom('geom1').feature('blk2').label('Electrode_1');
model.component('comp1').geom('geom1').feature('blk2').set('selresult', true);
model.component('comp1').geom('geom1').feature('blk2').set('pos', {'-95e-6' '0' '0'});
model.component('comp1').geom('geom1').feature('blk2').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk2').set('size', {'10e-6' '80e-6' '100e-6'});
model.component('comp1').geom('geom1').create('blk3', 'Block');
model.component('comp1').geom('geom1').feature('blk3').label('Electrode_2');
model.component('comp1').geom('geom1').feature('blk3').set('selresult', true);
model.component('comp1').geom('geom1').feature('blk3').set('pos', {'95e-6' '0' '0'});
model.component('comp1').geom('geom1').feature('blk3').set('axis', [0 0 1]);
model.component('comp1').geom('geom1').feature('blk3').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk3').set('size', {'10e-6' '80e-6' '100e-6'});
model.component('comp1').geom('geom1').create('pt1', 'Point');
model.component('comp1').geom('geom1').feature('pt1').label('Pt_bioreactor');
model.component('comp1').geom('geom1').feature('pt1').set('selresult', true);
model.component('comp1').geom('geom1').create('pt2', 'Point');
model.component('comp1').geom('geom1').feature('pt2').label('Pt_electrode_1');
model.component('comp1').geom('geom1').feature('pt2').set('selresult', true);
model.component('comp1').geom('geom1').feature('pt2').set('p', {'-95e-6' '0' '0'});
model.component('comp1').geom('geom1').create('pt3', 'Point');
model.component('comp1').geom('geom1').feature('pt3').label('Pt_electrode_2');
model.component('comp1').geom('geom1').feature('pt3').set('selresult', true);
model.component('comp1').geom('geom1').feature('pt3').set('p', {'0.000095' '0' '0'});
model.component('comp1').geom('geom1').create('blk4', 'Block');
model.component('comp1').geom('geom1').feature('blk4').label('Bioreactor_2');
model.component('comp1').geom('geom1').feature('blk4').set('selresult', true);
model.component('comp1').geom('geom1').feature('blk4').set('pos', {'+45e-6' '0' '0'});
model.component('comp1').geom('geom1').feature('blk4').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk4').set('size', {'90e-6' '80e-6' '100e-6'});
model.component('comp1').geom('geom1').create('uni1', 'Union');
model.component('comp1').geom('geom1').feature('uni1').label('Bioreactor');
model.component('comp1').geom('geom1').feature('uni1').set('selresult', true);
model.component('comp1').geom('geom1').feature('uni1').set('intbnd', false);
model.component('comp1').geom('geom1').feature('uni1').selection('input').set({'blk1' 'blk4'});
model.component('comp1').geom('geom1').run;

model.component('comp1').material.create('mat1', 'Common');
model.component('comp1').material.create('mat2', 'Common');
model.component('comp1').material('mat1').selection.set([1 3]);
model.component('comp1').material('mat2').selection.set([2]);

model.component('comp1').view('view1').set('transparency', true);

model.component('comp1').material('mat1').label('Electrode');
model.component('comp1').material('mat1').propertyGroup('def').set('electricconductivity', {'1e5' '0' '0' '0' '1e5' '0' '0' '0' '1e5'});
model.component('comp1').material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.component('comp1').material('mat2').label('Culture Medium');
model.component('comp1').material('mat2').propertyGroup('def').set('electricconductivity', {'1e-4' '0' '0' '0' '1e-4' '0' '0' '0' '1e-4'});
model.component('comp1').material('mat2').propertyGroup('def').set('relpermittivity', {'10' '0' '0' '0' '10' '0' '0' '0' '10'});

out = model;
