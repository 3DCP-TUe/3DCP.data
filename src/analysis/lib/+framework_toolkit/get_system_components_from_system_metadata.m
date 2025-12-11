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

function components = get_system_components_from_system_metadata(metadata)
%GET_SYSTEM_COMPONENTS_FROM_SYSTEM_METADATA Extract unique system components
%
% This function extracts the unique system component names used in a 
% session based on the provided metadata structure. It collects component 
% names from both the `system_layout` and `motion_systems` fields and 
% returns a deduplicated list.
%
% Syntax: components = get_system_components_from_system_metadata(metadata)
%
% Inputs:
%   metadata - struct containing system layout and motion system information, 
%              typically read from a session metadata file
%
% Outputs:
%   components - cell array of unique system component names
%
% Notes:
%   - The function assumes:
%       - `metadata.system_layout` is a cell array of structs, each with a 
%         `component` field.
%       - `metadata.motion_systems` is a cell array of structs, each with a 
%         `name` field.
%   - Duplicate component names are automatically removed.
%
% Example:
%   metadata = framework_toolkit.readyaml('session_metadata.yml');
%   components = get_system_components_from_system_metadata(metadata)
%   % Returns the unique system component names defined in the session.

%------------- BEGIN CODE --------------

    % Extract components from system layout
    layout_components = cellfun(@(x) x.component, metadata.system_layout, 'UniformOutput', false);

    % Extract names of motion systems
    motion_components = cellfun(@(x) x.name, metadata.motion_systems, 'UniformOutput', false);

    % Combine and return unique component names
    components = unique([layout_components; motion_components]);
end
