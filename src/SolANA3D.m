%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                              BIOCAD Program
%                               Release 1.0
%
%   Authors: Vincent Senez
%   
%   Release 1.0 : January 2019
%
%   Release 2.0 : January 2025
%
%   Function : Solve the 3D system by Analytical Method
%
%   Called by: Compute.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [tlm,model]=SolANA3D(tlm,model)

tlm.sol.val = [];
tlm.sol.fre=[];

%Turn off duplicate data point warning.
warning off MATLAB:griddata:DuplicateDataPoints

global fem_mesh_p;

tlm.conf.Name0=tlm.conf.Name;

name1=sprintf('%s.spi',tlm.conf.Name0);     % Name of the file
fid=fopen(name1, 'r');                     % Open the File
xyceCsvName=sprintf('%s.cir.FD.csv',tlm.conf.Name0);

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
    if exist(xyceCsvName,'file')==2
        xyceData=readmatrix(xyceCsvName);
        if ~isempty(xyceData) && size(xyceData,2)>=2
            tlm.sol.fre(:,1)=xyceData(:,1);
            tlm.sol.fre(:,2)=xyceData(:,2);
            Message=sprintf('\n\t\t . The Xyce CSV file has been exploited to extract frequencies');
            disp(Message);
            SPI=0;
        else
            Message=sprintf('\n\t\t . The Xyce CSV file exists but is malformed');
            disp(Message);
            SPI=1;
        end
    else
        Message=sprintf('\n\t\t . The SPI File does not exist in the current result directory');
        disp(Message);
        SPI=1;
    end

end

if isempty(tlm.sol.fre) || size(tlm.sol.fre,2)<2
    error('No valid frequency list found for analytical study. Expected %s.spi or %s', tlm.conf.Name0, xyceCsvName);
end

if tlm.conf.points==2               % for 2 points measurement
                
%    long=tlm.var.EcartementElectrode+tlm.var.LargeurElectrode;
    long=tlm.var.EcartementElectrode;
            
elseif tlm.conf.points==4           % for 4 points measurement

    long=tlm.var.LongueurChambre;
            
end

% Calculate Bode and Nyquist Plots

% 1st Case

% There is either no cell or the cell is electrically equal to the Milorga in  terms of electrical properties

% Calculate the Electrical Impedance with the Analytical (RC) Model 

nFreq=size(tlm.sol.fre,1);
cpt=0;

for a=1:1:nFreq
 %   for b=1:1:tlm.var.frequence.step
        cpt=cpt+1;
 %       f=b*10^a;
        f=tlm.sol.fre(cpt,2);
        if tlm.var.eps.MilOrga==0
            R=long/(tlm.var.sig.MilOrga*tlm.var.LargeurChambre*tlm.var.EpaisseurChambre);
            Z=R;
        elseif tlm.var.sig.MilOrga==0
            C=(tlm.var.eps.MilOrga*tlm.var.LargeurChambre*tlm.var.EpaisseurChambre)/long;
            Z=1/(j*2*pi*f*C);
        else
            if tlm.conf.Milo==1
                R=long/(tlm.var.sig.MilOrga*tlm.var.LargeurChambre*tlm.var.EpaisseurChambre);
                C=(tlm.var.eps.MilOrga*tlm.var.LargeurChambre*tlm.var.EpaisseurChambre)/long;
% serial            Z=R+(1/(i*2*pi*f*C));
                Z= R/(1+(j*R*C*pi*2*f));
            elseif tlm.conf.Milo==2
                R1=long/2/(tlm.var.sig.MilOrga*tlm.var.LargeurChambre*tlm.var.EpaisseurChambre);
                R2=long/2/(tlm.var.sig.MilOrgb*tlm.var.LargeurChambre*tlm.var.EpaisseurChambre);
                R=R1+R2;
                C1=(tlm.var.eps.MilOrga*tlm.var.LargeurChambre*tlm.var.EpaisseurChambre)/long/2;
                C2=(tlm.var.eps.MilOrgb*tlm.var.LargeurChambre*tlm.var.EpaisseurChambre)/long/2;
                C=4*C1*C2/(C1+C2);
% serial            Z=R+(1/(i*2*pi*f*C));
                Z= R/(1+(j*R*C*pi*2*f));
            end
        end
            
        tlm.sol.val(cpt,4)=f;
        tlm.sol.val(cpt,5)=20*log10(abs(Z));
        tlm.sol.val(cpt,6)=angle(Z)*180/pi;
        tlm.sol.val(cpt,7)=real(Z);
        tlm.sol.val(cpt,8)=imag(Z);

    %end
end
    
% Plots
   
%modifié à partir d'ici par vsnz le 04/10/24
%if (tlm.conf.figure==1)
    
%    % Plot the Bode Plot for the Analytical Calculation
    
%    figure(10);
%    clf('reset');
%    tlm.conf.fig=tlm.conf.fig+1;

%    subplot(2,1,1);
%    semilogx(tlm.sol.val(:,4),tlm.sol.val(:,5)); vsnz 04/10
%    title('Bode Plot from Analytical Calculations');
%    ylabel('Magnitude (dB)');
%    xlabel('Frequency');

%    subplot(2,1,2);
%    semilogx(tlm.sol.val(:,4),tlm.sol.val(:,6));
%    ylabel('Phase (Degrees)');
%    xlabel('Frequency');
    
%    % Plot the Nyquist diagramm for the Analytical Calculation

%    figure(11);
%    clf('reset');
%    tlm.conf.fig=tlm.conf.fig+1;

%    loglog(tlm.sol.val(:,7),-tlm.sol.val(:,8),'-or');

%    axis ij;
%    axis square;
%    axis([1 1000000 1 1000000]);

%    cpt=0;

%    for a=log10(tlm.var.frequence.min):1:log10(tlm.var.frequence.max)
%        for b=1:1:tlm.var.frequence.step
%            f=b*10^a;
%            cpt=cpt+1;
%            if (tlm.sol.val(cpt,7)>1 && tlm.sol.val(cpt,7)<1000000) && ...
%               (-tlm.sol.val(cpt,8)>1 && -tlm.sol.val(cpt,8)<1000000) && (b==1)    
%                text(tlm.sol.val(cpt,7),-tlm.sol.val(cpt,8),tlm.conf.f(a));
%            elseif (tlm.sol.val(cpt,7)>1 && tlm.sol.val(cpt,7)<1000000) && ...
%               (-tlm.sol.val(cpt,8)>1 && -tlm.sol.val(cpt,8)<1000000) && (f==tlm.var.frequence.max)    
%                text(tlm.sol.val(cpt,7),-tlm.sol.val(cpt,8),tlm.conf.f(10));
%            end
%        end
%    end

%    title('Nyquist Plot from Analytical Calculations');
%    ylabel('Im(|Z|)   (Ohms)');
%    xlabel('Re(|Z|)   (Ohms)');
    
%end
%fin modifications par vsnz le 04/10/24

% Save the results of the simulation in a file xx.ana

name1=sprintf('%s.ana',tlm.conf.Name);        % Name of the file for the Bode Diagramm
fid=fopen(name1, 'w');                     % Open the File

fprintf(fid, '%s.ana\n',tlm.conf.Name);       % Write the first line of the file which is use as a title of the graphical output
fprintf(fid, '********************************************************************************\n');            
fprintf(fid, '*\n');            
fprintf(fid, '*               Bode Diagram Calculated by Analytical Method \n'); 
fprintf(fid, '*\n');            
fprintf(fid, '*                              BIOCAD Program\n');            
fprintf(fid, '*                               Release 3.1\n');            
fprintf(fid, '*\n');            
fprintf(fid, '*   Authors: Vincent Senez, Benoit Poussard, Thomas Delmas\n'); 
fprintf(fid, '*\n');            
fprintf(fid, '*   Release 1.0 : July 2003\n'); 
fprintf(fid, '*   Release 1.1 : December 2004\n');
fprintf(fid, '*   Release 1.2 : July 2005\n'); 
fprintf(fid, '*   Release 2.0 : December 2005\n');
fprintf(fid, '*   Release 2.1 : July 2006\n');     
fprintf(fid, '*   Release 3.0 : December 2006\n');
fprintf(fid, '*   Release 3.1 : December 2007\n');
fprintf(fid, '*\n');            
fprintf(fid, '********************************************************************************\n');            
fprintf(fid, '*\n');
fprintf(fid, '* Values:\n');  

cpt=0;

for a=1:1:nFreq
%for a=log10(tlm.var.frequence.min):1:log10(tlm.var.frequence.max)-1
%    for b=1:1:tlm.var.frequence.step
        cpt=cpt+1;
        fprintf(fid, '%1.3g %1.10g %1.10g\n',tlm.sol.val(cpt,4), tlm.sol.val(cpt,5), tlm.sol.val(cpt,6));  
%    end
end

fclose(fid);
    
% Calculate 2D maps of the electrical potential

% 1st Case

% There is either no cell or the cell is electrically equal to the Milorga in  terms of electrical properties

% Calculate the Electrical Impedance with the Analytical Model 

for ij=1:1:3
    
    if ij==1
        f=tlm.var.frequence.min;
    elseif ij==2
        ex=round((log10(tlm.var.frequence.max)-log10(tlm.var.frequence.min))/2);
        f=5*10^ex;
    elseif ij==3
        f=tlm.var.frequence.max;
    end
    
    tlm.conf.Name=[tlm.conf.Name0 '_' num2str(f) 'Hz'];

    % Read the coordinates of the Nodes

    name1=sprintf('%s.cor',tlm.conf.Name0);       % Name of the file (generated in EcritNetlist3D)containing the coordinates of all nodes of the fem mesh

    [tlm.var.Node1, tlm.var.X, tlm.var.Y, tlm.var.Z] = textread(name1,'%u %f %f %f');
    
%    % Read the Voltage value at each node

%    name2=sprintf('%s.aex',[tlm.conf.Name0 '_full']);     % Name of the file (generated by SPICE) containing the voltage value at each of the fem nodes
%    fid=fopen(name2, 'r');                     % Open the File

%    if fid>=0       % The file exists

%        [tlm.var.Node2, tlm.var.Suf, Equal, tlm.var.Volt] = textread(name2,'*V(%[0 1 2 3 4 5 6 7 8 9]%s %q %f','headerlines',4);
%    
%        fclose(fid);
%    
%    end

    % Calculate the Electric Potential

    pulse=2*pi*f;                       % angular frequency

    E0=tlm.var.v0/(tlm.var.EcartementElectrode+2*tlm.var.LargeurElectrode);    % Electrical Field
    
    perm1=complex(tlm.var.eps.MilOrga,-tlm.var.sig.MilOrga/pulse);                % complex permittivity
    perm2=complex(tlm.var.eps.MembCel(1),-tlm.var.sig.MembCel(1)/pulse);
    perm3=complex(tlm.var.eps.Cytoplasme(1),-tlm.var.sig.Cytoplasme(1)/pulse);

%    K1=(perm2-perm1)/(perm2+perm1);
%    K2=perm2/(perm2+perm3);

    R1=tlm.var.RayonXCellule(1);               %radius of the cytoplasm
    R2=R1+tlm.var.EpaisseurMembrane;           %radius of the cell
%    a=R1/R2;

    % calcul of the laplace solution parameter

    if tlm.conf.Cell==1
        K=(R2^2*(perm2+perm3)+R1^2*(perm2-perm3))/(R2^2*(perm2+perm3)*(perm1+perm2)+R1^2*(perm1-perm2)*(perm2-perm3));
        A=-2*perm1*E0*R2^2*(K-1/(2*perm1));
        B=(1/(2*perm2))*(-E0*R2^2*(perm2-perm1)+A*(perm1+perm2));
        C=-E0+(A-B)/R2^2;
        D=C+B/R1^2;
    end

    %Calculation of the electrostatic potential

    tlm.sol.Res=zeros(size(tlm.var.Node1,1),3);            %initialisation

    for ii=1:1:size(tlm.var.Node1,1)                 %for each 
        
        r=sqrt((tlm.var.X(ii,1)-tlm.var.DecentrageYCellule(1))^2+(tlm.var.Y(ii,1)-tlm.var.DecentrageXCellule(1))^2+...
               (tlm.var.Z(ii,1)-tlm.var.DecentrageZCellule(1))^2);
           
        if r>0
            teta=acos((tlm.var.Y(ii,1)-tlm.var.DecentrageXCellule(1))/r);
        else
            teta=0;
        end
        
        rbis=r*sin(teta);
        
        if rbis>0
            phi=acos((tlm.var.X(ii,1)-tlm.var.DecentrageYCellule(1))/rbis);
        else
            phi=0;
        end
        
%        zcoorxy=complex(tlm.var.X(ii,1)-tlm.var.DecentrageYCellule(1),tlm.var.Y(ii,1)-tlm.var.DecentrageXCellule(1)); % The cell is centered on (0,0)

%        rxy=abs(zcoorxy); %polar coordonate
        
%        zcoor=complex(rxy,tlm.var.Z(ii,1)-tlm.var.DecentrageZCellule(1)); % The cell is centered on (0,0)teta=atan2(-imag(zcoor),real(zcoor));
%        if ii>=170 & ii<=180
%            disp(r)
%        end
%        if (-tlm.var.EcartementElectrode/2<tlm.var.X(ii,1)) & (tlm.var.X(ii,1)<tlm.var.EcartementElectrode/2) %restrict visualisation (The formula is not valid in the electrodes)

        if tlm.conf.Cell==0
                
            pot=-E0*r*cos(teta);
                
        elseif tlm.conf.Cell==1
                
            if r>=R1                        % out of the cell
                pot=(-E0*r+A/r)*cos(teta);
            else                            % in the cell
                pot=D*r*cos(teta);
            end
        end
            
        tlm.sol.num(ii,2)=pot+tlm.var.v0/2;      % middle tension off-set (Vin/2)

        
%        else
        
%            tlm.var.Res(ii,1)=0.;  
        
%        end 
    
    end

    % Début de modification par Vincent Senez
%    % Plot the results 

%    % Application mode 1

%    clear appl

%    appl.mode.class = 'QuasiStatics';
%    appl.module = 'ACDC';
%    appl.name = 'qvw';
%    appl.assignsuffix = '_qvw';

%    clear prop

%    prop.elemdefault='Lag1';
%    prop.analysis='smallcurr';

%    appl.prop = prop;
%    fem.appl{1} = appl;
%    fem=multiphysics(fem);
%    fem.xmesh=meshextend(fem);
    
%    % Extraction of nodes coordinates for our ddl V
 
%    if tlm.conf.fem==33
%        nodes = xmeshinfo(fem.xmesh,'out','nodes');
%    else
%        x = asseminit(fem,'init','x','out','u');
%        y = asseminit(fem,'init','y','out','u');
%        z = asseminit(fem,'init','z','out','u');
%
%        % Define the table linking the coordinates arrays to the solution array
%        % The value of the variable i at node k is stored in
%        % fem.sol.u at index table(i,k) fem.sol.u(table(i,k))
%        % where k is the location of the node in p.x, p.y and p.z

%        clear table;
%        
%        for k=1:size(fem_mesh_p,2)
%            pos=((x==fem_mesh_p(1,k))&(y==fem_mesh_p(2,k))&(z==fem_mesh_p(3,k)));
%            table(1,k)=find(pos);
%        end
%    end
%    
%    for k=1:size(fem_mesh_p,2)
%       if tlm.conf.fem==33
%           u(nodes.dofs(1,k),1)=tlm.sol.num(k,2);
%       else
%           u(table(1,k),1)=tlm.sol.num(k,2);
%       end
%    end
%        
%    nodes = xmeshinfo(fem.xmesh,'out','nodes');
        
%    for k=1:size(fem_mesh_p,2)
%        u(nodes.dofs(1,k),1)=tlm.sol.num(k,2);
%    end

%    fem.sol=femsol(u);
%        
%    if tlm.conf.Cell==0 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
%        % case without cell
%        if tlm.conf.Milo==1
%            tlm.dom.list = [1,2,3,4,5];
%        elseif tlm.conf.Milo==2
%            tlm.dom.list = [1,2,3,4,5,6];
%        end
%    elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
%        % case with one cell (without membrane)
%        tlm.dom.list = [1,2,3,4,5,6];
%    elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==0 && tlm.conf.Mitocho==0
%        % case with two cell (without membrane)
%        tlm.dom.list = [1,2,3,4,5,6,7];
%    elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0
%        % case with one cell + nucleus (without membrane)
%        tlm.dom.list = [1,2,3,4,5,6,7];
%    elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0
%        % case with two cell + nucleus (without membrane)
%        tlm.dom.list = [1,2,3,4,5,6,7,8,9];
%    elseif tlm.conf.Cell==1 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1
%        % case with one cell + nucleus + mitochondria (without membrane)
%        tlm.dom.list = [1,2,3,4,5,6,7,8];
%    elseif tlm.conf.Cell==2 && tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1
%        % case with two cell + nucleus + mitochondria (without membrane)
%        tlm.dom.list = [1,2,3,4,5,6,7,8,9,10,11];
%    end

%    % Plot the result

%    if (tlm.conf.figure==1)
%    
%        if ij==1
%            figure(12);
%        elseif ij==2
%            figure(14);
%        elseif ij==3
%            figure(16);
%        end

%        clf('reset');
%        tlm.conf.fig=tlm.conf.fig+1;

%        postplot(fem, ...
%                    'slicedata',{'V','cont','internal'}, ...
%                    'slicexspacing',1, ...
%                    'sliceyspacing',1, ...
%                    'slicezspacing',1, ...
%                    'slicemap','cool(1024)', ...
%                    'solnum',1, ...
%                    'phase',(0)*pi/180, ...
%                    'title',['Surface: Electrical Potential   Frequency: ',num2str(f,'%0.2g'),' Hertz obtained by Analytical Model'], ...
%                    'refine',3, ...
%                    'geom','on', ...
%                    'geomnum',1, ...
%                    'sdl',{tlm.dom.list}, ...
%                    'axisvisible','on', ...
%                    'axisequal','on', ...
%                    'grid','on', ...
%                    'camlight','off', ...
%                    'scenelight','off', ...
%                    'campos',[1.E-4,1.E-4,1.E-4], ...
%                    'camprojection','orthographic', ...
%                    'transparency',1.0);
%               
                
%        % Plot one specific slice (at zlin1) of the Analytique values in a 2D
       % figure 
       % 
       % xlin1=linspace(tlm.var.OrigineX-tlm.var.LargeurElectrode/2,tlm.var.OrigineX+tlm.var.LargeurElectrode/2,100);
       % ylin1=linspace(tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode,tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode,100);
       % zlin1=tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/2;
       % 
       % % Define a regular grid
       % 
       % [X1,Y1,Z1]= meshgrid(xlin1,ylin1,zlin1);
       % 
       %  % Interpolate the potential on the regular (X1,Y1,Z1) grid
       % 
       % xx=[X1(:),Y1(:),Z1(:)]';
       % size(xx,1);
       % Res1 = mphinterp(model, 'V', 'coord', xx);
       % Res1=reshape(real(Res1(1,:)),size(X1));
       % 
       % % Plot the result
       % 
       % if ij==1
       %     figure(13);
       % elseif ij==2
       %     figure(15);
       % elseif ij==3
       %     figure(17);
       % end
       % 
       % clf('reset');
       % tlm.conf.fig=tlm.conf.fig+1;
       % 
       % colormap(hot(256));
       % 
       % surf(X1,Y1,Res1);
       % 
       % camlight right;
       % lighting phong;
       % shading interp;
       % 
       % az=125;
       % el=20;
       % view(az,el);
       % 
       % axis tight; 
       % title(['2D Map of the Electric Potential (Volt) obtained by Analytical Model at F=',num2str(f,'%0.2g'),' Hertz and for z=',num2str(zlin1),' m']);
       % zlabel('Potential Difference   (V)');
       % ylabel('Y coordinate   (microns)');
       % xlabel('X coordinate   (microns)');

     
        
%    end
    
    % Save the results of the simulation in a file xx.ana_cou

    name1=sprintf('%s.ana_cou',tlm.conf.Name);        % Name of the file for the Net List
    fid=fopen(name1, 'w');                     % Open the File

    fprintf(fid, '%s.ana_cou\n',tlm.conf.Name);       % Write the first line of the file which is use as a title of the graphical output
    fprintf(fid, '********************************************************************************\n');            
    fprintf(fid, '*\n');            
    fprintf(fid, '*         3D Map of Electric Potential Calculated by Analytical Model \n'); 
    fprintf(fid, '*                THE FREQUENCY FOR THIS RESULT IS %e HERTZ \n',f); 
    fprintf(fid, '*\n');            
    fprintf(fid, '*                              BIOCAD Program\n');            
    fprintf(fid, '*                               Release 3.1\n');            
    fprintf(fid, '*\n');            
    fprintf(fid, '*   Authors: Vincent Senez, Benoit Poussard, Thomas Delmas, Hugo Bertacchini\n'); 
    fprintf(fid, '*\n');            
    fprintf(fid, '*   Release 1.0 : July 2003\n');     
    fprintf(fid, '*   Release 1.1 : December 2004\n');     
    fprintf(fid, '*   Release 1.2 : July 2005\n');     
    fprintf(fid, '*   Release 2.0 : December 2005\n');     
    fprintf(fid, '*   Release 2.1 : July 2006\n');     
    fprintf(fid, '*   Release 3.0 : December 2006\n');     
    fprintf(fid, '*   Release 3.1 : December 2007\n');     
    fprintf(fid, '*\n');            
    fprintf(fid, '********************************************************************************\n');            

    for ik=1:1:size(tlm.var.Node1,1)
            fprintf(fid, '%1.10g %1.10g %1.10g %1.10g\n',tlm.var.X(ik,1), tlm.var.Y(ik,1), tlm.var.Z(ik,1), tlm.sol.num(ik,2));  
    end
    
    fclose(fid);
end

tlm.conf.Name=tlm.conf.Name0;