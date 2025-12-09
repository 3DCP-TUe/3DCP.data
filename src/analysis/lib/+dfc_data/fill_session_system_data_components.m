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

function fill_session_system_data_components(library, folder, subfolder, swipe_destination)
%FILL_SESSION_SYSTEM_DATA_COMPONENTS Populate system or material components folder
%
% This function populates the `system_components` or `material_components` 
% folder inside a session by copying the relevant setupinfo components 
% from a component library. The function reads the sessions metadata file 
% to determine which components are required and copies them accordingly. 
% Optionally, existing destination folders can be cleared before copying.
%
% Syntax: fill_session_system_data_components(library, folder, subfolder, swipe_destination)
%
% Inputs:
%   library           - string or char array specifying the source path of the component library
%   folder            - string, char array, or struct from `dir` specifying the session folder
%   subfolder         - string specifying the type of components to copy; must be either "system" or "materials"
%   swipe_destination - logical flag; if true, clears the destination folder before copying
%
% Outputs:
%   (none)
%
% Notes:
%   - The session folder must contain a metadata file located at `system_data/setupinfo/metadata.yml`.
%   - Components are determined by parsing the metadata:
%       - For "system", uses `dfc_data.get_system_components_from_system_metadata`.
%       - For "materials", uses `dfc_data.get_material_components_from_system_metadata`.
%   - If the metadata file does not exist, an error is thrown.
%   - Actual copying is handled by `dfc_data.copy_setupinfo`.
%
% Example:
%   fill_session_system_data_components('C:\lib', ...
%       'C:\records\session1', 'system', true)
%   % Populates system components in session1, clearing the target folder first.

%------------- BEGIN CODE --------------

    % Resolve folder path
    if isstruct(folder)
        path = fullfile(folder.folder, folder.name);
    elseif ischar(folder) || isstring(folder)
        path = char(folder);
    else
        error('Invalid input: folder must be a string, char array, or a dir struct.');
    end

    % Construct metadata file path
    metadata_file = fullfile(path, 'system_data', 'setupinfo', 'metadata.yml');

    % Check for metadata file
    if ~isfile(metadata_file)
        error('System data folder "%s" does not contain a metadata file.', path);
    end

    % Read system metadata
    metadata = dfc_data.readyaml(metadata_file);

    % Extract components based on subfolder type
    switch lower(subfolder)
        case "system"
            components = dfc_data.get_system_components_from_system_metadata(metadata);
            destination = fullfile(path, 'system_data', 'setupinfo', 'system_components');
        case "materials"
            components = dfc_data.get_material_components_from_system_metadata(metadata);
            destination = fullfile(path, 'system_data', 'setupinfo', 'material_components');
        otherwise
            error('Invalid input: subfolder must be "system" or "materials".');
    end

    % Copy setupinfo for used components
    dfc_data.copy_setupinfo(library, destination, components, swipe_destination);
end
