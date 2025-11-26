%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                              BIOCAD Program
%                               Release 1.0
%   Authors: Vincent Senez
%   
%   Release 1.0 : January 2019
%
%   Function :  Plot results calculated by TL, FE & AN Methods 
%               on 2D Systems
%
%   Called by: Postprocessing.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%function tlm=Read2D(tlm,fil)
function [tlm,model]=Read2D(tlm,fil)


global fem_mesh_p;
global fem_mesh_t;
global fem_mesh_e;

[tlm,model]=Geom2Dcad(tlm);

Message=sprintf('\n\t * Mesh Statitics: %u éléments, %u nodes',size(fem_mesh_e,2),size(fem_mesh_p,2));
disp(Message);
if tlm.conf.log==1
    fprintf(fil,'\n\t * Mesh Statitics: %u éléments, %u nodes',size(fem_mesh_e,2),size(fem_mesh_p,2));
    fprintf(fil,'\n ');
end

cd(tlm.conf.store);

%if tlm.var.Freq==-1

    Message=sprintf('\n Generate Bode and Nyquist Plots for Electrical Impedance');
    disp(Message);
    
    if tlm.conf.log==1
        fprintf(fil,'\n Generate Bode and Nyquist Plots for Electrical Impedance');
        fprintf(fil,'\n '); 
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Analysis of the Bode & Nyquist plots [check |Z|(freq) & arg(Z)(freq)]
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

        tlm.sol.spi=[];
        
        for ii=1:1:(tlm.var.frequence.step*imul+1)
            tlm.sol.spi(ii,1)=tlm.sol.fre(ii,2);
            tlm.sol.spi(ii,2)=tlm.sol.mesu.dcb(ii,1);
            tlm.sol.spi(ii,3)=tlm.sol.mesu.pha(ii,1)*180/pi;
            tlm.sol.spi(ii,4)=real(10^(tlm.sol.mesu.dcb(ii,1)/20)*exp(j*tlm.sol.mesu.pha(ii,1)));
            tlm.sol.spi(ii,5)=imag(10^(tlm.sol.mesu.dcb(ii,1)/20)*exp(j*tlm.sol.mesu.pha(ii,1)));
        end
        
        if (tlm.sol.spi(1,3)==180 || tlm.sol.spi(1,3)==90)
            tlm.sol.spi(:,3)=tlm.sol.spi(:,3)-180;
        end

        % Plot the Bode diagramm for the SPICE Calculation

        figure(2);
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

        saveas(2,'SPICE_Bode.emf');
    
        % Plot the Nyquist Plot for the Spice Calculation

        figure(3);
        clf('reset');
        tlm.conf.fig=tlm.conf.fig+1;

        loglog(tlm.sol.spi(:,4),-tlm.sol.spi(:,5),'-or');

        axis ij;
        axis square;
        axis([0.001 1000 0.001 1000]);

        cpt=0;

        for a=1:1:(tlm.var.frequence.step*imul+1)
            f=tlm.sol.spi(a,1);
            
            if abs(100*(f-1e0)/1e0)<=1 || abs(100*(f-1e1)/1e1)<=1 || abs(100*(f-1e2)/1e2)<=1 || abs(100*(f-1e3)/1e3)<=1 || abs(100*(f-1e4)/1e4)<=1 || ...
               abs(100*(f-1e5)/1e5)<=1 || abs(100*(f-1e6)/1e6)<=1 || abs(100*(f-1e7)/1e7)<=1 || abs(100*(f-1e8)/1e8)<=1 || abs(100*(f-1e9)/1e9)<=1 || ...
               abs(100*(f-1e10)/1e10)<=1

                cpt=cpt+1;
            
                if (tlm.sol.spi(a,4)>0.001 && tlm.sol.spi(a,4)<1000) && ...
                   (-tlm.sol.spi(a,5)>0.001 && -tlm.sol.spi(a,5)<1000)
            
                        text(tlm.sol.spi(a,4),-tlm.sol.spi(a,5),tlm.conf.f(cpt));
                end
                    
            end
        end

        title('Nyquist Plot from Spice Calculations');
        ylabel('Im(|Z|)   (Ohms)');
        xlabel('Re(|Z|)   (Ohms)');

        % Save the Figure

        saveas(3,'SPICE_Nyquist.emf');
    
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
    fid=fopen(name1, 'r');  

    if fid>=0       % The file exists
    
        tlineref='* Values:'; 

        i=0;
        
        tlm.sol.fem=[];

        while ~feof(fid)
            tlineread = fgetl(fid);
            C = strcmp(tlineref,tlineread);  
            if C==1
                imul=log10(tlm.var.frequence.max)-log10(tlm.var.frequence.min);
                while i<(imul*tlm.var.frequence.step+1)
                    tlineread = fgetl(fid);
%                   disp(tlineread);
                    tlm.sol.fem(i+1,:)=str2num(tlineread);
                    i=i+1;
                end
                break
            end
        end

        fclose(fid);
        
        if (abs(tlm.sol.fem(1,3)-180)<0.001 || abs(tlm.sol.fem(1,3)-90)<0.001)
            tlm.sol.fem(:,3)=tlm.sol.fem(:,3)-180;
        end

        tlm.sol.val=zeros(1,8);         % Empty the array
    
        imul=log10(tlm.var.frequence.max)-log10(tlm.var.frequence.min);
        for ii=1:1:(imul*tlm.var.frequence.step+1)
            tlm.sol.val(ii,7)=real(10^(tlm.sol.fem(ii,2)/20)*exp(j*tlm.sol.fem(ii,3)*pi/180));
            tlm.sol.val(ii,8)=imag(10^(tlm.sol.fem(ii,2)/20)*exp(j*tlm.sol.fem(ii,3)*pi/180));
        end

        % Plot the Bode plot for the FEM Calculation

        figure(4);
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

        saveas(4,'FEM_Bode.emf');
    
        % Plot the Nyquist diagramm for the FEM Calculation

        figure(5);
        clf('reset');
        tlm.conf.fig=tlm.conf.fig+1;

        loglog(tlm.sol.val(:,7),-tlm.sol.val(:,8),'-or');

        axis ij;
        axis square;
        axis([0.001 1000 0.001 1000]);

        cpt=0;
        cpu=1;

        for a=log10(tlm.var.frequence.min):1:log10(tlm.var.frequence.max)
            for b=1:1:tlm.var.frequence.step
                f=b*10^a;
                cpt=cpt+1;
                if cpt<=(imul*tlm.var.frequence.step+1)
                    if (tlm.sol.val(cpt,7)>0.001 && tlm.sol.val(cpt,7)<1000) && ...
                        (-tlm.sol.val(cpt,8)>0.001 && -tlm.sol.val(cpt,8)<1000) && (b==1)    
                            text(tlm.sol.val(cpt,7),-tlm.sol.val(cpt,8),tlm.conf.f(cpu));
%                    elseif (tlm.sol.val(cpt,7)>0.001 && tlm.sol.val(cpt,7)<1000) && ...
%                        (-tlm.sol.val(cpt,8)>0.001 && -tlm.sol.val(cpt,8)<1000) && (f==tlm.var.frequence.max)    
%                            text(tlm.sol.val(cpt,7),-tlm.sol.val(cpt,8),tlm.conf.f(10));
                    end
                end
            end
            
            cpu=cpu+1;
            
        end

        title('Nyquist Plot from FEM Calculations');
        ylabel('Im(|Z|)   (Ohms)');
        xlabel('Re(|Z|)   (Ohms)');
    
        % Save the Figure

        saveas(5,'FEM_Nyquist.emf');

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

        tlm.sol.ana=[];
        
        while ~feof(fid)
            tlineread = fgetl(fid);
            C = strcmp(tlineref,tlineread);  
            if C==1
                imul=log10(tlm.var.frequence.max)-log10(tlm.var.frequence.min);
                while i<(imul*tlm.var.frequence.step+1)
                    tlineread = fgetl(fid);
                   %disp(tlineread);
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

        figure(6);
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

        saveas(6,'ANA_Bode.emf');
    
        % Plot the Nyquist diagramm for the Analytical Calculation

        figure(7);
        clf('reset');
        tlm.conf.fig=tlm.conf.fig+1;

        loglog(tlm.sol.val(:,7),-tlm.sol.val(:,8),'-or');

        axis ij;
        axis square;
        axis([0.001 1000 0.001 1000]);

        cpt=0;
        cpu=1;

        for a=log10(tlm.var.frequence.min):1:log10(tlm.var.frequence.max)
            for b=1:1:tlm.var.frequence.step
                f=b*10^a;
                cpt=cpt+1;
                if cpt<=(imul*tlm.var.frequence.step+1)
                    if (tlm.sol.val(cpt,7)>0.001 && tlm.sol.val(cpt,7)<1000) && ...
                        (-tlm.sol.val(cpt,8)>0.001 && -tlm.sol.val(cpt,8)<1000) && (b==1)    
                            text(tlm.sol.val(cpt,7),-tlm.sol.val(cpt,8),tlm.conf.f(cpu));
%                    elseif (tlm.sol.val(cpt,7)>0.001 && tlm.sol.val(cpt,7)<1000) && ...
%                        (-tlm.sol.val(cpt,8)>0.001 && -tlm.sol.val(cpt,8)<1000) && (f==tlm.var.frequence.max)    
%                            text(tlm.sol.val(cpt,7),-tlm.sol.val(cpt,8),tlm.conf.f(10));
                    end
                end
            end
            
            cpu=cpu+1;
            
        end


        title('Nyquist Plot from Analytical Calculations');
        ylabel('Im(|Z|)   (Ohms)');
        xlabel('Re(|Z|)   (Ohms)');
    
        % Save the Figure

        saveas(7,'ANA_Nyquist.emf');
    
        Message=sprintf('\n\t\t . The ANA data has been exploited');
        disp(Message);

        ANA=0;
    
    else
    
        Message=sprintf('\n\t\t . The ANA File does not exist in the current result directory');
        disp(Message);
        ANA=1;
    
    end
    
    % Calculate relative errors between the different analysis

    if SPI==0 && FEM==0
    
        tlm.sol.int.spi=[];
        tlm.sol.mag.err=[];
        tlm.sol.tet.err=[];
        
        % Interpolate Spice data on the frequencies used for the FEM calculations

%       tlm.sol.int.spi(:,1)=tlm.sol.fem(:,1);
%       tlm.sol.int.spi(:,2)=interp1(tlm.sol.spi(:,1),tlm.sol.spi(:,2),tlm.sol.fem(:,1),'cubic');
%       tlm.sol.int.spi(:,3)=interp1(tlm.sol.spi(:,1),tlm.sol.spi(:,3),tlm.sol.fem(:,1),'cubic');
        tlm.sol.int.spi(:,2)=interp1(tlm.sol.fem(:,1),tlm.sol.fem(:,2),tlm.sol.spi(:,1),'spline');
        tlm.sol.int.spi(:,3)=interp1(tlm.sol.fem(:,1),tlm.sol.fem(:,3),tlm.sol.spi(:,1),'spline');

%       tlm.sol.int.spi(:,3)=tlm.sol.int.spi(:,3)+180;
%       tlm.sol.spi(:,3)=tlm.sol.spi(:,3)+180;

        % Calculate the error between SPICE & FEM calculations 

        for i=1:1:size(tlm.sol.int.spi,1)                     %for each node
%           tlm.sol.mag.err(i,1)=abs((tlm.sol.int.spi(i,2)-tlm.sol.fem(i,2))/tlm.sol.fem(i,2)); 
%           tlm.sol.tet.err(i,1)=abs((tlm.sol.int.spi(i,3)-tlm.sol.fem(i,3))/tlm.sol.fem(i,3)); 
%           tlm.sol.mag.err(i,1)=abs((tlm.sol.int.spi(i,2)-tlm.sol.spi(i,2))/tlm.sol.spi(i,2)); 
%           tlm.sol.tet.err(i,1)=abs((tlm.sol.int.spi(i,3)-tlm.sol.spi(i,3))/tlm.sol.spi(i,3)); 
            tlm.sol.mag.err(i,1)=100*abs(((10^(tlm.sol.int.spi(i,2)/20)-(10^(tlm.sol.spi(i,2)/20)))/10^(tlm.sol.spi(i,2)/20))); 
            if tlm.sol.spi(i,3)~=0
                tlm.sol.tet.err(i,1)=100*abs((tlm.sol.int.spi(i,3)-tlm.sol.spi(i,3))/tlm.sol.spi(i,3));
            else
                tlm.sol.tet.err(i,1)=0.;
            end
        end

        figure(8);
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

        saveas(8,'SPICE_FEM_Comp.emf');

    end

    if ANA==0 && SPI==0
    
        tlm.sol.int.spi=[];
        tlm.sol.mag.err=[];
        tlm.sol.tet.err=[];
        
        % Interpolate Spice data on the frequencies used for the Analytical calculations

%       tlm.sol.int.spi(:,1)=tlm.sol.ana(:,1);
%       tlm.sol.int.spi(:,2)=interp1(tlm.sol.spi(:,1),tlm.sol.spi(:,2),tlm.sol.ana(:,1));
%       tlm.sol.int.spi(:,3)=interp1(tlm.sol.spi(:,1),tlm.sol.spi(:,3),tlm.sol.ana(:,1));

%       tlm.sol.int.spi(:,3)=tlm.sol.int.spi(:,3)+180;
%       tlm.sol.ana(:,3)=tlm.sol.ana(:,3)+180;
    
        tlm.sol.int.spi(:,2)=interp1(tlm.sol.ana(:,1),tlm.sol.ana(:,2),tlm.sol.spi(:,1),'spline');
        tlm.sol.int.spi(:,3)=interp1(tlm.sol.ana(:,1),tlm.sol.ana(:,3),tlm.sol.spi(:,1),'spline');

%       tlm.sol.int.spi(:,3)=tlm.sol.int.spi(:,3)+180;

        % Calculate the error between SPICE & Analytical calculations 
        for i=1:1:size(tlm.sol.int.spi,1)                     %for each node
%           tlm.sol.mag.err(i,2)=abs((tlm.sol.int.spi(i,2)-tlm.sol.ana(i,2))/tlm.sol.ana(i,2)); 
%           tlm.sol.tet.err(i,2)=abs((tlm.sol.int.spi(i,3)-tlm.sol.ana(i,3))/tlm.sol.ana(i,3)); 
            tlm.sol.mag.err(i,2)=100*abs(((10^(tlm.sol.int.spi(i,2)/20)-(10^(tlm.sol.spi(i,2)/20)))/10^(tlm.sol.spi(i,2)/20))); 
            if tlm.sol.spi(i,3)~=0
                tlm.sol.tet.err(i,2)=100*abs((tlm.sol.int.spi(i,3)-tlm.sol.spi(i,3))/tlm.sol.spi(i,3)); 
            else
                tlm.sol.tet.err(i,2)=0.;
            end
        end

        figure(9);
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

        saveas(9,'SPICE_ANA_Comp.emf');

    end

    if ANA==0 && FEM==0
    
        tlm.sol.int.ana=[];
        tlm.sol.mag.err=[];
        tlm.sol.tet.err=[];

        % Interpolate Analytical data on the frequencies used for the FEM calculations

        tlm.sol.int.ana(:,1)=tlm.sol.fem(:,1);
        tlm.sol.int.ana(:,2)=interp1(tlm.sol.ana(:,1),tlm.sol.ana(:,2),tlm.sol.fem(:,1));
        tlm.sol.int.ana(:,3)=interp1(tlm.sol.ana(:,1),tlm.sol.ana(:,3),tlm.sol.fem(:,1));

        % Calculate the error between FEM & Analytical calculations 

        for i=1:1:size(tlm.sol.int.ana,1)                     %for each node
%           tlm.sol.mag.err(i,3)=abs((tlm.sol.int.ana(i,2)-tlm.sol.fem(i,2))/tlm.sol.fem(i,2)); 
%           tlm.sol.mag.err(i,3)=abs((tlm.sol.int.ana(i,3)-tlm.sol.fem(i,3))/tlm.sol.fem(i,3)); 
            tlm.sol.mag.err(i,3)=100*abs(((10^(tlm.sol.int.ana(i,2)/20)-(10^(tlm.sol.fem(i,2)/20)))/10^(tlm.sol.fem(i,2)/20))); 
            if tlm.sol.fem(i,3)~=0
                tlm.sol.tet.err(i,3)=100*abs((tlm.sol.int.ana(i,3)-tlm.sol.fem(i,3))/tlm.sol.fem(i,3));
            else
                tlm.sol.tet.err(i,3)=0;
            end
        end

        figure(10);
        clf('reset');
        tlm.conf.fig=tlm.conf.fig+1;

        subplot(2,1,1);
        semilogx(tlm.sol.fem(:,1),tlm.sol.mag.err(:,3));
        title('Relative Error on Impedance Module & Phase between FEM & Analytical Calculations');
        ylabel('Relative Error on Impedance Module (%)');
        xlabel('Frequency');

        subplot(2,1,2);
        semilogx(tlm.sol.fem(:,1),tlm.sol.tet.err(:,3));
        ylabel('Relative Error on Impedance Phase (%)');
        xlabel('Frequency');
    
        % Save the Figure

        saveas(10,'FEM_ANA_Comp.emf');

    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Analysis of the 2D maps
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
        if tlm.var.frequence.max==10
            ex=0;
        end
        f=5*10^ex;
    elseif ii==3
        f=tlm.var.frequence.max;
    end
 
    tlm.conf.Name=[tlm.conf.Name '_' num2str(f) 'Hz'];
        
    name2=sprintf('%s.spi_cou',tlm.conf.Name);     % Name of the file (generated by SPICE) containing the voltage value at each of the fem nodes
    fid=fopen(name2, 'r');                     % Open the File

    if fid>=0       % The file exists

        tlineref1='Variables:'; 
        tlineref2='Values:'; 

        i=0;
        jk=1;
        cpt=0;
        
        while ~feof(fid)                    % In case of parasites or membrane, we have to choose one node between ibis, iter and iquad. 
            tlineread = fgetl(fid);         % In the following algorithme, we keep the electrical potential on ibis (in the outer electrodes)
            C1 = strcmp(tlineref1,tlineread);
            if C1==1
                tlineread = fgetl(fid);
                while i<3*size(fem_mesh_p,2)
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
                        while i<size(fem_mesh_p,2)+cpt
                            tlineread = fgetl(fid);
                            disp(tlineread);
                            if ind(i+1)==0
                                disp(jk);
                                disp(cpt);
                                tlm.sol.mesu.ri(jk+1,:)=str2num(tlineread);
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
        
        % SPICE values
        if tlm.conf.points==1
            xlin1=linspace(-tlm.var.LargeurChambre/2,tlm.var.LargeurChambre/2,100);
        elseif tlm.conf.points==2
            xlin1=linspace(-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode,tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode,100);
        elseif tlm.conf.points==4
            xlin1=linspace(-tlm.var.EcartementMesure/2-tlm.var.LargeurMesure,tlm.var.EcartementMesure/2+tlm.var.LargeurMesure,100);
        end

        ylin1=linspace(tlm.var.DecentrageZCellule(1)-tlm.var.EpaisseurChambre/2,tlm.var.DecentrageZCellule(1)+tlm.var.EpaisseurChambre/2,100);

        % Define a regular grid

        [X1,Y1]= meshgrid(xlin1,ylin1); %to be used with griddata not with gridfit

        % Interpolate tlm.var.Volt1 (Spice data) on the regular (X1,Y1) grid

        if size(tlm.var.X1,1)~=size(tlm.var.Volt1,2)
            Message=sprintf('\n\t\t . Error: The %s.cor and %s.spi_cou files doe not correspond',tlm.conf.Name,tlm.conf.Name);
            disp(Message);
            return
        else
            Res1=griddata(tlm.var.X1(:),tlm.var.Y1(:),tlm.var.Volt1(:),X1,Y1,'cubic');
        end
        
        % Generate approximante of tlm.var.Volt1 (Spice data) on the regular (xlin1,ylin1) grid with gridfit

%       cd(tlm.conf.src);
%       Res1=gridfit(tlm.var.X1(:),tlm.var.Y1(:),tlm.var.Volt1(:),xlin1,ylin1);
%       cd(tlm.conf.result);
%       cd(tlm.conf.Name);
    
        % Plot the result

        if ii==1
            figure(11);
        elseif ii==2
            figure(12);
        elseif ii==3
            figure(13);
        end

        clf('reset');
        tlm.conf.fig=tlm.conf.fig+1;
    
        colormap(hot(256));
    
        %with griddata
        surf(X1,Y1,Res1);
%       %with gridfit
%       surf(xlin1,ylin1,Res1);
    
        camlight right;
        lighting phong;
        shading interp
    
%       mesh(X1,Y1,Res1);
%       meshc(X1,Y1,Res1);
    
        az=40;
        el=30;
        view(az,el);

        axis tight; 
        title(['2D Map of the Electric Potential (Volt) at F=',num2str(f,'%0.2g'),' Hertz calculated with SPICE Model']);
        zlabel('Electric Potential   (Volts)');
        ylabel('Y coordinate   (microns)');
        xlabel('X coordinate   (microns)');
    
        % Save the Figure

        if ii==1
            saveas(11,'2D_Pot_SPICE_1.emf');
        elseif ii==2
            saveas(12,'2D_Pot_SPICE_2.emf');
        elseif ii==3
            saveas(13,'2D_Pot_SPICE_3.emf');
        end
        
    end
    
    tlm.conf.Name=tlm.conf.Name0;
    
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
        if tlm.var.frequence.max==10
            ex=0;
        end
        f=5*10^ex;
    elseif ii==3
        f=tlm.var.frequence.max;
    end
 
    tlm.conf.Name=[tlm.conf.Name '_' num2str(f) 'Hz'];

    name3=sprintf('%s.fem_cou',tlm.conf.Name);     % Name of the file (generated by SPICE) containing the voltage value at each of the fem nodes
    fid=fopen(name3, 'r');                     % Open the File

    if fid>=0       % The file exists

        [tlm.var.X2, tlm.var.Y2, tlm.var.Volt2] = textread(name3,'%f %f %f','headerlines',20);
    
        fclose(fid);
    
        Message=sprintf('\n\t\t . The FEM file (%s.fem_cou) has been exploited',tlm.conf.Name);
        disp(Message);
        
        if tlm.conf.log==1
            fprintf(fil,'\n\t\t . The FEM file (%s.fem_cou) has been exploited',tlm.conf.Name);
            fprintf(fil,'\n '); 
        end
        
        FEM_COU=0;
        
        for k=1:size(fem_mesh_p,2)
            tlm.var.VoltFem(k,ii)=tlm.var.Volt2(k);
        end

    else
    
        Message=sprintf('\n\t\t . The FEM File (%s.fem_cou) does not exist in the current result directory',tlm.conf.Name);
        disp(Message);
        if tlm.conf.log==1
            fprintf(fil,'\n\t\t . The FEM File (%s.fem_cou) does not exist in the current result directory',tlm.conf.Name);
            fprintf(fil,'\n '); 
        end
        
        FEM_COU=1;
    
    end
    
    % FEM values
    
    if FEM_COU==0
        
        if tlm.conf.points==1
            xlin2=linspace(-tlm.var.LargeurChambre/2,tlm.var.LargeurChambre/2,100);
        elseif tlm.conf.points==2
            xlin2=linspace(-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode,tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode,100);
        elseif tlm.conf.points==4
            xlin2=linspace(-tlm.var.EcartementMesure/2-tlm.var.LargeurMesure,tlm.var.EcartementMesure/2+tlm.var.LargeurMesure,100);
        end
       
        ylin2=linspace(tlm.var.DecentrageZCellule(1)-tlm.var.EpaisseurChambre/2,tlm.var.DecentrageZCellule(1)+tlm.var.EpaisseurChambre/2,100);

        % Define a regular grid

        [X2,Y2]= meshgrid(xlin2,ylin2); % to be used with griddata

        % Interpolate tlm.var.Volt2 (FEM data) on the regular (X2,Y2) grid

        Res2=griddata(tlm.var.X2(:),tlm.var.Y2(:),tlm.var.Volt2(:),X2,Y2,'cubic');

        % Approximate tlm.var.Volt2 (FEM data) on the regular (xlin2,ylin22) grid with gridfit

%       cd(tlm.conf.src);
%       Res2=gridfit(tlm.var.X2(:),tlm.var.Y2(:),tlm.var.Volt2(:),xlin2,ylin2);
%       cd(tlm.conf.result);
%       cd(tlm.conf.Name);

        % Plot the result

        if ii==1
            figure(14);
        elseif ii==2
            figure(16);
        elseif ii==3
            figure(18);
        end

        clf('reset');
        tlm.conf.fig=tlm.conf.fig+1;

        colormap(hot(256));
    
        %with griddata
        surf(X2,Y2,Res2);
%       %with gridfit
%       surf(xlin2,ylin2,Res2);

        camlight right;
        lighting phong;
        shading interp;

%       mesh(X2,Y2,Res2);
%       meshc(X2,Y2,Res2);
    
        az=40;
        el=30;
        view(az,el);

        axis tight; 
        title(['2D Map of the Electric Potential (Volt) at F=',num2str(f,'%0.2g'),' Hertz calculated with FEM Model']);
        zlabel('Electric Potential   (Volts)');
        ylabel('Y coordinate   (microns)');
        xlabel('X coordinate   (microns)');
        
        % Save the Figure

        if ii==1
            saveas(14,'2D_Pot_FEM_1.emf');
        elseif ii==2
            saveas(16,'2D_Pot_FEM_2.emf');
        elseif ii==3
            saveas(18,'2D_Pot_FEM_3.emf');
        end

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
        
        if tlm.conf.points==1
            xlin4=linspace(-tlm.var.LargeurChambre/2,tlm.var.LargeurChambre/2,100);
        elseif tlm.conf.points==2
            xlin4=linspace(-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode,tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode,100);
        elseif tlm.conf.points==4
            xlin4=linspace(-tlm.var.EcartementMesure/2-tlm.var.LargeurMesure,tlm.var.EcartementMesure/2+tlm.var.LargeurMesure,100);
        end
        
        ylin4=linspace(tlm.var.DecentrageZCellule(1)-tlm.var.EpaisseurChambre/2,tlm.var.DecentrageZCellule(1)+tlm.var.EpaisseurChambre/2,100);

        % Define a regular grid

%       [X4,Y4]= meshgrid(xlin4,ylin4); % to be used with griddata
    
        % Interpolate tlm.var.Err1 (Error between Spice & Analytical) on the regular (X4,Y4) grid

%       Res4=griddata(tlm.var.X1(:),tlm.var.Y1(:),tlm.var.Err1(:),X4,Y4,'linear');

        % Approximate tlm.var.Err1 (Error between Spice & Analytical) on the regular (X4,Y4) grid

        cd(tlm.conf.src);
        Res4=gridfit(tlm.var.X1(:),tlm.var.Y1(:),tlm.var.Err1(:),xlin4,ylin4);
        cd(tlm.conf.result);

        %   Plot the result

        if ii==1
            figure(15);
        elseif ii==2
            figure(17);
        elseif ii==3
            figure(19);
        end

        clf('reset');
        tlm.conf.fig=tlm.conf.fig+1;

        colormap(hot(256));
    
%       %with griddata
%       surf(X4,Y4,Res4);
        %with gridfit
        surf(xlin4,ylin4,Res4);
    
        camlight right;
        lighting phong;
        shading interp;

%       mesh(X4,Y4,Res4);
%       meshc(X4,Y4,Res4);
    
        az=40;
        el=50;
        view(az,el);
 
        axis tight; 
        title(['2D Map of the on the Electric Potential Difference(Volt) between Spice and FEM at F=',num2str(f,'%0.2g'),' Hertz']);
        zlabel('Potential Difference   (V)');
        ylabel('Y coordinate   (microns)');
        xlabel('X coordinate   (microns)');
        
        % Save the Figure

        if ii==1
            saveas(15,'2D_Pot_Diff_SPICE_FEM_1.emf');
        elseif ii==2
            saveas(17,'2D_Pot_Diff_SPICE_FEM_2.emf');
        elseif ii==3
            saveas(19,'2D_Pot_Diff_SPICE_FEM_3.emf');
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
        if tlm.var.frequence.max==10
            ex=0;
        end
        f=5*10^ex;
    elseif ii==3
        f=tlm.var.frequence.max;
    end
 
    tlm.conf.Name=[tlm.conf.Name '_' num2str(f) 'Hz'];

    name4=sprintf('%s.ana_cou',tlm.conf.Name);     % Name of the file (generated by SPICE) containing the voltage value at each of the fem nodes
    fid=fopen(name4, 'r');                         % Open the File

    if fid>=0       % The file exists

        [tlm.var.X3, tlm.var.Y3, tlm.var.Volt3] = textread(name4,'%f %f %f','headerlines',20);
    
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

        if tlm.conf.points==1
            xlin3=linspace(-tlm.var.LargeurChambre/2,tlm.var.LargeurChambre/2,100);
        elseif tlm.conf.points==2
            xlin3=linspace(-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode,tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode,100);
        elseif tlm.conf.points==4
            xlin3=linspace(-tlm.var.EcartementMesure/2-tlm.var.LargeurMesure,tlm.var.EcartementMesure/2+tlm.var.LargeurMesure,100);
        end

        ylin3=linspace(tlm.var.DecentrageZCellule(1)-tlm.var.EpaisseurChambre/2,tlm.var.DecentrageZCellule(1)+tlm.var.EpaisseurChambre/2,100);

        % Define a regular grid

        [X3,Y3]= meshgrid(xlin3,ylin3);        % to be used with griddata

        % Interpolate tlm.var.Volt3 (Analytical data) on the regular (X3,Y3) grid

        Res3=griddata(tlm.var.X3(:),tlm.var.Y3(:),tlm.var.Volt3(:),X3,Y3,'cubic');

        % Approximate tlm.var.Volt3 (Analytical data) on the regular (xlin3,ylin3) grid with gridfit

%       cd(tlm.conf.src);
%       Res3=gridfit(tlm.var.X3(:),tlm.var.Y3(:),tlm.var.Volt3(:),xlin3,ylin3);
%       cd(tlm.conf.result);
%       cd(tlm.conf.Name);

        % Plot the result

        if ii==1
            figure(20);
        elseif ii==2
            figure(23);
        elseif ii==3
            figure(26);
        end

        clf('reset');
        tlm.conf.fig=tlm.conf.fig+1;

        colormap(hot(256));
    
        %with griddata
        surf(X3,Y3,Res3);
%       %with gridfit
%       surf(xlin3,ylin3,Res3);
    
        camlight right;
        lighting phong;
        shading interp

%       mesh(X3,Y3,Res3);
%       meshc(X3,Y3,Res3);
    
        az=40;
        el=50;
        view(az,el);
 
        axis tight; 
        title(['2D Map of the Electric Potential (Volt) at F=',num2str(f,'%0.2g'),' Hertz calculated with Analytical Model']);
        zlabel('Electric Potential   (Volts)');
        ylabel('Y coordinate   (microns)');
        xlabel('X coordinate   (microns)');
        
        % Save the Figure

        if ii==1
            saveas(20,'2D_Pot_ANA_1.emf');
        elseif ii==2
            saveas(23,'2D_Pot_ANA_2.emf');
        elseif ii==3
            saveas(26,'2D_Pot_ANA_3.emf');
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
        
        if tlm.conf.points==1
            xlin5=linspace(-tlm.var.LargeurChambre/2,tlm.var.LargeurChambre/2,100);
        elseif tlm.conf.points==2
            xlin5=linspace(-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode,tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode,100);
        elseif tlm.conf.points==4
            xlin5=linspace(-tlm.var.EcartementMesure/2-tlm.var.LargeurMesure,tlm.var.EcartementMesure/2+tlm.var.LargeurMesure,100);
        end
        
        ylin5=linspace(tlm.var.DecentrageZCellule(1)-tlm.var.EpaisseurChambre/2,tlm.var.DecentrageZCellule(1)+tlm.var.EpaisseurChambre/2,100);
        
        % Define a regular grid

%       [X5,Y5]= meshgrid(xlin5,ylin5);
    
        % Interpolate tlm.var.Err2 (Error between Spice & Analytical) on the regular (X5,Y5) grid

%       Res5=griddata(tlm.var.X1(:),tlm.var.Y1(:),tlm.var.Err2(:),X5,Y5,'linear');

        % Approximate tlm.var.Err2 (Error between Spice & Analytical) on the regular (xlin5,ylin5) grid

        cd(tlm.conf.src);
        Res5=gridfit(tlm.var.X1(:),tlm.var.Y1(:),tlm.var.Err2(:),xlin5,ylin5);
        cd(tlm.conf.result);

    %   Plot the result

        if ii==1
            figure(21);
        elseif ii==2
            figure(24);
        elseif ii==3
            figure(27);
        end

        clf('reset');
        tlm.conf.fig=tlm.conf.fig+1;

        colormap(hot(256));
    
%       %with griddata
%       surf(X5,Y5,Res5);
        %with gridfit
        surf(xlin5,ylin5,Res5);
    
        camlight right;
        lighting phong;
        shading interp;

%       mesh(X5,Y5,Res5);
%       meshc(X5,Y5,Res5);
    
        az=40;
        el=50;
        view(az,el);
 
        axis tight; 
        title(['2D Map of the on the Electric Potential Difference(Volt) between Spice and Analytical at F=',num2str(f,'%0.2g'),' Hertz']);
        zlabel('Electric Potential Difference   (V)');
        ylabel('Y coordinate   (microns)');
        xlabel('X coordinate   (microns)');
        
        % Save the Figure

        if ii==1
            saveas(21,'2D_Pot_Diff_SPICE_ANA_1.emf');
        elseif ii==2
            saveas(24,'2D_Pot_Diff_SPICE_ANA_2.emf');
        elseif ii==3
            saveas(27,'2D_Pot_Diff_SPICE_ANA_3.emf');
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
        
        if tlm.conf.points==1
            xlin6=linspace(-tlm.var.LargeurChambre/2,tlm.var.LargeurChambre/2,100);
        elseif tlm.conf.points==2
            xlin6=linspace(-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode,tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode,100);
        elseif tlm.conf.points==4
            xlin6=linspace(-tlm.var.EcartementMesure/2-tlm.var.LargeurMesure,tlm.var.EcartementMesure/2+tlm.var.LargeurMesure,100);
        end
        
        ylin6=linspace(tlm.var.DecentrageZCellule(1)-tlm.var.EpaisseurChambre/2,tlm.var.DecentrageZCellule(1)+tlm.var.EpaisseurChambre/2,100);

        % Define a regular grid

%       [X6,Y6]= meshgrid(xlin6,ylin6);
    
        % Interpolate tlm.var.Err3 (Error between FEM & Analytical) on the regular (X6,Y6) grid

%       Res6=griddata(tlm.var.X1(:),tlm.var.Y1(:),tlm.var.Err3(:),X6,Y6,'linear');

        % Approximate tlm.var.Err3 (Error between FEM & Analytical) on the regular (xlin6,ylin6) grid

        cd(tlm.conf.src);
        Res6=gridfit(tlm.var.X1(:),tlm.var.Y1(:),tlm.var.Err3(:),xlin6,ylin6);
        cd(tlm.conf.result);

        %   Plot the result

        if ii==1
            figure(22);
        elseif ii==2
            figure(25);
        elseif ii==3
            figure(28);
        end

        clf('reset');
        tlm.conf.fig=tlm.conf.fig+1;

%       %with griddata
%       surf(X6,Y6,Res6);
        %with gridfit
        surf(xlin6,ylin6,Res6);
    
        camlight right;
        lighting phong;
        shading interp;

%       mesh(X6,Y6,Res6);
%       meshc(X6,Y6,Res6);
    
        az=40;
        el=50;
        view(az,el);
 
        axis tight; 
        title(['2D Map of the on the Electric Potential Difference(Volt) between FEM and Analytical at F=',num2str(f,'%0.2g'),' Hertz']);
        zlabel('Electric Potential Difference(V)');
        ylabel('Y coordinate   (microns)');
        xlabel('X coordinate   (microns)');
        
        % Save the Figure

        if ii==1
            saveas(22,'2D_Pot_Diff_FEM_ANA_1.emf');
        elseif ii==2
            saveas(25,'2D_Pot_Diff_FEM_ANA_2.emf');
        elseif ii==3
            saveas(28,'2D_Pot_Diff_FEM_ANA_3.emf');
        end

    
    end
    
    tlm.conf.Name=tlm.conf.Name0;

end