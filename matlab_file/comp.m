function out = model
%
% comp.m
%
% Model exported on Feb 26 2025, 13:27 by COMSOL 6.3.0.335.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('C:\Users\Vincent Senez\BIOCAD-2_Projet_YES_toulouse');

model.component.create('comp1', true);

model.component('comp1').geom.create('geom1', 3);
model.component('comp1').geom('geom1').geomRep('cadps');
model.component('comp1').geom('geom1').designBooleans(false);

model.component('comp1').mesh.create('mesh1');
model.component('comp1').mesh('mesh1').contribute('geom/detail', true);

model.component.create('comp2', true);

model.component('comp2').geom.create('geom2', 3);
model.component('comp2').geom('geom2').geomRep('cadps');
model.component('comp2').geom('geom2').designBooleans(false);

model.component('comp2').mesh.create('mesh2');
model.component('comp2').mesh('mesh2').contribute('geom/detail', true);

model.component.remove('comp2');

out = model;
