function UpdateZSlice(app, z_slice)
    % Fonction ultra-rapide pour rafraîchir les coupes 3D avec le slider
    
    tlm = app.tlm;
    
    % On crée la grille de coupe (allégée à 100x100 pour la fluidité)
    xlin = linspace(tlm.var.OrigineX-tlm.var.LongueurChambre/2, tlm.var.OrigineX+tlm.var.LongueurChambre/2, 100);
    ylin = linspace(tlm.var.OrigineY-tlm.var.LargeurChambre/2, tlm.var.OrigineY+tlm.var.LargeurChambre/2, 100);
    zlin = z_slice;
    [X, Y, Z] = meshgrid(xlin, ylin, zlin);
    
    % --- MISE À JOUR DES 3 CARTES SPICE ---
    if isfield(tlm.var, 'xyceData') && ~isempty(tlm.var.xyceData)
        xyceData = tlm.var.xyceData;
        nNodes = size(tlm.var.X1, 1);
        firstVrCol = 5;
        lastVrCol = firstVrCol + nNodes - 1;
        
        for ii=1:3
            % Identification de la fréquence
            if ii==1, f = tlm.var.frequence.min; 
            elseif ii==2, f = tlm.var.frequence.int; 
            else, f = tlm.var.frequence.max; end
            
            % Interpolation rapide
            [~,idxFreq] = min(abs(xyceData(:,2)-f));
            Volt1 = xyceData(idxFreq, firstVrCol:lastVrCol);
            Res1 = griddata(tlm.var.X1, tlm.var.Y1, tlm.var.Z1, real(Volt1(:)), X, Y, Z, 'linear');
            
            % Ciblage de l'axe
            switch ii
                case 1, ax = app.UIAxes_PotentialMapfmin_SPICE;
                case 2, ax = app.UIAxes_PotentialMapfint_SPICE;
                case 3, ax = app.UIAxes_PotentialMapfmax_SPICE;
            end
            
            % Dessin propre
            cla(ax);
            colormap(ax, hot(256));
            surf(ax, X, Y, Res1);
            camlight(ax, 'right');
            lighting(ax, 'phong'); 
            shading(ax, 'interp'); 
            view(ax, [40,50]); 
            axis(ax, 'tight');
            title(ax, strcat('2D Map of the Electric Potential (Volt) obtained by SPICE at F=', num2str(f,'%0.2g'), ' Hertz and for z=', num2str(zlin), ' meter'));
            zlabel('Potential Difference   (V)');
            ylabel('Y coordinate   (meter)');
            xlabel('X coordinate   (meter)');
        end
    end
    
    % --- MISE À JOUR DES 3 CARTES FEM ---
    if isfield(tlm.var, 'VoltFEM')
        for ii=1:3
            if ii==1, f = tlm.var.frequence.min; 
            elseif ii==2, f = tlm.var.frequence.int; 
            else, f = tlm.var.frequence.max; end
            
            if length(tlm.var.VoltFEM) >= ii && ~isempty(tlm.var.VoltFEM{ii})
                Res2 = griddata(tlm.var.X2, tlm.var.Y2, tlm.var.Z2, real(tlm.var.VoltFEM{ii}(:)), X, Y, Z, 'linear');
                
                switch ii
                    case 1, ax = app.UIAxes_PotentialMapfmin_FEM;
                    case 2, ax = app.UIAxes_PotentialMapfint_FEM;
                    case 3, ax = app.UIAxes_PotentialMapfmax_FEM;
                end
                
                cla(ax); surf(ax, X, Y, Res2);
                colormap(ax, hot(256)); shading(ax, 'interp'); view(ax, [40,50]); axis(ax, 'tight');
                title(ax, sprintf('Coupe FEM (F=%g Hz) à Z=%g m', f, zlin));
            end
        end
    end
    
    % On pousse l'image à l'écran
    drawnow;
end