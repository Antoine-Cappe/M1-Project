function out = model
%
% TestElectrode.m
%
% Model exported on Jan 11 2019, 14:40 by COMSOL 5.2.0.166.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('C:\Users\Vincent Senez\Documents\Recherche\Outils\Comsol\projets\camille_Lucie');

model.label('TestElectrode.mph');

model.comments(['sans titre\n\n']);

model.modelNode.create('comp1');

model.geom.create('geom1', 3);

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').lengthUnit([native2unicode(hex2dec({'00' 'b5'}), 'unicode') 'm']);
model.geom('geom1').geomRep('comsol');
model.geom('geom1').create('blk1', 'Block');
model.geom('geom1').feature('blk1').label('Matrigel');
model.geom('geom1').feature('blk1').set('size', {'500' '500' '100'});
model.geom('geom1').create('wp1', 'WorkPlane');
model.geom('geom1').feature('wp1').set('unite', 'on');
model.geom('geom1').feature('wp1').set('workplane3d', true);
model.geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp1').geom.feature('r1').set('size', {'500' '500'});
model.geom('geom1').create('wp2', 'WorkPlane');
model.geom('geom1').feature('wp2').set('unite', 'on');
model.geom('geom1').feature('wp2').set('workplane3d', true);
model.geom('geom1').feature('wp2').set('quickz', '100');
model.geom('geom1').feature('wp2').geom.create('r1', 'Rectangle');
model.geom('geom1').feature('wp2').geom.feature('r1').set('size', {'500' '500'});
model.geom('geom1').run;

model.material.create('mat1', 'Common', 'comp1');

model.physics.create('ec', 'ConductiveMedia', 'geom1');
model.physics('ec').create('gnd1', 'Ground', 2);
model.physics('ec').feature('gnd1').selection.set([4]);
model.physics('ec').create('term1', 'Terminal', 2);
model.physics('ec').feature('term1').selection.set([3]);

model.mesh('mesh1').autoMeshSize(1);

model.view('view2').axis.set('abstractviewxscale', '1.0617759227752686');
model.view('view2').axis.set('ymin', '-24.999969482421875');
model.view('view2').axis.set('xmax', '545.1737060546875');
model.view('view2').axis.set('abstractviewyscale', '1.061776041984558');
model.view('view2').axis.set('abstractviewbratio', '-0.05000000074505806');
model.view('view2').axis.set('abstractviewtratio', '0.05000000074505806');
model.view('view2').axis.set('abstractviewrratio', '0.09034740924835205');
model.view('view2').axis.set('xmin', '-45.173736572265625');
model.view('view2').axis.set('abstractviewlratio', '-0.09034747630357742');
model.view('view2').axis.set('ymax', '525');
model.view('view3').axis.set('abstractviewxscale', '0.003898635506629944');
model.view('view3').axis.set('abstractviewyscale', '0.003898635506629944');
model.view('view3').axis.set('abstractviewbratio', '-0.0020000000949949026');
model.view('view3').axis.set('abstractviewtratio', '-0.9980000257492065');
model.view('view3').axis.set('abstractviewrratio', '-0.9980000257492065');
model.view('view3').axis.set('xmin', '-1.1676414012908936');
model.view('view3').axis.set('abstractviewlratio', '-0.002335282741114497');

model.material('mat1').propertyGroup('def').set('electricconductivity', {'0.1' '0' '0' '0' '0.1' '0' '0' '0' '0.1'});
model.material('mat1').propertyGroup('def').set('relpermittivity', {'75' '0' '0' '0' '75' '0' '0' '0' '75'});

model.physics('ec').feature('term1').set('TerminalType', 'Voltage');
model.physics('ec').feature('term1').set('V0', '10[mV]');
model.physics('ec').feature('term1').set('I0', '10 [mA]');
model.physics('ec').feature('term1').set('Vinit', '10[mV]');

model.mesh('mesh1').run;

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

model.result.create('pg1', 'PlotGroup3D');
model.result.create('pg2', 'PlotGroup1D');
model.result('pg1').create('str1', 'Streamline');
model.result('pg1').create('vol1', 'Volume');
model.result('pg1').create('mslc1', 'Multislice');
model.result('pg1').feature('str1').set('data', 'dset1');
model.result('pg1').feature('str1').selection.all;
model.result('pg1').feature('vol1').set('data', 'dset1');
model.result('pg1').feature('mslc1').set('data', 'dset1');
model.result('pg2').create('glob1', 'Global');
model.result.export.create('plot1', 'Plot');
model.result.export.create('plot2', 'Plot');
model.result.export.create('plot3', 'Plot');

model.study('std1').feature('freq').set('plist', '100');

model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'100'});
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'auto');
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'bicgstab');
model.sol('sol1').runAll;

model.result('pg1').label(['Potentiel ' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'lectrique (ec)']);
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').set('showhiddenobjects', true);
model.result('pg1').feature('str1').set('tuberadiusscaleactive', true);
model.result('pg1').feature('str1').set('tuberadiusscale', '2.000000000000001');
model.result('pg1').feature('str1').set('linetype', 'tube');
model.result('pg1').feature('str1').set('posmethod', 'magnitude');
model.result('pg1').feature('mslc1').active(false);
model.result('pg2').set('xlabel', 'freq (Hz)');
model.result('pg2').set('ylabel', ['Imp' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'dance (' 'ohm' ')']);
model.result('pg2').set('ylabelactive', false);
model.result('pg2').set('xlabelactive', false);
model.result('pg2').feature('glob1').set('descr', {['Imp' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'dance']});
model.result('pg2').feature('glob1').set('expr', {'ec.Z11'});
model.result('pg2').feature('glob1').set('unit', {['ohm' ]});
model.result.export('plot1').set('filename', 'C:\Users\Cams3\OneDrive\Bureau\comsol\Untitled1.txt');
model.result.export('plot2').set('plot', 'vol1');
model.result.export('plot2').set('filename', 'C:\Users\Cams3\OneDrive\Bureau\comsol\Untitled2.txt');
model.result.export('plot3').set('plotgroup', 'pg2');
model.result.export('plot3').set('filename', 'C:\Users\Cams3\OneDrive\Bureau\comsol\Untitled.txt');

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
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'100'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'auto');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'pg1');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol1').feature('s1').set('control', 'freq');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'bicgstab');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').attach('std1');
model.sol('sol1').runAll;

model.result('pg1').run;

out = model;
