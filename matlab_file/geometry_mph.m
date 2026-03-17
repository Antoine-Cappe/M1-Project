function out = model
%
% geometry_mph.m
%
% Model exported on Oct 9 2024, 15:18 by COMSOL 6.2.0.415.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('C:\Users\Vincent Senez\BIOCAD-2_vsnz');

model.label('geometry_mph.mph');

model.component.create('comp1', true);

model.component('comp1').geom.create('geom1', 3);

model.component('comp1').curvedInterior(false);

model.component('comp1').mesh.create('mesh1');

model.component('comp1').geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.component('comp1').geom('geom1').create('blk1', 'Block');
model.component('comp1').geom('geom1').feature('blk1').label('Bioreactor');
model.component('comp1').geom('geom1').feature('blk1').set('pos', [0 0 0]);
model.component('comp1').geom('geom1').feature('blk1').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk1').set('size', [200 80 100]);
model.component('comp1').geom('geom1').create('blk2', 'Block');
model.component('comp1').geom('geom1').feature('blk2').label('Electrode_1');
model.component('comp1').geom('geom1').feature('blk2').set('pos', [-95 0 0]);
model.component('comp1').geom('geom1').feature('blk2').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk2').set('size', [10 80 100]);
model.component('comp1').geom('geom1').create('blk3', 'Block');
model.component('comp1').geom('geom1').feature('blk3').label('Electrode_2');
model.component('comp1').geom('geom1').feature('blk3').set('pos', [95 0 0]);
model.component('comp1').geom('geom1').feature('blk3').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk3').set('size', [10 80 100]);
model.component('comp1').geom('geom1').create('pt1', 'Point');
model.component('comp1').geom('geom1').feature('pt1').label('Pt_bioreactor');
model.component('comp1').geom('geom1').create('pt2', 'Point');
model.component('comp1').geom('geom1').feature('pt2').label('Pt_electrode_1');
model.component('comp1').geom('geom1').feature('pt2').set('p', [-95 0 0]);
model.component('comp1').geom('geom1').create('pt3', 'Point');
model.component('comp1').geom('geom1').feature('pt3').label('Pt_electrode_2');
model.component('comp1').geom('geom1').feature('pt3').set('p', [95 0 0]);
model.component('comp1').geom('geom1').run;
model.component('comp1').geom('geom1').run('fin');

model.view.create('view2', 2);
model.view.create('view3', 3);
model.view.create('view4', 2);
model.view.create('view5', 2);
model.view.create('view6', 3);
model.view.create('view7', 2);

model.component('comp1').material.create('mat1', 'Common');
model.component('comp1').material.create('mat2', 'Common');
model.component('comp1').material('mat1').selection.set([1 3]);
model.component('comp1').material('mat2').selection.set([2]);

model.component('comp1').physics.create('ec', 'ConductiveMedia', 'geom1');
model.component('comp1').physics('ec').create('gnd1', 'Ground', 2);
model.component('comp1').physics('ec').feature('gnd1').selection.set([16]);
model.component('comp1').physics('ec').create('term1', 'Terminal', 2);
model.component('comp1').physics('ec').feature('term1').selection.set([1]);

model.component('comp1').view('view1').set('transparency', true);
model.view('view2').axis.set('xmin', -15.5);
model.view('view2').axis.set('xmax', 215.5);
model.view('view2').axis.set('ymin', -109.99177551269531);
model.view('view2').axis.set('ymax', 189.9917755126953);
model.view('view4').axis.set('xmin', -147.33824157714844);
model.view('view4').axis.set('xmax', 347.3382568359375);
model.view('view4').axis.set('ymin', -103.53921508789062);
model.view('view4').axis.set('ymax', 183.53921508789062);
model.view('view5').axis.set('xmin', -15.5);
model.view('view5').axis.set('xmax', 215.5);
model.view('view5').axis.set('ymin', -160.3656005859375);
model.view('view5').axis.set('ymax', 240.3656005859375);
model.view('view7').axis.set('viewscaletype', 'automatic');

model.component('comp1').material('mat1').label('Electrode');
model.component('comp1').material('mat1').propertyGroup('def').set('electricconductivity', {'1e7' '0' '0' '0' '1e7' '0' '0' '0' '1e7'});
model.component('comp1').material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.component('comp1').material('mat2').label('Culture_medium');
model.component('comp1').material('mat2').propertyGroup('def').set('electricconductivity', {'1e-5' '0' '0' '0' '1e-5' '0' '0' '0' '1e-5'});
model.component('comp1').material('mat2').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});

model.component('comp1').physics('ec').feature('term1').set('TerminalType', 'Voltage');
model.component('comp1').physics('ec').feature('term1').set('V0', 0.025);

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
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature.remove('fcDef');

model.study('std1').feature('freq').set('plist', '1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 20000 30000');
model.study('std1').feature('freq').set('loadparameters', 'C:\Users\Vincent Senez\BIOCAD-2_vsnz\freq.txt');

model.sol('sol1').attach('std1');
model.sol('sol1').feature('st1').label(['Compilation des ' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'quations: Domaine fr' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'quentiel']);
model.sol('sol1').feature('v1').label(['Variables d' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'pendantes 1.1']);
model.sol('sol1').feature('v1').set('clistctrl', {'p1'});
model.sol('sol1').feature('v1').set('cname', {'freq'});
model.sol('sol1').feature('v1').set('clist', {'1000[Hz] 2000[Hz] 3000[Hz] 4000[Hz] 5000[Hz] 6000[Hz] 7000[Hz] 8000[Hz] 9000[Hz] 10000[Hz] 20000[Hz] 30000[Hz]'});
model.sol('sol1').feature('s1').label('Solveur stationnaire 1.1');
model.sol('sol1').feature('s1').set('probesel', 'none');
model.sol('sol1').feature('s1').feature('dDef').label('Direct 1');
model.sol('sol1').feature('s1').feature('aDef').label(['Avanc' native2unicode(hex2dec({'00' 'e9'}), 'unicode') ' 1']);
model.sol('sol1').feature('s1').feature('p1').label(['Param' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'trique 1.1']);
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 20000 30000'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('fc1').label('Couplage fort 1.1');
model.sol('sol1').feature('s1').feature('i1').label(['It' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'ratif 1.1']);
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'bicgstab');
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').feature('ilDef').label('LU incomplet 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').label('Multigrilles 1.1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').label(['R' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'gularisation initiale 1']);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('soDef').label('SOR 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').label(['R' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'gularisation de post-traitement 1']);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('soDef').label('SOR 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').label('Solveur grossier 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('dDef').label('Direct 1');
model.sol('sol1').runAll;

out = model;
