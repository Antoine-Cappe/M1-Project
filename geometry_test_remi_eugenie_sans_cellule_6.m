function out = model
%
% geometry_test_remi_eugenie_sans_cellule_6.m
%
% Model exported on Oct 9 2024, 10:28 by COMSOL 6.2.0.415.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('C:\Users\Vincent Senez\BIOCAD-2_vsnz');

model.label('geometry_test_remi_eugenie_sans_cellule_6.mph');

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
model.component('comp1').geom('geom1').feature('blk2').active(false);
model.component('comp1').geom('geom1').feature('blk2').label('Electrode_1');
model.component('comp1').geom('geom1').feature('blk2').set('pos', [-105 0 0]);
model.component('comp1').geom('geom1').feature('blk2').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk2').set('size', [10 80 100]);
model.component('comp1').geom('geom1').create('blk3', 'Block');
model.component('comp1').geom('geom1').feature('blk3').active(false);
model.component('comp1').geom('geom1').feature('blk3').label('Electrode_2');
model.component('comp1').geom('geom1').feature('blk3').set('pos', [105 0 0]);
model.component('comp1').geom('geom1').feature('blk3').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk3').set('size', [10 80 100]);
model.component('comp1').geom('geom1').create('pt1', 'Point');
model.component('comp1').geom('geom1').feature('pt1').active(false);
model.component('comp1').geom('geom1').feature('pt1').label('Pt_bioreactor');
model.component('comp1').geom('geom1').create('pt2', 'Point');
model.component('comp1').geom('geom1').feature('pt2').active(false);
model.component('comp1').geom('geom1').feature('pt2').label('Pt_electrode_1');
model.component('comp1').geom('geom1').feature('pt2').set('p', [-105 0 0]);
model.component('comp1').geom('geom1').create('pt3', 'Point');
model.component('comp1').geom('geom1').feature('pt3').active(false);
model.component('comp1').geom('geom1').feature('pt3').label('Pt_electrode_2');
model.component('comp1').geom('geom1').feature('pt3').set('p', [105 0 0]);
model.component('comp1').geom('geom1').run;

model.view.create('view2', 2);
model.view.create('view3', 3);
model.view.create('view4', 2);
model.view.create('view5', 2);
model.view.create('view6', 3);
model.view.create('view7', 2);

model.component('comp1').material.create('mat1', 'Common');
model.component('comp1').material.create('mat2', 'Common');
model.component('comp1').material('mat1').selection.set([]);
model.component('comp1').material('mat2').selection.set([1]);

model.component('comp1').physics.create('ec', 'ConductiveMedia', 'geom1');
model.component('comp1').physics('ec').create('gnd1', 'Ground', 2);
model.component('comp1').physics('ec').feature('gnd1').selection.set([6]);
model.component('comp1').physics('ec').create('term1', 'Terminal', 2);
model.component('comp1').physics('ec').feature('term1').selection.set([1]);

model.component('comp1').mesh('mesh1').autoMeshSize(3);

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

model.component('comp1').material('mat1').active(false);
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

model.result.dataset.create('cpl3', 'CutPlane');
model.result.create('pg6', 'PlotGroup2D');
model.result.create('pg7', 'PlotGroup1D');
model.result.create('pg8', 'PlotGroup3D');
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').create('hght1', 'Height');
model.result('pg6').feature('surf1').feature('hght1').set('view', 'view6');
model.result('pg7').create('glob1', 'Global');
model.result('pg7').feature('glob1').set('data', 'dset1');
model.result('pg8').create('vol1', 'Volume');
model.result.export.create('data1', 'Data');

model.study('std1').feature('freq').set('plist', '10^{range(log10(1000),1/10,log10(100000))}');

model.sol('sol1').attach('std1');
model.sol('sol1').feature('st1').label(['Compilation des ' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'quations: Domaine fr' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'quentiel']);
model.sol('sol1').feature('v1').label(['Variables d' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'pendantes 1.1']);
model.sol('sol1').feature('v1').set('clistctrl', {'p1'});
model.sol('sol1').feature('v1').set('cname', {'freq'});
model.sol('sol1').feature('v1').set('clist', {'10^{range(log10(1000),1/10,log10(100000))}[Hz]'});
model.sol('sol1').feature('s1').label('Solveur stationnaire 1.1');
model.sol('sol1').feature('s1').set('probesel', 'none');
model.sol('sol1').feature('s1').feature('dDef').label('Direct 1');
model.sol('sol1').feature('s1').feature('aDef').label(['Avanc' native2unicode(hex2dec({'00' 'e9'}), 'unicode') ' 1']);
model.sol('sol1').feature('s1').feature('p1').label(['Param' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'trique 1.1']);
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'10^{range(log10(1000),1/10,log10(100000))}'});
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

model.result.dataset('cpl3').set('quickplane', 'xy');
model.result('pg6').set('looplevel', [11]);
model.result('pg6').feature('surf1').set('data', 'cpl3');
model.result('pg6').feature('surf1').set('looplevel', [11]);
model.result('pg6').feature('surf1').set('resolution', 'normal');
model.result('pg6').feature('surf1').feature('hght1').set('heightdata', 'expr');
model.result('pg6').feature('surf1').feature('hght1').set('scale', 5599.999999999998);
model.result('pg6').feature('surf1').feature('hght1').set('scaleactive', false);
model.result('pg7').set('data', 'none');
model.result('pg7').set('xlabel', 'freq');
model.result('pg7').set('xlabelactive', true);
model.result('pg7').set('ylabel', 'impedance');
model.result('pg7').set('ylabelactive', true);
model.result('pg7').set('xlog', true);
model.result('pg7').feature('glob1').set('expr', {'abs(1/ec.Y11)'});
model.result('pg7').feature('glob1').set('unit', {['ohm' ]});
model.result('pg7').feature('glob1').set('descr', {''});
model.result('pg7').feature('glob1').set('xdata', 'expr');
model.result('pg7').feature('glob1').set('xdataexpr', 'freq');
model.result('pg7').feature('glob1').set('xdataunit', 'Hz');
model.result('pg7').feature('glob1').set('xdatadescr', ['Fr' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'quence']);
model.result('pg7').feature('glob1').set('linewidth', 'preference');
model.result('pg8').feature('vol1').set('resolution', 'normal');
model.result.export('data1').set('data', 'cpl3');
model.result.export('data1').set('expr', {'V'});
model.result.export('data1').set('unit', {'V'});
model.result.export('data1').set('descr', {['Potentiel ' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'lectrique']});
model.result.export('data1').set('filename', 'C:\Users\Vincent Senez\BIOCAD-2_vsnz\Untitled.txt');

out = model;
