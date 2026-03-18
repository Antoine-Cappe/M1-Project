function out = model
%
% essai3.m
%
% Model exported on Oct 9 2024, 17:17 by COMSOL 6.2.0.415.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('C:\Users\Vincent Senez\BIOCAD-2_vsnz');

model.label('geometry_finale_mph.mph');

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

model.study.create('std2');
model.study('std2').create('freq', 'Frequency');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').attach('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('p1', 'Parametric');
model.sol('sol2').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('s1').create('i1', 'Iterative');
model.sol('sol2').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature.remove('fcDef');

model.result.dataset.create('dset2', 'Solution');
model.result.dataset.remove('dset1');
model.result.numerical.create('int1', 'IntSurface');
model.result.numerical('int1').selection.set([16]);
model.result.create('pg2', 'PlotGroup3D');
model.result.create('pg3', 'PlotGroup3D');
model.result.create('pg4', 'PlotGroup1D');
model.result('pg2').create('vol1', 'Volume');
model.result('pg3').create('mslc1', 'Multislice');
model.result('pg3').create('strmsl1', 'StreamlineMultislice');
model.result('pg3').feature('mslc1').set('expr', 'ec.normE');
model.result('pg3').feature('strmsl1').create('col1', 'Color');
model.result('pg3').feature('strmsl1').create('filt1', 'Filter');
model.result('pg3').feature('strmsl1').feature('col1').set('expr', 'ec.normE');
model.result('pg3').feature('strmsl1').feature('filt1').set('expr', '!isScalingSystemDomain');

model.study('std2').feature('freq').set('plist', '1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 20000 30000 40000 50000 60000 70000 80000 90000 100000 200000 300000 400000 500000 600000 700000 800000 900000');
model.study('std2').feature('freq').set('loadparameters', 'C:\Users\Vincent Senez\BIOCAD-2_vsnz\freq.txt');

model.sol('sol2').attach('std2');
model.sol('sol2').feature('st1').label(['Compilation des ' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'quations: Domaine fr' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'quentiel']);
model.sol('sol2').feature('v1').label(['Variables d' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'pendantes 1.1']);
model.sol('sol2').feature('v1').set('clistctrl', {'p1'});
model.sol('sol2').feature('v1').set('cname', {'freq'});
model.sol('sol2').feature('v1').set('clist', {'1000[Hz] 2000[Hz] 3000[Hz] 4000[Hz] 5000[Hz] 6000[Hz] 7000[Hz] 8000[Hz] 9000[Hz] 10000[Hz] 20000[Hz] 30000[Hz] 40000[Hz] 50000[Hz] 60000[Hz] 70000[Hz] 80000[Hz] 90000[Hz] 100000[Hz] 200000[Hz] 300000[Hz] 400000[Hz] 500000[Hz] 600000[Hz] 700000[Hz] 800000[Hz] 900000[Hz]'});
model.sol('sol2').feature('s1').label('Solveur stationnaire 1.1');
model.sol('sol2').feature('s1').set('probesel', 'none');
model.sol('sol2').feature('s1').feature('dDef').label('Direct 1');
model.sol('sol2').feature('s1').feature('aDef').label(['Avanc' native2unicode(hex2dec({'00' 'e9'}), 'unicode') ' 1']);
model.sol('sol2').feature('s1').feature('p1').label(['Param' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'trique 1.1']);
model.sol('sol2').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol2').feature('s1').feature('p1').set('plistarr', {'1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 20000 30000 40000 50000 60000 70000 80000 90000 100000 200000 300000 400000 500000 600000 700000 800000 900000'});
model.sol('sol2').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol2').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol2').feature('s1').feature('fc1').label('Couplage fort 1.1');
model.sol('sol2').feature('s1').feature('i1').label(['It' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'ratif 1.1']);
model.sol('sol2').feature('s1').feature('i1').set('linsolver', 'bicgstab');
model.sol('sol2').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol2').feature('s1').feature('i1').feature('ilDef').label('LU incomplet 1');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').label('Multigrilles 1.1');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').label(['R' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'gularisation initiale 1']);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').feature('soDef').label('SOR 1');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').label(['R' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'gularisation de post-traitement 1']);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').feature('soDef').label('SOR 1');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').label('Solveur grossier 1');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('dDef').label('Direct 1');
model.sol('sol2').runAll;

model.result.numerical('int1').set('looplevelinput', {'manual'});
model.result('pg2').label(['Potentiel ' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'lectrique (ec)']);
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').set('showlegendsmaxmin', true);
model.result('pg2').feature('vol1').set('colortable', 'Dipole');
model.result('pg2').feature('vol1').set('resolution', 'normal');
model.result('pg3').label(['Norme du champ ' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'lectrique (ec)']);
model.result('pg3').set('frametype', 'spatial');
model.result('pg3').set('showlegendsmaxmin', true);
model.result('pg3').feature('mslc1').set('multiplanexmethod', 'coord');
model.result('pg3').feature('mslc1').set('xcoord', 'ec.CPx');
model.result('pg3').feature('mslc1').set('multiplaneymethod', 'coord');
model.result('pg3').feature('mslc1').set('ycoord', 'ec.CPy');
model.result('pg3').feature('mslc1').set('multiplanezmethod', 'coord');
model.result('pg3').feature('mslc1').set('zcoord', 'ec.CPz');
model.result('pg3').feature('mslc1').set('colortable', 'Prism');
model.result('pg3').feature('mslc1').set('colortabletrans', 'nonlinear');
model.result('pg3').feature('mslc1').set('colorcalibration', -0.8);
model.result('pg3').feature('mslc1').set('resolution', 'normal');
model.result('pg3').feature('strmsl1').set('expr', {'ec.Ex' 'ec.Ey' 'ec.Ez'});
model.result('pg3').feature('strmsl1').set('descr', ['Champ ' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'lectrique']);
model.result('pg3').feature('strmsl1').set('multiplanexmethod', 'coord');
model.result('pg3').feature('strmsl1').set('xcoord', 'ec.CPx');
model.result('pg3').feature('strmsl1').set('multiplaneymethod', 'coord');
model.result('pg3').feature('strmsl1').set('ycoord', 'ec.CPy');
model.result('pg3').feature('strmsl1').set('multiplanezmethod', 'coord');
model.result('pg3').feature('strmsl1').set('zcoord', 'ec.CPz');
model.result('pg3').feature('strmsl1').set('titletype', 'none');
model.result('pg3').feature('strmsl1').set('posmethod', 'uniform');
model.result('pg3').feature('strmsl1').set('udist', 0.02);
model.result('pg3').feature('strmsl1').set('maxlen', 0.4);
model.result('pg3').feature('strmsl1').set('inheritplot', 'mslc1');
model.result('pg3').feature('strmsl1').set('inheritcolor', false);
model.result('pg3').feature('strmsl1').set('resolution', 'normal');
model.result('pg3').feature('strmsl1').feature('col1').set('colortable', 'PrismDark');
model.result('pg3').feature('strmsl1').feature('col1').set('colorlegend', false);
model.result('pg3').feature('strmsl1').feature('col1').set('colortabletrans', 'nonlinear');
model.result('pg3').feature('strmsl1').feature('col1').set('colorcalibration', -0.8);

out = model;
