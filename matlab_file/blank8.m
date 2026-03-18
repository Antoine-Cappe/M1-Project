function out = model
%
% blank8.m
%
% Model exported on Feb 27 2025, 10:28 by COMSOL 6.3.0.335.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('C:\Users\Vincent Senez\BIOCAD-2_Projet_YES_toulouse');

model.label('electrical_circuit_plus_bioreactor.mph');

model.component.create('comp1', true);

model.component('comp1').geom.create('geom1', 3);

model.result.table.create('tbl2', 'Table');

model.component('comp1').mesh.create('mesh1');

model.component('comp1').geom('geom1').angularUnit('rad');
model.component('comp1').geom('geom1').geomRep('cadps');
model.component('comp1').geom('geom1').designBooleans(false);
model.component('comp1').geom('geom1').create('blk1', 'Block');
model.component('comp1').geom('geom1').feature('blk1').label('Bioreactor');
model.component('comp1').geom('geom1').feature('blk1').set('size', {'200e-6' '80e-6' '100e-6'});
model.component('comp1').geom('geom1').feature('blk1').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk1').set('selresult', true);
model.component('comp1').geom('geom1').feature('blk1').set('color', '22');
model.component('comp1').geom('geom1').create('pt1', 'Point');
model.component('comp1').geom('geom1').feature('pt1').label('Pt_bioreactor');
model.component('comp1').geom('geom1').feature('pt1').set('selresult', true);
model.component('comp1').geom('geom1').create('pt2', 'Point');
model.component('comp1').geom('geom1').feature('pt2').label('Pt_electrode_1');
model.component('comp1').geom('geom1').feature('pt2').set('p', {'-100e-6' '0' '0'});
model.component('comp1').geom('geom1').feature('pt2').set('selresult', true);
model.component('comp1').geom('geom1').create('pt3', 'Point');
model.component('comp1').geom('geom1').feature('pt3').label('Pt_electrode_2');
model.component('comp1').geom('geom1').feature('pt3').set('p', {'100e-6' '0' '0'});
model.component('comp1').geom('geom1').feature('pt3').set('selresult', true);
model.component('comp1').geom('geom1').create('wp3', 'WorkPlane');
model.component('comp1').geom('geom1').feature('wp3').label('Electrode_1');
model.component('comp1').geom('geom1').feature('wp3').set('quickplane', 'yz');
model.component('comp1').geom('geom1').feature('wp3').set('quickx', '-100e-6');
model.component('comp1').geom('geom1').feature('wp3').set('unite', true);
model.component('comp1').geom('geom1').feature('wp3').set('workplane3d', true);
model.component('comp1').geom('geom1').feature('wp3').geom.create('pol1', 'Polygon');
model.component('comp1').geom('geom1').feature('wp3').geom.feature('pol1').set('source', 'table');
model.component('comp1').geom('geom1').feature('wp3').geom.feature('pol1').set('table', {'-40.0E-6' '-50E-6'; '-40E-6' '50E-6'; '40.0E-6' '50E-6'; '40.0E-6' '-50E-6'});
model.component('comp1').geom('geom1').feature('wp3').geom.feature('pol1').set('selresult', true);
model.component('comp1').geom('geom1').feature('wp3').geom.feature('pol1').set('color', '13');
model.component('comp1').geom('geom1').create('wp2', 'WorkPlane');
model.component('comp1').geom('geom1').feature('wp2').label('Electrode_2');
model.component('comp1').geom('geom1').feature('wp2').set('quickplane', 'yz');
model.component('comp1').geom('geom1').feature('wp2').set('quickx', '100e-6');
model.component('comp1').geom('geom1').feature('wp2').set('unite', true);
model.component('comp1').geom('geom1').feature('wp2').set('workplane3d', true);
model.component('comp1').geom('geom1').feature('wp2').geom.create('pol1', 'Polygon');
model.component('comp1').geom('geom1').feature('wp2').geom.feature('pol1').set('source', 'table');
model.component('comp1').geom('geom1').feature('wp2').geom.feature('pol1').set('table', {'-40.0E-6' '-50E-6'; '-40.0E-6' '50E-6'; '40.0E-6' '50E-6'; '40.0E-6' '-50E-6'});
model.component('comp1').geom('geom1').feature('wp2').geom.feature('pol1').set('selresult', true);
model.component('comp1').geom('geom1').feature('wp2').geom.feature('pol1').set('color', '14');
model.component('comp1').geom('geom1').run;
model.component('comp1').geom('geom1').run('fin');

model.component('comp1').selection.create('sel1', 'Explicit');
model.component('comp1').selection('sel1').geom('geom1', 2);
model.component('comp1').selection('sel1').set([1]);
model.component('comp1').selection.create('sel2', 'Explicit');
model.component('comp1').selection('sel2').geom('geom1', 2);
model.component('comp1').selection('sel1').label('Electrode_1');
model.component('comp1').selection('sel1').set('color', '13');
model.component('comp1').selection('sel2').label('Electrode_2');
model.component('comp1').selection('sel2').set('color', '14');

model.component('comp1').view('view2').tag('view4');

model.component('comp1').material.create('mat1', 'Common');
model.component('comp1').material.create('mat2', 'Common');
model.component('comp1').material('mat1').selection.set([]);
model.component('comp1').material('mat2').selection.set([1]);

model.component('comp1').physics.create('ec', 'ConductiveMedia', 'geom1');
model.component('comp1').physics('ec').create('gnd1', 'Ground', 2);
model.component('comp1').physics('ec').feature('gnd1').selection.set([6]);
model.component('comp1').physics('ec').create('term1', 'Terminal', 2);
model.component('comp1').physics('ec').feature('term1').selection.set([1]);
model.component('comp1').physics.create('cir', 'Circuit', 'geom1');
model.component('comp1').physics('cir').create('V1', 'VoltageSource', -1);
model.component('comp1').physics('cir').create('R1', 'Resistor', -1);
model.component('comp1').physics('cir').create('IvsU2', 'ModelDeviceIV', -1);

model.result.table('tbl2').label('Table 1');
model.result.table('tbl2').comments('Global Evaluation 1');

model.component('comp1').view('view1').set('transparency', true);
model.component('comp1').view('view4').label('View 4');

model.component('comp1').material('mat1').active(false);
model.component('comp1').material('mat1').label('Electrode');
model.component('comp1').material('mat1').propertyGroup('def').set('electricconductivity', {'1e7' '0' '0' '0' '1e7' '0' '0' '0' '1e7'});
model.component('comp1').material('mat1').propertyGroup('def').set('relpermittivity', {'10' '0' '0' '0' '10' '0' '0' '0' '10'});
model.component('comp1').material('mat2').label('Culture Medium');
model.component('comp1').material('mat2').propertyGroup('def').set('electricconductivity', {'1e1' '0' '0' '0' '1e1' '0' '0' '0' '1e1'});
model.component('comp1').material('mat2').propertyGroup('def').set('relpermittivity', {'80' '0' '0' '0' '80' '0' '0' '0' '80'});

model.component('comp1').physics('ec').feature('dcont1').set('pairDisconnect', true);
model.component('comp1').physics('ec').feature('dcont1').label('Continuity');
model.component('comp1').physics('ec').feature('term1').set('TerminalType', 'Circuit');
model.component('comp1').physics('ec').feature('term1').set('V0', 0.025);
model.component('comp1').physics('ec').feature('term1').set('Vinit', '0[V]');
model.component('comp1').physics('ec').feature('term1').set('circuitConnectionStatus', 'circuitConnectedProperly');
model.component('comp1').physics('ec').feature('term1').set('derivedInformationMessage', 'Connected to Electrical Circuit, External I vs. U 2');
model.component('comp1').physics('ec').feature('term1').set('toBeReferencedElectricalCircuitTag', 'cir');
model.component('comp1').physics('cir').feature('V1').set('Connections', [1; 0]);
model.component('comp1').physics('cir').feature('V1').set('sourceType', 'AC');
model.component('comp1').physics('cir').feature('V1').set('value', 0.025);
model.component('comp1').physics('cir').feature('R1').set('R', '50e-5');
model.component('comp1').physics('cir').feature('R1').set('Connections', [1; 2]);
model.component('comp1').physics('cir').feature('IvsU2').set('V_src', 'root.comp1.ec.V0_1');
model.component('comp1').physics('cir').feature('IvsU2').set('Connections', [2; 0]);

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');

model.sol.create('sol1');
model.sol('sol1').attach('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').create('dp1', 'DirectPreconditioner');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('hybridization', 'multi');
model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('hybridization', 'multi');
model.sol('sol1').feature('s1').feature.remove('fcDef');

model.result.numerical.create('gev1', 'EvalGlobal');
model.result.create('pg1', 'PlotGroup3D');
model.result.create('pg2', 'PlotGroup1D');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg1').create('mslc1', 'Multislice');
model.result('pg2').create('glob1', 'Global');
model.result('pg2').feature('glob1').set('data', 'dset1');
model.result('pg2').feature('glob1').set('expr', {'' '' '(cir.v_2-cir.v_0)/cir.R1.i'});
model.result('pg3').create('iso1', 'Isosurface');
model.result('pg3').create('str1', 'Streamline');
model.result('pg3').feature('iso1').set('expr', 'ec.normE');

model.study('std1').feature('freq').set('plist', '1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 20000 30000 40000 50000 60000 70000 80000 90000 100000 200000 300000 400000 500000 600000 700000 800000 900000 1000000 2000000 3000000 4000000 5000000 6000000 7000000 8000000 9000000 10000000 1000000000');
model.study('std1').feature('freq').set('loadparameters', 'C:\Users\enzo3\OneDrive\Bureau\BIOCAD-2_vsnz\freq.txt');

model.sol('sol1').feature('st1').label('Compile Equations: Frequency Domain');
model.sol('sol1').feature('v1').label('Dependent Variables 1.1');
model.sol('sol1').feature('v1').set('clistctrl', {'p1'});
model.sol('sol1').feature('v1').set('cname', {'freq'});
model.sol('sol1').feature('v1').set('clist', {'1000[Hz] 2000[Hz] 3000[Hz] 4000[Hz] 5000[Hz] 6000[Hz] 7000[Hz] 8000[Hz] 9000[Hz] 10000[Hz] 20000[Hz] 30000[Hz] 40000[Hz] 50000[Hz] 60000[Hz] 70000[Hz] 80000[Hz] 90000[Hz] 100000[Hz] 200000[Hz] 300000[Hz] 400000[Hz] 500000[Hz] 600000[Hz] 700000[Hz] 800000[Hz] 900000[Hz] 1000000[Hz] 2000000[Hz] 3000000[Hz] 4000000[Hz] 5000000[Hz] 6000000[Hz] 7000000[Hz] 8000000[Hz] 9000000[Hz] 10000000[Hz] 1000000000[Hz]'});
model.sol('sol1').feature('s1').label('Stationary Solver 1.1');
model.sol('sol1').feature('s1').set('probesel', 'none');
model.sol('sol1').feature('s1').feature('dDef').label('Direct 1');
model.sol('sol1').feature('s1').feature('aDef').label('Advanced 1');
model.sol('sol1').feature('s1').feature('p1').label('Parametric 1.1');
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 20000 30000 40000 50000 60000 70000 80000 90000 100000 200000 300000 400000 500000 600000 700000 800000 900000 1000000 2000000 3000000 4000000 5000000 6000000 7000000 8000000 9000000 10000000 1000000000'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('excludelsqvalues', false);
model.sol('sol1').feature('s1').feature('fc1').label('Fully Coupled 1.1');
model.sol('sol1').feature('s1').feature('i1').label('Iterative 1.1');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'bicgstab');
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').feature('ilDef').label('Incomplete LU 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').active(true);
model.sol('sol1').feature('s1').feature('i1').feature('mg1').label('Multigrid 1.1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('hybridvar', {'comp1_V' 'comp1_ec_term1_V0_ode'});
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').label('Presmoother 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('soDef').label('SOR 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').label('Postsmoother 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('soDef').label('SOR 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').label('Coarse Solver 1');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('dDef').label('Direct 1');
model.sol('sol1').feature('s1').feature('i1').feature('dp1').label('Direct Preconditioner 1.1');
model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('hybridvar', {});

model.study('std1').runNoGen;

model.result.dataset('dset1').set('frametype', 'material');
model.result.numerical('gev1').set('looplevelinput', {'manual'});
model.result.numerical('gev1').set('table', 'tbl2');
model.result.numerical('gev1').set('expr', {'1/ec.Y11'});
model.result.numerical('gev1').set('unit', {''});
model.result.numerical('gev1').set('descr', {''});
model.result.numerical('gev1').setResult;
model.result('pg1').label('Electric Potential (ec)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').feature('mslc1').set('colortable', 'RainbowLightClassic');
model.result('pg1').feature('mslc1').set('resolution', 'normal');
model.result('pg2').set('looplevelinput', {'manual'});
model.result('pg2').set('xlabel', 'freq (Hz)');
model.result('pg2').set('xlog', true);
model.result('pg2').set('xlabelactive', false);
model.result('pg2').feature('glob1').set('linewidth', 'preference');
model.result('pg3').feature('iso1').active(false);
model.result('pg3').feature('iso1').set('number', 50);
model.result('pg3').feature('iso1').set('colortable', 'RainbowClassic');
model.result('pg3').feature('iso1').set('resolution', 'normal');
model.result('pg3').feature('str1').set('posmethod', 'start');
model.result('pg3').feature('str1').set('number', 50);
model.result('pg3').feature('str1').set('resolution', 'normal');

model.sol('sol1').study('std1');
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
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 20000 30000 40000 50000 60000 70000 80000 90000 100000 200000 300000 400000 500000 600000 700000 800000 900000 1000000 2000000 3000000 4000000 5000000 6000000 7000000 8000000 9000000 10000000 1000000000'});
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
model.sol('sol1').feature('s1').set('linpmethod', 'sol');
model.sol('sol1').feature('s1').set('linpsol', 'zero');
model.sol('sol1').feature('s1').set('control', 'freq');
model.sol('sol1').feature('s1').create('iDef', 'Iterative');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'bicgstab');
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('hybridization', 'multi');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('hybridvar', {'comp1_V' 'comp1_ec_term1_V0_ode'});
model.sol('sol1').feature('s1').feature('i1').create('dp1', 'DirectPreconditioner');
model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('hybridization', 'multi');
model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('hybridvar', {'comp1_currents'});
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').feature('s1').feature.remove('iDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg1').setIndex('looplevel', 22, 0);
model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').run;
model.result('pg2').run;

model.component('comp1').selection('sel2').set([6]);

model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').create('glob2', 'Global');
model.result('pg2').feature('glob2').set('markerpos', 'datapoints');
model.result('pg2').feature('glob2').set('linewidth', 'preference');
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').feature('glob2').set('data', 'dset1');
model.result('pg2').feature('glob2').setIndex('expr', '20log10()', 0);
model.result('pg2').run;
model.result('pg2').feature('glob2').setIndex('expr', '20log10((cir.v_2-cir.v_0)/cir.R1.i)', 0);
model.result('pg2').feature('glob2').setIndex('expr', '20log(cir.v_2-cir.v_0)/cir.R1.i)', 0);
model.result('pg2').feature('glob2').setIndex('expr', '20*log10(cir.v_2-cir.v_0)/cir.R1.i)', 0);
model.result('pg2').feature('glob2').setIndex('expr', '20*log10((cir.v_2-cir.v_0)/cir.R1.i)', 0);
model.result('pg2').run;
model.result('pg2').run;
model.result.duplicate('pg4', 'pg2');
model.result('pg4').run;
model.result('pg2').run;
model.result('pg2').feature.remove('glob2');
model.result('pg2').run;
model.result('pg4').run;
model.result('pg4').feature.remove('glob1');
model.result('pg4').run;
model.result('pg4').run;
model.result('pg4').feature('glob2').setIndex('expr', 'arg()', 1);
model.result('pg4').feature('glob2').setIndex('expr', 'arg((cir.v_2-cir.v_0)/cir.R1.i)', 1);
model.result('pg4').feature('glob2').setIndex('expr', 'arg((cir.v_2-cir.v_0)/cir.R1.i)*180/pi', 1);
model.result('pg4').run;
model.result('pg4').run;
model.result.duplicate('pg5', 'pg4');
model.result('pg5').run;
model.result('pg4').run;
model.result('pg4').feature('glob2').setIndex('expr', '', 1);
model.result('pg5').run;
model.result('pg5').feature('glob2').remove('unit', 0);
model.result('pg5').feature('glob2').remove('descr', 0);
model.result('pg5').feature('glob2').remove('expr', [0]);
model.result('pg5').run;
model.result('pg5').feature('glob2').setIndex('expr', 'arg((cir.v_2-cir.v_0)/cir.R1.i)*180/3,14', 0);
model.result('pg5').feature('glob2').setIndex('expr', 'arg((cir.v_2-cir.v_0)/cir.R1.i)*180/3.14', 0);
model.result('pg5').run;
model.result('pg5').run;
model.result('pg5').set('preserveaspect', true);
model.result('pg5').run;
model.result('pg5').set('preserveaspect', false);
model.result('pg5').run;
model.result('pg3').run;
model.result('pg4').run;

model.component('comp1').material('mat2').propertyGroup('def').set('electricconductivity', {'1e-1'});

model.sol('sol1').study('std1');
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
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 20000 30000 40000 50000 60000 70000 80000 90000 100000 200000 300000 400000 500000 600000 700000 800000 900000 1000000 2000000 3000000 4000000 5000000 6000000 7000000 8000000 9000000 10000000 1000000000'});
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
model.sol('sol1').feature('s1').set('linpmethod', 'sol');
model.sol('sol1').feature('s1').set('linpsol', 'zero');
model.sol('sol1').feature('s1').set('control', 'freq');
model.sol('sol1').feature('s1').create('iDef', 'Iterative');
model.sol('sol1').feature('s1').create('seDef', 'Segregated');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'bicgstab');
model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('hybridization', 'multi');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('hybridvar', {'comp1_V' 'comp1_ec_term1_V0_ode'});
model.sol('sol1').feature('s1').feature('i1').create('dp1', 'DirectPreconditioner');
model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('hybridization', 'multi');
model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('hybridvar', {'comp1_currents'});
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').feature('s1').feature.remove('iDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg4').run;
model.result('pg5').run;
model.result('pg5').feature('glob2').setIndex('expr', 'arg((cir.v_2-cir.v_0)/cir.R1.i)*180/pi', 0);
model.result('pg5').run;

model.label('sample_simulation_file.mph');

model.study('std1').feature('freq').set('loadparameters', '');

model.result('pg2').run;

out = model;
