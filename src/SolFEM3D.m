%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                              BIOCAD Program
%                               Release 1.0
%
%   Authors: Vincent Senez
%   
%   Release 1.0 : January 2019
%
%   Function : Solve the 3D system by FEM Method
%
%   Called by: Compute.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [tlm,model]=SolFEM3D(tlm,model)

%Initialization

tlm.sol.fre=[];

global fem_mesh_p;

tlm.conf.Name0=tlm.conf.Name;

name1=sprintf('%s.spi',tlm.conf.Name0);     % Name of the file
fid=fopen(name1, 'r');                     % Open the File

if fid>=0       % The file exists
    
    tlineref='Values:';

    i=0;

    while ~feof(fid)
        tlineread = fgetl(fid);
        C = strcmp(tlineref,tlineread);
        if C==1
            imul=log10(tlm.var.frequence.max)-log10(tlm.var.frequence.min);
            while i<(tlm.var.frequence.step*imul+1)
                    tlineread = fgetl(fid);
%                    disp(tlineread);
                       tlm.sol.fre(i+1,:)=str2num(tlineread);

                       tlineread = fgetl(fid);
%                    disp(tlineread);
                    tlineread = fgetl(fid);
%                    disp(tlineread);
                    tlineread = fgetl(fid);
%                    disp(tlineread);
                    i=i+1;
            end
            break
        end
    end

    fclose(fid);

else
    
    Message=sprintf('\n\t\t . The SPI File does not exist in the current result directory');
    disp(Message);
    SPI=1;

end

geom_material_name = model.component('comp1').material.tags;

% we set the conductivity and permittivity to each material in COMSOL
% database from value given in BIOCAD interface

i=1;

while i<=size(geom_material_name,1) %Loop on the materials contained in geom1

   Label = model.component('comp1').material(geom_material_name(i)).label;
   tf=strcmp(Label,'Electrode');

   if tf == 1 
     model.component('comp1').material('mat1').propertyGroup('def').set('electricconductivity', {num2str(tlm.var.sig.electrode)});
     model.component('comp1').material('mat1').propertyGroup('def').set('relpermittivity', {num2str(tlm.var.eps.electrode/tlm.var.eps0)});
   end

   tf=strcmp(Label,'Culture Medium');

   if tf == 1
     model.component('comp1').material('mat2').propertyGroup('def').set('electricconductivity', {num2str(tlm.var.sig.MilOrga)});
     model.component('comp1').material('mat2').propertyGroup('def').set('relpermittivity', {num2str(tlm.var.eps.MilOrga/tlm.var.eps0)});
   end

   i=i+1;
end

%model.component('comp1').physics.remove('ec');
%model.component('comp1').physics.create('ec', 'ConductiveMedia', 'geom1');
%model.component('comp1').physics('ec').create('gnd1', 'Ground', 2); %Pourquoi 2
%model.component('comp1').physics('ec').feature('gnd1').selection.set([20]); %sur surface 20
%model.component('comp1').physics('ec').create('term1', 'Terminal', 2); % Pourquoi 2
%model.component('comp1').physics('ec').feature('term1').selection.set([1]); %sur surface 1

model.component('comp1').physics('ec').feature('term1').set('TerminalType', 'Voltage');
model.component('comp1').physics('ec').feature('term1').set('V0', 0.025); %Valeur du voltage à remplacer par la valeur donnée dans l interface

% On affecte la valeur du potentiel dans la base de données COMSOL à
% partir de la valeur donnée dans l interface BIOCAD

%           model.component('comp1').physics('cir').feature('V1').set('value', {num2str(tlm.var.v0)});


%model.study.remove('std1'); % a retirer en regime de non debug
%model.study.create('std1');
%model.study('std1').create('freq', 'Frequency');

%model.sol.create('sol1');
%model.sol('sol1').study('std1');
%model.sol('sol1').attach('std1');
%model.sol('sol1').create('st1', 'StudyStep');
%model.sol('sol1').create('v1', 'Variables');
%model.sol('sol1').create('s1', 'Stationary');
%model.sol('sol1').feature('s1').create('p1', 'Parametric');
%model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
%model.sol('sol1').feature('s1').create('i1', 'Iterative');
%model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
%model.sol('sol1').feature('s1').feature.remove('fcDef');

freqlist = '';
freqlistHz = '';

curf = 0;
cpt = 0;
    
while abs(100*(curf-tlm.var.frequence.max)/tlm.var.frequence.max)>=1
    
    cpt = cpt+1;
    curf = tlm.sol.fre(cpt,2);

    freqlist = append(freqlist,num2str(curf),' ');
    freqlistHz = append(freqlistHz,num2str(curf),'[Hz] ');
    
end

model.study('std1').feature('freq').set('plist', freqlist);
model.study('std1').feature('freq').set('preusesol', 'no');

%model.study('std1').feature('freq').set('loadparameters', 'C:\Users\Vincent Senez\BIOCAD-2_vsnz\freq.txt');

%model.sol('sol1').attach('std1');
%model.sol('sol1').feature('st1').label(['Compilation des ' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'quations: Domaine fr' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'quentiel']);
%model.sol('sol1').feature('v1').label(['Variables d' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'pendantes 1.1']);
%model.sol('sol1').feature('v1').set('clistctrl', {'p1'});
%model.sol('sol1').feature('v1').set('cname', {'freq'});
model.sol('sol1').feature('v1').set('clist', {freqlistHz});
%model.sol('sol1').feature('s1').label('Solveur stationnaire 1.1');
%model.sol('sol1').feature('s1').set('probesel', 'none');
%model.sol('sol1').feature('s1').feature('dDef').label('Direct 1');
%model.sol('sol1').feature('s1').feature('aDef').label(['Avanc' native2unicode(hex2dec({'00' 'e9'}), 'unicode') ' 1']);
%model.sol('sol1').feature('s1').feature('p1').label(['Param' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'trique 1.1']);
%model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
%model.sol('sol1').feature('s1').feature('p1').set('plistarr', {freqlist});
%model.sol('sol1').feature('s1').feature('p1').set('punit', {'Hz'});
%model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
%model.sol('sol1').feature('s1').feature('fc1').label('Couplage fort 1.1');
%model.sol('sol1').feature('s1').feature('i1').label(['It' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'ratif 1.1']);
%model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'bicgstab');
%model.sol('sol1').feature('s1').feature('i1').set('nlinnormuse', true);
%model.sol('sol1').feature('s1').feature('i1').feature('ilDef').label('LU incomplet 1');
%model.sol('sol1').feature('s1').feature('i1').feature('mg1').label('Multigrilles 1.1');
%model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').label(['R' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'gularisation initiale 1']);
%model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('pr').feature('soDef').label('SOR 1');
%model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').label(['R' native2unicode(hex2dec({'00' 'e9'}), 'unicode') 'gularisation de post-traitement 1']);
%model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('po').feature('soDef').label('SOR 1');
%model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').label('Solveur grossier 1');
%model.sol('sol1').feature('s1').feature('i1').feature('mg1').feature('cs').feature('dDef').label('Direct 1');

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
%model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 20000 30000 40000 50000 60000 70000 80000 90000 100000 200000 300000 400000 500000 600000 700000 800000 900000 1000000 2000000 3000000 4000000 5000000 6000000 7000000 8000000 9000000 10000000 1000000000'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {freqlist});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'Hz'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'no');
model.sol('sol1').feature('s1').feature('p1').set('pdistrib', 'off');
model.sol('sol1').feature('s1').feature('p1').set('plot', 'off');
%model.sol('sol1').feature('s1').feature('p1').set('plotgroup', 'pg2');
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
%       model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('hybridvar', {'comp1_V' 'comp1_ec_term1_V0_ode'});
model.sol('sol1').feature('s1').feature('i1').create('dp1', 'DirectPreconditioner');
model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('linsolver', 'pardiso');
model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('hybridization', 'multi');
%       model.sol('sol1').feature('s1').feature('i1').feature('dp1').set('hybridvar', {'comp1_currents'});
model.sol('sol1').feature('s1').feature('fc1').set('linsolver', 'i1');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol('sol1').feature('s1').feature.remove('seDef');
model.sol('sol1').feature('s1').feature.remove('iDef');
model.sol('sol1').attach('std1');

model.sol('sol1').runAll;

data = mpheval(model,'V');
%data = mpheval(model,'(cir.v_2-cir.v_0)/cir.R1.i');

%model.result.numerical.create('gev1', 'EvalGlobal');
%               model.result.numerical('gev1').setIndex('expr', '(cir.v_2-cir.v_0)/cir.R1.i', 0);
toto=model.result.table.tags;
model.result.table.remove('tbl1');
model.result.table.create('tbl1', 'Table');
model.result.table('tbl1').comments('Global Evaluation 1');
model.result.numerical('gev1').set('table', 'tbl1');
model.result.numerical('gev1').setResult;
FreqZ=model.result.table('tbl1').getTableData(false);

% data.p est la liste des noeuds avec leurs coordonnées x, y et z
% data.t est la liste des tétrahedres avec les numeros des 4 noeuds des 4
% sommets de ce tetrahedre
% data.d1 est la valeur de 'V' pour chaque noeud et ici chaque frequence

%fem_mesh_p(:,:)=data.p(:,:);

% sollicitation coordinate for the outer electrodes (ici il faut mettre les
% coordonnées des noeuds Pt_bioreactor, Pt_electrode_1, Pt_electrode_2

%XX = tlm.var.pt_electrode_1_x;
%YY = tlm.var.pt_electrode_1_y;
%ZZ = tlm.var.pt_electrode_1_z;

%i=1;

%while i<=size(fem_mesh_p,2) %Loop on the total number of nodes to find the right node

%    if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%       (abs(fem_mesh_p(2,i)-YY)<1e-10)&&...
%       (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%            tlm.ind.pt.elec22=i;     % Find the number of the node in the mesh
%    end 

%    i=i+1;

%end
    
% ground coordinate for the outer electrodes

%XX = tlm.var.pt_electrode_2_x;
%YY = tlm.var.pt_electrode_2_y;
%ZZ = tlm.var.pt_electrode_2_z;

%i=1;

%while i<=size(fem_mesh_p,2) %Loop on the total number of nodes to find the right node

%    if (abs(fem_mesh_p(1,i)-XX)<1e-10) && ...
%       (abs(fem_mesh_p(2,i)-YY)<1e-10)&&...
%       (abs(fem_mesh_p(3,i)-ZZ)<1e-10)
%            tlm.ind.pt.elec11=i;     % Find the number of the node in the mesh
%    end

%    i=i+1;

%end

% Start Postprocessing

cpt=1;
ii=0;

%ex=round((log10(tlm.var.frequence.max)+log10(tlm.var.frequence.min))/2);

for a=1:1:(log10(tlm.var.frequence.max)-log10(tlm.var.frequence.min))*tlm.var.frequence.step+1
       
    f=tlm.sol.fre(a,2);

    fem_sol_u(:,:)=data.d1(:,:);

    if (abs(f-tlm.var.frequence.min)<2e-10 || ...
        abs(f-tlm.var.frequence.int)<2e-10 || ...
        abs(f-tlm.var.frequence.max)<2e-10)
        
       tlm.conf.Name=strcat(tlm.conf.Name0,'_',num2str(f),'Hz'); 

           
       for i=1:1:size(fem_mesh_p,2) %Loop on the total number of physical nodes
                
           tlm.var.X(i,1)=data.p(1,i);
           tlm.var.Y(i,1)=data.p(2,i);
           tlm.var.Z(i,1)=data.p(3,i);
           tlm.sol.num(i,1)=data.d1(a,i);
            
       end
            
       % Save the results of the simulation in a file xx.fem_cou

            
       name1=sprintf('%s.fem_cou',tlm.conf.Name);        % Name of the file for the Net List
       fid=fopen(name1, 'w');                     % Open the File

       fprintf(fid, '%s.fem_cou\n',tlm.conf.Name);       % Write the first line of the file which is use as a title of the graphical output
       fprintf(fid, '********************************************************************************\n');            
       fprintf(fid, '*\n');            
       fprintf(fid, '*            3D Map of Electric Potential Calculated by FEM \n'); 
       fprintf(fid, '*                THE FREQUENCY FOR THIS RESULT IS %e HERTZ \n',f); 
       fprintf(fid, '*\n');            
       fprintf(fid, '*                              BIOCAD Program\n');            
       fprintf(fid, '*                               Release 1.0\n');            
       fprintf(fid, '*\n');            
       fprintf(fid, '*   Authors: Vincent Senez\n'); 
       fprintf(fid, '*\n');            
       fprintf(fid, '*   Release 1.0 : January 2019\n');     
       fprintf(fid, '*\n');            
       fprintf(fid, '********************************************************************************\n');            

       for i=1:1:size(fem_mesh_p,2)
               
           fprintf(fid, '%1.10g %1.10g %1.10g %1.10g\n',tlm.var.X(i,1), tlm.var.Y(i,1),tlm.var.Z(i,1), tlm.sol.num(i,1));  
            
       end
         
       fclose(fid);
            
       ii=ii+1;
        
    end        
                
    % Calculate the corresponding Impedance (les formules de Z sont
    % inexactes)
            
 
    if tlm.conf.points==2               % for 2 points measurement
              
        %Z=(fem_sol_u(tlm.ind.pt.elec11)-fem_sol_u(tlm.ind.pt.elec22))*(realRow(1,1)-i*imagRow(2,1))/(abs(realRow(1,1)+i*imagRow(2,1))^2); %il faut trouver ou aller trouver la solution des points remaquable dans les deux electrodes
         Z=str2double(FreqZ(a,2));
    elseif tlm.conf.points==4           % for 4 points measurement 
            
        %Z=((fem.sol.u(tlm.ind.pt.mesu1)-fem.sol.u(tlm.ind.pt.mesu2))*conj(I1))/(abs(I1)^2);
       
    end

    tlm.sol.val(cpt,1)=f;
    tlm.sol.val(cpt,2)=20*log10(abs(Z));
    tlm.sol.val(cpt,3)=angle(Z)*180/pi;
    tlm.sol.val(cpt,7)=real(Z);
    tlm.sol.val(cpt,8)=imag(Z);

    cpt=cpt+1;    

end

cptmem=cpt-1;

% Save the results of the simulation in a file xx.fem

name1=sprintf('%s.fem',tlm.conf.Name0);        % Name of the file for the Net List
fid=fopen(name1, 'w');                     % Open the File

fprintf(fid, '%s.fem\n',tlm.conf.Name0);       % Write the first line of the file which is use as a title of the graphical output
fprintf(fid, '********************************************************************************\n');            
fprintf(fid, '*\n');            
fprintf(fid, '*                        Bode Diagram Calculated by FEM \n'); 
fprintf(fid, '*\n');            
fprintf(fid, '*                              BIOCAD Program\n');            
fprintf(fid, '*                               Release 1.0\n');            
fprintf(fid, '*\n');            
fprintf(fid, '*   Authors: Vincent Senez \n'); 
fprintf(fid, '*\n');            
fprintf(fid, '*   Release 1.0 : January 2019\n');          
fprintf(fid, '*\n');            
fprintf(fid, '********************************************************************************\n');            
fprintf(fid, '*\n');            
fprintf(fid, '* Values:\n');            

for cpt=1:1:cptmem
    fprintf(fid, '%1.3g %1.10g %1.10g %1.10g %1.10g\n',tlm.sol.val(cpt,1), tlm.sol.val(cpt,2), tlm.sol.val(cpt,3), tlm.sol.val(cpt,7), tlm.sol.val(cpt,8));  
end

fclose(fid);

tlm.conf.Name=tlm.conf.Name0;