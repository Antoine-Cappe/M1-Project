%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                              BIOCAD Program
%                               Release 2.0
%
%   Authors: Tina
%   
%   Date: March 2026
%   Modified by: Tina - NEW FILE for circuit validation
%
%   Function: Validate circuit connectivity and identify isolated nodes
%
%   Purpose: This function performs comprehensive validation of the SPICE
%            circuit extraction to ensure all probe nodes are properly
%            connected and that the extracted circuit is electrically valid.
%            Identifies isolated nodes that could cause infinite impedance.
%
%   Called by: EcriNetList3Dnew.m, SolFEM3D.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [validation_result] = validateCircuit(tlm, fem_mesh_p)

% Modified by: Tina - Comprehensive circuit validation routine
% Checks that all nodes in the SPICE circuit are properly connected

fprintf('\n\t . Circuit Connectivity Validation:');
fprintf('\n\t\t - Checking %d nodes for connectivity...', size(fem_mesh_p, 2));

% Initialize validation result structure
validation_result.num_total_nodes = size(fem_mesh_p, 2);
validation_result.connected_nodes = 0;
validation_result.isolated_nodes = [];
validation_result.electrode_connected = false;
validation_result.measurement_connected = false;
validation_result.issues = {};

% Modified by: Tina - Count connected nodes and identify isolated ones
% A connected node has at least one RC element connecting to another node
for node_idx = 1:validation_result.num_total_nodes
    if ~isempty(tlm.result{node_idx})
        validation_result.connected_nodes = validation_result.connected_nodes + 1;
    else
        % Modified by: Tina - Track isolated nodes
        % These will cause infinite impedance in SPICE
        validation_result.isolated_nodes = [validation_result.isolated_nodes; node_idx];
    end
end

% Modified by: Tina - Report node connectivity statistics
connectivity_percent = 100 * validation_result.connected_nodes / validation_result.num_total_nodes;
fprintf('\n\t\t - Connected nodes: %d / %d (%.1f%%)', ...
    validation_result.connected_nodes, validation_result.num_total_nodes, connectivity_percent);

if ~isempty(validation_result.isolated_nodes)
    fprintf('\n\t\t - Warning: %d isolated nodes found', length(validation_result.isolated_nodes));
    fprintf('\n\t\t   Isolated node IDs: %s', mat2str(validation_result.isolated_nodes(1:min(10, end))));
    validation_result.issues = [validation_result.issues; ...
        {sprintf('Isolated nodes: %d nodes have no RC connections', length(validation_result.isolated_nodes))}];
end

% Modified by: Tina - Check if critical probe nodes are connected
% These node IDs must exist and have connections for valid measurements
if isfield(tlm.ind.pt, 'elec1') && ~isempty(tlm.ind.pt.elec1)
    elec1_id = tlm.ind.pt.elec1;
    if elec1_id <= validation_result.num_total_nodes
        if ~isempty(tlm.result{elec1_id})
            validation_result.electrode_connected = true;
            fprintf('\n\t\t . Electrode 1 (node %d) is connected ✓', elec1_id);
        else
            fprintf('\n\t\t . Warning: Electrode 1 (node %d) is ISOLATED ✗', elec1_id);
            validation_result.issues = [validation_result.issues; ...
                {sprintf('Electrode 1 (node %d) has no RC connections', elec1_id)}];
        end
    end
end

if isfield(tlm.ind.pt, 'elec2') && ~isempty(tlm.ind.pt.elec2)
    elec2_id = tlm.ind.pt.elec2;
    if elec2_id <= validation_result.num_total_nodes
        if ~isempty(tlm.result{elec2_id})
            validation_result.electrode_connected = validation_result.electrode_connected && true;
            fprintf('\n\t\t . Electrode 2 (node %d) is connected ✓', elec2_id);
        else
            fprintf('\n\t\t . Warning: Electrode 2 (node %d) is ISOLATED ✗', elec2_id);
            validation_result.issues = [validation_result.issues; ...
                {sprintf('Electrode 2 (node %d) has no RC connections', elec2_id)}];
        end
    end
end

% Modified by: Tina - Check measurement nodes if specified
if isfield(tlm.ind.pt, 'mesu1') && ~isempty(tlm.ind.pt.mesu1)
    mesu1_id = tlm.ind.pt.mesu1;
    if mesu1_id <= validation_result.num_total_nodes
        if ~isempty(tlm.result{mesu1_id})
            validation_result.measurement_connected = true;
            fprintf('\n\t\t . Measurement node 1 (node %d) is connected ✓', mesu1_id);
        else
            fprintf('\n\t\t . Warning: Measurement node 1 (node %d) is ISOLATED ✗', mesu1_id);
            validation_result.issues = [validation_result.issues; ...
                {sprintf('Measurement node 1 (node %d) has no RC connections', mesu1_id)}];
        end
    end
end

if isfield(tlm.ind.pt, 'mesu2') && ~isempty(tlm.ind.pt.mesu2)
    mesu2_id = tlm.ind.pt.mesu2;
    if mesu2_id <= validation_result.num_total_nodes
        if ~isempty(tlm.result{mesu2_id})
            validation_result.measurement_connected = validation_result.measurement_connected && true;
            fprintf('\n\t\t . Measurement node 2 (node %d) is connected ✓', mesu2_id);
        else
            fprintf('\n\t\t . Warning: Measurement node 2 (node %d) is ISOLATED ✗', mesu2_id);
            validation_result.issues = [validation_result.issues; ...
                {sprintf('Measurement node 2 (node %d) has no RC connections', mesu2_id)}];
        end
    end
end

% Modified by: Tina - Overall validation status
validation_result.valid = validation_result.electrode_connected && ...
                          (connectivity_percent > 50);  % At least 50% connectivity expected

fprintf('\n\t\t . Validation Status: ');
if validation_result.valid
    fprintf('PASS ✓');
else
    fprintf('FAIL ✗ - Check issues below');
end

% Modified by: Tina - Report all identified issues
if ~isempty(validation_result.issues)
    fprintf('\n\t\t . Issues found (%d):', length(validation_result.issues));
    for issue_idx = 1:length(validation_result.issues)
        fprintf('\n\t\t   - %s', validation_result.issues{issue_idx});
    end
end

fprintf('\n');

end
