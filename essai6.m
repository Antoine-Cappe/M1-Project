function out = model
%
% essai6.m
%
% Model exported on Feb 7 2025, 11:40 by COMSOL 5.6.0.341.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('C:\Users\Vincent Senez\BIOCAD-2_Projet_YES_toulouse');

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

model.label('geometry_finale_mph_5.6.mph');

model.result('pg2').run;

model.component('comp1').material('mat2').propertyGroup('def').set('relpermittivity', {'0'});
model.component('comp1').material('mat1').propertyGroup('def').set('relpermittivity', {'0'});

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

model.label('geometry_finale_mph_5.6.mph');

model.result('pg1').run;

model.component('comp1').geom('geom1').feature('blk2').set('size', {'0' '80' '100'});
model.component('comp1').geom('geom1').feature('blk3').set('size', {'0' '80' '100'});
model.component('comp1').geom('geom1').run('blk1');
model.component('comp1').geom('geom1').feature('blk2').set('size', [10 80 100]);
model.component('comp1').geom('geom1').feature('blk3').set('size', [10 80 100]);
model.component('comp1').geom('geom1').runPre('fin');
model.component('comp1').geom('geom1').feature('blk2').active(false);
model.component('comp1').geom('geom1').feature('blk3').active(false);
model.component('comp1').geom('geom1').run('pt3');
model.component('comp1').geom('geom1').create('wp1', 'WorkPlane');
model.component('comp1').geom('geom1').feature('wp1').set('unite', true);
model.component('comp1').geom('geom1').feature('wp1').set('quickplane', 'yz');
model.component('comp1').geom('geom1').feature('wp1').set('quickx', -100);
model.component('comp1').geom('geom1').run('wp1');
model.component('comp1').geom('geom1').feature('wp1').geom.create('sq1', 'Square');
model.component('comp1').geom('geom1').feature('wp1').geom.feature('sq1').set('size', 80);
model.component('comp1').geom('geom1').feature('wp1').geom.run('sq1');
model.component('comp1').geom('geom1').feature('wp1').geom.feature('sq1').set('base', 'center');
model.component('comp1').geom('geom1').feature('wp1').geom.run('sq1');
model.component('comp1').geom('geom1').feature('wp1').geom.feature('sq1').set('size', 100);
model.component('comp1').geom('geom1').feature('wp1').geom.run('sq1');
model.component('comp1').geom('geom1').feature('wp1').geom.feature.remove('sq1');
model.component('comp1').geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.component('comp1').geom('geom1').feature('wp1').geom.feature('r1').set('size', [10 100]);
model.component('comp1').geom('geom1').feature('wp1').geom.run('r1');
model.component('comp1').geom('geom1').feature('wp1').geom.feature('r1').set('base', 'center');
model.component('comp1').geom('geom1').feature('wp1').geom.feature('r1').set('size', [80 100]);
model.component('comp1').geom('geom1').feature('wp1').geom.run('r1');
model.component('comp1').geom('geom1').run('wp1');
model.component('comp1').geom('geom1').create('wp2', 'WorkPlane');
model.component('comp1').geom('geom1').feature('wp2').set('unite', true);
model.component('comp1').geom('geom1').feature('wp2').set('quickplane', 'yz');
model.component('comp1').geom('geom1').feature('wp2').set('quickx', 100);
model.component('comp1').geom('geom1').run('wp2');
model.component('comp1').geom('geom1').feature('wp2').geom.create('r1', 'Rectangle');
model.component('comp1').geom('geom1').feature('wp2').geom.feature('r1').set('size', [80 1]);
model.component('comp1').geom('geom1').feature('wp2').geom.feature('r1').set('base', 'center');
model.component('comp1').geom('geom1').feature('wp2').geom.feature('r1').set('size', [80 100]);
model.component('comp1').geom('geom1').feature('wp2').geom.run('r1');
model.component('comp1').geom('geom1').run('fin');

model.component('comp1').material('mat1').selection.all;
model.component('comp1').material('mat1').selection.set([1]);
model.component('comp1').material('mat1').selection.geom('geom1', 2);
model.component('comp1').material('mat1').selection.set([1 6]);

model.component('comp1').geom('geom1').feature('wp1').active(false);
model.component('comp1').geom('geom1').feature('wp2').active(false);
model.component('comp1').geom('geom1').feature('blk2').active(true);
model.component('comp1').geom('geom1').feature('blk3').active(true);
model.component('comp1').geom('geom1').runPre('fin');
model.component('comp1').geom('geom1').feature('blk2').set('base', 'corner');
model.component('comp1').geom('geom1').feature('blk3').set('base', 'corner');
model.component('comp1').geom('geom1').runPre('fin');
model.component('comp1').geom('geom1').feature('blk3').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk3').set('axistype', 'x');
model.component('comp1').geom('geom1').run('blk3');
model.component('comp1').geom('geom1').feature('blk3').set('axistype', 'y');
model.component('comp1').geom('geom1').run('blk3');
model.component('comp1').geom('geom1').feature('blk3').set('axistype', 'z');
model.component('comp1').geom('geom1').runPre('fin');
model.component('comp1').geom('geom1').feature('blk3').set('pos', [100 0 0]);
model.component('comp1').geom('geom1').run('blk3');
model.component('comp1').geom('geom1').feature('blk3').set('pos', [95 0 0]);
model.component('comp1').geom('geom1').run('blk3');
model.component('comp1').geom('geom1').feature('blk2').set('base', 'center');
model.component('comp1').geom('geom1').runPre('fin');
model.component('comp1').geom('geom1').run;

model.component('comp1').material('mat1').selection.geom('geom1', 3);
model.component('comp1').material('mat2').selection.set([2]);
model.component('comp1').material('mat1').selection.set([1 3]);

model.component('comp1').geom('geom1').feature('wp1').geom.feature('r1').active(false);
model.component('comp1').geom('geom1').feature('wp2').geom.feature('r1').active(false);
model.component('comp1').geom('geom1').runPre('fin');
model.component('comp1').geom('geom1').run('fin');

model.component('comp1').material('mat1').propertyGroup('def').set('electricconductivity', {'1e-1'});
model.component('comp1').material('mat2').propertyGroup('def').set('electricconductivity', {'1e-1'});
model.component('comp1').material('mat1').propertyGroup('def').set('electricconductivity', {'1e7'});

model.component('comp1').physics('ec').create('bcs1', 'BoundaryCurrentSource', 2);
model.component('comp1').physics('ec').feature.remove('bcs1');
model.component('comp1').physics('ec').prop('PortSweepSettings').set('zref', '1[ohm]');
model.component('comp1').physics('ec').prop('PortSweepSettings').set('useSweep', false);
model.component('comp1').physics('ec').prop('PortSweepSettings').set('zref', '50[ohm]');

model.result('pg2').run;
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('expr', {'ec.V0_1'});
model.result('pg2').feature('glob1').set('descr', {'Terminal voltage'});
model.result('pg2').feature('glob1').set('unit', {'V'});
model.result('pg2').feature('glob1').setIndex('expr', '20*log(ec.V0_1/', 0);
model.result('pg2').feature('glob1').set('expr', {'ec.I0_1'});
model.result('pg2').feature('glob1').set('descr', {'Terminal current'});
model.result('pg2').feature('glob1').set('unit', {'A'});
model.result('pg2').feature('glob1').setIndex('expr', '20*log', 0);
model.result('pg2').feature('glob1').setIndex('expr', '20*log(', 0);
model.result('pg2').feature('glob1').set('expr', {'20*log(' 'ec.I0_1'});
model.result('pg2').feature('glob1').set('descr', {'' 'Terminal current'});
model.result('pg2').feature('glob1').set('expr', {'20*log(' 'ec.I0_1' 'ec.V0_1'});
model.result('pg2').feature('glob1').set('descr', {'' 'Terminal current' 'Terminal voltage'});
model.result('pg2').feature('glob1').setIndex('expr', '20*log(ec.V0_1/ec.I0_1)', 0);
model.result('pg2').feature('glob1').setIndex('unit', 'dB', 0);
model.result('pg2').run;
model.result('pg2').feature.remove('glob1');
model.result('pg2').run;

model.component('comp1').physics('ec').feature('term1').selection.set([1 2 4 5 6]);
model.component('comp1').physics('ec').feature('gnd1').selection.set([11 12 13 14 15 16]);
model.component('comp1').physics('ec').feature('term1').selection.set([1 2 3 4 5 6]);

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
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').run;
model.result('pg3').create('iso1', 'Isosurface');
model.result('pg3').feature('iso1').set('expr', 'ec.I0_1');
model.result('pg3').feature('iso1').set('descr', 'Terminal current');
model.result('pg3').run;
model.result('pg3').feature('iso1').set('expr', 'ec.normJ');
model.result('pg3').feature('iso1').set('descr', 'Current density norm');
model.result('pg3').run;
model.result('pg3').feature('iso1').set('expr', 'ec.Jx');
model.result('pg3').feature('iso1').set('descr', 'Current density, x component');
model.result('pg3').run;

model.component('comp1').physics('ec').feature('term1').selection.set([1]);
model.component('comp1').physics('ec').feature('gnd1').selection.set([11]);
model.component('comp1').physics('ec').feature('term1').selection.set([6]);

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
model.result('pg3').run;
model.result('pg3').run;

model.label('geometry_finale_mph_5.6.mph');

model.result('pg3').run;

model.component('comp1').physics('ec').feature('term1').selection.set([1]);

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

model.component('comp1').geom('geom1').lengthUnit('m');
model.component('comp1').geom('geom1').feature('blk1').set('size', {'200e-6' '80e-6' '100'});
model.component('comp1').geom('geom1').feature('blk1').setIndex('size', '100e-6', 2);
model.component('comp1').geom('geom1').feature('blk2').set('size', {'10e-6' '80e-6' '100e-6'});
model.component('comp1').geom('geom1').feature('blk2').set('pos', {'-95e-6' '0' '0'});
model.component('comp1').geom('geom1').feature('blk3').set('size', {'10e-6' '80e-6' '100e-6'});
model.component('comp1').geom('geom1').feature('blk3').set('pos', {'95e-6' '0' '0'});
model.component('comp1').geom('geom1').feature('pt2').setIndex('p', '-95e-6', 0);
model.component('comp1').geom('geom1').feature('pt3').setIndex('p', '95e-6', 0);
model.component('comp1').geom('geom1').runPre('fin');

model.label('geometry_finale_mph_5.6.mph');

model.component('comp1').geom('geom1').run;
model.component('comp1').geom('geom1').run('fin');

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
model.result('pg3').run;
model.result('pg2').run;

model.label('geometry_finale_mph_5.6.mph');

model.result('pg2').run;

model.component('comp1').geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.component('comp1').geom('geom1').feature('blk1').setIndex('size', 200, 0);
model.component('comp1').geom('geom1').feature('blk1').set('size', [200 80 100]);
model.component('comp1').geom('geom1').lengthUnit('m');
model.component('comp1').geom('geom1').scaleUnitValue(true);
model.component('comp1').geom('geom1').scaleUnitValue(false);
model.component('comp1').geom('geom1').feature('blk1').set('size', {'200e-6' '80e-6' '100'});
model.component('comp1').geom('geom1').feature('blk1').setIndex('size', '100e-6', 2);
model.component('comp1').geom('geom1').run('blk1');
model.component('comp1').geom('geom1').runPre('fin');

model.component('comp1').material('mat1').propertyGroup('def').set('relpermittivity', {'5'});
model.component('comp1').material('mat2').propertyGroup('def').set('relpermittivity', {'1'});
model.component('comp1').material('mat1').propertyGroup('def').set('relpermittivity', {'10'});
model.component('comp1').material('mat2').propertyGroup('def').set('relpermittivity', {'10'});

model.study('std1').feature('freq').set('plist', '1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 20000 30000 40000 50000 60000 70000 80000 90000 100000 200000 300000 400000 500000 600000 700000 800000 900000 1000000 2000000 3000000 4000000 5000000 6000000 7000000 8000000 9000000 10000000 1000000000');

model.component('comp1').geom('geom1').angularUnit('rad');

model.label('geometry_finale_mph_capa_5.6.mph');

model.component('comp1').geom('geom1').feature.remove('wp1');
model.component('comp1').geom('geom1').feature.remove('wp2');
model.component('comp1').geom('geom1').feature('blk1').setIndex('size', '90e-6', 0);
model.component('comp1').geom('geom1').feature('blk1').set('pos', {'-45e-6' '0' '0'});
model.component('comp1').geom('geom1').feature('blk1').set('selresult', true);
model.component('comp1').geom('geom1').feature.duplicate('blk4', 'blk1');
model.component('comp1').geom('geom1').feature('blk1').label('Bioreactor_1');
model.component('comp1').geom('geom1').feature('blk4').label('Bioreactor_2');
model.component('comp1').geom('geom1').feature('blk4').set('pos', {'+45e-6' '0' '0'});
model.component('comp1').geom('geom1').run('fin');
model.component('comp1').geom('geom1').run('blk4');
model.component('comp1').geom('geom1').create('co1', 'Compose');
model.component('comp1').geom('geom1').feature('co1').selection('input').set({'blk1' 'blk4'});
model.component('comp1').geom('geom1').feature('co1').set('selresult', true);
model.component('comp1').geom('geom1').feature('co1').label('Bioreactor');
model.component('comp1').geom('geom1').feature('co1').set('intbnd', false);
model.component('comp1').geom('geom1').run('blk4');
model.component('comp1').geom('geom1').feature('co1').selection('input').named('blk1');
model.component('comp1').geom('geom1').feature('co1').selection('input').named('');
model.component('comp1').geom('geom1').feature('co1').selection('input').set({'blk1' 'blk4'});
model.component('comp1').geom('geom1').feature.remove('co1');
model.component('comp1').geom('geom1').run('blk4');
model.component('comp1').geom('geom1').create('uni1', 'Union');
model.component('comp1').geom('geom1').feature('uni1').selection('input').set({'blk1' 'blk4'});
model.component('comp1').geom('geom1').feature('uni1').set('selresult', true);
model.component('comp1').geom('geom1').feature('uni1').set('intbnd', false);
model.component('comp1').geom('geom1').run('uni1');
model.component('comp1').geom('geom1').feature('uni1').label('Bioreactor');
model.component('comp1').geom('geom1').feature('blk2').set('selresult', true);
model.component('comp1').geom('geom1').feature('blk3').set('selresult', true);
model.component('comp1').geom('geom1').feature('pt1').set('selresult', true);
model.component('comp1').geom('geom1').feature('pt2').set('selresult', true);
model.component('comp1').geom('geom1').feature('pt3').set('selresult', true);

out = model;
