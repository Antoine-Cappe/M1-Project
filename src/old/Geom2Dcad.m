%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                              BIOCAD Program
%                               Release 1.0
%
%   Authors: Vincent Senez
%   
%   Release 1.0 : January 2019
%
%   Function : Draw the 2D geometry of the device with COMSOL routines
%
%   Call by: Compute.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%function [tlm,fem]=Geom2Dcad(tlm)
function [tlm,model]=Geom2Dcad(tlm)

%Check the geometry

%%%%%%%%%%more controls to add

% Create the COMSOL model

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('C:\Users\Vincent Senez\Documents\Enseignement\YNCREA\TP_COMSOL'); % definit la directory ou sont sauvés les fichier .mph ou .m

model.comments(['sans titre\n\n']); % revoir à quoi cela sert


% Set the parameters

model.param.set('LargeurChambre', tlm.var.LargeurChambre);
model.param.set('EpaisseurChambre', tlm.var.EpaisseurChambre);
model.param.set('EpaisseurMesure', tlm.var.EpaisseurMesure);
model.param.set('OrigineX', tlm.var.OrigineX);
model.param.set('OrigineY', tlm.var.OrigineY);
model.param.set('Center', tlm.var.Center);
model.param.set('LargeurElectrode', tlm.var.LargeurElectrode);
model.param.set('LargeurMesure', tlm.var.LargeurMesure);
model.param.set('EpaisseurElectrode', tlm.var.EpaisseurElectrode);
model.param.set('EcartementElectrode', tlm.var.EcartementElectrode);
model.param.set('EcartementMesure', tlm.var.EcartementMesure);
model.param.set('RayonXCellule', tlm.var.RayonXCellule(1));
model.param.set('RayonYCellule', tlm.var.RayonYCellule(1));
model.param.set('RayonZCellule', tlm.var.RayonZCellule(1));
model.param.set('RayonXNoyau', tlm.var.RayonXNoyau(1));
model.param.set('RayonYNoyau', tlm.var.RayonYNoyau(1));
model.param.set('RayonZNoyau', tlm.var.RayonZNoyau(1));
model.param.set('RayonXMitoc', tlm.var.RayonXMitoc(1));
model.param.set('RayonYMitoc', tlm.var.RayonYMitoc(1));
model.param.set('RayonZMitoc', tlm.var.RayonZMitoc(1));
model.param.set('DecentrageXCellule', tlm.var.DecentrageXCellule(1));
model.param.set('DecentrageYCellule', tlm.var.DecentrageYCellule(1));
model.param.set('DecentrageZCellule', tlm.var.DecentrageZCellule(1));
model.param.set('DecentrageXNoyau', tlm.var.DecentrageXNoyau(1));
model.param.set('DecentrageYNoyau', tlm.var.DecentrageYNoyau(1));
model.param.set('DecentrageZNoyau', tlm.var.DecentrageZNoyau(1));
model.param.set('DecentrageXMitoc', tlm.var.DecentrageXMitoc(1));
model.param.set('DecentrageYMitoc', tlm.var.DecentrageYMitoc(1));
model.param.set('DecentrageZMitoc', tlm.var.DecentrageZMitoc(1));

%create a simulation model named 'comp1'
model.modelNode.create('comp1');

% set a label for the simaulation model
model.modelNode('comp1').label('Simulation Spectre Impedance Electrique');

% create a 2D geometry called 'geom1'
model.geom.create('geom1', 2);

%set a label for the geometry named 'geom1'
model.geom('geom1').label('Integrated Microfluidique Device');

% Set the length unit
model.geom('geom1').lengthUnit('m');

%create a 2D mesh named 'mesh1' for geometry named 'geom1'
model.mesh.create('mesh1', 'geom1');

% FEMLAB Version

%clear vrsn;                   % 2018

%vrsn.name = tlm.conf.nam;                  % 2018
%vrsn.ext = tlm.conf.ext;
%vrsn.major = tlm.conf.major;                  % 2018
%vrsn.build = tlm.conf.build;                  % 2018
%vrsn.rcs = tlm.conf.rcs;                  % 2018
%vrsn.date = tlm.conf.da;                  % 2018

%fem.version = vrsn;

% New geometry 1
fem.sdim={'x','y'};

% Geometry
clear s c p

%The Chamber

if tlm.conf.Milo==1
    model.geom('geom1').create('R1', 'Rectangle');
    model.geom('geom1').feature('R1').set('size', {'LargeurChambre' 'EpaisseurChambre'});
    model.geom('geom1').feature('R1').set('pos', {'OrigineX-Center-LargeurChambre/2' 'OrigineY'});
    model.geom('geom1').run;
    
%    model.material('mat1').selection.set([2]);

%    R1=rect2(tlm.var.OrigineX-tlm.var.LargeurChambre/2-tlm.var.Center,tlm.var.OrigineX+tlm.var.LargeurChambre/2-tlm.var.Center, ...
%    tlm.var.OrigineY,tlm.var.OrigineY+tlm.var.EpaisseurChambre);
end

if tlm.conf.Milo==2
    if (tlm.conf.Cell==0 || tlm.conf.Cell==2)
        R1=rect2(tlm.var.OrigineX-tlm.var.LargeurChambre/2-tlm.var.Center,tlm.var.OrigineX+tlm.var.LargeurChambre/2-tlm.var.Center, ...
        tlm.var.OrigineY,tlm.var.OrigineY+tlm.var.EpaisseurChambre);
        R6=rect2(tlm.var.OrigineX-tlm.var.LargeurChambre/2+tlm.var.Center,tlm.var.OrigineX+tlm.var.LargeurChambre/2+tlm.var.Center, ...
        tlm.var.OrigineY,tlm.var.OrigineY+tlm.var.EpaisseurChambre);
    else
        R11=rect2(tlm.var.OrigineX-tlm.var.LargeurChambre/2-tlm.var.Center,tlm.var.OrigineX+tlm.var.LargeurChambre/2-tlm.var.Center, ...
        tlm.var.OrigineY,tlm.var.OrigineY+tlm.var.EpaisseurChambre);
        if tlm.conf.Shape==0                    % spheroid cell 
            E11=ellip2(tlm.var.OrigineX+tlm.var.DecentrageXCellule(1),tlm.var.OrigineY+tlm.var.DecentrageZCellule(1),tlm.var.RayonXCellule(1), ...
                  tlm.var.RayonZCellule(1),0);
            E11=rotate(E11,tlm.var.Orientation.Cellule(1),[0,tlm.var.DecentrageZCellule(1)]);
        end
        R1=geomcomp({R11,E11},'ns',{'R11','E11'},'sf','R11-E11','edge','none');
        R66=rect2(tlm.var.OrigineX-tlm.var.LargeurChambre/2+tlm.var.Center,tlm.var.OrigineX+tlm.var.LargeurChambre/2+tlm.var.Center, ...
        tlm.var.OrigineY,tlm.var.OrigineY+tlm.var.EpaisseurChambre);
        if tlm.conf.Shape==0                    % spheroid cell 
            E11=ellip2(tlm.var.OrigineX+tlm.var.DecentrageXCellule(1),tlm.var.OrigineY+tlm.var.DecentrageZCellule(1),tlm.var.RayonXCellule(1), ...
                  tlm.var.RayonZCellule(1),0);
            E11=rotate(E11,tlm.var.Orientation.Cellule(1),[0,tlm.var.DecentrageZCellule(1)]);
        end
        R6=geomcomp({R66,E11},'ns',{'R66','E11'},'sf','R66-E11','edge','none');
    end
end

%The left outer electrode

model.geom('geom1').create('R2', 'Rectangle');
    model.geom('geom1').feature('R2').set('size', {'LargeurElectrode' 'EpaisseurElectrode'});
    model.geom('geom1').feature('R2').set('pos', {'OrigineX-EcartementElectrode/2-LargeurElectrode' 'OrigineY'});
    
%if tlm.conf.points==1 % 2 points facing
%    model.geom('geom1').create('R2', 'Rectangle');
%    model.geom('geom1').feature('R2').set('size', {'LargeurElectrode' 'EpaisseurElectrode'});
%    model.geom('geom1').feature('R2').set('pos', {'OrigineX-EcartementElectrode/2-LargeurElectrode' 'OrigineY'});
%    model.geom('geom1').run;

%    R2=rect2(tlm.var.OrigineX-tlm.var.LargeurElectrode/2, ...
%    tlm.var.OrigineX+tlm.var.LargeurElectrode/2,tlm.var.OrigineY, ...
%    tlm.var.OrigineY+tlm.var.EpaisseurMesure);
%elseif tlm.conf.points==2 % 2 points coplanar
%    model.geom('geom1').create('R2', 'Rectangle');
%    model.geom('geom1').feature('R2').set('size', {'LargeurElectrode' 'EpaisseurMesure'});
%    model.geom('geom1').feature('R2').set('pos', {'OrigineX-EcartementElectrode/2-LargeurElectrode' 'OrigineY'});
%    model.geom('geom1').run;


%    R2=rect2(tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode, ...
%    tlm.var.OrigineX-tlm.var.EcartementElectrode/2,tlm.var.OrigineY, ...
%    tlm.var.OrigineY+tlm.var.EpaisseurElectrode);
%elseif tlm.conf.points==4 % 4 points coplanar 
%   
%    model.geom('geom1').create('R2', 'Rectangle');
%    model.geom('geom1').feature('R2').set('size', {'LargeurElectrode' 'EpaisseurElectrode'});
%    model.geom('geom1').feature('R2').set('pos', {'OrigineX-EcartementElectrode/2-LargeurElectrode' 'OrigineY'});
%    model.geom('geom1').run;    

%    R2=rect2(tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode, ...
%    tlm.var.OrigineX-tlm.var.EcartementElectrode/2,tlm.var.OrigineY, ...
%    tlm.var.OrigineY+tlm.var.EpaisseurElectrode);
%end

%The right outer 

    model.geom('geom1').create('R3', 'Rectangle');
    model.geom('geom1').feature('R3').set('size', {'LargeurElectrode' 'EpaisseurElectrode'});
    model.geom('geom1').feature('R3').set('pos', {'OrigineX+EcartementElectrode/2' 'OrigineY'});

%if tlm.conf.points==1 % 2 points facing
%    model.geom('geom1').create('R3', 'Rectangle');
%    model.geom('geom1').feature('R3').set('size', {'LargeurElectrode' 'EpaisseurElectrode'});
%    model.geom('geom1').feature('R3').set('pos', {'OrigineX+EcartementElectrode/2+LargeurElectrode' 'OrigineY'});

%    R3=rect2(tlm.var.OrigineX-tlm.var.LargeurElectrode/2, ...
%    tlm.var.OrigineX+tlm.var.LargeurElectrode/2,tlm.var.OrigineY+tlm.var.EpaisseurChambre-tlm.var.EpaisseurMesure, ...
%    tlm.var.OrigineY+tlm.var.EpaisseurChambre);
%elseif tlm.conf.points==2 % 2 points coplanar
%    model.geom('geom1').create('R3', 'Rectangle');
%    model.geom('geom1').feature('R3').set('size', {'LargeurElectrode' 'EpaisseurMesure'});
%    model.geom('geom1').feature('R3').set('pos', {'OrigineX+EcartementElectrode/2+LargeurElectrode' 'OrigineY'});

%    R3=rect2(tlm.var.OrigineX+tlm.var.EcartementElectrode/2, ...
%    tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode,tlm.var.OrigineY, ...
%    tlm.var.OrigineY+tlm.var.EpaisseurElectrode);
%elseif tlm.conf.points==4
%    model.geom('geom1').create('R3', 'Rectangle');
%    model.geom('geom1').feature('R3').set('size', {'LargeurElectrode' 'EpaisseurElectrode'});
%    model.geom('geom1').feature('R3').set('pos', {'OrigineX+EcartementElectrode/2' 'OrigineY'});
%    model.geom('geom1').run;    

%    R3=rect2(tlm.var.OrigineX+tlm.var.EcartementElectrode/2, ...
%    tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode,tlm.var.OrigineY, ...
%    tlm.var.OrigineY+tlm.var.EpaisseurElectrode);
%end

%The left inner electrode
if tlm.conf.points==4

    model.geom('geom1').create('R4', 'Rectangle');
    model.geom('geom1').feature('R4').set('size', {'LargeurMesure' 'EpaisseurMesure'});
    model.geom('geom1').feature('R4').set('pos', {'OrigineX-EcartementMesure/2-LargeurMesure' 'OrigineY'});
%    model.geom('geom1').run;    

%    R4=rect2(tlm.var.OrigineX-tlm.var.EcartementMesure/2-tlm.var.LargeurMesure,tlm.var.OrigineX-tlm.var.EcartementMesure/2, ...
%    tlm.var.OrigineY, tlm.var.OrigineY+tlm.var.EpaisseurMesure);
end

%The right inner electrode
if tlm.conf.points==4
    model.geom('geom1').create('R5', 'Rectangle');
    model.geom('geom1').feature('R5').set('size', {'LargeurMesure' 'EpaisseurMesure'});
    model.geom('geom1').feature('R5').set('pos', {'OrigineX+EcartementMesure/2' 'OrigineY'});
%    model.geom('geom1').run;    

%    R5=rect2(tlm.var.OrigineX+tlm.var.EcartementMesure/2,tlm.var.OrigineX+tlm.var.EcartementMesure/2+tlm.var.LargeurMesure, ...
%    tlm.var.OrigineY, tlm.var.OrigineY+tlm.var.EpaisseurMesure);
end

if tlm.conf.Cell==1

%The first cell

    if tlm.conf.Shape==0                    % spheroid cell 
        model.geom('geom1').create('E1', 'Ellipse');
        model.geom('geom1').feature('E1').set('semiaxes',{'RayonXCellule' 'RayonZCellule'});
        model.geom('geom1').feature('E1').set('pos', {'OrigineX+DecentrageXCellule' 'OrigineY+DecentrageZCellule'});
 %       E1=ellip2(tlm.var.OrigineX+tlm.var.DecentrageXCellule(1),tlm.var.OrigineY+tlm.var.DecentrageZCellule(1),tlm.var.RayonXCellule(1), ...
 %                 tlm.var.RayonZCellule(1),0);
 %       E1=rotate(E1,tlm.var.Orientation.Cellule(1),[0,tlm.var.DecentrageZCellule(1)]);
    elseif tlm.conf.Shape==2                % arbitrary shaped cell
        [A]= xlsread(tlm.conf.XLS.Name,tlm.conf.XLS.Sheet);
        for i=1:1:61
            point(1,i)=(A(i,1)-A(1,1)-((A(61,1)-A(1,1))/2))*tlm.var.EpaisseurChambre/2;
            point(2,i)=A(i,2)*tlm.var.EpaisseurChambre/2+tlm.var.DecentrageZCellule(1);
        end
        carr={geomspline(point,'Closed','on','SplineMethod','centripetal')};
        E1a=geomcoerce('solid',carr);
        E1b=mirror(E1a,[0,tlm.var.DecentrageZCellule(1)],[0,1]);
        E1=geomcomp({E1a,E1b},'ns',{'E1a','E1b'},'sf','E1a+E1b','edge','none');
        E1=geomdel(E1);
        E1=scale(E1,1,1,0,0);
        E1=move(E1,[tlm.var.DecentrageXCellule(1),0]);
        E1=rotate(E1,tlm.var.Orientation.Cellule(1),[0,tlm.var.DecentrageZCellule(1)]);
    elseif tlm.conf.Shape==1                % non-spheroid cell
        rmax=0;
        for i=1:1:36
            r=tlm.var.sha0+tlm.var.sha1*cos(10*i*pi/180)+cos(10*i*pi/180)*cos(10*i*pi/180);
            if r>=rmax
                rmax=r;!
%                    display(r);
            end
        end
        for i=1:1:36
            r=tlm.var.sha0+tlm.var.sha1*cos(10*i*pi/180)+cos(10*i*pi/180)*cos(10*i*pi/180);
            point(1,i)=r/rmax*cos(10*i*pi/180)*tlm.var.RayonXCellule(1);
            point(2,i)=r/rmax*sin(10*i*pi/180)*tlm.var.RayonYCellule(1)+tlm.var.DecentrageZCellule(1);
%                if 10*i==90
%                    display(point(1,i));
%                    display(point(2,i));
%                end
        end
        carr={geomspline(point,'Closed','on','SplineMethod','centripetal')};
        E1=geomcoerce('solid',carr);
        E1=geomdel(E1);
        E1=scale(E1,1,1,0,0);
        E1=move(E1,[tlm.var.DecentrageXCellule(1),0]);
        E1=rotate(E1,tlm.var.Orientation.Cellule(1),[0,tlm.var.DecentrageZCellule(1)]);
    end

%    tlm.var.NbSurfaceCell(1)=flgeomnbs(E1); % Number of edge (i.e.: line in 2D, surface in 3D) at the cel1 surface
%    tlm.var.NbSurfaceCell(1)=model.geom('geom1').feature('E1').getNEdges();%
%    Number of edge (i.e.: line in 2D, surface in 3D) at the cel1 surface a
%    modifier 11012019
%The nucleus of the first cell
    if tlm.conf.Nucleus==1
        model.geom('geom1').create('E2', 'Ellipse');
        model.geom('geom1').feature('E2').set('semiaxes',{'RayonXNoyau' 'RayonZNoyau'});
        model.geom('geom1').feature('E2').set('pos', {'OrigineX+DecentrageXCellule+DecentrageXNoyau' 'OrigineY+DecentrageZCellule+DecentrageZNoyau'});

%        E2=ellip2(tlm.var.OrigineX+tlm.var.DecentrageXCellule(1)+tlm.var.DecentrageXNoyau(1), ...
%        tlm.var.OrigineY+tlm.var.DecentrageZCellule(1)+tlm.var.DecentrageZNoyau(1), ...
%        tlm.var.RayonXNoyau(1),tlm.var.RayonZNoyau(1),0);
% a remettre        E2=rotate(E2,tlm.var.Orientation.Cellule(1),[0,tlm.var.DecentrageZCellule(1)]);
    end

%The mitochondria of the first cell
    if tlm.conf.Mitocho==1
        model.geom('geom1').create('E3', 'Ellipse');
        model.geom('geom1').feature('E3').set('semiaxes',{'RayonXMitoc' 'RayonZMitoc'});
        model.geom('geom1').feature('E3').set('pos', {'OrigineX+DecentrageXCellule+DecentrageXMitoc' 'OrigineY+DecentrageZCellule+DecentrageZMitoc'});

%        E3=ellip2(tlm.var.OrigineX+tlm.var.DecentrageXCellule(1)+tlm.var.DecentrageXMitoc(1), ...
%        tlm.var.OrigineY+tlm.var.DecentrageZCellule(1)+tlm.var.DecentrageZMitoc(1), ...
%        tlm.var.RayonXMitoc(1),tlm.var.RayonZMitoc(1),pi/4);
% a rajouter        E3=rotate(E3,tlm.var.Orientation.Cellule(1),[0,tlm.var.DecentrageZCellule(1)]);
    end
    model.geom('geom1').feature('E1')%?????? a quoi ca sert??
elseif (tlm.conf.Cell==2)
    
%The first cell

    if tlm.conf.Shape==0                    % spheroid cell 
        model.geom('geom1').create('E1', 'Ellipse');
        model.geom('geom1').feature('E1').set('semiaxes',{'RayonXCellule' 'RayonZCellule'});
        model.geom('geom1').feature('E1').set('pos', {'OrigineX+DecentrageXCellule' 'OrigineY+DecentrageZCellule'});
%        E1=ellip2(tlm.var.OrigineX+tlm.var.DecentrageXCellule(1),tlm.var.OrigineY+tlm.var.DecentrageZCellule(1),tlm.var.RayonXCellule(1), ...
%                  tlm.var.RayonZCellule(1),0);
% a rajouter        E1=rotate(E1,tlm.var.Orientation.Cellule(1),[0,tlm.var.DecentrageZCellule(1)]);
    elseif tlm.conf.Shape==2                % arbitrary shaped cell
        [A]= xlsread(tlm.conf.XLS.Name,tlm.conf.XLS.Sheet);
        for i=1:1:61
            point(1,i)=(A(i,1)-A(1,1)-((A(61,1)-A(1,1))/2))*tlm.var.EpaisseurChambre/2;
            point(2,i)=A(i,2)*tlm.var.EpaisseurChambre/2+tlm.var.DecentrageZCellule(1);
        end
        carr={geomspline(point,'Closed','on','SplineMethod','centripetal')};
        E1a=geomcoerce('solid',carr);
        E1b=mirror(E1a,[0,tlm.var.DecentrageZCellule(1)],[0,1]);
        E1=geomcomp({E1a,E1b},'ns',{'E1a','E1b'},'sf','E1a+E1b','edge','none');
        E1=geomdel(E1);
        E1=scale(E1,1,1,0,0);
        E1=move(E1,[tlm.var.DecentrageXCellule(1),0]);
        E1=rotate(E1,tlm.var.Orientation.Cellule(1),[0,tlm.var.DecentrageZCellule(1)]);
    elseif tlm.conf.Shape==1                % non-spheroid cell
        rmax=0;
        for i=1:1:36
            r=tlm.var.sha0+tlm.var.sha1*cos(10*i*pi/180)+cos(10*i*pi/180)*cos(10*i*pi/180);
            if r>=rmax
                rmax=r;
%                    display(r);
            end
        end
        for i=1:1:36
            r=tlm.var.sha0+tlm.var.sha1*cos(10*i*pi/180)+cos(10*i*pi/180)*cos(10*i*pi/180);
            point(1,i)=r/rmax*cos(10*i*pi/180)*tlm.var.RayonXCellule(1);
            point(2,i)=r/rmax*sin(10*i*pi/180)*tlm.var.RayonYCellule(1)+tlm.var.DecentrageZCellule(1);
%                if 10*i==90
%                    display(point(1,i));
%                    display(point(2,i));
%                end
        end
        carr={geomspline(point,'Closed','on','SplineMethod','centripetal')};
        E1=geomcoerce('solid',carr);
        E1=geomdel(E1);
        E1=scale(E1,1,1,0,0);
        E1=move(E1,[tlm.var.DecentrageXCellule(1),0]);
        E1=rotate(E1,tlm.var.Orientation.Cellule(1),[0,tlm.var.DecentrageZCellule(1)]);
    end
    
    tlm.var.NbSurfaceCell(1)=flgeomnbs(E1); % Number of edge (i.e.: line in 2D, surface in 3D) at the cell1 surface
    
%The nucleus of the first cell
    if tlm.conf.Nucleus==1
        model.geom('geom1').create('E2', 'Ellipse');
        model.geom('geom1').feature('E2').set('semiaxes',{'RayonXNoyau' 'RayonZNoyau'});
        model.geom('geom1').feature('E2').set('pos', {'OrigineX+DecentrageXCellule+DecentrageXNoyau' 'OrigineY+DecentrageZCellule+DecentrageZNoyau'});


%        E2=ellip2(tlm.var.OrigineX+tlm.var.DecentrageXCellule(1)+tlm.var.DecentrageXNoyau(1), ...
%        tlm.var.OrigineY+tlm.var.DecentrageZCellule(1)+tlm.var.DecentrageZNoyau(1), ...
%        tlm.var.RayonXNoyau(1),tlm.var.RayonZNoyau(1),0);
% a rajouter        E2=rotate(E2,tlm.var.Orientation.Cellule(1),[0,tlm.var.DecentrageZCellule(1)]);
    end

%The mitochondria of the first cell
    if tlm.conf.Mitocho==1
        model.geom('geom1').create('E3', 'Ellipse');
        model.geom('geom1').feature('E3').set('semiaxes',{'RayonXMitoc' 'RayonZMitoc'});
        model.geom('geom1').feature('E3').set('pos', {'OrigineX+DecentrageXCellule+DecentrageXMitoc' 'OrigineY+DecentrageZCellule+DecentrageZMitoc'});

%        E3=ellip2(tlm.var.OrigineX+tlm.var.DecentrageXCellule(1)+tlm.var.DecentrageXMitoc(1), ...
%        tlm.var.OrigineY+tlm.var.DecentrageZCellule(1)+tlm.var.DecentrageZMitoc(1), ...
%        tlm.var.RayonXMitoc(1),tlm.var.RayonZMitoc(1),pi/4);
% a rajouter        E3=rotate(E3,tlm.var.Orientation.Cellule(1),[0,tlm.var.DecentrageZCellule(1)]);
    end

%The second cell
    if tlm.conf.Shape==0                    % spheroid cell 
        model.geom('geom1').create('E4', 'Ellipse');
        model.geom('geom1').feature('E4').set('semiaxes',{'RayonXCellule' 'RayonZCellule'});
        model.geom('geom1').feature('E4').set('pos', {'OrigineX+DecentrageXCellule' 'OrigineY+DecentrageZCellule'});

%        E4=ellip2(tlm.var.OrigineX+tlm.var.DecentrageXCellule(2),tlm.var.OrigineY+tlm.var.DecentrageZCellule(2),tlm.var.RayonXCellule(2), ...
%                  tlm.var.RayonZCellule(2),0);
% a rajouter        E4=rotate(E4,tlm.var.Orientation.Cellule(2),[0,tlm.var.DecentrageZCellule(2)]);
    elseif tlm.conf.Shape==2                % arbitrary shaped cell
        [A]= xlsread(tlm.conf.XLS.Name,tlm.conf.XLS.Sheet);
        for i=1:1:61
            point(1,i)=(A(i,1)-A(1,1)-((A(61,1)-A(1,1))/2))*tlm.var.EpaisseurChambre/2;
            point(2,i)=A(i,2)*tlm.var.EpaisseurChambre/2+tlm.var.DecentrageZCellule(2);
        end
        carr={geomspline(point,'Closed','on','SplineMethod','centripetal')};
        E4a=geomcoerce('solid',carr);
        E4b=mirror(E4a,[0,tlm.var.DecentrageZCellule(2)],[0,1]);
        E4=geomcomp({E4a,E4b},'ns',{'E4a','E4b'},'sf','E4a+E4b','edge','none');
        E4=geomdel(E4);
        E4=scale(E4,1,1,0,0);
        E4=move(E4,[tlm.var.DecentrageXCellule(2),0]);
        E4=rotate(E4,tlm.var.Orientation.Cellule(2),[0,tlm.var.DecentrageZCellule(2)]);
    elseif tlm.conf.Shape==1                % non-spheroid cell
        rmax=0;
        for i=1:1:36
            r=tlm.var.sha0+tlm.var.sha1*cos(10*i*pi/180)+cos(10*i*pi/180)*cos(10*i*pi/180);
            if r>=rmax
                rmax=r;
%                    display(r);
            end
        end
        for i=1:1:36
            r=tlm.var.sha0+tlm.var.sha1*cos(10*i*pi/180)+cos(10*i*pi/180)*cos(10*i*pi/180);
            point(1,i)=r/rmax*cos(10*i*pi/180)*tlm.var.RayonXCellule(2);
            point(2,i)=r/rmax*sin(10*i*pi/180)*tlm.var.RayonYCellule(2)+tlm.var.DecentrageZCellule(2);
%                if 10*i==90
%                    display(point(1,i));
%                    display(point(2,i));
%                end
        end
        carr={geomspline(point,'Closed','on','SplineMethod','centripetal')};
        E4=geomcoerce('solid',carr);
        E4=geomdel(E4);
        E4=scale(E4,1,1,0,0);
        E4=move(E4,[tlm.var.DecentrageXCellule(2),0]);
        E4=rotate(E4,tlm.var.Orientation.Cellule(2),[0,tlm.var.DecentrageZCellule(2)]);
    end
    
    tlm.var.NbSurfaceCell(2)=flgeomnbs(E4); % Number of edge (i.e.: line in 2D, surface in 3D) at the cell2 surface
    
%The nucleus of the second cell
    if tlm.conf.Nucleus==1
        model.geom('geom1').create('E5', 'Ellipse');
        model.geom('geom1').feature('E5').set('semiaxes',{'RayonXNoyau' 'RayonZNoyau'});
        model.geom('geom1').feature('E5').set('pos', {'OrigineX+DecentrageXCellule+DecentrageXNoyau' 'OrigineY+DecentrageZCellule+DecentrageZNoyau'});


%        E5=ellip2(tlm.var.OrigineX+tlm.var.DecentrageXCellule(2)+tlm.var.DecentrageXNoyau(2), ...
%        tlm.var.OrigineY+tlm.var.DecentrageZCellule(2)+tlm.var.DecentrageZNoyau(2), ...
%        tlm.var.RayonXNoyau(2),tlm.var.RayonZNoyau(2),0);
% a rajouter        E5=rotate(E5,tlm.var.Orientation.Cellule(2),[0,tlm.var.DecentrageZCellule(2)]);
    end

%The mitochondria of the second cell
    if tlm.conf.Mitocho==1
        model.geom('geom1').create('E6', 'Ellipse');
        model.geom('geom1').feature('E6').set('semiaxes',{'RayonXMitoc' 'RayonZMitoc'});
        model.geom('geom1').feature('E6').set('pos', {'OrigineX+DecentrageXCellule+DecentrageXMitoc' 'OrigineY+DecentrageZCellule+DecentrageZMitoc'});

%        E6=ellip2(tlm.var.OrigineX+tlm.var.DecentrageXCellule(2)+tlm.var.DecentrageXMitoc(2), ...
%        tlm.var.OrigineY+tlm.var.DecentrageZCellule(2)+tlm.var.DecentrageZMitoc(2), ...
%        tlm.var.RayonXMitoc(2),tlm.var.RayonZMitoc(2),-pi/4);
% a rajouter        E6=rotate(E6,tlm.var.Orientation.Cellule(1),[0,tlm.var.DecentrageZCellule(1)]);
    end
    
end

model.geom('geom1').run;  

%model.geom('geom1').feature('R1').set('createselection','on');
%model.selection.tags;
%mphgetselection(model.selection('geom1_R1_dom'))

%model.geom('geom1').run;
      
if (tlm.conf.Cell==0 && tlm.conf.Milo==1)
    
    if  tlm.conf.points==1 || tlm.conf.points==2
        model.geom('geom1').feature('R1').label('CHAMBER');
        model.geom('geom1').feature('R2').label('ELEC1');
        model.geom('geom1').feature('R3').label('ELEC2');
        model.geom('geom1').feature('fin').label('UNION');

%        objs={R1,R2,R3};
%        names={'CHAMBER','ELEC1','ELEC2'};
    elseif tlm.conf.points==4
        model.geom('geom1').feature('R1').label('CHAMBER');
        model.geom('geom1').feature('R2').label('ELEC1');
        model.geom('geom1').feature('R3').label('ELEC2');
        model.geom('geom1').feature('R4').label('MESU1');
        model.geom('geom1').feature('R5').label('MESU2');
        model.geom('geom1').feature('fin').label('UNION');
        
%        model.material.create('mat1', 'Common', 'comp1');
%        model.material('mat1').propertyGroup('def').set('electricconductivity', {'num2str(tlm.var.sig.MilOrga)'});
%        model.material('mat1').propertyGroup('def').set('relpermittivity', {'num2str(tlm.var.eps.MilOrga/tlm.var.eps0)'});

%        model.material('mat1').label('MilOrga');
%        model.material('mat1').selection.set([2]);

%        objs={R1,R2,R3,R4,R5};
%        names={'CHAMBER','ELEC1','ELEC2','MESU1','MESU2'};

    end
    
elseif (tlm.conf.Cell==0 && tlm.conf.Milo==2)
    
    if  tlm.conf.points==1 || tlm.conf.points==2
        model.geom('geom1').feature('R1').label('MEDIUM1');
        model.geom('geom1').feature('R2').label('ELEC1');
        model.geom('geom1').feature('R3').label('ELEC2');
        model.geom('geom1').feature('R6').label('MEDIUM2');
        model.geom('geom1').feature('fin').label('UNION');

%        objs={R1,R2,R3,R6};
%        names={'MEDIUM1','ELEC1','ELEC2','MEDIUM2'};
    elseif tlm.conf.points==4
        
        model.geom('geom1').feature('R1').label('MEDIUM1');
        model.geom('geom1').feature('R2').label('ELEC1');
        model.geom('geom1').feature('R3').label('ELEC2');
        model.geom('geom1').feature('R4').label('MESU1');
        model.geom('geom1').feature('R5').label('MESU2');
        model.geom('geom1').feature('R6').label('MEDIUM2');
        model.geom('geom1').feature('fin').label('UNION');

%        objs={R1,R2,R3,R4,R5,R6};
%        names={'MEDIUM1','ELEC1','ELEC2','MESU1','MESU2','MEDIUM2'};
    end

elseif (tlm.conf.Cell==1 && tlm.conf.Milo==1)
    
    if (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1)
        if tlm.conf.points==1 || tlm.conf.points==2
            model.geom('geom1').feature('R1').label('CHAMBER');
            model.geom('geom1').feature('R2').label('ELEC1');
            model.geom('geom1').feature('R3').label('ELEC2');
            model.geom('geom1').feature('E1').label('CELL1');
            model.geom('geom1').feature('E2').label('NUCLEUS1');
            model.geom('geom1').feature('E3').label('MITOCHONDRIA1');
            model.geom('geom1').feature('fin').label('UNION');
            
 %           objs={R1,R2,R3,E1,E2,E3};
 %           names={'CHAMBER','ELEC1','ELEC2','CELL1','NUCLEUS1','MITOCHONDRIA1'};
        elseif tlm.conf.points==4
            model.geom('geom1').feature('R1').label('CHAMBER');
            model.geom('geom1').feature('R2').label('ELEC1');
            model.geom('geom1').feature('R3').label('ELEC2');
            model.geom('geom1').feature('R4').label('MESU1');
            model.geom('geom1').feature('R5').label('MESU2');
            model.geom('geom1').feature('E1').label('CELL1');
            model.geom('geom1').feature('E2').label('NUCLEUS1');
            model.geom('geom1').feature('E3').label('MITOCHONDRIA1');
            model.geom('geom1').feature('fin').label('UNION');
            
 %           objs={R1,R2,R3,R4,R5,E1,E2,E3};
 %           names={'CHAMBER','ELEC1','ELEC2','MESU1','MESU2','CELL1','NUCLEUS1','MITOCHONDRIA1'};
        end
    elseif (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0)
        if tlm.conf.points==1 || tlm.conf.points==2
            model.geom('geom1').feature('R1').label('CHAMBER');
            model.geom('geom1').feature('R2').label('ELEC1');
            model.geom('geom1').feature('R3').label('ELEC2');
            model.geom('geom1').feature('E1').label('CELL1');
            model.geom('geom1').feature('E2').label('NUCLEUS1');
            model.geom('geom1').feature('fin').label('UNION');

%            objs={R1,R2,R3,E1,E2};
%            names={'CHAMBER','ELEC1','ELEC2','CELL1','NUCLEUS1'};
        elseif tlm.conf.points==4
            model.geom('geom1').feature('R1').label('CHAMBER');
            model.geom('geom1').feature('R2').label('ELEC1');
            model.geom('geom1').feature('R3').label('ELEC2');
            model.geom('geom1').feature('R4').label('MESU1');
            model.geom('geom1').feature('R5').label('MESU2');
            model.geom('geom1').feature('E1').label('CELL1');
            model.geom('geom1').feature('E2').label('NUCLEUS1');
            model.geom('geom1').feature('fin').label('UNION');

 %           objs={R1,R2,R3,R4,R5,E1,E2};
 %           names={'CHAMBER','ELEC1','ELEC2','MESU1','MESU2','CELL1','NUCLEUS1'};
        end
    else
        if tlm.conf.points==1 || tlm.conf.points==2
            model.geom('geom1').feature('R1').label('CHAMBER');
            model.geom('geom1').feature('R2').label('ELEC1');
            model.geom('geom1').feature('R3').label('ELEC2');
            model.geom('geom1').feature('E1').label('CELL1');
            model.geom('geom1').feature('fin').label('UNION');

%            objs={R1,R2,R3,E1};
%            names={'CHAMBER','ELEC1','ELEC2','CELL1'};
        elseif tlm.conf.points==4
            model.geom('geom1').feature('R1').label('CHAMBER');
            model.geom('geom1').feature('R2').label('ELEC1');
            model.geom('geom1').feature('R3').label('ELEC2');
            model.geom('geom1').feature('R4').label('MESU1');
            model.geom('geom1').feature('R5').label('MESU2');
            model.geom('geom1').feature('E1').label('CELL1');
            model.geom('geom1').feature('fin').label('UNION');

%            objs={R1,R2,R3,R4,R5,E1};
%            names={'CHAMBER','ELEC1','ELEC2','MESU1','MESU2','CELL1'};
        end
    end
    
elseif (tlm.conf.Cell==1 && tlm.conf.Milo==2)
    
    if (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1)
        if tlm.conf.points==1 || tlm.conf.points==2
            model.geom('geom1').feature('R1').label('MEDIUM1');
            model.geom('geom1').feature('R2').label('ELEC1');
            model.geom('geom1').feature('R3').label('ELEC2');
            model.geom('geom1').feature('R6').label('MEDIUM2');
            model.geom('geom1').feature('E1').label('CELL1');
            model.geom('geom1').feature('E2').label('NUCLEUS1');
            model.geom('geom1').feature('E3').label('MITOCHONDRIA1');
            model.geom('geom1').feature('fin').label('UNION');

 %           objs={R1,R2,R3,R6,E1,E2,E3};
 %           names={'MEDIUM1','ELEC1','ELEC2','MEDIUM2','CELL1','NUCLEUS1','MITOCHONDRIA1'};
        elseif tlm.conf.points==4
            model.geom('geom1').feature('R1').label('MEDIUM1');
            model.geom('geom1').feature('R2').label('ELEC1');
            model.geom('geom1').feature('R3').label('ELEC2');
            model.geom('geom1').feature('R4').label('MESU1');
            model.geom('geom1').feature('R5').label('MESU2');
            model.geom('geom1').feature('R6').label('MEDIUM2');
            model.geom('geom1').feature('E1').label('CELL1');
            model.geom('geom1').feature('E2').label('NUCLEUS1');
            model.geom('geom1').feature('E3').label('MITOCHONDRIA1');
            model.geom('geom1').feature('fin').label('UNION');

%            objs={R1,R2,R3,R4,R5,R6,E1,E2,E3};
%            names={'MEDIUM1','ELEC1','ELEC2','MESU1','MESU2','MEDIUM2','CELL1','NUCLEUS1','MITOCHONDRIA1'};
        end
    elseif (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0)
        if tlm.conf.points==1 || tlm.conf.points==2
            model.geom('geom1').feature('R1').label('MEDIUM1');
            model.geom('geom1').feature('R2').label('ELEC1');
            model.geom('geom1').feature('R3').label('ELEC2');
            model.geom('geom1').feature('R6').label('MEDIUM2');
            model.geom('geom1').feature('E1').label('CELL1');
            model.geom('geom1').feature('E2').label('NUCLEUS1');
            model.geom('geom1').feature('fin').label('UNION');

 %           objs={R1,R2,R3,R6,E1,E2};
 %           names={'MEDIUM1','ELEC1','ELEC2','MEDIUM2','CELL1','NUCLEUS1'};
        elseif tlm.conf.points==4
            model.geom('geom1').feature('R1').label('MEDIUM1');
            model.geom('geom1').feature('R2').label('ELEC1');
            model.geom('geom1').feature('R3').label('ELEC2');
            model.geom('geom1').feature('R4').label('MESU1');
            model.geom('geom1').feature('R5').label('MESU2');
            model.geom('geom1').feature('R6').label('MEDIUM2');
            model.geom('geom1').feature('E1').label('CELL1');
            model.geom('geom1').feature('E2').label('NUCLEUS1');
            model.geom('geom1').feature('fin').label('UNION');

 %           objs={R1,R2,R3,R4,R5,R6,E1,E2};
 %           names={'MEDIUM1','ELEC1','ELEC2','MESU1','MESU2','MEDIUM2','CELL1','NUCLEUS1'};
        end
    else
        if tlm.conf.points==1 || tlm.conf.points==2
            model.geom('geom1').feature('R1').label('MEDIUM1');
            model.geom('geom1').feature('R2').label('ELEC1');
            model.geom('geom1').feature('R3').label('ELEC2');
            model.geom('geom1').feature('R6').label('MEDIUM2');
            model.geom('geom1').feature('E1').label('CELL1');
            model.geom('geom1').feature('fin').label('UNION');

%            objs={R1,R2,R3,R6,E1};
%            names={'MEDIUM1','ELEC1','ELEC2','MEDIUM2','CELL1'};
        elseif tlm.conf.points==4
            model.geom('geom1').feature('R1').label('MEDIUM1');
            model.geom('geom1').feature('R2').label('ELEC1');
            model.geom('geom1').feature('R3').label('ELEC2');
            model.geom('geom1').feature('R4').label('MESU1');
            model.geom('geom1').feature('R5').label('MESU2');
            model.geom('geom1').feature('R6').label('MEDIUM2');
            model.geom('geom1').feature('E1').label('CELL1');
            model.geom('geom1').feature('fin').label('UNION');

 %           objs={R1,R2,R3,R4,R5,R6,E1};
 %           names={'MEDIUM1','ELEC1','ELEC2','MESU1','MESU2','MEDIUM2','CELL1'};
        end
    end

elseif (tlm.conf.Cell==2 && tlm.conf.Milo==1)
    
    if (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1)
        if tlm.conf.points==1 || tlm.conf.points==2
            model.geom('geom1').feature('R1').label('MEDIUM1');
            model.geom('geom1').feature('R2').label('ELEC1');
            model.geom('geom1').feature('R3').label('ELEC2');
            model.geom('geom1').feature('E1').label('CELL1');
            model.geom('geom1').feature('E2').label('NUCLEUS1');
            model.geom('geom1').feature('E3').label('MITOCHONDRIA1');
            model.geom('geom1').feature('E4').label('CELL2');
            model.geom('geom1').feature('E5').label('NUCLEUS2');
            model.geom('geom1').feature('E6').label('MITOCHONDRIA2');
            model.geom('geom1').feature('fin').label('UNION');

%            objs={R1,R2,R3,E1,E2,E3,E4,E5,E6};
%            names={'CHAMBER','ELEC1','ELEC2','CELL1','NUCLEUS1','MITOCHONDRIA1','CELL2','NUCLEUS2','MITOCHONDRIA2'};
        elseif tlm.conf.points==4
            model.geom('geom1').feature('R1').label('CHAMBER');
            model.geom('geom1').feature('R2').label('ELEC1');
            model.geom('geom1').feature('R3').label('ELEC2');
            model.geom('geom1').feature('R4').label('MESU1');
            model.geom('geom1').feature('R5').label('MESU2');
            model.geom('geom1').feature('E1').label('CELL1');
            model.geom('geom1').feature('E2').label('NUCLEUS1');
            model.geom('geom1').feature('E3').label('MITOCHONDRIA1');
            model.geom('geom1').feature('E4').label('CELL2');
            model.geom('geom1').feature('E5').label('NUCLEUS2');
            model.geom('geom1').feature('E6').label('MITOCHONDRIA2');
            model.geom('geom1').feature('fin').label('UNION');
            
 %           objs={R1,R2,R3,R4,R5,E1,E2,E3,E4,E5,E6};
 %           names={'CHAMBER','ELEC1','ELEC2','MESU1','MESU2','CELL1','NUCLEUS1','MITOCHONDRIA1','CELL2','NUCLEUS2','MITOCHONDRIA2'};
        end
    elseif (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0)
        if tlm.conf.points==1 || tlm.conf.points==2
            model.geom('geom1').feature('R1').label('CHAMBER');
            model.geom('geom1').feature('R2').label('ELEC1');
            model.geom('geom1').feature('R3').label('ELEC2');
            model.geom('geom1').feature('E1').label('CELL1');
            model.geom('geom1').feature('E2').label('NUCLEUS1');
            model.geom('geom1').feature('E4').label('CELL2');
            model.geom('geom1').feature('E5').label('NUCLEUS2');
            model.geom('geom1').feature('fin').label('UNION');
            
 %           objs={R1,R2,R3,E1,E2,E4,E5};
 %           names={'CHAMBER','ELEC1','ELEC2','CELL1','NUCLEUS1','CELL2','NUCLEUS2'};
        elseif tlm.conf.points==4
            model.geom('geom1').feature('R1').label('CHAMBER');
            model.geom('geom1').feature('R2').label('ELEC1');
            model.geom('geom1').feature('R3').label('ELEC2');
            model.geom('geom1').feature('R4').label('MESU1');
            model.geom('geom1').feature('R5').label('MESU2');
            model.geom('geom1').feature('E1').label('CELL1');
            model.geom('geom1').feature('E2').label('NUCLEUS1');
            model.geom('geom1').feature('E4').label('CELL2');
            model.geom('geom1').feature('E5').label('NUCLEUS2');
            model.geom('geom1').feature('fin').label('UNION');
            
%            objs={R1,R2,R3,R4,R5,E1,E2,E4,E5};
%            names={'CHAMBER','ELEC1','ELEC2','MESU1','MESU2','CELL1','NUCLEUS1','CELL2','NUCLEUS2'};
        end
    else
        if tlm.conf.points==1 || tlm.conf.points==2
            model.geom('geom1').feature('R1').label('CHAMBER');
            model.geom('geom1').feature('R2').label('ELEC1');
            model.geom('geom1').feature('R3').label('ELEC2');
            model.geom('geom1').feature('E1').label('CELL1');
            model.geom('geom1').feature('E4').label('CELL2');
            model.geom('geom1').feature('fin').label('UNION');
            
%            objs={R1,R2,R3,E1,E4};
%            names={'CHAMBER','ELEC1','ELEC2','CELL1','CELL2'};
        elseif tlm.conf.points==4
            model.geom('geom1').feature('R1').label('CHAMBER');
            model.geom('geom1').feature('R2').label('ELEC1');
            model.geom('geom1').feature('R3').label('ELEC2');
            model.geom('geom1').feature('R4').label('MESU1');
            model.geom('geom1').feature('R5').label('MESU2');
            model.geom('geom1').feature('E1').label('CELL1');
            model.geom('geom1').feature('E4').label('CELL2');
            model.geom('geom1').feature('fin').label('UNION');
            
%            objs={R1,R2,R3,R4,R5,E1,E4};
%            names={'CHAMBER','ELEC1','ELEC2','MESU1','MESU2','CELL1','CELL2'};
        end
    end

elseif (tlm.conf.Cell==2 && tlm.conf.Milo==2)
    
    if (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1)
        if tlm.conf.points==1 || tlm.conf.points==2
            model.geom('geom1').feature('R1').label('MEDIUM1');
            model.geom('geom1').feature('R2').label('ELEC1');
            model.geom('geom1').feature('R3').label('ELEC2');
            model.geom('geom1').feature('R6').label('MEDIUM2');
            model.geom('geom1').feature('E1').label('CELL1');
            model.geom('geom1').feature('E2').label('NUCLEUS1');
            model.geom('geom1').feature('E3').label('MITOCHONDRIA1');
            model.geom('geom1').feature('E4').label('CELL2');
            model.geom('geom1').feature('E5').label('NUCLEUS2');
            model.geom('geom1').feature('E6').label('MITOCHONDRIA2');
            model.geom('geom1').feature('fin').label('UNION');
            
%            objs={R1,R2,R3,R6,E1,E2,E3,E4,E5,E6};
%            names={'MEDIUM1','ELEC1','ELEC2','MEDIUM2','CELL1','NUCLEUS1','MITOCHONDRIA1','CELL2','NUCLEUS2','MITOCHONDRIA2'};
        elseif tlm.conf.points==4
            model.geom('geom1').feature('R1').label('MEDIUM1');
            model.geom('geom1').feature('R2').label('ELEC1');
            model.geom('geom1').feature('R3').label('ELEC2');
            model.geom('geom1').feature('R4').label('MESU1');
            model.geom('geom1').feature('R5').label('MESU2');
            model.geom('geom1').feature('R6').label('MEDIUM2');
            model.geom('geom1').feature('E1').label('CELL1');
            model.geom('geom1').feature('E2').label('NUCLEUS1');
            model.geom('geom1').feature('E3').label('MITOCHONDRIA1');
            model.geom('geom1').feature('E4').label('CELL2');
            model.geom('geom1').feature('E5').label('NUCLEUS2');
            model.geom('geom1').feature('E6').label('MITOCHONDRIA2');
            model.geom('geom1').feature('fin').label('UNION');
            
 %           objs={R1,R2,R3,R4,R5,R6,E1,E2,E3,E4,E5,E6};
 %           names={'MEDIUM1','ELEC1','ELEC2','MESU1','MESU2','MEDIUM2','CELL1','NUCLEUS1','MITOCHONDRIA1','CELL2','NUCLEUS2','MITOCHONDRIA2'};
        end
    elseif (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0)
        if tlm.conf.points==1 || tlm.conf.points==2
            model.geom('geom1').feature('R1').label('MEDIUM1');
            model.geom('geom1').feature('R2').label('ELEC1');
            model.geom('geom1').feature('R3').label('ELEC2');
            model.geom('geom1').feature('R6').label('MEDIUM2');
            model.geom('geom1').feature('E1').label('CELL1');
            model.geom('geom1').feature('E2').label('NUCLEUS1');
            model.geom('geom1').feature('E4').label('CELL2');
            model.geom('geom1').feature('E5').label('NUCLEUS2');
            model.geom('geom1').feature('fin').label('UNION');

%            objs={R1,R2,R3,R6,E1,E2,E4,E5};
%            names={'MEDIUM1','ELEC1','ELEC2','MEDIUM2','CELL1','NUCLEUS1','CELL2','NUCLEUS2'};
        elseif tlm.conf.points==4
            model.geom('geom1').feature('R1').label('MEDIUM1');
            model.geom('geom1').feature('R2').label('ELEC1');
            model.geom('geom1').feature('R3').label('ELEC2');
            model.geom('geom1').feature('R4').label('MESU1');
            model.geom('geom1').feature('R5').label('MESU2');
            model.geom('geom1').feature('R6').label('MEDIUM2');
            model.geom('geom1').feature('E1').label('CELL1');
            model.geom('geom1').feature('E2').label('NUCLEUS1');
            model.geom('geom1').feature('E4').label('CELL2');
            model.geom('geom1').feature('E5').label('NUCLEUS2');
            model.geom('geom1').feature('fin').label('UNION');

%            objs={R1,R2,R3,R4,R5,R6,E1,E2,E4,E5};
%            names={'MEDIUM1','ELEC1','ELEC2','MESU1','MESU2','MEDIUM2','CELL1','NUCLEUS1','CELL2','NUCLEUS2'};
        end
    else
        if tlm.conf.points==1 || tlm.conf.points==2
            model.geom('geom1').feature('R1').label('MEDIUM1');
            model.geom('geom1').feature('R2').label('ELEC1');
            model.geom('geom1').feature('R3').label('ELEC2');
            model.geom('geom1').feature('R6').label('MEDIUM2');
            model.geom('geom1').feature('E1').label('CELL1');
            model.geom('geom1').feature('E4').label('CELL2');
            model.geom('geom1').feature('fin').label('UNION');

 %           objs={R1,R2,R3,R6,E1,E4};
 %           names={'MEDIUM1','ELEC1','ELEC2','MEDIUM2','CELL1','CELL2'};
        elseif tlm.conf.points==4
            model.geom('geom1').feature('R1').label('MEDIUM1');
            model.geom('geom1').feature('R2').label('ELEC1');
            model.geom('geom1').feature('R3').label('ELEC2');
            model.geom('geom1').feature('R4').label('MESU1');
            model.geom('geom1').feature('R5').label('MESU2');
            model.geom('geom1').feature('E1').label('CELL1');
            model.geom('geom1').feature('E4').label('CELL2');
            model.geom('geom1').feature('fin').label('UNION');

%            objs={R1,R2,R3,R4,R5,E1,E4};
%            names={'MEDIUM1','ELEC1','ELEC2','MESU1','MESU2','MEDIUM2','CELL1','CELL2'};
        end
    end

end

%s.objs=objs;
%s.name=names;

%Surfaces

objs={};
names={};

c.objs=objs;
c.name=names;

%Points - Points are imposed in the domains to constrain the mesh and be
%sure to have known coordinates when looking for domain to fill properties

%Point in the left outer electrode where there is the solicitation

%if tlm.conf.points==1 
%     if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
%        model.geom('geom1').create('PT1','Point');
%        model.geom('geom1').feature('PT1').set('p',[tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2]);
%        coordBox=[tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurChambre/2-1e-6 tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2-1e-6; ...
%                  tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurChambre/2+1e-6 tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2+1e-6];
%        n=mphselectbox(model,'geom1',coordBox,'domain')
%        model.geom('geom1').feature('PT1').getVertexDomain();

 %       PT1=point2(tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
 %       tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2);
    
%        model.geom('geom1').create('PT1A','Point');
%        model.geom('geom1').feature('PT1A').set('p',[tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+tlm.var.EpaisseurElectrode/8]);

 %       PT1A=point2(tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
 %       tlm.var.OrigineY+tlm.var.EpaisseurElectrode/8);
 
%        model.geom('geom1').create('PT1B','Point');
%        model.geom('geom1').feature('PT1B').set('p',[tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+2*tlm.var.EpaisseurElectrode/8]);

%        PT1B=point2(tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+2*tlm.var.EpaisseurElectrode/8);

%        model.geom('geom1').create('PT1C','Point');
%        model.geom('geom1').feature('PT1C').set('p',[tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+3*tlm.var.EpaisseurElectrode/8]);

%        PT1C=point2(tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+3*tlm.var.EpaisseurElectrode/8);
    
%        model.geom('geom1').create('PT1D','Point');
%        model.geom('geom1').feature('PT1D').set('p',[tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+5*tlm.var.EpaisseurElectrode/8]);

%        PT1D=point2(tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+5*tlm.var.EpaisseurElectrode/8);

%        model.geom('geom1').create('PT1E','Point');
%        model.geom('geom1').feature('PT1E').set('p',[tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+6*tlm.var.EpaisseurElectrode/8]);

%        PT1E=point2(tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+6*tlm.var.EpaisseurElectrode/8);

%        model.geom('geom1').create('PT1F','Point');
%        model.geom('geom1').feature('PT1F').set('p',[tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+7*tlm.var.EpaisseurElectrode/8]);

%        PT1F=point2(tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+7*tlm.var.EpaisseurElectrode/8);
%    else
%        model.geom('geom1').create('PT1','Point');
%        model.geom('geom1').feature('PT1').set('p',[tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2]);

 %       PT1=point2(tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
 %       tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2);
 %   end
 
%elseif tlm.conf.points==2
%    if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
%        model.geom('geom1').create('PT1','Point');
%        model.geom('geom1').feature('PT1').set('p',[tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2]);

%        PT1=point2(tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2);

%        model.geom('geom1').create('PT1A','Point');
%        model.geom('geom1').feature('PT1A').set('p',[tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+tlm.var.EpaisseurElectrode/8]);

%        PT1A=point2(tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+tlm.var.EpaisseurElectrode/8);
    
%        model.geom('geom1').create('PT1B','Point');
%        model.geom('geom1').feature('PT1B').set('p',[tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+2*tlm.var.EpaisseurElectrode/8]);

%        PT1B=point2(tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+2*tlm.var.EpaisseurElectrode/8);

%        model.geom('geom1').create('PT1C','Point');
%        model.geom('geom1').feature('PT1C').set('p',[tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+3*tlm.var.EpaisseurElectrode/8]);

 %       PT1C=point2(tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
 %       tlm.var.OrigineY+3*tlm.var.EpaisseurElectrode/8);
    
%        model.geom('geom1').create('PT1D','Point');
%        model.geom('geom1').feature('PT1D').set('p',[tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+5*tlm.var.EpaisseurElectrode/8]);

%        PT1D=point2(tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+5*tlm.var.EpaisseurElectrode/8);

%        model.geom('geom1').create('PT1E','Point');
%        model.geom('geom1').feature('PT1E').set('p',[tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+6*tlm.var.EpaisseurElectrode/8]);

%        PT1E=point2(tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+6*tlm.var.EpaisseurElectrode/8);

%        model.geom('geom1').create('PT1F','Point');
%        model.geom('geom1').feature('PT1F').set('p',[tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+7*tlm.var.EpaisseurElectrode/8]);

%        PT1F=point2(tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+7*tlm.var.EpaisseurElectrode/8);
%    else
%        model.geom('geom1').create('PT1','Point');
%        model.geom('geom1').feature('PT1').set('p',[tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2]);

 %       PT1=point2(tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
 %       tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2);
%    end
%elseif tlm.conf.points==4
    if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
        model.geom('geom1').create('PT1','Point');
        model.geom('geom1').feature('PT1').set('p',[tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2]);
%        coordBox=[tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurChambre/2-1e-6 tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2-1e-6; ...
%                  tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurChambre/2+1e-6 tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2+1e-6];
%        n=mphselectbox(model,'geom1',coordBox,'domain')
%        model.geom('geom1').feature('PT1').getVertexDomain();

 %       PT1=point2(tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
 %       tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2);
    
        model.geom('geom1').create('PT1A','Point');
        model.geom('geom1').feature('PT1A').set('p',[tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+tlm.var.EpaisseurElectrode/8]);

 %       PT1A=point2(tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
 %       tlm.var.OrigineY+tlm.var.EpaisseurElectrode/8);
 
        model.geom('geom1').create('PT1B','Point');
        model.geom('geom1').feature('PT1B').set('p',[tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+2*tlm.var.EpaisseurElectrode/8]);

%        PT1B=point2(tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+2*tlm.var.EpaisseurElectrode/8);

        model.geom('geom1').create('PT1C','Point');
        model.geom('geom1').feature('PT1C').set('p',[tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+3*tlm.var.EpaisseurElectrode/8]);

%        PT1C=point2(tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+3*tlm.var.EpaisseurElectrode/8);
    
        model.geom('geom1').create('PT1D','Point');
        model.geom('geom1').feature('PT1D').set('p',[tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+5*tlm.var.EpaisseurElectrode/8]);

%        PT1D=point2(tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+5*tlm.var.EpaisseurElectrode/8);

        model.geom('geom1').create('PT1E','Point');
        model.geom('geom1').feature('PT1E').set('p',[tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+6*tlm.var.EpaisseurElectrode/8]);

%        PT1E=point2(tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+6*tlm.var.EpaisseurElectrode/8);

        model.geom('geom1').create('PT1F','Point');
        model.geom('geom1').feature('PT1F').set('p',[tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+7*tlm.var.EpaisseurElectrode/8]);

%        PT1F=point2(tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+7*tlm.var.EpaisseurElectrode/8);
    else
        model.geom('geom1').create('PT1','Point');
        model.geom('geom1').feature('PT1').set('p',[tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2]);

 %       PT1=point2(tlm.var.OrigineX-tlm.var.EcartementElectrode/2-tlm.var.LargeurElectrode/2, ...
 %       tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2);
    end
%end

%Point in the left inner electrode called MESUR1

if tlm.conf.points==4
    model.geom('geom1').create('PT2','Point');
    model.geom('geom1').feature('PT2').set('p',[tlm.var.OrigineX-tlm.var.EcartementMesure/2-tlm.var.LargeurMesure/2, ...
    tlm.var.OrigineY+tlm.var.EpaisseurMesure/2]);

%    PT2=point2(tlm.var.OrigineX-tlm.var.EcartementMesure/2-tlm.var.LargeurMesure/2, ...
%    tlm.var.OrigineY+tlm.var.EpaisseurMesure/2);
end

%Point in the right inner electrode called MESUR2

if tlm.conf.points==4
    model.geom('geom1').create('PT3','Point');
    model.geom('geom1').feature('PT3').set('p',[tlm.var.OrigineX+tlm.var.EcartementMesure/2+tlm.var.LargeurMesure/2, ...
    tlm.var.OrigineY+tlm.var.EpaisseurMesure/2]);
    
%    PT3=point2(tlm.var.OrigineX+tlm.var.EcartementMesure/2+tlm.var.LargeurMesure/2, ...
%    tlm.var.OrigineY+tlm.var.EpaisseurMesure/2);
end

%Point in the right outer electrode where we set the ground

%if tlm.conf.points==1 % 2 points facing
%     if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
%        model.geom('geom1').create('PT4','Point');
%        model.geom('geom1').feature('PT4').set('p',[tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2]);

%        PT4=point2(tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2);

%        model.geom('geom1').create('PT4A','Point');
%        model.geom('geom1').feature('PT4A').set('p',[tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+tlm.var.EpaisseurChambre/8]);

%        PT4A=point2(tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+tlm.var.EpaisseurChambre/8);

%        model.geom('geom1').create('PT4B','Point');
%        model.geom('geom1').feature('PT4B').set('p',[tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+2*tlm.var.EpaisseurChambre/8]);

%        PT4B=point2(tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+2*tlm.var.EpaisseurChambre/8);

%        model.geom('geom1').create('PT4C','Point');
%        model.geom('geom1').feature('PT4C').set('p',[tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+3*tlm.var.EpaisseurChambre/8]);

%        PT4C=point2(tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+3*tlm.var.EpaisseurChambre/8);

%        model.geom('geom1').create('PT4D','Point');
%        model.geom('geom1').feature('PT4D').set('p',[tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+5*tlm.var.EpaisseurChambre/8]);

%        PT4D=point2(tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+5*tlm.var.EpaisseurChambre/8);

%        model.geom('geom1').create('PT4E','Point');
%        model.geom('geom1').feature('PT4E').set('p',[tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+6*tlm.var.EpaisseurChambre/8]);

%        PT4E=point2(tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+6*tlm.var.EpaisseurChambre/8);

%        model.geom('geom1').create('PT4F','Point');
%        model.geom('geom1').feature('PT4F').set('p',[tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+7*tlm.var.EpaisseurChambre/8]);

%        PT4F=point2(tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+7*tlm.var.EpaisseurChambre/8);
%    else
%        model.geom('geom1').create('PT4','Point');
%        model.geom('geom1').feature('PT4').set('p',[tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2]);
       
%        PT4=point2(tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2);
%    end
%elseif tlm.conf.points==2
%    if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
%        PT4=point2(tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2);
%        PT4A=point2(tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+tlm.var.EpaisseurChambre/8);
%        PT4B=point2(tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+2*tlm.var.EpaisseurChambre/8);
%        PT4C=point2(tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+3*tlm.var.EpaisseurChambre/8);
%        PT4D=point2(tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+5*tlm.var.EpaisseurChambre/8);
%        PT4E=point2(tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+6*tlm.var.EpaisseurChambre/8);
%        PT4F=point2(tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%       tlm.var.OrigineY+7*tlm.var.EpaisseurChambre/8);
%    else
%        PT4=point2(tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2);
%    end
%elseif tlm.conf.points==4
    if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
        model.geom('geom1').create('PT4','Point');
        model.geom('geom1').feature('PT4').set('p',[tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2]);

%        PT4=point2(tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2);

        model.geom('geom1').create('PT4A','Point');
        model.geom('geom1').feature('PT4A').set('p',[tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+tlm.var.EpaisseurChambre/8]);

%        PT4A=point2(tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+tlm.var.EpaisseurChambre/8);

        model.geom('geom1').create('PT4B','Point');
        model.geom('geom1').feature('PT4B').set('p',[tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+2*tlm.var.EpaisseurChambre/8]);

%        PT4B=point2(tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+2*tlm.var.EpaisseurChambre/8);

        model.geom('geom1').create('PT4C','Point');
        model.geom('geom1').feature('PT4C').set('p',[tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+3*tlm.var.EpaisseurChambre/8]);

%        PT4C=point2(tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+3*tlm.var.EpaisseurChambre/8);

        model.geom('geom1').create('PT4D','Point');
        model.geom('geom1').feature('PT4D').set('p',[tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+5*tlm.var.EpaisseurChambre/8]);

%        PT4D=point2(tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+5*tlm.var.EpaisseurChambre/8);

        model.geom('geom1').create('PT4E','Point');
        model.geom('geom1').feature('PT4E').set('p',[tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+6*tlm.var.EpaisseurChambre/8]);

%        PT4E=point2(tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+6*tlm.var.EpaisseurChambre/8);

        model.geom('geom1').create('PT4F','Point');
        model.geom('geom1').feature('PT4F').set('p',[tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+7*tlm.var.EpaisseurChambre/8]);

%        PT4F=point2(tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+7*tlm.var.EpaisseurChambre/8);
    else
        model.geom('geom1').create('PT4','Point');
        model.geom('geom1').feature('PT4').set('p',[tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
        tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2]);
       
%        PT4=point2(tlm.var.OrigineX+tlm.var.EcartementElectrode/2+tlm.var.LargeurElectrode/2, ...
%        tlm.var.OrigineY+tlm.var.EpaisseurElectrode/2);
    end
%end

%Point that should be in the FIRST external organic medium (Please check your configuration!)

if (tlm.conf.Cell==1 || tlm.conf.Cell==2)
    if tlm.conf.points~=1
        model.geom('geom1').create('PT5','Point');
        model.geom('geom1').feature('PT5').set('p',[tlm.var.OrigineX-tlm.var.Center, ...
        tlm.var.OrigineY+tlm.var.EpaisseurChambre-tlm.var.Epsilon]);

%        PT5=point2(tlm.var.OrigineX-tlm.var.Center, tlm.var.OrigineY+tlm.var.EpaisseurChambre-tlm.var.Epsilon);
    else
        model.geom('geom1').create('PT5','Point');
        model.geom('geom1').feature('PT5').set('p',[tlm.var.OrigineX-tlm.var.Center, ...
        tlm.var.OrigineY+tlm.var.DecentrageZCellule(1)+tlm.var.RayonZCellule(1)+tlm.var.Epsilon]);

%        PT5=point2(tlm.var.OrigineX-tlm.var.Center, tlm.var.OrigineY+tlm.var.DecentrageZCellule(1)+tlm.var.RayonZCellule(1)+tlm.var.Epsilon);
    end
else
    model.geom('geom1').create('PT5','Point');
    model.geom('geom1').feature('PT5').set('p',[tlm.var.OrigineX-tlm.var.Center, ...
    tlm.var.OrigineY+tlm.var.EpaisseurChambre/2]);
    
%    PT5=point2(tlm.var.OrigineX-tlm.var.Center, tlm.var.OrigineY+tlm.var.EpaisseurChambre/2);
end

%Point that should be in the SECOND external organic medium (above the left outer electrode - Please check your configuration!)

if tlm.conf.Milo==2
    if (tlm.conf.Cell==1 || tlm.conf.Cell==2)
        if tlm.conf.points~=1
            PT12=point2(tlm.var.OrigineX+tlm.var.Center,tlm.var.OrigineY+tlm.var.EpaisseurChambre-tlm.var.Epsilon);
        else
            PT12=point2(tlm.var.OrigineX+tlm.var.Center,tlm.var.OrigineY+tlm.var.DecentrageZCellule(2)+tlm.var.RayonZCellule(2)+tlm.var.Epsilon);
        end
    else
        PT12=point2(tlm.var.OrigineX+tlm.var.Center,tlm.var.OrigineY+tlm.var.EpaisseurChambre/2);
    end
end

if tlm.conf.Cell==1

%Point that should be in the Cytoplasm of the first cell (please check your configuration)

    model.geom('geom1').create('PT6','Point');
    model.geom('geom1').feature('PT6').set('p',[tlm.var.OrigineX+tlm.var.DecentrageXCellule(1), ...
    tlm.var.OrigineY+tlm.var.DecentrageZCellule(1)]);

%    PT6=point2(tlm.var.OrigineX+tlm.var.DecentrageXCellule(1), ...
%               tlm.var.OrigineY+tlm.var.DecentrageZCellule(1));
%    PT6=rotate(PT6,tlm.var.Orientation.Cellule(1),[0,tlm.var.DecentrageZCellule(1)]); a ajouter 11/01/2019

%Point in the Nucleus of the first cell

    if tlm.conf.Nucleus==1
        model.geom('geom1').create('PT7','Point');
        model.geom('geom1').feature('PT7').set('p',[tlm.var.OrigineX+tlm.var.DecentrageXCellule(1)+tlm.var.DecentrageXNoyau(1), ...
        tlm.var.OrigineY+tlm.var.DecentrageZCellule(1)+tlm.var.DecentrageZNoyau(1)]);
    
%        PT7=point2(tlm.var.OrigineX+tlm.var.DecentrageXCellule(1)+tlm.var.DecentrageXNoyau(1), ...
%                   tlm.var.OrigineY+tlm.var.DecentrageZCellule(1)+tlm.var.DecentrageZNoyau(1));
% a rajouter        PT7=rotate(PT7,tlm.var.Orientation.Cellule(1),[0,tlm.var.DecentrageZCellule(1)]);
    end

%Point in the Mitochondria of the first cell

    if tlm.conf.Mitocho==1
        model.geom('geom1').create('PT8','Point');
        model.geom('geom1').feature('PT8').set('p',[tlm.var.OrigineX+tlm.var.DecentrageXCellule(1)+tlm.var.DecentrageXMitoc(1), ...
        tlm.var.OrigineY+tlm.var.DecentrageZCellule(1)+tlm.var.DecentrageZMitoc(1)]);

%        PT8=point2(tlm.var.OrigineX+tlm.var.DecentrageXCellule(1)+tlm.var.DecentrageXMitoc(1), ...
%        tlm.var.OrigineY+tlm.var.DecentrageZCellule(1)+tlm.var.DecentrageZMitoc(1));
% a rajouter        PT8=rotate(PT8,tlm.var.Orientation.Cellule(1),[0,tlm.var.DecentrageZCellule(1)]);
    end
    
elseif (tlm.conf.Cell==2)

%Point that should be in the Cytoplasm of the first cell (please check your configuration)

    PT6=point2(tlm.var.OrigineX+tlm.var.DecentrageXCellule(1), ...
               tlm.var.OrigineY+tlm.var.DecentrageZCellule(1));
    PT6=rotate(PT6,tlm.var.Orientation.Cellule(1),[0,tlm.var.DecentrageZCellule(1)]);

%Point in the Nucleus of the first cell

    if tlm.conf.Nucleus==1
        PT7=point2(tlm.var.OrigineX+tlm.var.DecentrageXCellule(1)+tlm.var.DecentrageXNoyau(1), ...
                tlm.var.OrigineY+tlm.var.DecentrageZCellule(1)+tlm.var.DecentrageZNoyau(1));
        PT7=rotate(PT7,tlm.var.Orientation.Cellule(1),[0,tlm.var.DecentrageZCellule(1)]);
    end

%Point in the Mitochondria of the first cell

    if tlm.conf.Mitocho==1
        PT8=point2(tlm.var.OrigineX+tlm.var.DecentrageXCellule(1)+tlm.var.DecentrageXMitoc(1), ...
        tlm.var.OrigineY+tlm.var.DecentrageZCellule(1)+tlm.var.DecentrageZMitoc(1));
        PT8=rotate(PT8,tlm.var.Orientation.Cellule(1),[0,tlm.var.DecentrageZCellule(1)]);
    end

    %Point that should be in the Cytoplasm of the second cell (please check your configuration)

    PT9=point2(tlm.var.OrigineX+tlm.var.DecentrageXCellule(2), ...
               tlm.var.OrigineY+tlm.var.DecentrageZCellule(2));
    PT9=rotate(PT9,tlm.var.Orientation.Cellule(2),[0,tlm.var.DecentrageZCellule(2)]);

%Point in the Nucleus of the second cell

    if tlm.conf.Nucleus==1
        PT10=point2(tlm.var.OrigineX+tlm.var.DecentrageXCellule(2)+tlm.var.DecentrageXNoyau(2), ...
                tlm.var.OrigineY+tlm.var.DecentrageZCellule(2)+tlm.var.DecentrageZNoyau(2));
        PT10=rotate(PT10,tlm.var.Orientation.Cellule(2),[0,tlm.var.DecentrageZCellule(2)]);
    end

%Point in the Mitochondria of the second cell

    if tlm.conf.Mitocho==1
        PT11=point2(tlm.var.OrigineX+tlm.var.DecentrageXCellule(2)+tlm.var.DecentrageXMitoc(2), ...
        tlm.var.OrigineY+tlm.var.DecentrageZCellule(2)+tlm.var.DecentrageZMitoc(2));
        PT11=rotate(PT11,tlm.var.Orientation.Cellule(2),[0,tlm.var.DecentrageZCellule(2)]);
    end
    
end

if (tlm.conf.Cell==0 && tlm.conf.Milo==1)
    
    if tlm.conf.points==1
        model.geom('geom1').feature('PT1').label('PT1');
        model.geom('geom1').feature('PT1A').label('PT1A');
        model.geom('geom1').feature('PT1B').label('PT1B');
        model.geom('geom1').feature('PT1C').label('PT1C');
        model.geom('geom1').feature('PT1D').label('PT1D');
        model.geom('geom1').feature('PT1E').label('PT1E');
        model.geom('geom1').feature('PT1F').label('PT1F');
        model.geom('geom1').feature('PT4').label('PT4');
        model.geom('geom1').feature('PT4A').label('PT4A');
        model.geom('geom1').feature('PT4B').label('PT4B');
        model.geom('geom1').feature('PT4C').label('PT4C');
        model.geom('geom1').feature('PT4D').label('PT4D');
        model.geom('geom1').feature('PT4E').label('PT4E');
        model.geom('geom1').feature('PT4F').label('PT4F');
        model.geom('geom1').feature('PT5').label('PT5');

%        objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5};
%        names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5'};
    elseif tlm.conf.points==2
        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
            model.geom('geom1').feature('PT1').label('PT1');
            model.geom('geom1').feature('PT1A').label('PT1A');
            model.geom('geom1').feature('PT1B').label('PT1B');
            model.geom('geom1').feature('PT1C').label('PT1C');
            model.geom('geom1').feature('PT1D').label('PT1D');
            model.geom('geom1').feature('PT1E').label('PT1E');
            model.geom('geom1').feature('PT1F').label('PT1F');
            model.geom('geom1').feature('PT4').label('PT4');
            model.geom('geom1').feature('PT4A').label('PT4A');
            model.geom('geom1').feature('PT4B').label('PT4B');
            model.geom('geom1').feature('PT4C').label('PT4C');
            model.geom('geom1').feature('PT4D').label('PT4D');
            model.geom('geom1').feature('PT4E').label('PT4E');
            model.geom('geom1').feature('PT4F').label('PT4F');
            model.geom('geom1').feature('PT5').label('PT5');

%            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5};
%            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5'};
        else
            model.geom('geom1').feature('PT1').label('PT1');
            model.geom('geom1').feature('PT4').label('PT4');
            model.geom('geom1').feature('PT5').label('PT5');

 %           objs={PT1,PT4,PT5};
 %           names={'PT1','PT4','PT5'};
        end
    elseif tlm.conf.points==4
        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
            model.geom('geom1').feature('PT1').label('PT1');
            model.geom('geom1').feature('PT1A').label('PT1A');
            model.geom('geom1').feature('PT1B').label('PT1B');
            model.geom('geom1').feature('PT1C').label('PT1C');
            model.geom('geom1').feature('PT1D').label('PT1D');
            model.geom('geom1').feature('PT1E').label('PT1E');
            model.geom('geom1').feature('PT1F').label('PT1F');
            model.geom('geom1').feature('PT2').label('PT2');
            model.geom('geom1').feature('PT3').label('PT3');
            model.geom('geom1').feature('PT4').label('PT4');
            model.geom('geom1').feature('PT4A').label('PT4A');
            model.geom('geom1').feature('PT4B').label('PT4B');
            model.geom('geom1').feature('PT4C').label('PT4C');
            model.geom('geom1').feature('PT4D').label('PT4D');
            model.geom('geom1').feature('PT4E').label('PT4E');
            model.geom('geom1').feature('PT4F').label('PT4F');
            model.geom('geom1').feature('PT5').label('PT5');            
            
 %           objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT2,PT3,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5};
 %           names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT2','PT3','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5'};
        else
            model.geom('geom1').feature('PT1').label('PT1');
            model.geom('geom1').feature('PT2').label('PT2');
            model.geom('geom1').feature('PT3').label('PT3');
            model.geom('geom1').feature('PT4').label('PT4');
            model.geom('geom1').feature('PT5').label('PT5');
            
%            objs={PT1,PT2,PT3,PT4,PT5};
%            names={'PT1','PT2','PT3','PT4','PT5'};
        end
    end
    
elseif (tlm.conf.Cell==0 && tlm.conf.Milo==2)
    
    if tlm.conf.points==1 % This case is not possible (triple points)
    elseif tlm.conf.points==2
        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT12};
            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT12'};
        else
            objs={PT1,PT4,PT5,PT12};
            names={'PT1','PT4','PT5','PT12'};
        end
    elseif tlm.conf.points==4
        if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT2,PT3,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT12};
            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT2','PT3','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT12'};
        else
            objs={PT1,PT2,PT3,PT4,PT5,PT12};
            names={'PT1','PT2','PT3','PT4','PT5','PT12'};
        end
    end
    
elseif (tlm.conf.Cell==1 && tlm.conf.Milo==1)
    
    if (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1)
        if tlm.conf.points==1
            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT8};
            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F''PT6','PT7','PT8'};    
        elseif tlm.conf.points==2
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT8};
                names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT6','PT7','PT8'};
            else
                objs={PT1,PT4,PT5,PT6,PT7,PT8};
                names={'PT1','PT2','PT3','PT6','PT7','PT8'};
            end
        elseif tlm.conf.points==4
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
 %               objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT2,PT3,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT8};
 %               names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT2','PT3','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT6','PT7','PT8'};
            else
                objs={PT1,PT2,PT3,PT4,PT5,PT6,PT7,PT8};
                names={'PT1','PT2','PT3','PT4','PT5','PT6','PT7','PT8'};
            end
        end
    elseif (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0)
        if tlm.conf.points==1
            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7};
            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F''PT6','PT7'};    
        elseif tlm.conf.points==2
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7};
                names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT6','PT7'};
            else
                objs={PT1,PT4,PT5,PT6,PT7};
                names={'PT1','PT2','PT3','PT6','PT7'};
            end
        elseif tlm.conf.points==4
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
%                objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT2,PT3,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7};
%                names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT2','PT3','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT6','PT7'};
            else
                objs={PT1,PT2,PT3,PT4,PT5,PT6,PT7};
                names={'PT1','PT2','PT3','PT4','PT5','PT6','PT7'};
            end
        end
    else
        if tlm.conf.points==1
            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6};
            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F''PT6'};    
        elseif tlm.conf.points==2
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6};
                names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT6'};
            else
                objs={PT1,PT4,PT5,PT6};
                names={'PT1','PT2','PT3','PT6'};
            end
        elseif tlm.conf.points==4
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
 %               objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT2,PT3,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6};
 %               names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT2','PT3','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT6'};
            else
                objs={PT1,PT2,PT3,PT4,PT5,PT6};
                names={'PT1','PT2','PT3','PT4','PT5','PT6'};
            end
        end
    end
    
elseif (tlm.conf.Cell==1 && tlm.conf.Milo==2)
    
    if (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1)
        if tlm.conf.points==1
            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT8,PT12};
            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F''PT6','PT7','PT8','PT12'};    
        elseif tlm.conf.points==2
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT8,PT12};
                names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT6','PT7','PT8','PT12'};
            else
                objs={PT1,PT4,PT5,PT6,PT7,PT8,PT12};
                names={'PT1','PT2','PT3','PT6','PT7','PT8','PT12'};
            end
        elseif tlm.conf.points==4
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT2,PT3,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT8,PT12};
                names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT2','PT3','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT6','PT7','PT8','PT12'};
            else
                objs={PT1,PT2,PT3,PT4,PT5,PT6,PT7,PT8,PT12};
                names={'PT1','PT2','PT3','PT4','PT5','PT6','PT7','PT8','PT12'};
            end
        end
    elseif (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0)
        if tlm.conf.points==1
            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT12};
            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F''PT6','PT7','PT12'};    
        elseif tlm.conf.points==2
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT12};
                names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT6','PT7','PT12'};
            else
                objs={PT1,PT4,PT5,PT6,PT7,PT12};
                names={'PT1','PT2','PT3','PT6','PT7','PT12'};
            end
        elseif tlm.conf.points==4
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT2,PT3,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT12};
                names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT2','PT3','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT6','PT7','PT12'};
            else
                objs={PT1,PT2,PT3,PT4,PT5,PT6,PT7,PT12};
                names={'PT1','PT2','PT3','PT4','PT5','PT6','PT7','PT12'};
            end
        end
    else
        if tlm.conf.points==1
            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT12};
            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F''PT6','PT12'};    
        elseif tlm.conf.points==2
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT12};
                names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT6','PT12'};
            else
                objs={PT1,PT4,PT5,PT6,PT12};
                names={'PT1','PT2','PT3','PT6','PT12'};
            end
        elseif tlm.conf.points==4
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT2,PT3,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT12};
                names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT2','PT3','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT6','PT12'};
            else
                objs={PT1,PT2,PT3,PT4,PT5,PT6,PT12};
                names={'PT1','PT2','PT3','PT4','PT5','PT6','PT12'};
            end
        end
    end
    
elseif (tlm.conf.Cell==2 && tlm.conf.Milo==1)
    
    if (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1)
        if tlm.conf.points==1
            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT8,PT9,PT10,PT11};
            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT6','PT7','PT8','PT9','PT10','PT11'};    
        elseif tlm.conf.points==2
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT8,PT9,PT10,PT11};
                names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT6','PT7','PT8','PT9','PT10','PT11'};
            else
                objs={PT1,PT4,PT5,PT6,PT7,PT8,PT9,PT10,PT11};
                names={'PT1','PT2','PT3','PT6','PT7','PT8','PT9','PT10','PT11'};
            end
        elseif tlm.conf.points==4
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT2,PT3,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT8,PT9,PT10,PT11};
                names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT2','PT3','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT6','PT7','PT8','PT9','PT10','PT11'};
            else
                objs={PT1,PT2,PT3,PT4,PT5,PT6,PT7,PT8,PT9,PT10,PT11};
                names={'PT1','PT2','PT3','PT4','PT5','PT6','PT7','PT8','PT9','PT10','PT11'};
            end
        end
    elseif (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0)
        if tlm.conf.points==1
            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT9,PT10};
            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F''PT6','PT7','PT9','PT10'};    
        elseif tlm.conf.points==2
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT9,PT10};
                names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT6','PT7','PT9','PT10'};
            else
                objs={PT1,PT4,PT5,PT6,PT7,PT9,PT10};
                names={'PT1','PT2','PT3','PT6','PT7','PT9','PT10'};
            end
        elseif tlm.conf.points==4
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT2,PT3,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT9,PT10};
                names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT2','PT3','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT6','PT7','PT9','PT10'};
            else
                objs={PT1,PT2,PT3,PT4,PT5,PT6,PT7,PT9,PT10};
                names={'PT1','PT2','PT3','PT4','PT5','PT6','PT7','PT9','PT10'};
            end
        end
    else
        if tlm.conf.points==1
            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT9};
            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F''PT6','PT9'};    
        elseif tlm.conf.points==2
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT9};
                names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT6','PT9'};
            else
                objs={PT1,PT4,PT5,PT6,PT9};
                names={'PT1','PT2','PT3','PT6','PT9'};
            end
        elseif tlm.conf.points==4
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT2,PT3,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT9};
                names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT2','PT3','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT6','PT9'};
            else
                objs={PT1,PT2,PT3,PT4,PT5,PT6,PT9};
                names={'PT1','PT2','PT3','PT4','PT5','PT6','PT9'};
            end
        end
    end
    
elseif (tlm.conf.Cell==2 && tlm.conf.Milo==2)
    
    if (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==1)
        if tlm.conf.points==1
            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT8,PT9,PT10,PT11,PT12};
            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT6','PT7','PT8','PT9','PT10','PT11','PT12'};    
        elseif tlm.conf.points==2
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT8,PT9,PT10,PT11,PT12};
                names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT6','PT7','PT8','PT9','PT10','PT11','PT12'};
            else
                objs={PT1,PT4,PT5,PT6,PT7,PT8,PT9,PT10,PT11,PT12};
                names={'PT1','PT2','PT3','PT6','PT7','PT8','PT9','PT10','PT11','PT12'};
            end
        elseif tlm.conf.points==4
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT2,PT3,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT8,PT9,PT10,PT11,PT12};
                names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT2','PT3','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT6','PT7','PT8','PT9','PT10','PT11','PT12'};
            else
                objs={PT1,PT2,PT3,PT4,PT5,PT6,PT7,PT8,PT9,PT10,PT11,PT12};
                names={'PT1','PT2','PT3','PT4','PT5','PT6','PT7','PT8','PT9','PT10','PT11','PT12'};
            end
        end
    elseif (tlm.conf.Nucleus==1 && tlm.conf.Mitocho==0)
        if tlm.conf.points==1
            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT9,PT10,PT12};
            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F''PT6','PT7','PT9','PT10','PT12'};    
        elseif tlm.conf.points==2
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT9,PT10,PT12};
                names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT6','PT7','PT9','PT10','PT12'};
            else
                objs={PT1,PT4,PT5,PT6,PT7,PT9,PT10,PT12};
                names={'PT1','PT2','PT3','PT6','PT7','PT9','PT10','PT12'};
            end
        elseif tlm.conf.points==4
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT2,PT3,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT7,PT9,PT10,PT12};
                names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT2','PT3','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT6','PT7','PT9','PT10','PT12'};
            else
                objs={PT1,PT2,PT3,PT4,PT5,PT6,PT7,PT9,PT10,PT12};
                names={'PT1','PT2','PT3','PT4','PT5','PT6','PT7','PT9','PT10','PT12'};
            end
        end
    else
        if tlm.conf.points==1
            objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT9,PT12};
            names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F''PT6','PT9','PT12'};    
        elseif tlm.conf.points==2
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT9,PT12};
                names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT6','PT9','PT12'};
            else
                objs={PT1,PT4,PT5,PT6,PT9,PT12};
                names={'PT1','PT2','PT3','PT6','PT9','PT12'};
            end
        elseif tlm.conf.points==4
            if abs(tlm.var.EpaisseurChambre-tlm.var.EpaisseurElectrode)<1e-10
                objs={PT1,PT1A,PT1B,PT1C,PT1D,PT1E,PT1F,PT2,PT3,PT4,PT4A,PT4B,PT4C,PT4D,PT4E,PT4F,PT5,PT6,PT9,PT12};
                names={'PT1','PT1A','PT1B','PT1C','PT1D','PT1E','PT1F','PT2','PT3','PT4','PT4A','PT4B','PT4C','PT4D','PT4E','PT4F','PT5','PT6','PT9','PT12'};
            else
                objs={PT1,PT2,PT3,PT4,PT5,PT6,PT9,PT12};
                names={'PT1','PT2','PT3','PT4','PT5','PT6','PT9','PT12'};
            end
        end
    end

end

p.objs=objs;
p.name=names;

%drawstruct=struct('s',s,'c',c,'p',p);
%fem.draw=drawstruct;
%fem.geom=geomcsg(fem);

%Properties of each domains

%fem.const={'sig_Electrode',num2str(tlm.var.sig.electrode),'sig_Milorga',num2str(tlm.var.sig.MilOrga),'sig_Milorgb',num2str(tlm.var.sig.MilOrgb),'sig_Cytoplasme1',num2str(tlm.var.sig.Cytoplasme(1)), ...
%           'sig_Nucleus1',num2str(tlm.var.sig.Nucleus(1)),'sig_Mitocho1',num2str(tlm.var.sig.Mitocho(1)),'sig_Cytoplasme2',num2str(tlm.var.sig.Cytoplasme(2)), ...
%           'sig_Nucleus2',num2str(tlm.var.sig.Nucleus(2)),'sig_Mitocho2',num2str(tlm.var.sig.Mitocho(2)),'eps_Electrode',num2str(tlm.var.eps.electrode/tlm.var.eps0), ...
%           'eps_Milorga',num2str(tlm.var.eps.MilOrga/tlm.var.eps0),'eps_Milorgb',num2str(tlm.var.eps.MilOrgb/tlm.var.eps0),'eps_Cytoplasme1',num2str(tlm.var.eps.Cytoplasme(1)/tlm.var.eps0), ...
%           'eps_Nucleus1',num2str(tlm.var.eps.Nucleus(1)/tlm.var.eps0),'eps_Mitocho1',num2str(tlm.var.eps.Mitocho(1)/tlm.var.eps0), ...
%           'eps_Cytoplasme2',num2str(tlm.var.eps.Cytoplasme(2)/tlm.var.eps0),'eps_Nucleus2',num2str(tlm.var.eps.Nucleus(2)/tlm.var.eps0), ...
%           'eps_Mitocho2',num2str(tlm.var.eps.Mitocho(2)/tlm.var.eps0)};

%model.material('mat1').propertyGroup('def').set('electricconductivity', {'0.1' '0' '0' '0' '0.1' '0' '0' '0' '0.1'});

model.material.create('mat1', 'Common', 'comp1');
model.material('mat1').propertyGroup('def').set('electricconductivity', tlm.var.sig.MilOrga);
model.material('mat1').propertyGroup('def').set('relpermittivity', tlm.var.eps.MilOrga/tlm.var.eps0);
model.material('mat1').label('MilOrga');
model.material('mat1').selection.set([2]);

model.material.create('mat2', 'Common', 'comp1');
model.material('mat2').propertyGroup('def').set('electricconductivity', tlm.var.sig.electrode);
model.material('mat2').propertyGroup('def').set('relpermittivity', tlm.var.eps.electrode/tlm.var.eps0);
model.material('mat2').label('electrode');

if (tlm.conf.points==1 || tlm.conf.points==2)
    model.material('mat2').selection.set([1 3]);
elseif tlm.conf.points==4
    model.material('mat2').selection.set([1 3 4 5]);
end

if tlm.conf.Milo==2
    model.material.create('mat3', 'Common', 'comp1');
    model.material('mat3').propertyGroup('def').set('electricconductivity', {'num2str(tlm.var.sig.MilOrgb)'});
    model.material('mat3').propertyGroup('def').set('relpermittivity', {'num2str(tlm.var.eps.MilOrgb/tlm.var.eps0)'});
    model.material('mat3').label('MilOrgb');
    model.material('mat3').selection.set([6]);
end

if tlm.conf.Cell==1
    model.material.create('mat4', 'Common', 'comp1');
    model.material('mat4').propertyGroup('def').set('electricconductivity', {'num2str(tlm.var.sig.Nucleus(1))'});
    model.material('mat4').propertyGroup('def').set('relpermittivity', {'num2str(tlm.var.eps.Nucleus(1)/tlm.var.eps0)'});
    model.material('mat4').label('Nucleus1');
%    model.material('mat4').selection.set([7]);

    model.material.create('mat5', 'Common', 'comp1');
    model.material('mat5').propertyGroup('def').set('electricconductivity', {'num2str(tlm.var.sig.Mitocho(1))'});
    model.material('mat5').propertyGroup('def').set('relpermittivity', {'num2str(tlm.var.eps.Mitocho(1)/tlm.var.eps0)'});
    model.material('mat5').label('Mitocho1');
%    model.material('mat5').selection.set([8]);

    model.material.create('mat6', 'Common', 'comp1');
    model.material('mat6').propertyGroup('def').set('electricconductivity', {'num2str(tlm.var.sig.Cytoplasme(1))'});
    model.material('mat6').propertyGroup('def').set('relpermittivity', {'num2str(tlm.var.eps.Cytoplasme(1)/tlm.var.eps0)'});
    model.material('mat6').label('Cytoplasme1');
%    model.material('mat6').selection.set([9]);
elseif tlm.conf.Cell==2
    model.material.create('mat7', 'Common', 'comp1');
    model.material('mat7').propertyGroup('def').set('electricconductivity', {'num2str(tlm.var.sig.Nucleus(2))'});
    model.material('mat7').propertyGroup('def').set('relpermittivity', {'num2str(tlm.var.eps.Nucleus(2)/tlm.var.eps0)'});
    model.material('mat7').label('Nucleus2');
    model.material('mat7').selection.set([10]);

    model.material.create('mat8', 'Common', 'comp1');
    model.material('mat8').propertyGroup('def').set('electricconductivity', {'num2str(tlm.var.sig.Mitocho(2))'});
    model.material('mat8').propertyGroup('def').set('relpermittivity', {'num2str(tlm.var.eps.Mitocho(2)/tlm.var.eps0)'});
    model.material('mat8').label('Mitocho2');
    model.material('mat8').selection.set([11]);

    model.material.create('mat9', 'Common', 'comp1');
    model.material('mat9').propertyGroup('def').set('electricconductivity', {'num2str(tlm.var.sig.Cytoplasme(2))'});
    model.material('mat9').propertyGroup('def').set('relpermittivity', {'num2str(tlm.var.eps.Cytoplasme(2)/tlm.var.eps0)'});
    model.material('mat9').label('Cytoplasme2');
    model.material('mat9').selection.set([12]);
end

model.view('view1').axis.set('ymin', 'OrigineY-1');
model.view('view1').axis.set('abstractviewlratio', '-0.23119696974754333');
model.view('view1').axis.set('abstractviewyscale', '0.0011652541579678655');
model.view('view1').axis.set('abstractviewrratio', '0.23119688034057617');
model.view('view1').axis.set('ymax', 'OrigineY+EpaisseurChambre+1');
model.view('view1').axis.set('xmin', '8.020391464233398');
model.view('view1').axis.set('abstractviewtratio', '0.04999995231628418');
model.view('view1').axis.set('abstractviewbratio', '-0.04999998211860657');
model.view('view1').axis.set('xmax', '21.9796085357666');
model.view('view1').axis.set('abstractviewxscale', '0.0011652540415525436');

%Plot the geometry
if (tlm.conf.fig==0)
    figure(1);
    tlm.conf.fig=tlm.conf.fig+1;
    clf('reset');
    colormap(hot(256));

    %geomplot(fem,'Sublabels','off', 'Edgelabels','off','pointlabels','off','Pointmode','on'), axis equal
    %geomplot(fem,'Sublabels','off', 'Edgelabels','on','pointlabels','off','Pointmode','off');
     
    mphgeom(model);
    mphgeom(model,'geom1','domainlabels','off','vertexmode','on','edgelabels','on');
          
% Create axes
%axes1 = axes('Parent',2,...
%    'PlotBoxAspectRatio',[5.49999986105831 1 100000],...
%    'OuterPosition',[-8.32667268468867e-17 0.503434920775036 1 0.468773447499669],...
%    'DataAspectRatio',[1 1 1]);
%% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[-5.49999986105831e-05 5.49999986105831e-05]);
%% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[-5e-06 1.5e-05]);
%box(axes1,'on');

% Create xlabel
xlabel({'X-Coordinate (microns)'});

% Create ylabel
ylabel({'Y-Coordinate (microns)'});

% Create title
title({'Device Geometry'});

% Create patch
%patch('Parent',axes1,'VertexNormals',VertexNormals1,'YData',YData1,...
%    'XData',XData1,...
%    'Vertices',Vertices1,...
%    'Faces',Faces1,...
%    'FaceColor','interp',...
%    'EdgeColor','none',...
%    'FaceVertexCData',FaceVertexCData1,...
%    'CData',CData1);

% Create patch
%patch('Parent',axes1,'VertexNormals',VertexNormals2,'YData',YData2,...
%    'XData',XData2,...
%    'Vertices',Vertices1,...
%    'Faces',Faces2,...
%    'FaceColor','none');

% Create axes
%axes2 = axes('Parent',figure1,'OuterPosition',[0 0 1 0.5]);
%box(axes2,'on');

% Create textbox
%annotation(figure1,'textbox',...
%    [0.26328125 0.484923657768001 0.04453125 0.0771349862258953],...
%    'String',{'essai'});

% Create arrow
%annotation(figure1,'arrow',[0.16640625 0.2390625],...
%    [0.673931129476584 0.465564738292011]);
    if tlm.conf.save==1
        saveas(1,'Geometry.emf');
    end
elseif (tlm.conf.fig==1)
    figure(1);
    clf('reset');
    %geomplot(fem,'Sublabels','off', 'Edgelabels','off','pointlabels','off','Pointmode','on'), axis equal
    geomplot(fem,'Sublabels','off', 'Edgelabels','on','pointlabels','off','Pointmode','off');
    if tlm.conf.save==1
        saveas(1,'Geometry.emf');
    end
end

% Initialize mesh

if tlm.conf.mesh==1

    %Extra fine 
    
    model.mesh('mesh1').autoMeshSize(1);

%    fem.mesh=meshinit(fem, ...
%                  'hmaxfact',0.3, ...
%                  'hgrad',1.2, ...
%                  'hcurve',0.25, ...
%                  'hcutoff',0.0003);
elseif tlm.conf.mesh==2
    %Normal
    
    model.mesh('mesh1').autoMeshSize(2);

%    fem.mesh=meshinit(fem, ...
%                  'hmaxfact',1, ...
%                  'hgrad',1.3, ...
%                  'hcurve',0.3, ...
%                  'hcutoff',0.001);
elseif tlm.conf.mesh==3
    %Extra coarse
        
    model.mesh('mesh1').autoMeshSize(3);

%    fem.mesh=meshinit(fem, ...
%                  'hmaxfact',3, ...
%                  'hgrad',1.8, ...
%                  'hcurve',0.8, ...
%                  'hcutoff',0.02);
end              

model.mesh('mesh1').run;

% Refine mesh
%if tlm.conf.refine~=0
%    for i=1:1:tlm.conf.refine
%        fem.mesh=meshrefine(fem, ...
%                    'mcase',0, ...
%                    'rmethod','regular');
%    end
%end

%Plot the mesh
if (tlm.conf.fig==1)
    figure(2);
    tlm.conf.fig=tlm.conf.fig+1;
    clf('reset');
    colormap(hot(256));
%    meshplot(fem,'Nodelabels','off','Ellabels','off');
    mphmesh(model);
    mphmesh(model,'mesh1','vertexlabels','on');

    if tlm.conf.save==1
        saveas(1,'Mesh.emf');
    end
elseif (tlm.conf.fig==2)
    figure(2);
    tlm.conf.fig=tlm.conf.fig+1;
    clf('reset');
%    meshplot(fem,'Nodelabels','off','Ellabels','off');
     colormap(hot(256));
   mphmesh(model,'mesh1','vertexlabels','on');

% Create xlabel
xlabel({'X-Coordinate (microns)'});

% Create ylabel
ylabel({'Y-Coordinate (microns)'});

% Create title
title({'Device Geometry'});

    if tlm.conf.save==1
        saveas(2,'Mesh.emf');
    end
end