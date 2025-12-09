% SPDX-License-Identifier: GPL-3.0-or-later
% 3DCP.data
% Project: https://github.com/3DCP-TUe/3DCP.data
%
% Copyright (c) 2024-2025 Eindhoven University of Technology
%
% Authors:
%   - Arjen Deetman (2024-2025)
%
% For license details, see the LICENSE file in the project root.

function components = get_material_components_from_system_metadata(metadata)
%GET_MATERIAL_COMPONENTS_FROM_SYSTEM_METADATA Extract unique material components
%
% This function extracts the unique material component names used in a 
% session based on the provided metadata structure. It parses the 
% `system_layout` field of the metadata and returns the unique component 
% names.
%
% Syntax: components = get_material_components_from_system_metadata(metadata)
%
% Inputs:
%   metadata - struct containing system layout information, typically read 
%              from a session metadata file
%
% Outputs:
%   components - cell array of unique material component names
%
% Notes:
%   - The function assumes `metadata.system_layout` is a cell array of 
%     structs, each with a `component` field.
%   - Duplicate component names are removed automatically.
%
% Example:
%   metadata = dfc_data.readyaml('session_metadata.yml');
%   components = get_material_components_from_system_metadata(metadata)
%   % Returns the unique material component names defined in the session.

%------------- BEGIN CODE --------------

    % Extract components from materials
    material_components = cellfun(@(x) x.component, metadata.system_layout, 'UniformOutput', false);

    % Return unique component names
    components = unique(material_components);
end
