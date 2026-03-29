%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                              BIOCAD Program
%                               Release 3.0
%
%   Authors: Vincent Senez, Benoit Poussard, 
%            Thomas Delmas, Hugo Bertacchini
%   
%   Release 1.0 : July 2003
%   Release 1.1 : December 2004
%   Release 1.2 : July 2005
%   Release 2.0 : December 2005
%   Release 2.1 : July 2006
%   Release 3.0 : December 2006
%
%   Function : Solve the 3D system by FEM Method
%
%   Called by: Compute.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [tlm,fem]=SolFEM3D(tlm,fem)

%Initialization

global fem_mesh_p;

tlm.conf.Name0=tlm.conf.Name;

% Application mode 1

clear appl

appl.mode.class = 'QuasiStatics';
%appl.mode.type = 'cartesian';
%appl.dim = {'V','Ax','Ay','Az','psi'};
%appl.sdim = {'x','y','z'};
%appl.name = 'qvw';
appl.module = 'EM';
%appl.shape = {'shlag(2,''V'')'};
%appl.gporder = 4;
%appl.cporder = 2;
%appl.sshape = 2;
%appl.border = 'off';
appl.assignsuffix = '_emqvw';

clear prop
prop.elemdefault='Lag2';
prop.analysis='smallcurr';
%prop.potential='VA';
%prop.gaugefix='on';
%prop.weakconstr=struct('value',{'off'},'dim',{{'lm1'}});
appl.prop = prop;

%clear pnt

% The system is solved only in case of no membrane

%if (tlm.conf.Test==4 | tlm.conf.Test==5 | tlm.conf.Test==6 | tlm.conf.Test==8)
    % case without cell -  37 vertex
%    pnt.ind = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
%elseif (tlm.conf.Test==10 | tlm.conf.Test==12)
    % case with one cell (without membrane) -  50 vertex
%    pnt.ind = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
%elseif (tlm.conf.Test==18 | tlm.conf.Test==20)
    % case with one cell + nucleus (without membrane) 63 vertex
%    pnt.ind = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
%end

%appl.pnt = pnt;

%clear edg
%edg.I0 = 0;
%if (tlm.conf.Test==4 | tlm.conf.Test==5 | tlm.conf.Test==6 | tlm.conf.Test==8)
    % case without cell - 56 edges
%    edg.ind = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
%elseif (tlm.conf.Test==10 | tlm.conf.Test==12)
    % case with one cell (without membrane) - 76 edges
%    edg.ind = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
%elseif (tlm.conf.Test==18 | tlm.conf.Test==20)
    % case with one cell + nucleus (without membrane) 96 vertex
%    edg.ind = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, ...
%               1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
%end
%appl.edg = edg;

clear bnd
%bnd.murbnd = 1;
%bnd.murtensorbnd = 1;
%bnd.mutype = 'iso';
%bnd.epsilonrbnd = 1;
%bnd.epsrtensorbnd = 1;
%bnd.epstype = 'iso';
%bnd.sigmabnd = 0;
%bnd.sigmatensorbnd = 0;
%bnd.sigtype = 'iso';
%bnd.J0 = {{0;0;0}};
%bnd.Jn = 0;
%bnd.d = 1;
%bnd.Vref = 0;
%bnd.H0 = {{0;0;0}};
%bnd.Js0 = {{0;0;0}};
%bnd.A0 = {{0;0;0}};
bnd.V0 = {0,0,0,tlm.var.v0};
%bnd.eta = 1;
%bnd.Es = {{0;0;0}};
%bnd.eltype = {'V0','V','cont','V'};
bnd.eltype = {'V0','nJ0','cont','V'};
%bnd.magtype = {'A0','A0','A0','A0'};
bnd.magtype = {'A0','A0','cont','A0'};

% The system is solved only in case of no membrane

if tlm.conf.Cell==0 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
    if tlm.conf.Milo==1
        % case without cell one medium - 30 faces
        bnd.ind = [2,4,2,2,2,3,2,2,2,3,2,3,3,2,2,3,2,3,3,2,2,3,2,2,1,2,2,2,2,2]; 
    elseif tlm.conf.Milo==2
        % case without cell two mediums - 35 faces
        bnd.ind = [2,4,2,2,2,3,2,2,2,3,2,3,3,2,2,3,2,2,2,3,2,3,3,2,2,3,2,2,1,2,2,2,2,2,2]; 
    end
elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0 
    % case with one cell (without membrane)
    bnd.ind = [2,4,2,2,2,3,2,2,2,3,2,3,3,2,2,3,2,3,3,2,2,3,2,2,1]; 
    for inbs=1:1:tlm.var.NbSurfaceCell(1)
        bnd.ind = [ bnd.ind, 3];
    end
    bnd.ind = [bnd.ind,2,2,2,2,2];
elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0 
    % case with one cell (without membrane)
    bnd.ind = [2,4,2,2,2,3,2,2,2,3,2,3,3,2,2,3,2,3,3,2,2,3,2,2,1]; 
    for inbs=1:1:tlm.var.NbSurfaceCell(1)
        bnd.ind = [ bnd.ind, 3];
    end
    for inbs=1:1:tlm.var.NbSurfaceCell(2)
        bnd.ind = [ bnd.ind, 3];
    end
    bnd.ind = [bnd.ind,2,2,2,2,2];
elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0
    % case with one cell + nucleus (without membrane)
    bnd.ind = [2,4,2,2,2,3,2,2,2,3,2,3,3,2,2,3,2,3,3,2,2,3,2,2,1]; 
    for inbs=1:1:tlm.var.NbSurfaceCell(1)
        bnd.ind = [ bnd.ind, 3];
    end
    bnd.ind = [bnd.ind,3,3,3,3,3,3,3,3,2,2,2,2,2];
elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0
    % case with one cell + nucleus (without membrane)
    bnd.ind = [2,4,2,2,2,3,2,2,2,3,2,3,3,2,2,3,2,3,3,2,2,3,2,2,1]; 
    for inbs=1:1:tlm.var.NbSurfaceCell(1)
        bnd.ind = [ bnd.ind, 3];
    end
    for inbs=1:1:tlm.var.NbSurfaceCell(2)
        bnd.ind = [ bnd.ind, 3];
    end
    bnd.ind = [bnd.ind,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,2,2,2,2,2];
elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1
    % case with one cell + nucleus + mitochondria (without membrane)
    bnd.ind = [2,4,2,2,2,3,2,2,2,3,2,3,3,2,2,3,2,3,3,2,2,3,2,2,1];
    for inbs=1:1:tlm.var.NbSurfaceCell(1)
        bnd.ind = [ bnd.ind, 3];
    end
    bnd.ind = [bnd.ind,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,2,2,2,2,2];
elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1
    % case with one cell + nucleus + mitochondria (without membrane)
    bnd.ind = [2,4,2,2,2,3,2,2,2,3,2,3,3,2,2,3,2,3,3,2,2,3,2,2,1];
    for inbs=1:1:tlm.var.NbSurfaceCell(1)
        bnd.ind = [ bnd.ind, 3];
    end
    for inbs=1:1:tlm.var.NbSurfaceCell(2)
        bnd.ind = [ bnd.ind, 3];
    end
    bnd.ind = [bnd.ind,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,2,2,2,2,2];
end

appl.bnd = bnd;

clear equ

%equ.shape = 1;
%equ.gporder = 1;
%equ.cporder = 1;
%equ.init = 0;
%equ.usage = 1;
%equ.mur = 1;
%equ.murtensor = 1;
%equ.mutype = 'iso';

if tlm.conf.Cell==0 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
    % case without cell
    if tlm.conf.Milo==1
        equ.epsilonr = {'eps_Electrode','eps_Milorga'};
        equ.sigma = {'sig_Electrode','sig_Milorga'};
    elseif tlm.conf.Milo==2
        equ.epsilonr = {'eps_Electrode','eps_Milorga','eps_Milorgb'};
        equ.sigma = {'sig_Electrode','sig_Milorga','sig_Milorgb'};
    end
elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
    % case with one cell (without membrane)
    equ.epsilonr = {'eps_Electrode','eps_Milorga','eps_Cytoplasme1'};
    equ.sigma = {'sig_Electrode','sig_Milorga','sig_Cytoplasme1'};
elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
    % case with one cell (without membrane)
    equ.epsilonr = {'eps_Electrode','eps_Milorga','eps_Cytoplasme1','eps_Cytoplasme2'};
    equ.sigma = {'sig_Electrode','sig_Milorga','sig_Cytoplasme1','sig_Cytoplasme2'};
elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0
    % case with one cell + nucleus (without membrane)
    equ.epsilonr = {'eps_Electrode','eps_Milorga','eps_Cytoplasme1','eps_Nucleus1'};
    equ.sigma = {'sig_Electrode','sig_Milorga','sig_Cytoplasme1','sig_Nucleus1'};
elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0
    % case with one cell + nucleus (without membrane)
    equ.epsilonr = {'eps_Electrode','eps_Milorga','eps_Cytoplasme1','eps_Cytoplasme2','eps_Nucleus1','eps_Nucleus2'};
    equ.sigma = {'sig_Electrode','sig_Milorga','sig_Cytoplasme1','sig_Cytoplasme2','sig_Nucleus1','sig_Nucleus2'};
elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1
    % case with one cell + nucleus + mitochondria (without membrane)
    equ.epsilonr = {'eps_Electrode','eps_Milorga','eps_Cytoplasme1','eps_Nucleus1','eps_Mitocho1'};
    equ.sigma = {'sig_Electrode','sig_Milorga','sig_Cytoplasme1','sig_Nucleus1','sig_Mitocho1'};
elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1
    % case with one cell + nucleus + mitochondria (without membrane)
    equ.epsilonr = {'eps_Electrode','eps_Milorga','eps_Cytoplasme1','eps_Cytoplasme2','eps_Nucleus1','eps_Nucleus2','eps_Mitocho1','eps_Mitocho2'};
    equ.sigma = {'sig_Electrode','sig_Milorga','sig_Cytoplasme1','sig_Cytoplasme2','sig_Nucleus1','sig_Nucleus2','sig_Mitocho1','sig_Mitocho2'};
end

%equ.epsrtensor = 1;
%equ.epstype = 'iso';
%equ.sigmatensor = 0;
%equ.sigtype = 'iso';
%equ.elconstrel = 'epsr';
%equ.P = {{0;0;0}};
%equ.Dr = {{0;0;0}};
%equ.magconstrel = 'mur';
%equ.M = {{0;0;0}};
%equ.Br = {{0;0;0}};
%equ.Je = {{0;0;0}};
%equ.v = {{0;0;0}};
%equ.maxwell = {{}};

% The system is solved only in case of no membrane

if tlm.conf.Cell==0 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
    % case without cell
    if tlm.conf.Milo==1
        equ.ind = [1,2,1,1,1];
    elseif tlm.conf.Milo==2
        equ.ind = [1,2,3,1,1,1];
    end
elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
    % case with one cell (without membrane)
    equ.ind = [1,2,1,1,1,3];
elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
    % case with one cell (without membrane)
    equ.ind = [1,2,1,1,1,3,4];
elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0
    % case with one cell + nucleus (without membrane)
    equ.ind = [1,2,1,1,1,3,4];
elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0
    % case with one cell + nucleus (without membrane)
    equ.ind = [1,2,1,1,1,3,5,4,6];
elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1
    % case with one cell + nucleus + mitochondria (without membrane)
    equ.ind = [1,2,1,1,1,3,4,5];
elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1
    % case with one cell + nucleus + mitochondria (without membrane)
    equ.ind = [1,2,1,1,1,3,5,7,4,6,8];
end

appl.equ = equ;

fem.appl{1} = appl;
%fem.sdim = {'x','y','z'};

% Simplify expressions
%fem.simplify = 'on';
fem.border = 1;
fem.units = 'SI';
fem.frame = {'ref'};

% Global expressions
%fem.expr = {};

% Functions
%clear fcns
%fem.functions = {};

if tlm.conf.Cell==0 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
    % case without cell
    if tlm.conf.Milo==1
        tlm.dom.list = [1,2,3,4,5];
    elseif tlm.conf.Milo==2
        tlm.dom.list = [1,2,3,4,5,6];
    end
elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
    % case with one cell (without membrane)
    tlm.dom.list = [1,2,3,4,5,6];
elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
    % case with two cell (without membrane)
    tlm.dom.list = [1,2,3,4,5,6,7];
elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0
    % case with one cell + nucleus (without membrane)
    tlm.dom.list = [1,2,3,4,5,6,7];
elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0
    % case with two cell + nucleus (without membrane)
    tlm.dom.list = [1,2,3,4,5,6,7,8,9];
elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1
    % case with one cell + nucleus + mitochondria (without membrane)
    tlm.dom.list = [1,2,3,4,5,6,7,8];
elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1
    % case with two cell + nucleus + mitochondria (without membrane)
    tlm.dom.list = [1,2,3,4,5,6,7,8,9,10,11];
end

cpt=1;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           case where we analyse the full spectrum
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
appl.var = {'epsilon0','8.854187817e-12','mu0','4*pi*1e-7'};
fem.appl{1} = appl;

% Multiphysics
fem=multiphysics(fem);

% Extend mesh
% fem.xmesh=meshextend(fem,'geoms',[1],'eqvars','on','cplbndeq','on','cplbndsh','off');
fem.xmesh=meshextend(fem);
    
tlm.conf.plist=[];

for a=log10(tlm.var.frequence.min):1:(log10(tlm.var.frequence.max)-1)
    for b=1:1:tlm.var.frequence.step
        tlm.conf.plist=[tlm.conf.plist b*10^a];
    end
end

% Solve problem
fem.sol=femlin(fem, ...
                    'symmetric','on', ...
                    'solcomp',{'V'}, ...
                    'outcomp',{'V'}, ...
                    'linsolver','gmres', ...
                    'prefun','ssor', ...
                    'pname','nu_emqvw', ...
                    'plist',tlm.conf.plist);

% Save current fem structure for restart purposes
%fem0=fem;

for a=log10(tlm.var.frequence.min):1:(log10(tlm.var.frequence.max)-1)
    for b=1:1:tlm.var.frequence.step
            
        f=b*10^a;
                
        % Integrate the current density on the electrode (ground)
        if tlm.conf.Milo==1
            I1=postint(fem,'nJ_emqvw', ...
                        'dl',25, ...
                        'edim',2, ...
                        'intorder',4, ...
                        'geomnum',1, ...
                        'solnum',1, ...
                        'phase',(0)*pi/180);
         elseif tlm.conf.Milo==2
            I1=postint(fem,'nJ_emqvw', ...
                        'dl',29, ...
                        'edim',2, ...
                        'intorder',4, ...
                        'geomnum',1, ...
                        'solnum',1, ...
                        'phase',(0)*pi/180);
         end
                
         % Calculate the corresponding Impedance
            
         if tlm.conf.points==2               % for 2 points measurement
                
            Z=((fem.sol.u(tlm.ind.pt.elec1)-fem.sol.u(tlm.ind.pt.elec2))*conj(I1))/(abs(I1)^2);
            
         elseif tlm.conf.points==4           % for 4 points measurement

            Z=((fem.sol.u(tlm.ind.pt.mesu1)-fem.sol.u(tlm.ind.pt.mesu2))*conj(I1))/(abs(I1)^2);
            
         end
                
         % Save the frequency, magnitude and Phase of the Impedance
         tlm.sol.val(cpt,1)=f;
         tlm.sol.val(cpt,2)=20*log10(abs(Z));
         tlm.sol.val(cpt,3)=angle(Z)*180/pi;
         tlm.sol.val(cpt,7)=real(Z);
         tlm.sol.val(cpt,8)=imag(Z);
         cpt=cpt+1;
    
    end
end

cptmem=cpt-1;

% Plot the Bode diagramm for the FEM Calculation

if (tlm.conf.figure==1)
    figure(2);
    clf('reset');
    subplot(2,1,1);
    semilogx(tlm.sol.val(:,1),tlm.sol.val(:,2));
    title('Bode Plot from FEM Calculations');
    ylabel('Magnitude (dB)');
    xlabel('Frequency');

    subplot(2,1,2);
    semilogx(tlm.sol.val(:,1),tlm.sol.val(:,3));
    ylabel('Phase (Degrees)');
    xlabel('Frequency');

    % Plot the Nyquist diagramm for the FEM Calculation


    figure(3);
    clf('reset');
    loglog(tlm.sol.val(:,7),-tlm.sol.val(:,8),'-or');

    axis ij;
    axis square;
    axis([1 1000000 1 1000000]);

    cpt=0;

    for a=log10(tlm.var.frequence.min):1:(log10(tlm.var.frequence.max)-1)
        for b=1:1:tlm.var.frequence.step
            f=b*10^a;
            cpt=cpt+1;
            if (tlm.sol.val(cpt,7)>1 && tlm.sol.val(cpt,7)<1000000) && ...
               (-tlm.sol.val(cpt,8)>1 && -tlm.sol.val(cpt,8)<1000000) && (b==1)    
                text(tlm.sol.val(cpt,7),-tlm.sol.val(cpt,8),tlm.conf.f(a));
            elseif (tlm.sol.val(cpt,7)>1 && tlm.sol.val(cpt,7)<1000000) && ...
                   (-tlm.sol.val(cpt,8)>1 && -tlm.sol.val(cpt,8)<1000000) && (f==tlm.var.frequence.step*10^(log10(tlm.var.frequence.max)-1))    
                text(tlm.sol.val(cpt,7),-tlm.sol.val(cpt,8),tlm.conf.f(10));
            end
        end
    end

    title('Nyquist Plot from FEM Calculations');
    ylabel('Im(|Z|)   (Ohms)');
    xlabel('Re(|Z|)   (Ohms)');

    title('Nyquist Plot from FEM Calculations');
    ylabel('Im(|Z|)   (Ohms)'); 
    xlabel('Re(|Z|)   (Ohms)');

end

% Save the results of the simulation in a file xx.fem

name1=sprintf('%s.fem',tlm.conf.Name);        % Name of the file for the Net List
fid=fopen(name1, 'w');                     % Open the File

fprintf(fid, '%s.fem\n',tlm.conf.Name);       % Write the first line of the file which is use as a title of the graphical output
fprintf(fid, '********************************************************************************\n');            
fprintf(fid, '*\n');            
fprintf(fid, '*                        Bode Diagram Calculated by FEM \n'); 
fprintf(fid, '*\n');            
fprintf(fid, '*                              BIOCAD Program\n');            
fprintf(fid, '*                               Release 3.0\n');            
fprintf(fid, '*\n');            
fprintf(fid, '*   Authors: Vincent Senez, Benoit Poussard, Thomas Delmas, Hugo Bertacchini\n'); 
fprintf(fid, '*\n');            
fprintf(fid, '*   Release 1.0 : July 2003\n');     
fprintf(fid, '*   Release 1.1 : December 2004\n');     
fprintf(fid, '*   Release 1.2 : July 2005\n');     
fprintf(fid, '*   Release 2.0 : December 2005\n');     
fprintf(fid, '*   Release 2.1 : July 2006\n');     
fprintf(fid, '*   Release 3.0 : December 2006\n');     
fprintf(fid, '*\n');            
fprintf(fid, '********************************************************************************\n');            

for cpt=1:1:cptmem
    fprintf(fid, '%1.3g %1.10g %1.10g\n',tlm.sol.val(cpt,1), tlm.sol.val(cpt,2), tlm.sol.val(cpt,3));  
end

fclose(fid);

tlm.conf.Name=tlm.conf.Name0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           case where we analyse only one frequency
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
for ii=1:1:3
    
    tlm.conf.Name0=tlm.conf.Name;
    
    if ii==1
        f=tlm.var.frequence.min;
    elseif ii==2
        f=10^((log10(tlm.var.frequence.max)-log10(tlm.var.frequence.min))/2);
    elseif ii==3
        f=tlm.var.frequence.max;
    end
    
    tlm.conf.Name=[tlm.conf.Name '_' num2str(f) 'Hz'];

    appl.var = {'epsilon0','8.854187817e-12','mu0','4*pi*1e-7','nu',num2str(f)};
    fem.appl{1} = appl;

    % Multiphysics
    fem=multiphysics(fem);

    % Extend mesh
%    fem.xmesh=meshextend(fem,'geoms',[1],'eqvars','on','cplbndeq','on','cplbndsh','off');
    fem.xmesh=meshextend(fem);

    % Solve problem
    fem.sol=femlin(fem, ...
                        'symmetric','on', ...
                        'solcomp',{'V'}, ...
                        'outcomp',{'V'}, ...
                        'linsolver','gmres', ...
                        'prefun','ssor');

    % Save current fem structure for restart purposes
%    fem0=fem;
    
    % Plot solution
    if (tlm.conf.figure==1)
        figure(4+(ii-1)*2);
        clf('reset');
            
        if tlm.conf.Cell==0 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
            % case without cell
            if tlm.conf.Milo==1
                tlm.dom.list = [1,2,3,4,5];
            elseif tlm.conf.Milo==2
                tlm.dom.list = [1,2,3,4,5,6];
            end
        elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
            % case with one cell (without membrane)
            tlm.dom.list = [1,2,3,4,5,6];
        elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
            % case with two cell (without membrane)
            tlm.dom.list = [1,2,3,4,5,6,7];
        elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0
            % case with one cell + nucleus (without membrane)
            tlm.dom.list = [1,2,3,4,5,6,7];
        elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0
            % case with two cell + nucleus (without membrane)
            tlm.dom.list = [1,2,3,4,5,6,7,8,9];
        elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1
            % case with one cell + nucleus + mitochondria (without membrane)
            tlm.dom.list = [1,2,3,4,5,6,7,8];
        elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1
            % case with two cell + nucleus + mitochondria (without membrane)
            tlm.dom.list = [1,2,3,4,5,6,7,8,9,10,11];
        end

        postplot(fem, ...
                'slicedata',{'V','cont','internal'}, ...
                'slicexspacing',1, ...
                'sliceyspacing',1, ...
                'slicezspacing',1, ...
                'slicemap','cool(1024)', ...
                'arrowdata',{'Jx_emqvw','Jy_emqvw','Jz_emqvw'}, ...
                'arrowxspacing',1, ...
                'arrowyspacing',7, ...
                'arrowzspacing',7, ...
                'arrowtype','cone', ...
                'arrowstyle','proportional', ...
                'arrowcolor',[1.0,0.0,0.0], ...
                'solnum',1, ...
                'phase',(0)*pi/180, ...
                'title',['Surface: Electrical Potential   Arrows: Total Current Density   Frequency: ',num2str(f,'%0.2g'),' Hertz'], ...
                'refine',3, ...
                'geom','on', ...
                'geomnum',1, ...
                'sdl',{tlm.dom.list}, ...
                'axisvisible','on', ...
                'axisequal','on', ...
                'grid','on', ...
                'camlight','off', ...
                'scenelight','off', ...
                'campos',[1.39072716328233E-4,3.74592355124712E-5,-4.83999558227306E-4], ...
                'camprojection','orthographic', ...
                'transparency',1.0);
                
    end
    
    if (tlm.conf.figure==1 && tlm.conf.save==1)
        name=[tlm.conf.Name '.emf'];
        saveas(4+(ii-1)*2,name);
    end
 
    % Save corresponding solution for comparison of the map of V with analytical and Spice calculation
 
%    ind = asseminit(fem,'init',{'V',1},'out','u');

%    %%%ind = asseminit(fem,'init',{'a',1,'b',2},'out','u'); for two coordinates

    x = asseminit(fem,'init','x','out','u');
    y = asseminit(fem,'init','y','out','u');
    z = asseminit(fem,'init','z','out','u');

    %p.x=x(find(ind==1));
    %p.y=y(find(ind==1));
    %p.z=z(find(ind==1));

    % Define the table linking the coordinates arrays to the solution array
    % The value of the variable i at node k is stored in
    % fem.sol.u at index table(i,k) fem.sol.u(table(i,k))
    % where k is the location of the node in p.x, p.y and p.z

    clear table;
%    for k=1:length(p.x)
%        pos=((x==p.x(k))&(y==p.y(k))&(z==p.z(k)));
%        table(1,k)=find(pos&(ind==1));
%    %%%  table(2,k)=find(pos&&(ind==2)); this is for 2 ddl
%    end
    for k=1:size(fem_mesh_p,2)
        pos=((x==fem_mesh_p(1,k))&(y==fem_mesh_p(2,k))&(z==fem_mesh_p(3,k)));
        table(1,k)=find(pos);
    %%%  table(2,k)=find(pos&&(ind==2)); this is for 2 ddl
    end
    

    for i=1:1:size(fem_mesh_p,2) %Loop on the total number of ddl
        tlm.var.X(i,1)=fem_mesh_p(1,i);
        tlm.var.Y(i,1)=fem_mesh_p(2,i);
        tlm.var.Z(i,1)=fem_mesh_p(3,i);
        tlm.sol.num(i,1)=real(fem.sol.u(table(1,i)));
    end
     
%     sliceomatic(tlm.sol.nu,tlm.var.X,tlm.var.Y,tlm.var.Z);
%    plot3c(tlm.var.X,tlm.var.Y,tlm.var.Z,tlm.sol.nu,'o');
    % Define a regular grid

    xlin1=linspace(-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode,tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode,50);
    ylin1=linspace(tlm.var.DecentrageZCellule(1)-tlm.var.LongueurChambre/2,tlm.var.DecentrageZCellule(1)+tlm.var.LongueurChambre/2,50);
    zlin1=linspace(tlm.var.DecentrageZCellule(1)-tlm.var.EpaisseurChambre/2,tlm.var.DecentrageZCellule(1)+tlm.var.EpaisseurChambre/2,50);
     
    [X1,Y1,Z1]= meshgrid(xlin1,ylin1,zlin1);

    % Interpolate tlm.sol.num(:,1) (FEM data) on the regular (X1,Y1) grid
    cd(tlm.conf.src);
    Res25=NewtFit(tlm.var.X(:,1),tlm.var.Y(:,1),tlm.var.Z(:,1),tlm.sol.num(:,1),X1,Y1,Z1);
    cd(tlm.conf.result);

%    Res1=griddata3(p.x,p.y,p.z,real(fem.sol.u(table(1,:))),X1,Y1,Z1,'nearest');
%    Res25=griddata3(tlm.var.X,tlm.var.Y,tlm.var.Z,tlm.sol.num,X1,Y1,Z1,'nearest');
%    Res25=interp3(tlm.var.X(:,1),tlm.var.Y(:,1),tlm.var.Z(:,1),tlm.sol.nu(:,1),X1,Y1,Z1,'cubic');
%    AA=reshape(real(fem.sol.u),size(fem_mesh_p,2),size(fem_mesh_p,2),size(fem_mesh_p,2))
%    vi = interp3(tlm.var.X(:,1),tlm.var.Y(:,1),tlm.var.Z(:,1),AA,X1,Y1,Z1); 
  
% Plot the result

    if (tlm.conf.figure==1)
        figure(5+(ii-1)*2);
        clf('reset');
     
        view(-30,10);
%        X1slice=[0];Y1slice=[];Z1slice=[tlm.var.DecentrageZCellule(1)];
%        slice(X1,Y1,Z1,Res1,X1slice,Y1slice,Z1slice);
        slice(X1,Y1,Z1,Res25,0,[],tlm.var.DecentrageZCellule(1));
%        [f,v] = isosurface(X1,Y1,Z1,tlm.sol.num,0.005);
%        patch('Faces',f,'Vertices',v)
%        shading flat

        colormap(cool);
%        mesh(X1,Y1,Res25);
%        meshc(X1,Y1,Res1);
     

        axis tight; 
        title(['2D Slices of the Electric Potential (Volt) at F=',num2str(f,'%0.2g'),' Hertz calculated by FEM']);
        zlabel('Z coordinate   (microns)');
        ylabel('Y coordinate   (microns)');
        xlabel('X coordinate   (microns)');

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
    fprintf(fid, '*                               Release 3.0\n');            
    fprintf(fid, '*\n');            
    fprintf(fid, '*   Authors: Vincent Senez, Benoit Poussard, Thomas Delmas, Hugo Bertacchini\n'); 
    fprintf(fid, '*\n');            
    fprintf(fid, '*   Release 1.0 : July 2003\n');     
    fprintf(fid, '*   Release 1.1 : December 2004\n');     
    fprintf(fid, '*   Release 1.2 : July 2005\n');     
    fprintf(fid, '*   Release 2.0 : December 2005\n');     
    fprintf(fid, '*   Release 2.1 : July 2006\n');     
    fprintf(fid, '*   Release 3.0 : December 2006\n');
    fprintf(fid, '*\n');            
    fprintf(fid, '********************************************************************************\n');            

    for i=1:1:size(fem_mesh_p,2)
            fprintf(fid, '%1.10g %1.10g %1.10g %1.10g\n',tlm.var.X(i,1), tlm.var.Y(i,1),tlm.var.Z(i,1), tlm.sol.num(i,1));  
    end
    
    fclose(fid);
    
    tlm.conf.Name=tlm.conf.Name0;
    
end

cd(tlm.conf.src);
