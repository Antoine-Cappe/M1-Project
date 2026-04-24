function [tlm, model] = SetDomainValues(tlm, model)

    %#ok<INUSD>
    global fem_mesh_t;

    fprintf('\n\t . Applying explicit domain values for the complex geometry');

    if ~isfield(tlm.conf, 'complexGeometry') || tlm.conf.complexGeometry ~= 1
        fprintf('\n\t   Complex-geometry mapping skipped (simple model in use).');
        return;
    end

    domain_ids = extract_domain_ids(fem_mesh_t);
    if isempty(domain_ids)
        error('SetDomainValues: no domain identifiers were found in the FEM mesh.');
    end

    max_domain = max(domain_ids);
    tlm.dom.sig = zeros(1, max_domain);
    tlm.dom.eps = zeros(1, max_domain);

    % Default everything to the fluid medium, then override the specific
    % domains that belong to the current TiC geometry.
    tlm.dom.sig(:) = tlm.var.sig.CultureMedium;
    tlm.dom.eps(:) = tlm.var.eps.CultureMedium;

    % Hardcoded domain map for the current complex geometry.
    map.Glass         = [1];
    map.PDMS          = [2 5 6 7 10 11 12 13 16 17 18 19 20 21];
    map.CultureMedium = [3 4 23];
    map.Matrix        = [8];
    map.Plastic       = [9];
    map.DoubleLayer   = [14 15];

    apply_material(map.Glass, tlm.var.sig.Glass, tlm.var.eps.Glass);
    apply_material(map.PDMS, tlm.var.sig.PDMS, tlm.var.eps.PDMS);
    apply_material(map.CultureMedium, tlm.var.sig.CultureMedium, tlm.var.eps.CultureMedium);
    apply_material(map.Matrix, tlm.var.sig.Matrix, tlm.var.eps.Matrix);
    apply_material(map.Plastic, tlm.var.sig.Plastic, tlm.var.eps.Plastic);
    apply_material(map.DoubleLayer, tlm.var.sig.Platinum, tlm.var.eps.Platinum);

    % Geometry-specific indices used elsewhere in BIOCAD.
    tlm.ind.dom.Glass = 1;
    tlm.ind.dom.PDMS = map.PDMS;
    tlm.ind.dom.CultureMedium = map.CultureMedium;
    tlm.ind.dom.Matrix = 8;
    tlm.ind.dom.Plastic = 9;
    tlm.ind.dom.DoubleLayer = map.DoubleLayer;

    % The existing circuit code expects scalar electrode / medium IDs.
    tlm.ind.dom.elec1 = 14;
    tlm.ind.dom.elec2 = 15;
    tlm.ind.dom.MilOrga = 3;

    % Keep the second fluid alias aligned with the matrix domain used in
    % the current geometry.
    tlm.ind.dom.MilOrgb = tlm.ind.dom.Matrix;

    fprintf('\n\t   Domain map applied: Glass=1, PDMS=[%s], Medium=[%s], Matrix=8, Plastic=9, DoubleLayer=[14 15]', ...
        num2str(map.PDMS), num2str(map.CultureMedium));

    function apply_material(domain_list, sigma_value, epsilon_value)
        for domain_id = domain_list
            if domain_id <= max_domain
                tlm.dom.sig(domain_id) = sigma_value;
                tlm.dom.eps(domain_id) = epsilon_value;
            end
        end
    end
end

function domain_ids = extract_domain_ids(mesh_t)
    if isempty(mesh_t)
        domain_ids = [];
        return;
    end

    if isvector(mesh_t)
        domain_ids = unique(mesh_t(:)');
    elseif size(mesh_t, 1) >= 5
        domain_ids = unique(mesh_t(5, :));
    elseif size(mesh_t, 2) >= 5
        domain_ids = unique(mesh_t(:, 5)');
    else
        domain_ids = unique(mesh_t(:)');
    end

    domain_ids = domain_ids(domain_ids > 0 & isfinite(domain_ids));
end