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

%tlm.conf.Name0=tlm.conf.Name;

%name1=sprintf('%s.spi',tlm.conf.Name0);     % Name of the file
%fid=fopen(name1, 'r');                     % Open the File

%if fid>=0       % The file exists
    
    %tlineref='Values:';

    %i=0;

    %while ~feof(fid)
     %   tlineread = fgetl(fid);
      %  C = strcmp(tlineref,tlineread);
       % if C==1
        %    imul=log10(tlm.var.frequence.max)-log10(tlm.var.frequence.min);
         %   while i<(tlm.var.frequence.step*imul+1)
          %          tlineread = fgetl(fid);
%    -                disp(tlineread);
          %             tlm.sol.fre(i+1,:)=str2num(tlineread);

           %            tlineread = fgetl(fid);
%    -                disp(tlineread);
            %        tlineread = fgetl(fid);
%  -                  disp(tlineread);
             %       tlineread = fgetl(fid);
%   -                 disp(tlineread);
            %        i=i+1;
           % end
           % break
        %end
   % end

 %   fclose(fid);

%else
    
  %  Message=sprintf('\n\t\t . The SPI File does not exist in the current result directory');
  %  disp(Message);
   % SPI=1;

%end

% NEW - reads Xyce .prn file:
tlm.conf.Name0 = tlm.conf.Name;
tlm.sol.fre = [];

name1 = sprintf('%s.prn', tlm.conf.Name0);
fid = fopen(name1, 'r');

if fid >= 0
    % Read header line (column names)
    header = fgetl(fid);
    
    row = 0;
    while ~feof(fid)
        line = fgetl(fid);
        if ischar(line) && ~isempty(strtrim(line)) && ~strcmp(strtrim(line), 'End of Xyce(TM) Simulation')
            vals = str2num(line);
            if numel(vals) >= 3
                row = row + 1;
                % cols: Index, FREQ, Re(V(elec2,elec1)), Im(V(elec2,elec1)), Re(I(Vin)), Im(I(Vin))
                tlm.sol.fre(row, 1) = vals(1); % index
                tlm.sol.fre(row, 2) = vals(2); % frequency
                tlm.sol.fre(row, 3) = vals(3); % Re(V)
                tlm.sol.fre(row, 4) = vals(4); % Im(V)
                tlm.sol.fre(row, 5) = vals(5); % Re(I)
                tlm.sol.fre(row, 6) = vals(6); % Im(I)
            end
        end
    end
    fclose(fid);
else
    Message = sprintf('\n\t\t . The PRN File does not exist in the current result directory');
    disp(Message);
end

% --- MISE A JOUR DYNAMIQUE DES PARAMETRES COMSOL ---
model.param.set('sig_elec', num2str(tlm.var.sig.electrode));
model.param.set('eps_elec', num2str(tlm.var.eps.electrode/tlm.var.eps0));
model.param.set('sig_med', num2str(tlm.var.sig.MilOrga));
model.param.set('eps_med', num2str(tlm.var.eps.MilOrga/tlm.var.eps0));
model.param.set('v_in', num2str(tlm.var.v0));

% --- PREPARATION DES FREQUENCES ET RESOLUTION ---

% On crée une chaîne de caractères avec toutes les fréquences espacées
freq_str = sprintf('%g ', tlm.sol.fre(:,2)); 

% On injecte cette liste dans l'étape fréquentielle de l'étude COMSOL
model.study('std1').feature('freq').set('plist', freq_str);
model.study('std1').feature('freq').set('preusesol', 'no');

% On lance directement l'étude (COMSOL va automatiquement utiliser le bon solveur)
model.study('std1').run;
data = mpheval(model,'V');

% --- EXTRACTION BODE VECTORISEE ---
% Extraction de l'admittance globale calculée par le terminal COMSOL
Y_complex = mphglobal(model, 'ec.Y11');

% Calcul de l'impédance (Z = 1 / Y). 
% Note : On met un signe '-' au cas où le courant serait orienté vers l'extérieur dans COMSOL,
% ce qui est souvent le cas quand on a des admittances négatives comme ici.
Z_complex = conj(-1 ./ Y_complex);

% On s'assure que Z_complex est bien sous forme de colonne
Z_complex = Z_complex(:); 

% Remplissage instantané du tableau des résultats
freqs = tlm.sol.fre(:,2);
tlm.sol.val(:,1) = freqs;
tlm.sol.val(:,2) = 20 * log10(abs(Z_complex));
tlm.sol.val(:,3) = angle(Z_complex) * 180 / pi;
tlm.sol.val(:,7) = real(Z_complex);
tlm.sol.val(:,8) = imag(Z_complex);

ii=0;

%ex=round((log10(tlm.var.frequence.max)+log10(tlm.var.frequence.min))/2);
% Safety check - use actual number of points from Xyce output
nfreqs = size(tlm.sol.fre, 1);
%for a=1:1:(log10(tlm.var.frequence.max)-log10(tlm.var.frequence.min))*tlm.var.frequence.step+1
for a=1:1:nfreqs
       
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
end

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

% Écriture vectorisée ultra-rapide
fprintf(fid, '%1.3g %1.10g %1.10g %1.10g %1.10g\n', tlm.sol.val(:,[1, 2, 3, 7, 8])');

fclose(fid);

tlm.conf.Name=tlm.conf.Name0;