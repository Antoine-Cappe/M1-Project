function out = model
%
% geometry_test_remi_eugenie_sans_cellule_4.m
%
% Model exported on Oct 7 2024, 16:22 by COMSOL 6.2.0.415.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('C:\Users\Vincent Senez\BIOCAD-2_vsnz');

model.label('geometry_test_remi_eugenie_sans_cellule_ter.mph');

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
model.component('comp1').geom('geom1').feature('blk2').set('pos', [-105 0 0]);
model.component('comp1').geom('geom1').feature('blk2').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk2').set('size', [10 80 100]);
model.component('comp1').geom('geom1').create('blk3', 'Block');
model.component('comp1').geom('geom1').feature('blk3').label('Electrode_2');
model.component('comp1').geom('geom1').feature('blk3').set('pos', [105 0 0]);
model.component('comp1').geom('geom1').feature('blk3').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk3').set('size', [10 80 100]);
model.component('comp1').geom('geom1').create('pt1', 'Point');
model.component('comp1').geom('geom1').feature('pt1').label('Pt_bioreactor');
model.component('comp1').geom('geom1').create('pt2', 'Point');
model.component('comp1').geom('geom1').feature('pt2').label('Pt_electrode_1');
model.component('comp1').geom('geom1').feature('pt2').set('p', [-105 0 0]);
model.component('comp1').geom('geom1').create('pt3', 'Point');
model.component('comp1').geom('geom1').feature('pt3').label('Pt_electrode_2');
model.component('comp1').geom('geom1').feature('pt3').set('p', [105 0 0]);
model.component('comp1').geom('geom1').run;

model.view.create('view2', 2);
model.view.create('view3', 3);
model.view.create('view4', 2);
model.view.create('view5', 2);
model.view.create('view6', 3);

model.component('comp1').material.create('mat1', 'Common');
model.component('comp1').material.create('mat2', 'Common');
model.component('comp1').material('mat1').selection.set([1 3]);
model.component('comp1').material('mat2').selection.set([2]);

model.component('comp1').physics.create('ec', 'ConductiveMedia', 'geom1');
model.component('comp1').physics('ec').create('term1', 'DomainTerminal', 3);
model.component('comp1').physics('ec').feature('term1').selection.set([1]);
model.component('comp1').physics('ec').create('term2', 'DomainTerminal', 3);
model.component('comp1').physics('ec').feature('term2').selection.set([3]);

model.component('comp1').mesh('mesh1').autoMeshSize(4);

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

model.component('comp1').material('mat1').label('Electrode');
model.component('comp1').material('mat1').propertyGroup('def').set('electricconductivity', {'1e7' '0' '0' '0' '1e7' '0' '0' '0' '1e7'});
model.component('comp1').material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.component('comp1').material('mat2').label('Culture_medium');
model.component('comp1').material('mat2').propertyGroup('def').set('electricconductivity', {'1e-4' '0' '0' '0' '1e-4' '0' '0' '0' '1e-4'});
model.component('comp1').material('mat2').propertyGroup('def').set('relpermittivity', {'80' '0' '0' '0' '80' '0' '0' '0' '80'});

model.component('comp1').physics('ec').feature('term1').set('TerminalType', 'Voltage');
model.component('comp1').physics('ec').feature('term1').set('V0', 0);
model.component('comp1').physics('ec').feature('term2').set('TerminalType', 'Voltage');
model.component('comp1').physics('ec').feature('term2').set('V0', 0.025);

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
model.result('pg6').create('surf1', 'Surface');
model.result('pg6').feature('surf1').create('hght1', 'Height');
model.result('pg6').feature('surf1').feature('hght1').set('view', 'view6');

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
model.result('pg6').feature('surf1').set('data', 'cpl3');
model.result('pg6').feature('surf1').set('looplevel', [1]);
model.result('pg6').feature('surf1').set('resolution', 'normal');
model.result('pg6').feature('surf1').feature('hght1').set('scale', 6000);
model.result('pg6').feature('surf1').feature('hght1').set('scaleactive', false);

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
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'10^{range(log10(1000),1/10,log10(100000))}'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'pg6');
model.sol('sol1').feature('s1').feature('p1').set('probesel', 'all');
model.sol('sol1').feature('s1').feature('p1').set('probes', {});
model.sol('sol1').feature('s1').feature('p1').set('control', 'freq');
model.sol('sol1').feature('s1').set('linpmethod', 'sol');
model.sol('sol1').feature('s1').set('linpsol', 'zero');
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

model.result('pg6').run;
model.result('pg6').run;
model.result.export.create('data1', 'Data');
model.result.export('data1').set('filename', 'C:\Users\Vincent Senez\BIOCAD-2_vsnz\Untitled.txt');
model.result.export('data1').run;
model.result.export('data1').set('data', 'cpl3');
model.result.export('data1').setIndex('looplevelinput', 'manual', 0);
model.result.export('data1').setIndex('looplevel', [1], 0);
model.result.export('data1').setIndex('expr', 'V', 0);
model.result.export('data1').run;
model.result.export('data1').setIndex('looplevel', [2], 0);
model.result.export('data1').setIndex('looplevel', [3], 0);
model.result.export('data1').setIndex('looplevel', [4], 0);
model.result.export('data1').setIndex('looplevel', [5], 0);
model.result.export('data1').setIndex('looplevel', [6], 0);
model.result.export('data1').setIndex('looplevel', [7], 0);
model.result.export('data1').setIndex('looplevel', [8], 0);
model.result.export('data1').setIndex('looplevel', [9], 0);
model.result.export('data1').setIndex('looplevel', [10], 0);
model.result.export('data1').setIndex('looplevelinput', 'manualindices', 0);
model.result.export('data1').setIndex('looplevelindices', 21, 0);
model.result.export('data1').run;
model.result.export('data1').setIndex('looplevelindices', 'range(1000,100,100000)', 0);
model.result.export('data1').setIndex('looplevelinput', 'all', 0);
model.result.export('data1').run;

out = model;
