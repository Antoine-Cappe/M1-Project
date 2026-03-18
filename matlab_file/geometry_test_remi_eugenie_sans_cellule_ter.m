function out = model
%
% geometry_test_remi_eugenie_sans_cellule_ter.m
%
% Model exported on Oct 7 2024, 11:52 by COMSOL 6.2.0.415.

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
model.component('comp1').geom('geom1').create('pt1', 'Point');
model.component('comp1').geom('geom1').feature('pt1').label('Pt_bioreactor');
model.component('comp1').geom('geom1').feature('pt1').set('p', [0 0 -45]);
model.component('comp1').geom('geom1').create('sph1', 'Sphere');
model.component('comp1').geom('geom1').feature('sph1').active(false);
model.component('comp1').geom('geom1').feature('sph1').label('Cell_1');
model.component('comp1').geom('geom1').feature('sph1').set('pos', [100 40 50]);
model.component('comp1').geom('geom1').feature('sph1').set('r', 25);
model.component('comp1').geom('geom1').create('pt2', 'Point');
model.component('comp1').geom('geom1').feature('pt2').active(false);
model.component('comp1').geom('geom1').feature('pt2').label('Pt_cell_1');
model.component('comp1').geom('geom1').feature('pt2').set('p', [100 40 50]);
model.component('comp1').geom('geom1').create('blk2', 'Block');
model.component('comp1').geom('geom1').feature('blk2').label('Electrode_1');
model.component('comp1').geom('geom1').feature('blk2').set('pos', [-105 0 0]);
model.component('comp1').geom('geom1').feature('blk2').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk2').set('size', [10 80 100]);
model.component('comp1').geom('geom1').create('pt3', 'Point');
model.component('comp1').geom('geom1').feature('pt3').label('Pt_electrode_1');
model.component('comp1').geom('geom1').feature('pt3').set('p', [-105 0 0]);
model.component('comp1').geom('geom1').create('blk3', 'Block');
model.component('comp1').geom('geom1').feature('blk3').label('Electrode_2');
model.component('comp1').geom('geom1').feature('blk3').set('pos', [105 0 0]);
model.component('comp1').geom('geom1').feature('blk3').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk3').set('size', [10 80 100]);
model.component('comp1').geom('geom1').create('pt4', 'Point');
model.component('comp1').geom('geom1').feature('pt4').label('Pt_electrode_2');
model.component('comp1').geom('geom1').feature('pt4').set('p', [105 0 0]);
model.component('comp1').geom('geom1').run;
model.component('comp1').geom('geom1').run('fin');

model.view.create('view2', 2);
model.view.create('view3', 3);
model.view.create('view4', 2);
model.view.create('view5', 2);
model.view.create('view6', 3);

model.component('comp1').material.create('mat1', 'Common');
model.component('comp1').material.create('mat2', 'Common');
model.component('comp1').material('mat1').selection.set([1 3]);
model.component('comp1').material('mat1').propertyGroup.create('Enu', 'Young''s modulus and Poisson''s ratio');
model.component('comp1').material('mat1').propertyGroup.create('linzRes', 'Linearized resistivity');
model.component('comp1').material('mat2').selection.set([2]);
model.component('comp1').material('mat2').propertyGroup('def').func.create('eta', 'Piecewise');
model.component('comp1').material('mat2').propertyGroup('def').func.create('Cp', 'Piecewise');
model.component('comp1').material('mat2').propertyGroup('def').func.create('rho', 'Piecewise');
model.component('comp1').material('mat2').propertyGroup('def').func.create('k', 'Piecewise');
model.component('comp1').material('mat2').propertyGroup('def').func.create('cs', 'Interpolation');
model.component('comp1').material('mat2').propertyGroup('def').func.create('an1', 'Analytic');
model.component('comp1').material('mat2').propertyGroup('def').func.create('an2', 'Analytic');
model.component('comp1').material('mat2').propertyGroup('def').func.create('an3', 'Analytic');

model.component('comp1').physics.create('ec', 'ConductiveMedia', 'geom1');
model.component('comp1').physics('ec').create('term1', 'DomainTerminal', 3);
model.component('comp1').physics('ec').feature('term1').selection.set([1]);
model.component('comp1').physics('ec').create('term3', 'DomainTerminal', 3);
model.component('comp1').physics('ec').feature('term3').selection.set([3]);

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

model.component('comp1').material('mat1').label('Copper');
model.component('comp1').material('mat1').set('family', 'copper');
model.component('comp1').material('mat1').propertyGroup('def').label('Basic');
model.component('comp1').material('mat1').propertyGroup('def').set('tlm.model.material('mat1')', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.component('comp1').material('mat1').propertyGroup('def').set('electricconductivity', {'5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]' '0' '0' '0' '5.998e7[S/m]'});
model.component('comp1').material('mat1').propertyGroup('def').set('heatcapacity', '385[J/(kg*K)]');
model.component('comp1').material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.component('comp1').material('mat1').propertyGroup('def').set('emissivity', '0.5');
model.component('comp1').material('mat1').propertyGroup('def').set('density', '8940[kg/m^3]');
model.component('comp1').material('mat1').propertyGroup('def').set('thermalconductivity', {'400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]' '0' '0' '0' '400[W/(m*K)]'});
model.component('comp1').material('mat1').propertyGroup('Enu').label('Young''s modulus and Poisson''s ratio');
model.component('comp1').material('mat1').propertyGroup('Enu').set('E', '126e9[Pa]');
model.component('comp1').material('mat1').propertyGroup('Enu').set('nu', '0.34');
model.component('comp1').material('mat1').propertyGroup('linzRes').label('Linearized resistivity');
model.component('comp1').material('mat1').propertyGroup('linzRes').set('rho0', '1.667e-8[ohm*m]');
model.component('comp1').material('mat1').propertyGroup('linzRes').set('alpha', '3.862e-3[1/K]');
model.component('comp1').material('mat1').propertyGroup('linzRes').set('Tref', '293.15[K]');
model.component('comp1').material('mat1').propertyGroup('linzRes').addInput('temperature');
model.component('comp1').material('mat2').label('Water');
model.component('comp1').material('mat2').set('family', 'water');
model.component('comp1').material('mat2').propertyGroup('def').label('Basic');
model.component('comp1').material('mat2').propertyGroup('def').func('eta').label('Piecewise');
model.component('comp1').material('mat2').propertyGroup('def').func('eta').set('arg', 'T');
model.component('comp1').material('mat2').propertyGroup('def').func('eta').set('pieces', {'273.15' '413.15' '1.3799566804-0.021224019151*T^1+1.3604562827E-4*T^2-4.6454090319E-7*T^3+8.9042735735E-10*T^4-9.0790692686E-13*T^5+3.8457331488E-16*T^6'; '413.15' '553.75' '0.00401235783-2.10746715E-5*T^1+3.85772275E-8*T^2-2.39730284E-11*T^3'});
model.component('comp1').material('mat2').propertyGroup('def').func('eta').set('argunit', 'K');
model.component('comp1').material('mat2').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.component('comp1').material('mat2').propertyGroup('def').func('Cp').label('Piecewise 2');
model.component('comp1').material('mat2').propertyGroup('def').func('Cp').set('arg', 'T');
model.component('comp1').material('mat2').propertyGroup('def').func('Cp').set('pieces', {'273.15' '553.75' '12010.1471-80.4072879*T^1+0.309866854*T^2-5.38186884E-4*T^3+3.62536437E-7*T^4'});
model.component('comp1').material('mat2').propertyGroup('def').func('Cp').set('argunit', 'K');
model.component('comp1').material('mat2').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.component('comp1').material('mat2').propertyGroup('def').func('rho').label('Piecewise 3');
model.component('comp1').material('mat2').propertyGroup('def').func('rho').set('arg', 'T');
model.component('comp1').material('mat2').propertyGroup('def').func('rho').set('smooth', 'contd1');
model.component('comp1').material('mat2').propertyGroup('def').func('rho').set('pieces', {'273.15' '293.15' '0.000063092789034*T^3-0.060367639882855*T^2+18.9229382407066*T-950.704055329848'; '293.15' '373.15' '0.000010335053319*T^3-0.013395065634452*T^2+4.969288832655160*T+432.257114008512'});
model.component('comp1').material('mat2').propertyGroup('def').func('rho').set('argunit', 'K');
model.component('comp1').material('mat2').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.component('comp1').material('mat2').propertyGroup('def').func('k').label('Piecewise 4');
model.component('comp1').material('mat2').propertyGroup('def').func('k').set('arg', 'T');
model.component('comp1').material('mat2').propertyGroup('def').func('k').set('pieces', {'273.15' '553.75' '-0.869083936+0.00894880345*T^1-1.58366345E-5*T^2+7.97543259E-9*T^3'});
model.component('comp1').material('mat2').propertyGroup('def').func('k').set('argunit', 'K');
model.component('comp1').material('mat2').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.component('comp1').material('mat2').propertyGroup('def').func('cs').set('table', {'273' '1403';  ...
'278' '1427';  ...
'283' '1447';  ...
'293' '1481';  ...
'303' '1507';  ...
'313' '1526';  ...
'323' '1541';  ...
'333' '1552';  ...
'343' '1555';  ...
'353' '1555';  ...
'363' '1550';  ...
'373' '1543'});
model.component('comp1').material('mat2').propertyGroup('def').func('cs').set('interp', 'piecewisecubic');
model.component('comp1').material('mat2').propertyGroup('def').func('cs').set('fununit', {'m/s'});
model.component('comp1').material('mat2').propertyGroup('def').func('cs').set('argunit', {'K'});
model.component('comp1').material('mat2').propertyGroup('def').func('an1').label('Analytic ');
model.component('comp1').material('mat2').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.component('comp1').material('mat2').propertyGroup('def').func('an1').set('expr', '-1/rho(T)*d(rho(T),T)');
model.component('comp1').material('mat2').propertyGroup('def').func('an1').set('args', {'T'});
model.component('comp1').material('mat2').propertyGroup('def').func('an1').set('fununit', '1/K');
model.component('comp1').material('mat2').propertyGroup('def').func('an1').set('argunit', {'K'});
model.component('comp1').material('mat2').propertyGroup('def').func('an1').set('plotfixedvalue', {'273.15'});
model.component('comp1').material('mat2').propertyGroup('def').func('an1').set('plotargs', {'T' '273.15' '373.15'});
model.component('comp1').material('mat2').propertyGroup('def').func('an2').label('Analytic 2');
model.component('comp1').material('mat2').propertyGroup('def').func('an2').set('funcname', 'gamma_w');
model.component('comp1').material('mat2').propertyGroup('def').func('an2').set('expr', '1+(T/Cp(T))*(alpha_p(T)*cs(T))^2');
model.component('comp1').material('mat2').propertyGroup('def').func('an2').set('args', {'T'});
model.component('comp1').material('mat2').propertyGroup('def').func('an2').set('fununit', '1');
model.component('comp1').material('mat2').propertyGroup('def').func('an2').set('argunit', {'K'});
model.component('comp1').material('mat2').propertyGroup('def').func('an2').set('plotfixedvalue', {'273.15'});
model.component('comp1').material('mat2').propertyGroup('def').func('an2').set('plotargs', {'T' '273.15' '373.15'});
model.component('comp1').material('mat2').propertyGroup('def').func('an3').label('Analytic 3');
model.component('comp1').material('mat2').propertyGroup('def').func('an3').set('funcname', 'muB');
model.component('comp1').material('mat2').propertyGroup('def').func('an3').set('expr', '2.79*eta(T)');
model.component('comp1').material('mat2').propertyGroup('def').func('an3').set('args', {'T'});
model.component('comp1').material('mat2').propertyGroup('def').func('an3').set('fununit', 'Pa*s');
model.component('comp1').material('mat2').propertyGroup('def').func('an3').set('argunit', {'K'});
model.component('comp1').material('mat2').propertyGroup('def').func('an3').set('plotfixedvalue', {'273.15'});
model.component('comp1').material('mat2').propertyGroup('def').func('an3').set('plotargs', {'T' '273.15' '553.75'});
model.component('comp1').material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', '');
model.component('comp1').material('mat2').propertyGroup('def').set('bulkviscosity', '');
model.component('comp1').material('mat2').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(T)' '0' '0' '0' 'alpha_p(T)' '0' '0' '0' 'alpha_p(T)'});
model.component('comp1').material('mat2').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.component('comp1').material('mat2').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.component('comp1').material('mat2').propertyGroup('def').set('ratioofspecificheat', 'gamma_w(T)');
model.component('comp1').material('mat2').propertyGroup('def').set('electricconductivity', {'1e-4[S/m]' '0' '0' '0' '1e-4[S/m]' '0' '0' '0' '1e-4[S/m]'});
model.component('comp1').material('mat2').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.component('comp1').material('mat2').propertyGroup('def').set('density', 'rho(T)');
model.component('comp1').material('mat2').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.component('comp1').material('mat2').propertyGroup('def').set('soundspeed', 'cs(T)');
model.component('comp1').material('mat2').propertyGroup('def').set('relpermittivity', {'80' '0' '0' '0' '80' '0' '0' '0' '80'});
model.component('comp1').material('mat2').propertyGroup('def').addInput('temperature');

model.component('comp1').physics('ec').feature('term1').set('TerminalType', 'Voltage');
model.component('comp1').physics('ec').feature('term1').set('V0', 0.025);
model.component('comp1').physics('ec').feature('term3').set('TerminalName', '3');
model.component('comp1').physics('ec').feature('term3').set('TerminalType', 'Voltage');
model.component('comp1').physics('ec').feature('term3').set('V0', 0);

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

model.study('std1').feature('freq').set('plist', '10^{range(log10(500),1/2,log10(600000))}');

model.sol('sol1').attach('std1');
model.sol('sol1').feature('st1').label(['Compilation des ' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'quations: Domaine fr' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'quentiel']);
model.sol('sol1').feature('v1').label(['Variables d' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'pendantes 1.1']);
model.sol('sol1').feature('v1').set('clistctrl', {'p1'});
model.sol('sol1').feature('v1').set('cname', {'freq'});
model.sol('sol1').feature('v1').set('clist', {'10^{range(log10(500),1/2,log10(600000))}[Hz]'});
model.sol('sol1').feature('s1').label('Solveur stationnaire 1.1');
model.sol('sol1').feature('s1').set('probesel', 'none');
model.sol('sol1').feature('s1').feature('dDef').label('Direct 1');
model.sol('sol1').feature('s1').feature('aDef').label(['Avanc' native2unicode(hex2dec({'00' 'e9'}), 'unicode') ' 1']);
model.sol('sol1').feature('s1').feature('p1').label(['Param' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'trique 1.1']);
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'10^{range(log10(500),1/2,log10(600000))}'});
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
model.result.dataset('cpl3').set('quickz', 50);
model.result('pg6').set('looplevel', [3]);
model.result('pg6').feature('surf1').set('data', 'cpl3');
model.result('pg6').feature('surf1').set('looplevel', [3]);
model.result('pg6').feature('surf1').set('resolution', 'normal');
model.result('pg6').feature('surf1').feature('hght1').set('scale', 6000.000000000001);
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
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'10^{range(log10(500),1/2,log10(600000))}'});
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

out = model;
