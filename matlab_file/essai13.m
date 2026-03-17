function out = model
%
% essai13.m
%
% Model exported on Feb 11 2025, 17:14 by COMSOL 5.6.0.341.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('C:\Users\Vincent Senez\BIOCAD-2_Projet_YES_toulouse');

model.label('geometry_finale_mph_capa_5.6bis.mph');

model.component.create('comp1', true);

model.component('comp1').geom.create('geom1', 3);

model.result.table.create('tbl2', 'Table');

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

model.component('comp1').physics.create('ec', 'ConductiveMedia', 'geom1');
model.component('comp1').physics('ec').create('gnd1', 'Ground', 2);
model.component('comp1').physics('ec').feature('gnd1').selection.set([20]);
model.component('comp1').physics('ec').create('term1', 'Terminal', 2);
model.component('comp1').physics('ec').feature('term1').selection.set([1]);

model.result.table('tbl2').label('Table 1');
model.result.table('tbl2').comments('Global Evaluation 1');

model.component('comp1').view('view1').set('transparency', true);

model.component('comp1').material('mat1').label('Electrode');
model.component('comp1').material('mat1').propertyGroup('def').set('electricconductivity', {'1e5' '0' '0' '0' '1e5' '0' '0' '0' '1e5'});
model.component('comp1').material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.component('comp1').material('mat2').label('Culture Medium');
model.component('comp1').material('mat2').propertyGroup('def').set('electricconductivity', {'1e-4' '0' '0' '0' '1e-4' '0' '0' '0' '1e-4'});
model.component('comp1').material('mat2').propertyGroup('def').set('relpermittivity', {'10' '0' '0' '0' '10' '0' '0' '0' '10'});

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

model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('probetag', 'none');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg2').create('tblp1', 'Table');

model.study('std1').feature('freq').set('plist', '10^{range(log10(100),1/2,log10(1.0e10))}');
model.study('std1').feature('freq').set('preusesol', 'no');

model.sol('sol1').attach('std1');
model.sol('sol1').feature('st1').label('Compile Equations: Frequency Domain');
model.sol('sol1').feature('v1').label('Dependent Variables 1.1');
model.sol('sol1').feature('v1').set('clistctrl', {'p1'});
model.sol('sol1').feature('v1').set('cname', {'freq'});
model.sol('sol1').feature('v1').set('clist', {'10^{range(log10(100),1/2,log10(1.0e10))}[Hz]'});
model.sol('sol1').feature('s1').label('Stationary Solver 1.1');
model.sol('sol1').feature('s1').feature('dDef').label('Direct 1');
model.sol('sol1').feature('s1').feature('aDef').label('Advanced 1');
model.sol('sol1').feature('s1').feature('p1').label('Parametric 1.1');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'10^{range(log10(100),1/2,log10(1.0e10))}'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('fc1').label('Fully Coupled 1.1');
model.sol('sol1').feature('s1').feature('i1').label('Iterative 1.1');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'bicgstab');
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').feature('ilDef').label('Incomplete LU 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').label('Multigrid 1.1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').label('Presmoother 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('soDef').label('SOR 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').label('Postsmoother 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('soDef').label('SOR 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').label('Coarse Solver 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('dDef').label('Direct 1');
model.sol('sol1').runAll;

model.result.numerical('gev1').set('table', 'tbl2');
model.result.numerical('gev1').set('expr', {'20*log(abs(1/ec.Y11))'});
model.result.numerical('gev1').set('unit', {''});
model.result.numerical('gev1').set('descr', {''});
model.result.numerical('gev1').setResult;
model.result('pg2').set('xlabel', 'freq (Hz)');
model.result('pg2').set('ylabel', '20*log(abs(1/ec.Y11))');
model.result('pg2').set('xlog', true);
model.result('pg2').set('xlabelactive', false);
model.result('pg2').set('ylabelactive', false);
model.result('pg2').feature('tblp1').set('plotcolumninput', 'manual');

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
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'10^{range(log10(100),1/2,log10(1.0e10))}'});
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

out = model;
