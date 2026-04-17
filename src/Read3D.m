%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                              BIOCAD Program
%                               Release 2.0
%
%   Authors: Vincent Senez
%   
%   Release 1.0 : January 2019
%
%   Release 2.0 : January 2025
%
%   Function :  Plot results calculated by TL, FE & AN Methods 
%               on 3D Systems
%
%   Called by: Postprocessing.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [tlm,model]=Read3D(tlm,fil,app,model)

% Initialization

%clear global fem_mesh_p;
tlm.sol.spi = [];
tlm.sol.ana = [];
tlm.sol.fem = [];

global fem_mesh_p;
global fem_mesh_t;
global fem_mesh_e;

Message=sprintf('\n\t * Mesh Statitics: %u Elements, %u nodes',size(fem_mesh_e,2),size(fem_mesh_p,2));
disp(Message);

if tlm.conf.log==1
    fprintf(fil,'\n\t * Mesh Statitics: %u Elements, %u nodes',size(fem_mesh_e,2),size(fem_mesh_p,2));
    fprintf(fil,'\n ');
end

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
xyceCsvName=sprintf('%s.cir.FD.csv',tlm.conf.Name);
xyceData=[];

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
        tlm.sol.spi(ii,3)=tlm.sol.mesu.pha(ii,1)*180/3.1416;
        tlm.sol.spi(ii,4)=real(10^(tlm.sol.mesu.dcb(ii,1)/20)*exp(j*tlm.sol.mesu.pha(ii,1)));
        tlm.sol.spi(ii,5)=imag(10^(tlm.sol.mesu.dcb(ii,1)/20)*exp(j*tlm.sol.mesu.pha(ii,1)));
        tlm.sol.spi(ii,6)=real(10^(tlm.sol.mesu.dcb(ii,1)/20));
    end

    if (tlm.sol.spi(1,3)>90)
        tlm.sol.spi(:,3)=tlm.sol.spi(:,3)-180;
    elseif (tlm.sol.spi(1,3)<-90)
        tlm.sol.spi(:,3)=tlm.sol.spi(:,3)+180;
    end
    
% Plot the Bode diagramm for the SPICE Calculation

    semilogx(app.UIAxesMagnitude_Bode_SPICE, tlm.sol.spi(:,1),tlm.sol.spi(:,2)); % bode (magnitude) plot in interface axes

    semilogx(app.UIAxesPhase_Bode_SPICE, tlm.sol.spi(:,1),tlm.sol.spi(:,3)); % bode (phase) plot in interface axes

% Plot the Nyquist diagramm for the SPICE Calculation

    plot(app.UIAxes_Nyquist_SPICE, tlm.sol.spi(:,4),-tlm.sol.spi(:,5),'-or'); % nyquist plot in interface axes

    A={'\leftarrow 1 Hz';'\leftarrow 10 Hz';'\leftarrow 100 Hz';'\leftarrow 1 KHz';'\leftarrow 10 KHz';'\leftarrow 100 KHz';'\leftarrow 1 MHz';'\leftarrow 10 MHz';'\leftarrow 100 MHz';'\leftarrow 1 GHz';'\leftarrow 10 GHz';'\leftarrow 100 GHz'};
    
    str=string(A);

    cpt=0;

    for a=1:1:(tlm.var.frequence.step*imul+1)

        f=tlm.sol.spi(a,1);
            
        if abs(100*(f-1e0)/1e0)<=1 
           text(app.UIAxes_Nyquist_SPICE,tlm.sol.spi(a,4),-tlm.sol.spi(a,5),str(1));
        elseif abs(100*(f-1e1)/1e1)<=1 
           text(app.UIAxes_Nyquist_SPICE,tlm.sol.spi(a,4),-tlm.sol.spi(a,5),str(2));
        elseif abs(100*(f-1e2)/1e2)<=1
           text(app.UIAxes_Nyquist_SPICE,tlm.sol.spi(a,4),-tlm.sol.spi(a,5),str(3));
        elseif abs(100*(f-1e3)/1e3)<=1
           text(app.UIAxes_Nyquist_SPICE,tlm.sol.spi(a,4),-tlm.sol.spi(a,5),str(4));
        elseif abs(100*(f-1e4)/1e4)<=1
           text(app.UIAxes_Nyquist_SPICE,tlm.sol.spi(a,4),-tlm.sol.spi(a,5),str(5));
        elseif abs(100*(f-1e5)/1e5)<=1
           text(app.UIAxes_Nyquist_SPICE,tlm.sol.spi(a,4),-tlm.sol.spi(a,5),str(6));
        elseif abs(100*(f-1e6)/1e6)<=1
           text(app.UIAxes_Nyquist_SPICE,tlm.sol.spi(a,4),-tlm.sol.spi(a,5),str(7));
        elseif abs(100*(f-1e7)/1e7)<=1
           text(app.UIAxes_Nyquist_SPICE,tlm.sol.spi(a,4),-tlm.sol.spi(a,5),str(8));
        elseif abs(100*(f-1e8)/1e8)<=1
           text(app.UIAxes_Nyquist_SPICE,tlm.sol.spi(a,4),-tlm.sol.spi(a,5),str(9));
        elseif abs(100*(f-1e9)/1e9)<=1
           text(app.UIAxes_Nyquist_SPICE,tlm.sol.spi(a,4),-tlm.sol.spi(a,5),str(10));
        elseif abs(100*(f-1e10)/1e10)<=1
           text(app.UIAxes_Nyquist_SPICE,tlm.sol.spi(a,4),-tlm.sol.spi(a,5),str(11));
        elseif abs(100*(f-1e11)/1e11)<=1
           text(app.UIAxes_Nyquist_SPICE,tlm.sol.spi(a,4),-tlm.sol.spi(a,5),str(12));
        end

        cpt=cpt+1;
    end

    Message=sprintf('\n\t\t . The SPI File has been exploited');
    disp(Message);
    SPI=0;

else
    if exist(xyceCsvName, 'file')==2
        xyceData=readmatrix(xyceCsvName);
        if ~isempty(xyceData) && size(xyceData,2)>=4
            imul=log10(tlm.var.frequence.max)-log10(tlm.var.frequence.min);
            nPts=min(size(xyceData,1),tlm.var.frequence.step*imul+1);
            tlm.sol.spi=zeros(nPts,6);
            tlm.sol.spi(:,1)=xyceData(1:nPts,2);
            tlm.sol.spi(:,2)=xyceData(1:nPts,3);
            tlm.sol.spi(:,3)=xyceData(1:nPts,4);
            for ii=1:1:nPts
                tlm.sol.spi(ii,4)=real(10^(tlm.sol.spi(ii,2)/20)*exp(j*tlm.sol.spi(ii,3)*pi/180));
                tlm.sol.spi(ii,5)=imag(10^(tlm.sol.spi(ii,2)/20)*exp(j*tlm.sol.spi(ii,3)*pi/180));
                tlm.sol.spi(ii,6)=real(10^(tlm.sol.spi(ii,2)/20));
            end

            if (tlm.sol.spi(1,3)>90)
                tlm.sol.spi(:,3)=tlm.sol.spi(:,3)-180;
            elseif (tlm.sol.spi(1,3)<-90)
                tlm.sol.spi(:,3)=tlm.sol.spi(:,3)+180;
            end

            semilogx(app.UIAxesMagnitude_Bode_SPICE, tlm.sol.spi(:,1),tlm.sol.spi(:,2));
            semilogx(app.UIAxesPhase_Bode_SPICE, tlm.sol.spi(:,1),tlm.sol.spi(:,3));
            plot(app.UIAxes_Nyquist_SPICE, tlm.sol.spi(:,4),-tlm.sol.spi(:,5),'-or');

            Message=sprintf('\n\t\t . The Xyce CSV file (%s) has been exploited',xyceCsvName);
            disp(Message);
            SPI=0;
        else
            Message=sprintf('\n\t\t . The Xyce CSV file (%s) is empty or malformed',xyceCsvName);
            disp(Message);
            SPI=1;
        end
    else
        Message=sprintf('\n\t\t . The SPI File does not exist in the current result directory');
        disp(Message);
        SPI=1;
    end
    
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
               % disp(tlineread);
               % disp(i);
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

    semilogx(app.UIAxesMagnitude_Bode_FEM, tlm.sol.fem(:,1),tlm.sol.fem(:,2)); % bode (magnitude) plot in interface axes

    semilogx(app.UIAxesPhase_Bode_FEM, tlm.sol.fem(:,1),tlm.sol.fem(:,3)); % bode (phase) plot in interface axes
    
% Plot the Nyquist diagramm for the FEM Calculation

    plot(app.UIAxes_Nyquist_FEM, tlm.sol.fem(:,4),-tlm.sol.fem(:,5),'-or'); % nyquist plot in interface axes

    cpt=0;

    A={'\leftarrow 1 Hz';'\leftarrow 10 Hz';'\leftarrow 100 Hz';'\leftarrow 1 KHz';'\leftarrow 10 KHz';'\leftarrow 100 KHz';'\leftarrow 1 MHz';'\leftarrow 10 MHz';'\leftarrow 100 MHz';'\leftarrow 1 GHz';'\leftarrow 10 GHz';'\leftarrow 100 GHz'};
    
    str=string(A);

    for a=1:1:(log10(tlm.var.frequence.max)-log10(tlm.var.frequence.min))*tlm.var.frequence.step+1

        f=tlm.sol.fem(a,1);

        if abs(100*(f-1e0)/1e0)<=1 
           text(app.UIAxes_Nyquist_FEM,tlm.sol.val(a,7),-tlm.sol.val(a,8),str(1));
        elseif abs(100*(f-1e1)/1e1)<=1 
           text(app.UIAxes_Nyquist_FEM,tlm.sol.val(a,7),-tlm.sol.val(a,8),str(2));
        elseif abs(100*(f-1e2)/1e2)<=1
           text(app.UIAxes_Nyquist_FEM,tlm.sol.val(a,7),-tlm.sol.val(a,8),str(3));
        elseif abs(100*(f-1e3)/1e3)<=1
           text(app.UIAxes_Nyquist_FEM,tlm.sol.val(a,7),-tlm.sol.val(a,8),str(4));
        elseif abs(100*(f-1e4)/1e4)<=1
           text(app.UIAxes_Nyquist_FEM,tlm.sol.val(a,7),-tlm.sol.val(a,8),str(5));
        elseif abs(100*(f-1e5)/1e5)<=1
           text(app.UIAxes_Nyquist_FEM,tlm.sol.val(a,7),-tlm.sol.val(a,8),str(6));
        elseif abs(100*(f-1e6)/1e6)<=1
           text(app.UIAxes_Nyquist_FEM,tlm.sol.val(a,7),-tlm.sol.val(a,8),str(7));
        elseif abs(100*(f-1e7)/1e7)<=1
           text(app.UIAxes_Nyquist_FEM,tlm.sol.val(a,7),-tlm.sol.val(a,8),str(8));
        elseif abs(100*(f-1e8)/1e8)<=1
           text(app.UIAxes_Nyquist_FEM,tlm.sol.val(a,7),-tlm.sol.val(a,8),str(9));
        elseif abs(100*(f-1e9)/1e9)<=1
           text(app.UIAxes_Nyquist_FEM,tlm.sol.val(a,7),-tlm.sol.val(a,8),str(10));
        elseif abs(100*(f-1e10)/1e10)<=1
           text(app.UIAxes_Nyquist_FEM,tlm.sol.val(a,7),-tlm.sol.val(a,8),str(11));
        elseif abs(100*(f-1e11)/1e11)<=1
           text(app.UIAxes_Nyquist_FEM,tlm.sol.val(a,7),-tlm.sol.val(a,8),str(12));
        end

        cpt=cpt+1;
  
    end
    
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

    semilogx(app.UIAxesMagnitude_Bode_ANA, tlm.sol.ana(:,1),tlm.sol.ana(:,2)); % bode (magnitude) plot in interface axes

    semilogx(app.UIAxesPhase_Bode_ANA, tlm.sol.ana(:,1),tlm.sol.ana(:,3)); % bode (phase) plot in interface axes

    % Plot the Nyquist diagramm for the Analytical Calculation

    plot(app.UIAxes_Nyquist_ANA, tlm.sol.val(:,7),-tlm.sol.val(:,8),'-or'); % nyquist plot in interface axes
    
    cpt=0;

    A={'\leftarrow 1 Hz';'\leftarrow 10 Hz';'\leftarrow 100 Hz';'\leftarrow 1 KHz';'\leftarrow 10 KHz';'\leftarrow 100 KHz';'\leftarrow 1 MHz';'\leftarrow 10 MHz';'\leftarrow 100 MHz';'\leftarrow 1 GHz';'\leftarrow 10 GHz';'\leftarrow 100 GHz'};
    
    str=string(A);

    for a=1:1:(log10(tlm.var.frequence.max)-log10(tlm.var.frequence.min))*tlm.var.frequence.step+1

        f=tlm.sol.ana(a,1);

        if abs(100*(f-1e0)/1e0)<=1 
           text(app.UIAxes_Nyquist_ANA,tlm.sol.val(a,7),-tlm.sol.val(a,8),str(1));
        elseif abs(100*(f-1e1)/1e1)<=1 
           text(app.UIAxes_Nyquist_ANA,tlm.sol.val(a,7),-tlm.sol.val(a,8),str(2));
        elseif abs(100*(f-1e2)/1e2)<=1
           text(app.UIAxes_Nyquist_ANA,tlm.sol.val(a,7),-tlm.sol.val(a,8),str(3));
        elseif abs(100*(f-1e3)/1e3)<=1
           text(app.UIAxes_Nyquist_ANA,tlm.sol.val(a,7),-tlm.sol.val(a,8),str(4));
        elseif abs(100*(f-1e4)/1e4)<=1
           text(app.UIAxes_Nyquist_ANA,tlm.sol.val(a,7),-tlm.sol.val(a,8),str(5));
        elseif abs(100*(f-1e5)/1e5)<=1
           text(app.UIAxes_Nyquist_ANA,tlm.sol.val(a,7),-tlm.sol.val(a,8),str(6));
        elseif abs(100*(f-1e6)/1e6)<=1
           text(app.UIAxes_Nyquist_ANA,tlm.sol.val(a,7),-tlm.sol.val(a,8),str(7));
        elseif abs(100*(f-1e7)/1e7)<=1
           text(app.UIAxes_Nyquist_ANA,tlm.sol.val(a,7),-tlm.sol.val(a,8),str(8));
        elseif abs(100*(f-1e8)/1e8)<=1
           text(app.UIAxes_Nyquist_ANA,tlm.sol.val(a,7),-tlm.sol.val(a,8),str(9));
        elseif abs(100*(f-1e9)/1e9)<=1
           text(app.UIAxes_Nyquist_ANA,tlm.sol.val(a,7),-tlm.sol.val(a,8),str(10));
        elseif abs(100*(f-1e10)/1e10)<=1
           text(app.UIAxes_Nyquist_ANA,tlm.sol.val(a,7),-tlm.sol.val(a,8),str(11));
        elseif abs(100*(f-1e11)/1e11)<=1
           text(app.UIAxes_Nyquist_ANA,tlm.sol.val(a,7),-tlm.sol.val(a,8),str(12));
        end

        cpt=cpt+1;
        
    end

    title('Nyquist Plot from Analytical Calculations');
    ylabel('Im(|Z|)   (Ohms)');
    xlabel('Re(|Z|)   (Ohms)');
    
    Message=sprintf('\n\t\t . The ANA data has been exploited');
    disp(Message);
    ANA=0;
    
else
    
    Message=sprintf('\n\t\t . The ANA File does not exist in the current result directory');
    disp(Message);
    ANA=1;
    
end
    
SPI=1; %for debug purpose vsnz 11/10/2024

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

    figure(tlm.conf.fig);
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

    %saveas(7,'SPICE_FEM_Comp.fig');

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

    figure(tlm.conf.fig);
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

    saveas(8,'SPICE_ANA_Comp.fig');

end
ANA = 1;
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

    figure(tlm.conf.fig);
    clf('reset');
    tlm.conf.fig=tlm.conf.fig+1;

    subplot(2,1,1);
    semilogx(tlm.sol.fem(:,1),tlm.sol.mag.err(i,3));
    title('Relative Error on Impedance Module & Phase between FEM & Analytical Calculations');
    ylabel('Relative Error on Impedance Module (%)');Figure
    xlabel('Frequency');

    subplot(2,1,2);
    semilogx(tlm.sol.fem(:,1),tlm.sol.mag.err(i,3));
    ylabel('Relative Error on Impedance Phase (%)');
    xlabel('Frequency');    
    
    % Save the Figure

    saveas(9,'FEM_ANA_Comp.fig');

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

tlm.conf.Name0=tlm.conf.Name;
    
% Read the SPICE Data (coordinates) in the xx.cor file and (voltage) in the xx.spi_cou file

Message=sprintf('\n\t * SPICE Simulations');
disp(Message);
    
if tlm.conf.log==1
    fprintf(fil,'\n\t * SPICE Simulations');
    fprintf(fil,'\n '); 
end
        
% Read the coordinates of the Nodes in the xx.cor file

name1=sprintf('%s.cor',tlm.conf.Name);       % Name of the file (generated in EcritNetlist2D) containing the coordinates of all nodes of the fem mesh
[fid, msg] =fopen(name1, 'r');                     % Open the File

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
        f=tlm.var.frequence.int;
    elseif ii==3
        f=tlm.var.frequence.max;
    end

    name2 = strcat(tlm.conf.Name, "_", num2str(f), "Hz.spi_cou");    % Name of the file (generated by SPICE) containing the voltage value at each of the fem nodes
    fid=fopen(name2, 'r');                     % Open the File

    if fid>=0       % The file exists

        tlineref1='Variables:'; 
        tlineref2='Values:'; 

        i=0;
        jk=1;
        cpt=0;
        
        tlineread = 0;

        tlm.sol.mesu.ri = [];
        while ~strcmp(string(tlineread), "-1")
%           while ~feof(fid)                    % In case of parasites or membrane, we have to choose one node between ibis, iter and iquad. 
            tlineread = fgetl(fid);         % In the following algorithme, we keep the electrical potential on ibis (in the outer electrodes)
            C1 = strcmp(tlineref1,tlineread);
            if C1==1
                tlineread = fgetl(fid);
                while i<3*size(fem_mesh_p,2) && ~strcmp(string(tlineread), "-1")
                    tlineread = fgetl(fid);
                    ind(jk)=0;
                    for kk=1:1:(size(tlineread,2)-3)
                        if strcmp(char([tlineread(kk) tlineread(kk+1) tlineread(kk+2)]),'ter') || ...
                           strcmp(char([tlineread(kk) tlineread(kk+1) tlineread(kk+2) tlineread(kk+3)]),'quad')
                                ind(jk)=1;
                                cpt=cpt+1;
                        end
                    end
                    jk=jk+1;
                    C2 = strcmp(tlineref2,tlineread);
                    if C2==1
                        tlineread = fgetl(fid);
                        jk=0;
                        while i<(size(fem_mesh_p,2)+cpt)  && ~strcmp(string(tlineread), "-1")
                            tlineread = fgetl(fid);
%                            disp(tlineread);
                            if ind(i+1)==0
                                tlm.sol.mesu.ri = [tlm.sol.mesu.ri;str2num(tlineread)];
                                jk=jk+1;
                            end
                            i=i+1;
                        end
                        break
                    end
                end
            end
        end

        fclose(fid);    

        %debut modif Balthazar 16/01 (a verifier!!!!!)
        
        tlm.var.Volt1 = [];
        tlm.var.VoltSpice = [];
        for k=1:size(fem_mesh_p,2)
            tlm.var.Volt1=[tlm.var.Volt1,tlm.sol.mesu.ri(k,1)];
            tlm.var.VoltSpice=[tlm.var.VoltSpice;tlm.sol.mesu.ri(k,1)];
        end
        %fin modif Balthazar 16/01
        Message=sprintf('\n\t\t . The SPI_COU file (%s) has been exploited',name2);
        disp(Message);
            
        if tlm.conf.log==1
            fprintf(fil,'\n\t\t . The SPI_COU file (%s) has been exploited',name2);
            fprintf(fil,'\n '); 
        end
        
        SPI_COU=0;
    
    else
        if isempty(xyceData) && exist(xyceCsvName, 'file')==2
            xyceData=readmatrix(xyceCsvName);
        end

        nNodes=size(fem_mesh_p,2);
        firstVrCol=5;
        lastVrCol=firstVrCol+nNodes-1;

        if ~isempty(xyceData) && size(xyceData,2)>=lastVrCol
            [~,idxFreq]=min(abs(xyceData(:,2)-f));
            tlm.var.Volt1=xyceData(idxFreq,firstVrCol:lastVrCol);
            tlm.var.VoltSpice=tlm.var.Volt1(:);

            Message=sprintf('\n\t\t . The Xyce CSV map data (%s) has been exploited at F=%g Hz',xyceCsvName,xyceData(idxFreq,2));
            disp(Message);
            SPI_COU=0;
        else
            Message=sprintf('\n\t\t . The SPI_COU File (%s) does not exist in the current result directory',name2);
            disp(Message);
            if tlm.conf.log==1
                fprintf(fil,'\n\t\t . The SPI_COU File (%s) does not exist in the current result directory',name2);
                fprintf(fil,'\n '); 
            end
            SPI_COU=1;
        end
    
    end
    
% Plot the results 

    if SPI_COU==0
        
        if size(tlm.var.X1,1)~=size(tlm.var.Volt1,2)
            Message=sprintf('\n\t\t . Error: The %s.cor and %s.spi_cou files do not correspond',tlm.conf.Name,tlm.conf.Name);
            disp(Message);
            return
        end

% Plot one specific slice (at zlin1) of the SPICE values in a 2D figure 

        xlin1=linspace(tlm.var.OrigineX-tlm.var.LongueurChambre/2,tlm.var.OrigineX+tlm.var.LongueurChambre/2,200);
        ylin1=linspace(tlm.var.OrigineY-tlm.var.LargeurChambre/2,tlm.var.OrigineY+tlm.var.LargeurChambre/2,200);
        zlin1=tlm.var.EpaisseurChambre/2; % La coupe est placée à mi-hauteur de la chambre de culture par défaut
        zlin1=tlm.var.OrigineZ+tlm.var.EpaisseurChambre/4;
       
        % Define a regular grid
        [X1,Y1,Z1]= meshgrid(xlin1,ylin1,zlin1);
    
        % Interpolate the potential on the regular (X1,Y1,Z1) grid
        if size(tlm.var.X1,1)~=size(tlm.var.Volt1,2)
            Message=sprintf('\n\t\t . Error: The %s.cor and %s.spi_cou files doe not correspond',tlm.conf.Name,tlm.conf.Name);
            disp(Message);
            return
        else
            Res1=griddata(tlm.var.X1,tlm.var.Y1,tlm.var.Z1,real(tlm.var.Volt1(:)),X1,Y1,Z1,'linear');
        end
        
        % Define the axes (interface) to plot on depending on ii
        switch ii
            case 1
                ax = app.UIAxes_PotentialMapfmin_SPICE;
            case 2 
                ax = app.UIAxes_PotentialMapfint_SPICE;
            case 3
                ax = app.UIAxes_PotentialMapfmax_SPICE;
        end   
        
        colormap(ax, hot(256)); % Potential Map plot in interface axes
    
        surf(ax,X1,Y1,Res1); % Potential Map plot in interface axes
    
        camlight(ax, 'right');
        lighting(ax, 'phong');
        shading(ax, 'interp');
    
        az=40;
        el=50;
        view(ax, [az,el]);
 
        axis(ax, 'tight'); 
        title(ax, strcat('2D Map of the Electric Potential (Volt) obtained by SPICE at F=', num2str(f,'%0.2g'), ' Hertz and for z=', num2str(zlin1), ' meter'));
        zlabel('Potential Difference   (V)');
        ylabel('Y coordinate   (meter)');
        xlabel('X coordinate   (meter)');
        
        % Save the Figure

%         if ii==1
%             saveas(tlm.conf.fig-1,'2D_Plot_SPICE_1.fig');
%         elseif ii==2
%             saveas(tlm.conf.fig-1,'2D_Plot_SPICE_2.fig');
%         elseif ii==3
%             saveas(tlm.conf.fig-1,'2D_Plot_SPICE_3.fig');
%         end

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
        f=tlm.var.frequence.int;
    elseif ii==3
        f=tlm.var.frequence.max;
    end
 
    name3 = strcat(tlm.conf.Name, "_", num2str(f), "Hz.fem_cou"); % Name of the file (generated by COMSOL) containing the voltage value at each of the fem nodes
    fid=fopen(name3, 'r');                     % Open the File

    if fid>=0       % The file exists

        [tlm.var.X2, tlm.var.Y2, tlm.var.Z2, tlm.var.Volt2] = textread(name3,'%f %f %f %f','headerlines',14);
    
        fclose(fid);
        
        Message=sprintf('\n\t\t . The FEM file (%s) has been exploited',name3);
        disp(Message);
        
        if tlm.conf.log==1
            fprintf(fil,'\n\t\t . The FEM file (%s) has been exploited',name3);
            fprintf(fil,'\n '); 
        end
        
        FEM_COU=0;
    
    else
    
        Message=sprintf('\n\t\t . The FEM File (%s) does not exist in the current result directory',name3);
        disp(Message);
        if tlm.conf.log==1
            fprintf(fil,'\n\t\t . The FEM File (%s) does not exist in the current result directory',name3);
            fprintf(fil,'\n '); 
        end
        
        FEM_COU=1;
    
    end
    
    % Plot slice of the FEM values in a 3D figure
    
    if FEM_COU==0
        
        %for k=1:size(tlm.var.Volt2,1)
        %    tlm.var.VoltFem(k,ii)=tlm.var.Volt2(k);
        %end

% Plot one specific slice (at zlin2) of the FEM values in a 2D figure 

        xlin2=linspace(tlm.var.OrigineX-tlm.var.LongueurChambre/2,tlm.var.OrigineX+tlm.var.LongueurChambre/2,200);
        ylin2=linspace(tlm.var.OrigineY-tlm.var.LargeurChambre/2,tlm.var.OrigineY+tlm.var.LargeurChambre/2,200);
        zlin2=tlm.var.OrigineZ+tlm.var.EpaisseurChambre/4; % La coupe est placée à mi-hauteur de la chambre de culture par défaut
        
        % Define a regular grid

        [X2,Y2,Z2]= meshgrid(xlin2,ylin2,zlin2);
    
        % Interpolate the potential on the regular (X2,Y2,Z2) grid
        
        Res2=griddata(tlm.var.X2,tlm.var.Y2,tlm.var.Z2,real(tlm.var.Volt2(:)),X2,Y2,Z2,'linear');
        
        % debut modification Enzo 16/01
        %xx=[X2(:),Y2(:),Z2(:)]';
        %Res2=mphinterp(model,'V','coord',xx,'ext',1);
        %Res2=reshape(real(Res2(1,:)),size(X2)); % Res2 is a complex value but the imaginary part is equal to 0 (Voltage)
        %fin de modification Enzo 16/01

        % Define the axes (interface) to plot on depending on ii
    
        switch ii
            case 1
                ax = app.UIAxes_PotentialMapfmin_FEM;
            case 2 
                ax = app.UIAxes_PotentialMapfint_FEM;
            case 3
                ax = app.UIAxes_PotentialMapfmax_FEM;
        end   
        
        colormap(ax, hot(256)); % Potential Map plot in interface axes

        surf(ax,X2,Y2,Res2); % Potential Map plot in interface axes

        camlight(ax, 'right');
        lighting(ax, 'phong');
        shading(ax, 'interp');
    
        az=40;
        el=50;
        view(ax, [az,el]);
 
        axis(ax, 'tight'); 
        title(ax, strcat('2D Map of the Electric Potential (Volt) obtained by FEM at F=', num2str(f,'%0.2g'), ' Hertz and for z=', num2str(zlin2), ' meter'));
        zlabel(ax,'Potential Difference   (V)');
        ylabel(ax,'Y coordinate   (meter)');
        xlabel(ax,'X coordinate   (meter)');
        
        % Save the Figure

%         if ii==1
%             saveas(tlm.conf.fig-1,'2D_Plot_SPICE_1.fig');
%         elseif ii==2
%             saveas(tlm.conf.fig-1,'2D_Plot_SPICE_2.fig');
%         elseif ii==3
%             saveas(tlm.conf.fig-1,'2D_Plot_SPICE_3.fig');
%         end

    end
end

% début de modification Enzo 16/01
%Plot the 2D map for Analytical Resolution
ANA_COU=1;
if ANA_COU==0
for ii=1:1:3
    
    if ii==1
        f=tlm.var.frequence.min;
    elseif ii==2
        ex=round((log10(tlm.var.frequence.max)+log10(tlm.var.frequence.min))/2);
        if tlm.var.frequence.max==10
            ex=0;
        end
        f=5*10^ex;
    elseif ii==3
        f=tlm.var.frequence.max;
    end

       xlin3=linspace(tlm.var.OrigineX-tlm.var.LongueurChambre/2,tlm.var.OrigineX+tlm.var.LongueurChambre/2,290);
       ylin3=linspace(tlm.var.OrigineY-tlm.var.LargeurChambre/2,tlm.var.OrigineY+tlm.var.LargeurChambre/2,290);
       zlin3=tlm.var.OrigineZ+tlm.var.EpaisseurElectrode/2;

       % Define a regular grid

       [X3,Y3,Z3]= meshgrid(xlin3,ylin3,zlin3);

        % Interpolate the potential on the regular (X1,Y1,Z1) grid
        
       xx=[X3(:),Y3(:),Z3(:)]';
       size(xx,1);
       Res3 = mphinterp(model, 'V', 'coord', xx);
       Res3=reshape(real(Res3(1,:)),size(X3));
       
       switch ii
            case 1
                ax = app.UIAxes_PotentialMapfmin_ANA;
            case 2 
                ax = app.UIAxes_PotentialMapfint_ANA;
            case 3
                ax = app.UIAxes_PotentialMapfmax_ANA;
        end   
        colormap(ax, hot(256)); % Potential Map plot in interface axes
    
            surf(ax,X3,Y3,Res3); % Potential Map plot in interface axes
        %end
    
        camlight(ax, 'right');
        lighting(ax, 'phong');
        shading(ax, 'interp');
    
        az=40;
        el=50;
        view(ax, [az,el]);
 
        axis(ax, 'tight'); 
        
        title(ax, strcat('2D Map of the Electric Potential (Volt) obtained by Analytical at F=', num2str(f,'%0.2g'), ' Hertz and for z=', num2str(zlin1), ' microns'));
        

        %   Plot the result

        if ii==1
           figure(tlm.conf.fig);
        elseif ii==2
           figure(tlm.conf.fig);
        elseif ii==3
           figure(tlm.conf.fig);
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
        title(['2D Map of the Electric Potential (Volt) obtained by Analytical at F=',num2str(f,'%0.2g'),' Hertz and for z=',num2str(zlin2),' m']);
        zlabel('Potential Difference   (V)');
        %ylabel('Y coordinate   (microns)');
        %xlabel('X coordinate   (microns)');
%fin de modification Enzo
    %   Compare FEM and Spice data - Calculate the difference and relative errors
    SPI_COU=1; %for debug purpose vsnz 11/10/2024
    if (SPI_COU==0 && FEM_COU==0)
        
        for k=1:size(tlm.var.Volt1,2)
            tlm.var.Volt1(k)=tlm.var.VoltSpice(k);
        end

        tlm.var.Moy1=0;
    
        for i=1:1:size(tlm.var.Volt1,2)                     %for each node in file xxx.aex
    
%        if tlm.var.Volt2(i)>=1e-5
%            tlm.var.Err1(i) = 100*abs((tlm.var.Volt1(i)-tlm.var.Volt2(i)))/abs(tlm.var.Volt2(i));
%        else
%            tlm.var.Err1(i) = 0.;
%        end

            tlm.var.Err1(i) = abs((tlm.var.Volt1(i)-tlm.var.Volt2(i)));
            tlm.var.Moy1 = tlm.var.Moy1 + tlm.var.Err1(i);
        
        end

        tlm.var.Moy1 = tlm.var.Moy1/size(tlm.var.Volt1,2);

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
            figure(tlm.conf.fig);
        elseif ii==2
            figure(tlm.conf.fig);
        elseif ii==3
            figure(tlm.conf.fig);
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
            saveas(22,'2D_Pot_FEM_1.fig');
        elseif ii==2
            saveas(23,'2D_Pot_FEM_2.fig');
        elseif ii==3
            saveas(24,'2D_Pot_FEM_3.fig');
        end


    end
end
    
    
end