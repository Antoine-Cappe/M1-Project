function out = model
%
% blank1.m
%
% Model exported on Feb 26 2025, 10:15 by COMSOL 6.3.0.335.

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

out = model;
