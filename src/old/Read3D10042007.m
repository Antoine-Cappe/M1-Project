%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%   Function :  Plot results calculated by TL, FE & AN Methods 
%               on 3D Systems
%
%   Called by: Postprocessing.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function tlm=Read3D(tlm,fil)

% Initialization

clear global fem_mesh_p;

global fem_mesh_p;

[tlm,fem]=Geom3Dcad(tlm);

Message=sprintf('\n\t * Mesh Statitics: %u éléments, %u nodes',size(fem.mesh.t,2),size(fem.mesh.p,2));
disp(Message);
if tlm.conf.log==1
    fprintf(fil,'\n\t * Mesh Statitics: %u éléments, %u nodes',size(fem.mesh.t,2),size(fem.mesh.p,2));
    fprintf(fil,'\n ');
end

% Transfer the fem.mesh structure into matlab arrays to save computing time
% in the following subroutines

fem_mesh_p(:,:)=fem.mesh.p(:,:);

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

cd(tlm.conf.result);

%if tlm.var.Freq==-1
    
Message=sprintf('\n Generate Bode and Nyquist Plots for Electrical Impedance');
disp(Message);
    
if tlm.conf.log==1
    fprintf(fil,'\n Generate Bode and Nyquist Plots for Electrical Impedance');
    fprintf(fil,'\n '); 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Analysis of the Bode plot [check |Z|(freq) & arg(Z)(freq)]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Read the SPICE results in the xx.spi file

Message=sprintf('\n\t * SPICE Simulations');
disp(Message);
    
if tlm.conf.log==1
    fprintf(fil,'\n\t * SPICE Simulations');
    fprintf(fil,'\n '); 
end

name1=sprintf('%s.spi',tlm.conf.Name);     % Name of the file
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
                    tlm.sol.mesu.dcb(i+1,:)=str2num(tlineread);
                    tlineread = fgetl(fid);
%                    disp(tlineread);
                    tlm.sol.mesu.pha(i+1,:)=str2num(tlineread);
                    tlineread = fgetl(fid);
%                    disp(tlineread);
                    i=i+1;
            end
            break
        end
    end

    fclose(fid);
    
    for ii=1:1:(tlm.var.frequence.step*imul+1)
        tlm.sol.spi(ii,1)=tlm.sol.fre(ii,2);
        tlm.sol.spi(ii,2)=tlm.sol.mesu.dcb(ii,1);
        tlm.sol.spi(ii,3)=tlm.sol.mesu.pha(ii,1)*180/pi;
        tlm.sol.spi(ii,4)=real(10^(tlm.sol.mesu.dcb(ii,1)/20)*exp(j*tlm.sol.mesu.pha(ii,1)));
        tlm.sol.spi(ii,5)=imag(10^(tlm.sol.mesu.dcb(ii,1)/20)*exp(j*tlm.sol.mesu.pha(ii,1)));
    end

    if (tlm.sol.spi(1,3)>90)
        tlm.sol.spi(:,3)=tlm.sol.spi(:,3)-180;
    elseif (tlm.sol.spi(1,3)<-90)
        tlm.sol.spi(:,3)=tlm.sol.spi(:,3)+180;
    end
    
% Plot the Bode diagramm for the SPICE Calculation

    figure(1);
    clf('reset');
    tlm.conf.fig=tlm.conf.fig+1;

    subplot(2,1,1);
    semilogx(tlm.sol.spi(:,1),tlm.sol.spi(:,2));
    title('Bode Plot from Spice Calculations');
    ylabel('Magnitude (dB)');
    xlabel('Frequency');
 
    subplot(2,1,2);
    semilogx(tlm.sol.spi(:,1),tlm.sol.spi(:,3));
    ylabel('Phase (Degrees)');
    xlabel('Frequency');

    % Save the Figure

    saveas(1,'SPICE_Bode.emf');
    
    % Plot the Nyquist Plot for the Spice Calculation

    figure(2);
    clf('reset');
    tlm.conf.fig=tlm.conf.fig+1;

    loglog(tlm.sol.spi(:,4),-tlm.sol.spi(:,5),'-or');

    axis ij;
    axis square;
    axis([1 1000000 1 1000000]);

    cpt=0;

    for a=1:1:(tlm.var.frequence.step*imul+1)
        f=tlm.sol.spi(a,1);
            
        if abs(100*(f-1e0)/1e0)<=1 || abs(100*(f-1e1)/1e1)<=1 || abs(100*(f-1e2)/1e2)<=1 || abs(100*(f-1e3)/1e3)<=1 || abs(100*(f-1e4)/1e4)<=1 || ...
           abs(100*(f-1e5)/1e5)<=1 || abs(100*(f-1e6)/1e6)<=1 || abs(100*(f-1e7)/1e7)<=1 || abs(100*(f-1e8)/1e8)<=1 || abs(100*(f-1e9)/1e9)<=1 || ...
           abs(100*(f-1e10)/1e10)<=1

           cpt=cpt+1;
            
           if (tlm.sol.spi(a,4)>1 && tlm.sol.spi(a,4)<1000000) && ...
              (-tlm.sol.spi(a,5)>1 && -tlm.sol.spi(a,5)<1000000)
            
                text(tlm.sol.spi(a,4),-tlm.sol.spi(a,5),tlm.conf.f(cpt));
           end
                    
        end
    end

    title('Nyquist Plot from Spice Calculations');
    ylabel('Im(|Z|)   (Ohms)');
    xlabel('Re(|Z|)   (Ohms)');

    % Save the Figure

    saveas(2,'SPICE_Nyquist.emf');
    
    Message=sprintf('\n\t\t . The SPI File has been exploited');
    disp(Message);
    SPI=0;

else
    
    Message=sprintf('\n\t\t . The SPI File does not exist in the current result directory');
    disp(Message);
    SPI=1;
    
end

% Read the FEM results in the xx.fem file

Message=sprintf('\n\t * FEM Simulations');
disp(Message);
    
if tlm.conf.log==1
    fprintf(fil,'\n\t * FEM Simulations');
    fprintf(fil,'\n '); 
end

% Open the File

name1=sprintf('%s.fem',tlm.conf.Name);     % Name of the file 
fid=fopen(name1, 'r');                     % Open the File

if fid>=0       % The file exists
    
    tlineref='* Values:'; 

    i=0;

    while ~feof(fid)
        tlineread = fgetl(fid);
        C = strcmp(tlineref,tlineread);  
        if C==1
            imul=log10(tlm.var.frequence.max)-log10(tlm.var.frequence.min);
            while i<(imul*tlm.var.frequence.step+1)

                tlineread = fgetl(fid);
%               disp(tlineread);
                tlm.sol.fem(i+1,:)=str2num(tlineread);
                i=i+1;
            end
            break
        end
    end

    fclose(fid);
    
    tlm.sol.val=zeros(1,8);         % Empty the array
    
    imul=log10(tlm.var.frequence.max)-log10(tlm.var.frequence.min);
    for ii=1:1:(imul*tlm.var.frequence.step+1)
        tlm.sol.val(ii,7)=real(10^(tlm.sol.fem(ii,2)/20)*exp(j*tlm.sol.fem(ii,3)*pi/180));
        tlm.sol.val(ii,8)=imag(10^(tlm.sol.fem(ii,2)/20)*exp(j*tlm.sol.fem(ii,3)*pi/180));
    end

% Plot the Bode diagramm for the FEM Calculation

    figure(3);
    clf('reset');
    tlm.conf.fig=tlm.conf.fig+1;

    subplot(2,1,1);
    semilogx(tlm.sol.fem(:,1),tlm.sol.fem(:,2));
    title('Bode Plot from FEM Calculations');
    ylabel('Magnitude (dB)');
    xlabel('Frequency');

    subplot(2,1,2);
    semilogx(tlm.sol.fem(:,1),tlm.sol.fem(:,3));
    ylabel('Phase (Degrees)');
    xlabel('Frequency');

    % Save the Figure

    saveas(3,'FEM_Bode.emf');
    
    % Plot the Nyquist diagramm for the FEM Calculation

    figure(4);
    clf('reset');
    tlm.conf.fig=tlm.conf.fig+1;

    loglog(tlm.sol.val(:,7),-tlm.sol.val(:,8),'-or');

    axis ij;
    axis square;
    axis([1 1000000 1 1000000]);

    cpt=0;

    for a=log10(tlm.var.frequence.min):1:log10(tlm.var.frequence.max)
        for b=1:1:tlm.var.frequence.step
            f=b*10^a;
            cpt=cpt+1;
            if cpt<=(imul*tlm.var.frequence.step+1)
                if (tlm.sol.val(cpt,7)>1 && tlm.sol.val(cpt,7)<1000000) && ...
                    (-tlm.sol.val(cpt,8)>1 && -tlm.sol.val(cpt,8)<1000000) && (b==1)    
                        text(tlm.sol.val(cpt,7),-tlm.sol.val(cpt,8),tlm.conf.f(a));
                elseif (tlm.sol.val(cpt,7)>1 && tlm.sol.val(cpt,7)<1000000) && ...
                    (-tlm.sol.val(cpt,8)>1 && -tlm.sol.val(cpt,8)<1000000) && (f==tlm.var.frequence.max)    
                    text(tlm.sol.val(cpt,7),-tlm.sol.val(cpt,8),tlm.conf.f(10));
                end
            end
        end
    end

    title('Nyquist Plot from FEM Calculations');
    ylabel('Im(|Z|)   (Ohms)');
    xlabel('Re(|Z|)   (Ohms)');
    
    % Save the Figure

    saveas(4,'FEM_Nyquist.emf');
    
    Message=sprintf('\n\t\t . The FEM File has been exploited');
    disp(Message);
    
    FEM=0;
    
else
    
    Message=sprintf('\n\t\t . The FEM File does not exist in the current result directory');
    disp(Message);
    FEM=1;
    
end

% Read the ANA results in the xx.ana file
    
Message=sprintf('\n\t * Analytical Simulations');
disp(Message);
    
if tlm.conf.log==1
    fprintf(fil,'\n\t * Analytical Simulations');
    fprintf(fil,'\n '); 
end

name1=sprintf('%s.ana',tlm.conf.Name);     % Name of the file 
fid=fopen(name1, 'r');                     % Open the File

if fid>=0       % The file exists

    tlineref='* Values:'; 

    i=0;

    while ~feof(fid)
        tlineread = fgetl(fid);
        C = strcmp(tlineref,tlineread);  
        if C==1
            imul=log10(tlm.var.frequence.max)-log10(tlm.var.frequence.min);
            while i<(imul*tlm.var.frequence.step+1)
                tlineread = fgetl(fid);
%               disp(tlineread);
                tlm.sol.ana(i+1,:)=str2num(tlineread);
                i=i+1;
            end
            break
        end
    end

    fclose(fid);
    
    tlm.sol.val=zeros(1,8);         % Empty the array
    
    imul=log10(tlm.var.frequence.max)-log10(tlm.var.frequence.min);
    for ii=1:1:(imul*tlm.var.frequence.step+1)
        tlm.sol.val(ii,7)=real(10^(tlm.sol.ana(ii,2)/20)*exp(j*tlm.sol.ana(ii,3)*pi/180));
        tlm.sol.val(ii,8)=imag(10^(tlm.sol.ana(ii,2)/20)*exp(j*tlm.sol.ana(ii,3)*pi/180));
    end

    % Plot the Bode Plot for the Analytical Calculation

    figure(5);
    clf('reset');
    tlm.conf.fig=tlm.conf.fig+1;

    subplot(2,1,1);
    semilogx(tlm.sol.ana(:,1),tlm.sol.ana(:,2));
    title('Bode Plot from Analytical Calculations');
    ylabel('Magnitude (dB)');
    xlabel('Frequency');

    subplot(2,1,2);
    semilogx(tlm.sol.ana(:,1),tlm.sol.ana(:,3));
    ylabel('Phase (Degrees)');
    xlabel('Frequency');
    
    % Save the Figure

    saveas(5,'ANA_Bode.emf');
    
    % Plot the Nyquist diagramm for the Analytical Calculation

    figure(6);
    clf('reset');
    tlm.conf.fig=tlm.conf.fig+1;

    loglog(tlm.sol.val(:,7),-tlm.sol.val(:,8),'-or');

    axis ij;
    axis square;
    axis([1 1000000 1 1000000]);

    cpt=0;

    for a=log10(tlm.var.frequence.min):1:log10(tlm.var.frequence.max)
        for b=1:1:tlm.var.frequence.step
            f=b*10^a;
            cpt=cpt+1;
            if cpt<=(imul*tlm.var.frequence.step+1)
                if (tlm.sol.val(cpt,7)>1 && tlm.sol.val(cpt,7)<1000000) && ...
                    (-tlm.sol.val(cpt,8)>1 && -tlm.sol.val(cpt,8)<1000000) && (b==1)    
                        text(tlm.sol.val(cpt,7),-tlm.sol.val(cpt,8),tlm.conf.f(a));
                elseif (tlm.sol.val(cpt,7)>1 && tlm.sol.val(cpt,7)<1000000) && ...
                       (-tlm.sol.val(cpt,8)>1 && -tlm.sol.val(cpt,8)<1000000) && (f==tlm.var.frequence.max)    
                        text(tlm.sol.val(cpt,7),-tlm.sol.val(cpt,8),tlm.conf.f(10));
                end
            end
        end
    end


    title('Nyquist Plot from Analytical Calculations');
    ylabel('Im(|Z|)   (Ohms)');
    xlabel('Re(|Z|)   (Ohms)');
    
    % Save the Figure

    saveas(6,'ANA_Nyquist.emf');
    
    Message=sprintf('\n\t\t . The ANA data has been exploited');
    disp(Message);

    ANA=0;
    
else
    
    Message=sprintf('\n\t\t . The ANA File does not exist in the current result directory');
    disp(Message);
    ANA=1;
    
end
    
if SPI==0 && FEM==0
    
    tlm.sol.int.spi=[];
    tlm.sol.mag.err=[];
    tlm.sol.tet.err=[];


% Interpolate Spice data on the frequencies used for the FEM calculations

%    tlm.sol.int.spi(:,1)=tlm.sol.fem(:,1);
%    tlm.sol.int.spi(:,2)=interp1(tlm.sol.spi(:,1),tlm.sol.spi(:,2),tlm.sol.fem(:,1));
%    tlm.sol.int.spi(:,3)=interp1(tlm.sol.spi(:,1),tlm.sol.spi(:,3),tlm.sol.fem(:,1));
    tlm.sol.int.spi(:,2)=interp1(tlm.sol.fem(:,1),tlm.sol.fem(:,2),tlm.sol.spi(:,1),'spline');
    tlm.sol.int.spi(:,3)=interp1(tlm.sol.fem(:,1),tlm.sol.fem(:,3),tlm.sol.spi(:,1),'spline');

%    tlm.sol.int.spi(:,3)=tlm.sol.int.spi(:,3)+180;
%    tlm.sol.fem(:,3)=tlm.sol.fem(:,3)+180;

% Calculate the error between SPICE & FEM calculations 

    for i=1:1:size(tlm.sol.int.spi,1)                     %for each node
%        tlm.sol.mag.err(i,1)=abs((tlm.sol.int.spi(i,2)-tlm.sol.fem(i,2))/tlm.sol.fem(i,2)); 
%       tlm.sol.tet.err(i,1)=abs((tlm.sol.int.spi(i,3)-tlm.sol.fem(i,3))/tlm.sol.fem(i,3)); 
        tlm.sol.mag.err(i,1)=100*abs(((10^(tlm.sol.int.spi(i,2)/20)-(10^(tlm.sol.spi(i,2)/20)))/10^(tlm.sol.spi(i,2)/20))); 
        if tlm.sol.spi(i,3)~=0
            tlm.sol.tet.err(i,1)=100*abs((tlm.sol.int.spi(i,3)-tlm.sol.spi(i,3))/tlm.sol.spi(i,3)); 
        else
            tlm.sol.tet.err(i,1)=0.;
        end
    end

    figure(7);
    clf('reset');
    tlm.conf.fig=tlm.conf.fig+1;

    subplot(2,1,1);
    semilogx(tlm.sol.spi(:,1),tlm.sol.mag.err(:,1));
    title('Relative Error on Impedance Module and Phase between Spice & FEM Calculations');
    ylabel('Relative Error on Impedance Module (%)');
    xlabel('Frequency');

    subplot(2,1,2);
    semilogx(tlm.sol.spi(:,1),tlm.sol.tet.err(:,1));
    ylabel('Relative Error on Impedance Phase (%)');
    xlabel('Frequency');
    
    % Save the Figure

    saveas(7,'SPICE_FEM_Comp.emf');

end

if ANA==0 && SPI==0    
    
    tlm.sol.int.spi=[];
    tlm.sol.mag.err=[];
    tlm.sol.tet.err=[];
    
    % Interpolate Spice data on the frequencies used for the Analytical calculations

%    tlm.sol.int.spi(:,1)=tlm.sol.ana(:,1);
%    tlm.sol.int.spi(:,2)=interp1(tlm.sol.spi(:,1),tlm.sol.spi(:,2),tlm.sol.ana(:,1));
%    tlm.sol.int.spi(:,3)=interp1(tlm.sol.spi(:,1),tlm.sol.spi(:,3),tlm.sol.ana(:,1));

%    tlm.sol.int.spi(:,3)=tlm.sol.int.spi(:,3)+180;
%    tlm.sol.ana(:,3)=tlm.sol.ana(:,3)+180;

    tlm.sol.int.spi(:,2)=interp1(tlm.sol.ana(:,1),tlm.sol.ana(:,2),tlm.sol.spi(:,1),'spline');
    tlm.sol.int.spi(:,3)=interp1(tlm.sol.ana(:,1),tlm.sol.ana(:,3),tlm.sol.spi(:,1),'spline');

%    tlm.sol.int.spi(:,3)=tlm.sol.int.spi(:,3)+180;

    % Calculate the error between SPICE & Analytical calculations 
    for i=1:1:size(tlm.sol.int.spi,1)                     %for each node
%        tlm.sol.mag.err(i,2)=abs((tlm.sol.int.spi(i,2)-tlm.sol.ana(i,2))/tlm.sol.ana(i,2)); 
%        tlm.sol.tet.err(i,2)=abs((tlm.sol.int.spi(i,3)-tlm.sol.ana(i,3))/tlm.sol.ana(i,3)); 
        tlm.sol.mag.err(i,2)=100*abs(((10^(tlm.sol.int.spi(i,2)/20)-(10^(tlm.sol.spi(i,2)/20)))/10^(tlm.sol.spi(i,2)/20))); 
        if tlm.sol.spi(i,3)~=0
            tlm.sol.tet.err(i,2)=100*abs((tlm.sol.int.spi(i,3)-tlm.sol.spi(i,3))/tlm.sol.spi(i,3));
        else
            tlm.sol.tet.err(i,2)=0.;
        end
    end

    figure(8);
    clf('reset');
    tlm.conf.fig=tlm.conf.fig+1;
    
    subplot(2,1,1);
    semilogx(tlm.sol.spi(:,1),tlm.sol.mag.err(:,2));
    title('Relative Error on Impedance Module & Phase between Spice & Analytical Calculations');
    ylabel('Relative Error on Impedance Module (%)');
    xlabel('Frequency');

    subplot(2,1,2);
    semilogx(tlm.sol.spi(:,1),tlm.sol.tet.err(:,2));
    ylabel('Relative Error on Impedance Phase (%)');
    xlabel('Frequency');
    
    % Save the Figure

    saveas(8,'SPICE_ANA_Comp.emf');

end

if ANA==0 && FEM==0

    % Interpolate Analytical data on the frequencies used for the FEM calculations

    tlm.sol.int.ana(:,1)=tlm.sol.fem(:,1);
    tlm.sol.int.ana(:,2)=interp1(tlm.sol.ana(:,1),tlm.sol.ana(:,2),tlm.sol.fem(:,1));
    tlm.sol.int.ana(:,3)=interp1(tlm.sol.ana(:,1),tlm.sol.ana(:,3),tlm.sol.fem(:,1));

    % Calculate the error between FEM & Analytical calculations 

    for i=1:1:size(tlm.sol.int.ana,1)                     %for each node
%        tlm.sol.mag.err(i,3)=abs((tlm.sol.int.ana(i,2)-tlm.sol.fem(i,2))/tlm.sol.fem(i,2)); 
%        tlm.sol.mag.err(i,3)=abs((tlm.sol.int.ana(i,3)-tlm.sol.fem(i,3))/tlm.sol.fem(i,3)); 
        tlm.sol.mag.err(i,3)=100*abs(((10^(tlm.sol.int.ana(i,2)/20)-(10^(tlm.sol.fem(i,2)/20)))/10^(tlm.sol.fem(i,2)/20))); 
        if tlm.sol.fem(i,3)~=0
            tlm.sol.tet.err(i,3)=100*abs((tlm.sol.int.ana(i,3)-tlm.sol.fem(i,3))/tlm.sol.fem(i,3));
        else
            tlm.sol.tet.err(i,3)=0.;
        end
    end

    figure(9);
    clf('reset');
    tlm.conf.fig=tlm.conf.fig+1;

    subplot(2,1,1);
    semilogx(tlm.sol.fem(:,1),tlm.sol.mag.err(i,3));
    title('Relative Error on Impedance Module & Phase between FEM & Analytical Calculations');
    ylabel('Relative Error on Impedance Module (%)');
    xlabel('Frequency');

    subplot(2,1,2);
    semilogx(tlm.sol.fem(:,1),tlm.sol.mag.err(i,3));
    ylabel('Relative Error on Impedance Phase (%)');
    xlabel('Frequency');    
    
    % Save the Figure

    saveas(9,'FEM_ANA_Comp.emf');

end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Analysis of the 2D Maps in the 3D solution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Message=sprintf('\n Generate 2D Map for Electrical Potential');
disp(Message);
    
if tlm.conf.log==1
    fprintf(fil,'\n Generate 2D Map for Electrical Potential');
    fprintf(fil,'\n '); 
end

% Initialization

parastr1=')';                               % For the ELDO results, we select the single nodes
parastr2='MTER)';                           % and for the double nodes, we take the node outside the membrane
parastr3='NBIS)';                           % (i.e.: in the organic medium for cell membrane, in the cytoplasm
parastr4='OBIS)';                           % for the nucleus and mitochondria)

tlm.conf.Name0=tlm.conf.Name;
    
% Read the SPICE Data (coordinates) in the xx.cor file and (voltage) in the xx.spi_cou file

Message=sprintf('\n\t * SPICE Simulations');
disp(Message);
    
if tlm.conf.log==1
    fprintf(fil,'\n\t * SPICE Simulations');
    fprintf(fil,'\n '); 
end
        
% Read the coordinates of the Nodes in the xx.cor file

name1=sprintf('%s.cor',tlm.conf.Name);       % Name of the file (generated in EcritNetlist2D)containing the coordinates of all nodes of the fem mesh
fid=fopen(name1, 'r');                     % Open the File

if fid>=0       % The file exists

    fclose(fid);
    [tlm.var.Node1, tlm.var.X1, tlm.var.Y1, tlm.var.Z1] = textread(name1,'%u %f %f %f');
else
    Message=sprintf('\n\t\t . The COR File does not exist in the current result directory');
    disp(Message);
    if tlm.conf.log==1
        fprintf(fil,'\n\t\t . The COR File does not exist in the current result directory');
        fprintf(fil,'\n '); 
     end
end

for ii=1:1:3
    
    if ii==1
        f=tlm.var.frequence.min;
    elseif ii==2
        ex=round((log10(tlm.var.frequence.max)-log10(tlm.var.frequence.min))/2);
        f=5*10^ex;
    elseif ii==3
        f=tlm.var.frequence.max;
    end
 
    tlm.conf.Name=[tlm.conf.Name '_' num2str(f) 'Hz'];

    name2=sprintf('%s.spi_cou',tlm.conf.Name);     % Name of the file (generated by SPICE) containing the voltage value at each of the fem nodes
    fid=fopen(name2, 'r');                     % Open the File

    if fid>=0       % The file exists

        tlineref='Values:'; 

        i=0;

        while ~feof(fid)
            tlineread = fgetl(fid);
            C = strcmp(tlineref,tlineread);
            if C==1
                tlineread = fgetl(fid);
%               disp(tlineread);
                while i<size(fem_mesh_p,2)
                    tlineread = fgetl(fid);
%                    disp(tlineread);
                    tlm.sol.mesu.ri(i+1,:)=str2num(tlineread);
                    i=i+1;
                end
                break
            end
        end

        fclose(fid);

        for k=1:size(fem_mesh_p,2)
            tlm.var.Volt1(k)=tlm.sol.mesu.ri(k,1);
            tlm.var.VoltSpice(k,ii)=tlm.sol.mesu.ri(k,1);
        end
        
        Message=sprintf('\n\t\t . The SPI_COU file (%s.spi_cou) has been exploited',tlm.conf.Name);
        disp(Message);
            
        if tlm.conf.log==1
            fprintf(fil,'\n\t\t . The SPI_COU file (%s.spi_cou) has been exploited',tlm.conf.Name);
            fprintf(fil,'\n '); 
        end
        
        SPI_COU=0;
    
    else
    
        Message=sprintf('\n\t\t . The SPI_COU File (%s.spi_cou) does not exist in the current result directory',tlm.conf.Name);
        disp(Message);
        if tlm.conf.log==1
            fprintf(fil,'\n\t\t . The SPI_COU File (%s.spi_cou) does not exist in the current result directory',tlm.conf.Name);
            fprintf(fil,'\n '); 
        end
        
        SPI_COU=1;
    
    end
    
% Plot the results 

    if SPI_COU==0
        
        if size(tlm.var.X1,1)~=size(tlm.var.Volt1,2)
            Message=sprintf('\n\t\t . Error: The %s.cor and %s.spi_cou files do not correspond',tlm.conf.Name,tlm.conf.Name);
            disp(Message);
            return
        end

        % Application mode 1

        clear appl

        appl.mode.class = 'QuasiStatics';
        appl.module = 'ACDC';
        appl.name = 'qvw';
        appl.assignsuffix = '_qvw';

        clear prop

        prop.elemdefault='Lag1';
        prop.analysis='smallcurr';

        appl.prop = prop;
        fem.appl{1} = appl;
        fem=multiphysics(fem);
        fem.xmesh=meshextend(fem);
        
        % Extraction of nodes coordinates for our ddl V
 
        if tlm.conf.fem==33
            nodes = xmeshinfo(fem.xmesh,'out','nodes');
        else
            x = asseminit(fem,'init','x','out','u');
            y = asseminit(fem,'init','y','out','u');
            z = asseminit(fem,'init','z','out','u');

            % Define the table linking the coordinates arrays to the solution array
            % The value of the variable i at node k is stored in
            % fem.sol.u at index table(i,k) fem.sol.u(table(i,k))
            % where k is the location of the node in p.x, p.y and p.z

            clear table;
            table=zeros(1,size(fem_mesh_p,2));
        
            for k=1:size(fem_mesh_p,2)
                disp(k);
                pos=((x==fem_mesh_p(1,k))&(y==fem_mesh_p(2,k))&(z==fem_mesh_p(3,k)));
                table(1,k)=find(pos);
            end
        end
    
        for k=1:size(fem_mesh_p,2)
            if tlm.conf.fem==33
                u(nodes.dofs(1,k),1)=tlm.var.Volt1(k);
            else
                u(table(1,k),1)=tlm.var.Volt1(k);
            end
        end
        
%        nodes = xmeshinfo(fem.xmesh,'out','nodes');
        
%        for k=1:size(fem_mesh_p,2)
%            u(nodes.dofs(1,k),1)=tlm.var.Volt1(k);
%        end

        fem.sol=femsol(u);
        
        % Plot the result

        if ii==1
            figure(10);
        elseif ii==2
            figure(12);
        elseif ii==3
            figure(14);
        end

        clf('reset');
        tlm.conf.fig=tlm.conf.fig+1;

        postplot(fem, ...
                    'slicedata',{'V','cont','internal'}, ...
                    'slicexspacing',1, ...
                    'sliceyspacing',1, ...
                    'slicezspacing',1, ...
                    'slicemap','cool(1024)', ...
                    'solnum',1, ...
                    'phase',(0)*pi/180, ...
                    'title',['Surface: Electrical Potential   Frequency: ',num2str(f,'%0.2g'),' Hertz calculated with SPICE Model'], ...
                    'refine',3, ...
                    'geom','on', ...
                    'geomnum',1, ...
                    'sdl',{tlm.dom.list}, ...
                    'axisvisible','on', ...
                    'axisequal','on', ...
                    'grid','on', ...
                    'camlight','off', ...
                    'scenelight','off', ...
                    'campos',[1.E-4,1.E-4,1.E-4], ...
                    'camprojection','orthographic', ...
                    'transparency',1.0);
               
        % Save the Figure

        if ii==1
            saveas(10,'3D_Pot_SPICE_1.emf');
        elseif ii==2
            saveas(12,'3D_Pot_SPICE_2.emf');
        elseif ii==3
            saveas(14,'3D_Pot_SPICE_3.emf');
        end

% Plot one specific slice (at zlin2) of the FEM values in a 2D figure 

        xlin1=linspace(tlm.var.OrigineX-tlm.var.LargeurElectrode/2,tlm.var.OrigineX+tlm.var.LargeurElectrode/2,100);
        ylin1=linspace(tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode,tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode,100);
        zlin1=tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/2;
        
        % Define a regular grid

       [X1,Y1,Z1]= meshgrid(xlin1,ylin1,zlin1);
    
        % Interpolate the potential on the regular (X1,Y1,Z1) grid
        
        xx=[X1(:),Y1(:),Z1(:)]';
        size(xx,1);
        Res1=postinterp(fem,'V',xx,'ext',1);
        Res1=reshape(Res1,size(X1));
        
        %   Plot the result

        if ii==1
            figure(11);
        elseif ii==2
            figure(13);
        elseif ii==3
            figure(15);
        end

        clf('reset');
        tlm.conf.fig=tlm.conf.fig+1;

        colormap(hot(256));
    
        surf(X1,Y1,Res1);
    
        camlight right;
        lighting phong;
        shading interp;
    
        az=40;
        el=50;
        view(az,el);
 
        axis tight; 
        title(['2D Map of the Electric Potential (Volt) obtained by SPICE at F=',num2str(f,'%0.2g'),' Hertz and for z=',num2str(zlin1),' m']);
        zlabel('Potential Difference   (V)');
        ylabel('Y coordinate   (microns)');
        xlabel('X coordinate   (microns)');
        
        % Save the Figure

        if ii==1
            saveas(11,'2D_Pot_SPICE_1.emf');
        elseif ii==2
            saveas(13,'2D_Pot_SPICE_2.emf');
        elseif ii==3
            saveas(15,'2D_Pot_SPICE_3.emf');
        end

        tlm.conf.Name=tlm.conf.Name0;
    end
end

% Read the FEM Data (coordinates and voltage) in the xx.fem_cou file

Message=sprintf('\n\t * FEM Simulations');
disp(Message);
    
if tlm.conf.log==1
    fprintf(fil,'\n\t * FEM Simulations');
    fprintf(fil,'\n '); 
end

for ii=1:1:3
    
    if ii==1
        f=tlm.var.frequence.min;
    elseif ii==2
        ex=round((log10(tlm.var.frequence.max)-log10(tlm.var.frequence.min))/2);
        f=5*10^ex;
    elseif ii==3
        f=tlm.var.frequence.max;
    end
 
    tlm.conf.Name=[tlm.conf.Name '_' num2str(f) 'Hz'];

    name3=sprintf('%s.fem_cou',tlm.conf.Name);     % Name of the file (generated by SPICE) containing the voltage value at each of the fem nodes
    fid=fopen(name3, 'r');                     % Open the File

    if fid>=0       % The file exists

        [tlm.var.X2, tlm.var.Y2, tlm.var.Z2, tlm.var.Volt2] = textread(name3,'%f %f %f %f','headerlines',19);
    
        fclose(fid);
        
        Message=sprintf('\n\t\t . The FEM file (%s.fem_cou) has been exploited',tlm.conf.Name);
        disp(Message);
        
        if tlm.conf.log==1
            fprintf(fil,'\n\t\t . The FEM file (%s.fem_cou) has been exploited',tlm.conf.Name);
            fprintf(fil,'\n '); 
        end
        
        FEM_COU=0;
    
    else
    
        Message=sprintf('\n\t\t . The FEM File (%s.fem_cou) does not exist in the current result directory',tlm.conf.Name);
        disp(Message);
        if tlm.conf.log==1
            fprintf(fil,'\n\t\t . The FEM File (%s.fem_cou) does not exist in the current result directory',tlm.conf.Name);
            fprintf(fil,'\n '); 
        end
        
        FEM_COU=1;
    
    end
    
    for k=1:size(fem_mesh_p,2)
        tlm.var.VoltFem(k,ii)=tlm.var.Volt2(k);
    end
    
    % Plot slice of the FEM values in a 3D figure
    
    if FEM_COU==0
        
        % Application mode 1

        clear appl

        appl.mode.class = 'QuasiStatics';
        appl.module = 'ACDC';
        appl.name = 'qvw';
        appl.assignsuffix = '_qvw';

        clear prop

        prop.elemdefault='Lag1';
        prop.analysis='smallcurr';

        appl.prop = prop;
        fem.appl{1} = appl;
        fem=multiphysics(fem);
        fem.xmesh=meshextend(fem);
        
        % Extraction of nodes coordinates for our ddl V
 
        if tlm.conf.fem==33
            nodes = xmeshinfo(fem.xmesh,'out','nodes');
        else
            x = asseminit(fem,'init','x','out','u');
            y = asseminit(fem,'init','y','out','u');
            z = asseminit(fem,'init','z','out','u');

            % Define the table linking the coordinates arrays to the solution array
            % The value of the variable i at node k is stored in
            % fem.sol.u at index table(i,k) fem.sol.u(table(i,k))
            % where k is the location of the node in p.x, p.y and p.z

            clear table;
        
            for k=1:size(fem_mesh_p,2)
                pos=((x==fem_mesh_p(1,k))&(y==fem_mesh_p(2,k))&(z==fem_mesh_p(3,k)));
                table(1,k)=find(pos);
            end
        end
    
        for k=1:size(fem_mesh_p,2)
            if tlm.conf.fem==33
                u(nodes.dofs(1,k),1)=tlm.var.Volt2(k);
            else
                u(table(1,k),1)=tlm.var.Volt2(k);
            end
        end

%        nodes = xmeshinfo(fem.xmesh,'out','nodes');
        
%        for k=1:size(fem_mesh_p,2)
%            u(nodes.dofs(1,k),1)=tlm.var.Volt2(k);
%        end

        fem.sol=femsol(u);
        
        % Plot the result

        if ii==1
            figure(16);
        elseif ii==2
            figure(18);
        elseif ii==3
            figure(20);
        end

        clf('reset');
        tlm.conf.fig=tlm.conf.fig+1;

        postplot(fem, ...
                    'slicedata',{'V','cont','internal'}, ...
                    'slicexspacing',1, ...
                    'sliceyspacing',1, ...
                    'slicezspacing',1, ...
                    'slicemap','cool(1024)', ...
                    'solnum',1, ...
                    'phase',(0)*pi/180, ...
                    'title',['Surface: Electrical Potential   Frequency: ',num2str(f,'%0.2g'),' Hertz calculated by FEM'], ...
                    'refine',3, ...
                    'geom','on', ...
                    'geomnum',1, ...
                    'sdl',{tlm.dom.list}, ...
                    'axisvisible','on', ...
                    'axisequal','on', ...
                    'grid','on', ...
                    'camlight','off', ...
                    'scenelight','off', ...
                    'campos',[1.E-4,1.E-4,1.E-4], ...
                    'camprojection','orthographic', ...
                    'transparency',1.0);
                
        % Save the Figure

        if ii==1
            saveas(16,'3D_Pot_FEM_1.emf');
        elseif ii==2
            saveas(18,'3D_Pot_FEM_2.emf');
        elseif ii==3
            saveas(20,'3D_Pot_FEM_3.emf');
        end

% Plot one specific slice (at zlin2) of the FEM values in a 2D figure 

        xlin2=linspace(tlm.var.OrigineX-tlm.var.LargeurElectrode/2,tlm.var.OrigineX+tlm.var.LargeurElectrode/2,100);
        ylin2=linspace(tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode,tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode,100);
        zlin2=tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/2;
        
        % Define a regular grid

       [X2,Y2,Z2]= meshgrid(xlin2,ylin2,zlin2);
    
        % Interpolate the potential on the regular (X2,Y2,Z2) grid
        
        xx=[X2(:),Y2(:),Z2(:)]';
        Res2=postinterp(fem,'V',xx,'ext',1);
        Res2=reshape(Res2,size(X2));
        
        %   Plot the result

        if ii==1
            figure(17);
        elseif ii==2
            figure(19);
        elseif ii==3
            figure(21);
        end

        clf('reset');
        tlm.conf.fig=tlm.conf.fig+1;

        colormap(hot(256));
    
        surf(X2,Y2,Res2);
    
        camlight right;
        lighting phong;
        shading interp;
    
        az=40;
        el=50;
        view(az,el);
 
        axis tight; 
        title(['2D Map of the Electric Potential (Volt) obtained by FEM at F=',num2str(f,'%0.2g'),' Hertz and for z=',num2str(zlin2),' m']);
        zlabel('Potential Difference   (V)');
        ylabel('Y coordinate   (microns)');
        xlabel('X coordinate   (microns)');

    end

    %   Compare FEM and Spice data - Calculate the difference and relative errors

    if (SPI_COU==0 && FEM_COU==0)
        
        for k=1:size(fem_mesh_p,2)
            tlm.var.Volt1(k)=tlm.var.VoltSpice(k,ii);
        end

        tlm.var.Moy1=0;
    
        for i=1:1:size(fem_mesh_p,2)                     %for each node in file xxx.aex
    
%        if tlm.var.Volt2(i)>=1e-5
%            tlm.var.Err1(i) = 100*abs((tlm.var.Volt1(i)-tlm.var.Volt2(i)))/abs(tlm.var.Volt2(i));
%        else
%            tlm.var.Err1(i) = 0.;
%        end

            tlm.var.Err1(i) = abs((tlm.var.Volt1(i)-tlm.var.Volt2(i)));
            tlm.var.Moy1 = tlm.var.Moy1 + tlm.var.Err1(i);
        
        end

        tlm.var.Moy1 = tlm.var.Moy1/size(fem_mesh_p,2);

        Message=sprintf('\n\t\t\t At f=%u Hz, Mean Delta(V) [Spice & Fem] is: %u (Volt)', ...
                        f,tlm.var.Moy1);
        disp(Message);
        Message=sprintf('\n\t\t\t At f=%u Hz, Mean Relative Error [Spice & Fem] is: %u (%%)\n', ...
                        f,100*tlm.var.Moy1/tlm.var.v0/2);
        disp(Message);

        xlin3=linspace(tlm.var.OrigineX-tlm.var.LargeurElectrode/2,tlm.var.OrigineX+tlm.var.LargeurElectrode/2,100);
        ylin3=linspace(tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode,tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode,100);
        zlin3=tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/2;
        
        % Define a regular grid

        [X3,Y3,Z3]= meshgrid(xlin3,ylin3,zlin3); % to be used with griddata
    
        % Interpolate tlm.var.Err1 (Error between Spice & FEM) on the regular (X3,Y3,Z3) grid
        
%        xx=[X3(:),Y3(:),Z3(:)];
        Res3=Res2-Res1;
%        Res3=postinterp(fem,'u',xx,'ext',1);
%        Res3=reshape(Res3,size(X3));
        
        %   Plot the result

        if ii==1
            figure(22);
        elseif ii==2
            figure(23);
        elseif ii==3
            figure(24);
        end

        clf('reset');
        tlm.conf.fig=tlm.conf.fig+1;

        colormap(hot(256));
    
        surf(X3,Y3,Res3);
    
        camlight right;
        lighting phong;
        shading interp;
    
        az=40;
        el=50;
        view(az,el);
 
        axis tight; 
        title(['2D Map of the Electric Potential Difference(Volt) between Spice and FEM at F=',num2str(f,'%0.2g'),' Hertz and for z=',num2str(zlin2),' m']);
        zlabel('Potential Difference   (V)');
        ylabel('Y coordinate   (microns)');
        xlabel('X coordinate   (microns)');
        
        % Save the Figure

        if ii==1
            saveas(22,'2D_Pot_FEM_1.emf');
        elseif ii==2
            saveas(23,'2D_Pot_FEM_2.emf');
        elseif ii==3
            saveas(24,'2D_Pot_FEM_3.emf');
        end


    end
    
    tlm.conf.Name=tlm.conf.Name0;
    
end

Message=sprintf('\n\t * ANA Simulations');
disp(Message);
    
if tlm.conf.log==1
    fprintf(fil,'\n\t * ANA Simulations');
    fprintf(fil,'\n '); 
end

% Read the ANA Data (coordinates and voltage) in the xx.ana_cou file

for ii=1:1:3
    
    if ii==1
        f=tlm.var.frequence.min;
    elseif ii==2
        ex=round((log10(tlm.var.frequence.max)-log10(tlm.var.frequence.min))/2);
        f=5*10^ex;
    elseif ii==3
        f=tlm.var.frequence.max;
    end
 
    tlm.conf.Name=[tlm.conf.Name '_' num2str(f) 'Hz'];

    name4=sprintf('%s.ana_cou',tlm.conf.Name);     % Name of the file (generated by SPICE) containing the voltage value at each of the fem nodes
    fid=fopen(name4, 'r');                         % Open the File

    if fid>=0       % The file exists

        [tlm.var.X3, tlm.var.Y3, tlm.var.Z3, tlm.var.Volt3] = textread(name4,'%f %f %f %f','headerlines',19);
    
        fclose(fid);
    
        Message=sprintf('\n\t\t . The ANA file (%s.ana_cou) has been exploited',tlm.conf.Name);
        disp(Message);
        
        if tlm.conf.log==1
            fprintf(fil,'\n\t\t . The ANA file (%s.ana_cou) has been exploited',tlm.conf.Name);
            fprintf(fil,'\n '); 
        end
        
        ANA_COU=0;
    
    else
    
        Message=sprintf('\n\t\t . The ANA File (%s.ana_cou) does not exist in the current result directory',tlm.conf.Name);
        disp(Message);
        if tlm.conf.log==1
            fprintf(fil,'\n\t\t . The ANA File (%s.ana_cou) does not exist in the current result directory',tlm.conf.Name);
            fprintf(fil,'\n '); 
        end

        ANA_COU=1;
    
    end

    % ANA values

    if ANA_COU==0

         % Application mode 1

        clear appl

        appl.mode.class = 'QuasiStatics';
        appl.module = 'ACDC';
        appl.name = 'qvw';
        appl.assignsuffix = '_qvw';

        clear prop

        prop.elemdefault='Lag1';
        prop.analysis='smallcurr';

        appl.prop = prop;
        fem.appl{1} = appl;
        fem=multiphysics(fem);
        fem.xmesh=meshextend(fem);
        
        % Extraction of nodes coordinates for our ddl V
 
        if tlm.conf.fem==33
            nodes = xmeshinfo(fem.xmesh,'out','nodes');
        else
            x = asseminit(fem,'init','x','out','u');
            y = asseminit(fem,'init','y','out','u');
            z = asseminit(fem,'init','z','out','u');

            % Define the table linking the coordinates arrays to the solution array
            % The value of the variable i at node k is stored in
            % fem.sol.u at index table(i,k) fem.sol.u(table(i,k))
            % where k is the location of the node in p.x, p.y and p.z

            clear table;
        
            for k=1:size(fem_mesh_p,2)
                pos=((x==fem_mesh_p(1,k))&(y==fem_mesh_p(2,k))&(z==fem_mesh_p(3,k)));
                table(1,k)=find(pos);
            end
        end
    
        for k=1:size(fem_mesh_p,2)
            if tlm.conf.fem==33
                u(nodes.dofs(1,k),1)=tlm.var.Volt3(k);
            else
                u(table(1,k),1)=tlm.var.Volt3(k);
            end
        end
        
%        nodes = xmeshinfo(fem.xmesh,'out','nodes');
        
%        for k=1:size(fem_mesh_p,2)
%            u(nodes.dofs(1,k),1)=tlm.var.Volt3(k);
%        end

        fem.sol=femsol(u);
        
        % Plot the result

        if ii==1
            figure(25);
        elseif ii==2
            figure(27);
        elseif ii==3
            figure(29);
        end

        clf('reset');
        tlm.conf.fig=tlm.conf.fig+1;

        postplot(fem, ...
                    'slicedata',{'V','cont','internal'}, ...
                    'slicexspacing',1, ...
                    'sliceyspacing',1, ...
                    'slicezspacing',1, ...
                    'slicemap','cool(1024)', ...
                    'solnum',1, ...
                    'phase',(0)*pi/180, ...
                    'title',['Surface: Electrical Potential  Frequency: ',num2str(f,'%0.2g'),' Hertz calculated with analytical model'], ...
                    'refine',3, ...
                    'geom','on', ...
                    'geomnum',1, ...
                    'sdl',{tlm.dom.list}, ...
                    'axisvisible','on', ...
                    'axisequal','on', ...
                    'grid','on', ...
                    'camlight','off', ...
                    'scenelight','off', ...
                    'campos',[1.E-4,1.E-4,1.E-4], ...
                    'camprojection','orthographic', ...
                    'transparency',1.0);
        
        % Save the Figure

        if ii==1
            saveas(25,'3D_Pot_ANA_1.emf');
        elseif ii==2
            saveas(27,'3D_Pot_ANA_2.emf');
        elseif ii==3
            saveas(29,'3D_Pot_ANA_3.emf');
        end

                
% Plot one specific slice (at zlin2) of the FEM values in a 2D figure 

        xlin4=linspace(tlm.var.OrigineX-tlm.var.LargeurElectrode/2,tlm.var.OrigineX+tlm.var.LargeurElectrode/2,100);
        ylin4=linspace(tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode,tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode,100);
        zlin4=tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/2;
        
        % Define a regular grid

       [X4,Y4,Z4]= meshgrid(xlin4,ylin4,zlin4);
    
        % Interpolate the potential on the regular (X4,Y4,Z4) grid
        
        xx=[X4(:),Y4(:),Z4(:)]';
        Res4=postinterp(fem,'V',xx,'ext',1);
        Res4=reshape(Res4,size(X4));
        
        %   Plot the result

        if ii==1
            figure(26);
        elseif ii==2
            figure(28);
        elseif ii==3
            figure(30);
        end

        clf('reset');
        tlm.conf.fig=tlm.conf.fig+1;

        colormap(hot(256));
    
        surf(X4,Y4,Res4);
    
        camlight right;
        lighting phong;
        shading interp;
    
        az=40;
        el=50;
        view(az,el);
 
        axis tight; 
        title(['2D Map of the Electric Potential (Volt) obtained by ANA at F=',num2str(f,'%0.2g'),' Hertz and for z=',num2str(zlin2),' m']);
        zlabel('Potential Difference   (V)');
        ylabel('Y coordinate   (microns)');
        xlabel('X coordinate   (microns)');
        
        % Save the Figure

        if ii==1
            saveas(26,'2D_Pot_ANA_1.emf');
        elseif ii==2
            saveas(28,'2D_Pot_ANA_2.emf');
        elseif ii==3
            saveas(30,'2D_Pot_ANA_3.emf');
        end

    end
    
 %   Compare Analytical and Spice data - Calculate the difference and relative errors

    if (SPI_COU==0 && ANA_COU==0)
        
        for k=1:size(fem_mesh_p,2)
            tlm.var.Volt1(k)=tlm.var.VoltSpice(k,ii);
        end

        tlm.var.Moy2=0;
    
        for i=1:1:size(fem_mesh_p,2)                     %for each node in file xxx.spi_cou
    
%           if tlm.var.Volt3(i)>=1e-5
%               tlm.var.Err2(i) = 100*abs((tlm.var.Volt1(i)-tlm.var.Volt3(i)))/abs(tlm.var.Volt3(i));
%           else
%               tlm.var.Err2(i) = 0.;
%           end

            tlm.var.Err2(i) = abs((tlm.var.Volt1(i)-tlm.var.Volt3(i)));
            tlm.var.Moy2 = tlm.var.Moy2 + tlm.var.Err2(i);
        
        end

        tlm.var.Moy2 = tlm.var.Moy2/size(fem_mesh_p,2);

        Message=sprintf('\n\t\t\t At f=%u Hz, Mean Delta(V) [Spice & Analytical] is: %u (Volt)', ...
                        f,tlm.var.Moy2);
        disp(Message);
        Message=sprintf('\n\t\t\t At f=%u Hz, Mean Relative Error [Spice & Analytical] is: %u (%%)\n', ...
                        f,100*tlm.var.Moy2/tlm.var.v0/2);
        disp(Message);

        xlin5=linspace(tlm.var.OrigineX-tlm.var.LargeurElectrode/2,tlm.var.OrigineX+tlm.var.LargeurElectrode/2,100);
        ylin5=linspace(tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode,tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode,100);
        zlin5=tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/2;
        
        % Define a regular grid

        [X5,Y5,Z5]= meshgrid(xlin5,ylin5,zlin5); % to be used with griddata
    
        % Interpolate tlm.var.Err1 (Error between Spice & FEM) on the regular (X3,Y3,Z3) grid
        
%        xx=[X5(:),Y5(:),Z5(:)];
        Res5=Res4-Res1;
%        Res3=postinterp(fem,'u',xx,'ext',1);
%        Res3=reshape(Res3,size(X3));
        
        %   Plot the result

        if ii==1
            figure(31);
        elseif ii==2
            figure(32);
        elseif ii==3
            figure(33);
        end

        clf('reset');
        tlm.conf.fig=tlm.conf.fig+1;

        colormap(hot(256));
    
        surf(X5,Y5,Res5);
    
        camlight right;
        lighting phong;
        shading interp;
    
        az=40;
        el=50;
        view(az,el);
 
        axis tight; 
        title(['2D Map of the Electric Potential Difference(Volt) between Spice and Analytical at F=',num2str(f,'%0.2g'),' Hertz and for z=',num2str(zlin2),' m']);
        zlabel('Potential Difference   (V)');
        ylabel('Y coordinate   (microns)');
        xlabel('X coordinate   (microns)');
        
        % Save the Figure

        if ii==1
            saveas(31,'2D_Pot_Diff_SPICE_ANA_1.emf');
        elseif ii==2
            saveas(32,'2D_Pot_Diff_SPICE_ANA_2.emf');
        elseif ii==3
            saveas(33,'2D_Pot_Diff_SPICE_ANA_3.emf');
        end


    end
    
   % Compare Analytical and FEM data - Calculate the difference and relative errors

    if (FEM_COU==0 && ANA_COU==0)
        
        for k=1:size(fem_mesh_p,2)
            tlm.var.Volt2(k)=tlm.var.VoltFem(k,ii);
        end

        tlm.var.Moy3 = 0;
    
        for i=1:1:size(fem_mesh_p,2)                     %for each node in file xxx.aex
    
%           if tlm.var.Volt3(i)>=1e-5
%               tlm.var.Err3(i) = 100*abs((tlm.var.Volt2(i)-tlm.var.Volt3(i)))/abs(tlm.var.Volt3(i));
%           else
%               tlm.var.Err3(i) = 0.;
%           end
        
            tlm.var.Err3(i) = abs((tlm.var.Volt2(i)-tlm.var.Volt3(i)));
            tlm.var.Moy3 = tlm.var.Moy3 + tlm.var.Err3(i);
        
        end

        tlm.var.Moy3 = tlm.var.Moy3/size(fem_mesh_p,2);

        Message=sprintf('\n\t\t\t At f=%u Hz, Mean Delta(V) [Fem & Analytical] is: %u (Volt)', ...
                        f,tlm.var.Moy3);
        disp(Message);
        Message=sprintf('\n\t\t\t At f=%u Hz, Mean Relative Error [Fem & Analytical] is: %u (%%)\n', ...
                        f,100*tlm.var.Moy3/tlm.var.v0/2);
        disp(Message);

        xlin6=linspace(tlm.var.OrigineX-tlm.var.LargeurElectrode/2,tlm.var.OrigineX+tlm.var.LargeurElectrode/2,100);
        ylin6=linspace(tlm.var.OrigineY-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode,tlm.var.OrigineY+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode,100);
        zlin6=tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/2;
        
        % Define a regular grid

        [X6,Y6,Z6]= meshgrid(xlin6,ylin6,zlin6); % to be used with griddata
    
        % Interpolate tlm.var.Err1 (Error between Spice & FEM) on the regular (X3,Y3,Z3) grid
        
%        xx=[X5(:),Y5(:),Z5(:)];
        Res6=Res4-Res2;
%        Res3=postinterp(fem,'u',xx,'ext',1);
%        Res3=reshape(Res3,size(X3));
        
        %   Plot the result

        if ii==1
            figure(34);
        elseif ii==2
            figure(35);
        elseif ii==3
            figure(36);
        end

        clf('reset');
        tlm.conf.fig=tlm.conf.fig+1;

        colormap(hot(256));
    
        surf(X6,Y6,Res6);
    
        camlight right;
        lighting phong;
        shading interp;
    
        az=40;
        el=50;
        view(az,el);
 
        axis tight; 
        title(['2D Map of the Electric Potential Difference(Volt) between FEM and Analytical at F=',num2str(f,'%0.2g'),' Hertz and for z=',num2str(zlin2),' m']);
        zlabel('Potential Difference   (V)');
        ylabel('Y coordinate   (microns)');
        xlabel('X coordinate   (microns)');
        
        % Save the Figure

        if ii==1
            saveas(34,'2D_Pot_Diff_FEM_ANA_1.emf');
        elseif ii==2
            saveas(35,'2D_Pot_Diff_FEM_ANA_2.emf');
        elseif ii==3
            saveas(36,'2D_Pot_Diff_FEM_ANA_3.emf');
        end
    
    end
    
    tlm.conf.Name=tlm.conf.Name0;

end

cd(tlm.conf.src);