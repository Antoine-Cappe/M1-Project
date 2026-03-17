function out = model
%
% geometry_finale_mph_56.m
%
% Model exported on Oct 23 2024, 19:11 by COMSOL 5.6.0.401.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('C:\Users\enzo3\OneDrive\Bureau\BIOCAD-2_vsnz');

model.component.create('comp1', true);

model.component('comp1').geom.create('geom1', 3);

model.component('comp1').mesh.create('mesh1');

model.component('comp1').geom('geom1').create('blk1', 'Block');
model.component('comp1').geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.component('comp1').geom('geom1').feature('blk1').set('size', [200 80 100]);
model.component('comp1').geom('geom1').feature('blk1').set('base', 'center');
model.component('comp1').geom('geom1').run('blk1');
model.component('comp1').geom('geom1').feature('blk1').label('Bioreactor');
model.component('comp1').geom('geom1').run('blk1');
model.component('comp1').geom('geom1').run('blk1');
model.component('comp1').geom('geom1').create('blk2', 'Block');
model.component('comp1').geom('geom1').feature('blk2').label('Electrode_1');
model.component('comp1').geom('geom1').feature('blk2').set('size', [10 80 100]);
model.component('comp1').geom('geom1').feature('blk2').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk2').set('pos', [-95 0 0]);
model.component('comp1').geom('geom1').run('blk2');
model.component('comp1').geom('geom1').run('blk2');
model.component('comp1').geom('geom1').create('blk3', 'Block');
model.component('comp1').geom('geom1').feature('blk3').label('Electrode_2');
model.component('comp1').geom('geom1').feature('blk3').set('size', [10 80 100]);
model.component('comp1').geom('geom1').feature('blk3').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk3').set('pos', [95 0 0]);
model.component('comp1').geom('geom1').run('blk3');

model.component('comp1').view('view1').set('transparency', true);

model.component('comp1').geom('geom1').run('blk3');
model.component('comp1').geom('geom1').create('pt1', 'Point');
model.component('comp1').geom('geom1').feature('pt1').label('Pt_bioreactor');
model.component('comp1').geom('geom1').run('pt1');
model.component('comp1').geom('geom1').feature.duplicate('pt2', 'pt1');
model.component('comp1').geom('geom1').feature.duplicate('pt3', 'pt2');
model.component('comp1').geom('geom1').feature('pt2').label('Pt_electrode_1');
model.component('comp1').geom('geom1').feature('pt2').setIndex('p', -95, 0);
model.component('comp1').geom('geom1').run('pt2');
model.component('comp1').geom('geom1').feature('pt3').label('Pt_electrode_2');
model.component('comp1').geom('geom1').feature('pt3').setIndex('p', 95, 0);
model.component('comp1').geom('geom1').run('pt3');
model.component('comp1').geom('geom1').run('fin');

model.component('comp1').material.create('mat1', 'Common');
model.component('comp1').material('mat1').label('Electrode');
model.component('comp1').material('mat1').selection.set([1 3]);
model.component('comp1').material('mat1').propertyGroup('def').set('electricconductivity', '');
model.component('comp1').material('mat1').propertyGroup('def').set('relpermittivity', '');
model.component('comp1').material('mat1').propertyGroup('def').set('electricconductivity', {'1e7'});
model.component('comp1').material('mat1').propertyGroup('def').set('relpermittivity', {'1'});
model.component('comp1').material.create('mat2', 'Common');
model.component('comp1').material('mat2').label('Culture Medium');
model.component('comp1').material('mat2').selection.set([2]);
model.component('comp1').material('mat2').propertyGroup('def').set('electricconductivity', '');
model.component('comp1').material('mat2').propertyGroup('def').set('relpermittivity', '');
model.component('comp1').material('mat2').propertyGroup('def').set('electricconductivity', {'1e-1'});
model.component('comp1').material('mat2').propertyGroup('def').set('relpermittivity', {'1'});

model.component('comp1').physics.create('ec', 'ConductiveMedia', 'geom1');
model.component('comp1').physics('ec').create('gnd1', 'Ground', 2);
model.component('comp1').physics('ec').feature('gnd1').selection.set([16]);

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');
model.study('std1').feature('freq').activate('ec', true);

model.component('comp1').physics('ec').create('term1', 'Terminal', 2);
model.component('comp1').physics('ec').feature('term1').selection.set([1]);
model.component('comp1').physics('ec').feature('term1').set('TerminalType', 'Voltage');
model.component('comp1').physics('ec').feature('term1').set('V0', 0.025);

model.component('comp1').mesh('mesh1').run;

model.study('std1').feature('freq').set('plist', '1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 20000 30000 40000 50000 60000 70000 80000 90000 100000 200000 300000 400000 500000 600000 700000 800000 900000');
model.study('std1').feature('freq').set('loadparameters', 'C:\Users\enzo3\OneDrive\Bureau\BIOCAD-2_vsnz\freq.txt');
model.study('std1').feature('freq').set('preusesol', 'no');

model.sol.create('sol1');
model.sol('sol1').study('std1');

model.study('std1').feature('freq').set('notlistsolnum', 1);
model.study('std1').feature('freq').set('notsolnum', '1');
model.study('std1').feature('freq').set('listsolnum', 1);
model.study('std1').feature('freq').set('solnum', '1');

model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'freq');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 20000 30000 40000 50000 60000 70000 80000 90000 100000 200000 300000 400000 500000 600000 700000 800000 900000'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'Default');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol1').feature('s1').set('control', 'freq');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'bicgstab');
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');

model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Electric Potential (ec)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('data', 'dset1');
model.result('pg1').feature.create('mslc1', 'Multislice');
model.result('pg1').feature('mslc1').set('colortable', 'RainbowLight');
model.result('pg1').feature('mslc1').set('data', 'parent');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').run;
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').setIndex('expr', '1/ec.Y11', 0);
model.result.table.create('tbl1', 'Table');
model.result('pg2').run;
model.result('pg2').create('tblp1', 'Table');
model.result('pg2').run;
model.result('pg2').run;
model.result.table.create('tbl2', 'Table');
model.result.table('tbl2').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl2');
model.result.numerical('gev1').setResult;
model.result.table.remove('tbl1');
model.result.table('tbl2').label('Table 1');
model.result('pg2').run;
model.result('pg2').create('tblp1', 'Table');
model.result('pg2').run;

model.study('std1').feature('freq').set('plot', true);
model.study('std1').feature('freq').set('plotgroup', 'pg2');
model.study('std1').feature('freq').set('plot', false);
model.study('std1').feature('freq').set('useadvanceddisable', false);

model.sol('sol1').study('std1');

model.study('std1').feature('freq').set('notlistsolnum', 1);
model.study('std1').feature('freq').set('notsolnum', '1');
model.study('std1').feature('freq').set('listsolnum', 1);
model.study('std1').feature('freq').set('solnum', '1');

model.sol('sol1').feature.remove('s1');
model.sol('sol1').feature.remove('v1');
model.sol('sol1').feature.remove('st1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').feature('st1').set('study', 'std1');
model.sol('sol1').feature('st1').set('studystep', 'freq');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').feature('v1').set('control', 'freq');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').feature.remove('pDef');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 20000 30000 40000 50000 60000 70000 80000 90000 100000 200000 300000 400000 500000 600000 700000 800000 900000'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'pg2');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol1').feature('s1').set('control', 'freq');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'bicgstab');
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;
model.result.table('tbl2').importData('C:\Users\enzo3\OneDrive\Bureau\BIOCAD-2_vsnz\Untitled test.txt');
model.result('pg2').run;
model.result('pg2').run;

out = model;
