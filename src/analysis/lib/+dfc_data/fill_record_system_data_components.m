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

function fill_record_system_data_components(library, folder, subfolder, swipe_destination)
%FILL_RECORD_SYSTEM_DATA_COMPONENTS Fill setupinfo system components for session subfolders
%
% This function iterates through all session subfolders within a specified 
% data record folder and fills the system or materials components from a 
% given component library. The function ensures that each session subfolder 
% contains the required setupinfo components. Optionally, the destination 
% folders can be cleared before copying.
%
% Syntax: fill_record_system_data_components(library, folder, subfolder, swipe_destination)
%
% Inputs:
%   library           - string or char array specifying the path to the component library
%   folder            - string, char array, or struct from `dir` specifying the data record folder
%   subfolder         - string specifying the type of components to copy; must be either "system" or "materials"
%   swipe_destination - logical flag; if true, clears destination before copying
%
% Outputs:
%   (none)
%
% Notes:
%   - If `folder` is a struct (from `dir`), the path is extracted from the first entry.
%   - An error is thrown if the provided folder does not exist or if the input type is invalid.
%   - Only subfolders containing "session" in their name are processed.
%   - The actual population of components is handled by `dfc_data.fill_session_system_data_components`.
%
% Example:
%   fill_record_system_data_components('C:\lib', 'C:\records', 'system', true)
%   % Populates system components in all session subfolders under C:\records,
%   % deleting existing targets first if swipe_destination is true.

%------------- BEGIN CODE --------------

    % Determine the folder path
    if isstruct(folder)
        path = folder(1).folder;  % Use first entry's folder
    elseif ischar(folder) || isstring(folder)
        path = char(folder);      % Convert to char if needed
    else
        error('Invalid input: folder must be a string, char array, or a dir struct.');
    end

    % Validate folder existence
    if ~isfolder(path)
        error('Data record folder does not exist: %s', path);
    end
    
    % Get all subfolders
    subfolders = dir(path);
    for i = 1:length(subfolders)
        name = subfolders(i).name;
        full_path = fullfile(path, name);

        % Check for session folders
        if subfolders(i).isdir && contains(name, 'session')
            dfc_data.fill_session_system_data_components(library, full_path, subfolder, swipe_destination);
        end
    end
end
