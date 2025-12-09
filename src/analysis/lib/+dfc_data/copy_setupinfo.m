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

function copy_setupinfo(root, destination, components, swipe_destination)
%COPY_SETUPINFO Copy setupinfo folders for specified components
%
% This function copies the setupinfo folders of specified components 
% from a source library to a destination folder. Optionally, the 
% destination folder can be cleared before copying. The function 
% validates the requested components against the available components 
% in the library and raises an error if any are missing. 
%
% Syntax: copy_setupinfo(root, destination, components, swipe_destination)
%
% Inputs:
%   root              - string or char array specifying the path to the 
%                       library containing setupinfo folders
%   destination       - string or char array specifying the target folder 
%                       to copy setupinfo into
%   components        - cell array of strings containing the names of the 
%                       components to copy
%   swipe_destination - logical flag; if true, clears the destination 
%                       folder before copying
%
% Outputs:
%   (none)
%
% Notes:
%   - The function relies on `dfc_data.get_components_from_folder` to 
%     retrieve available components in the library.
%   - If one or more requested components are not found in the library, 
%     an error is thrown.
%   - If `swipe_destination` is true, the entire destination folder is 
%     deleted before copying.
%   - Each component setupinfo folder is copied into the destination 
%     under its own subfolder.
%
% Example:
%   copy_setupinfo('C:\lib', 'C:\project\setup', {'compA','compB'}, true)
%   % Copies setupinfo for compA and compB from C:\lib into 
%   % C:\project\setup, deleting the target folder first.

%------------- BEGIN CODE --------------

    % Get all component names and their folders from the library
    [lib_names, lib_folders] = dfc_data.get_components_from_folder(root);

    % Match requested components to library components
    indices = zeros(size(components));
    for i = 1:length(components)
        idx = find(strcmp(lib_names, components{i}), 1);
        if ~isempty(idx)
            indices(i) = idx;
        end
    end

    % Check for missing components
    if any(indices == 0)
        missing = components(indices == 0);
        error('The following components were not found in the library: %s', ...
            strjoin(missing, ', '));
    end

    % Get folders for matched components
    folders_used = lib_folders(indices);

    % Optionally clear destination folder
    if swipe_destination
        if isfolder(destination)
            rmdir(destination, 's');
        end
    end

    % Ensure destination folder exists
    if ~isfolder(destination)
        mkdir(destination);
    end

    % Copy each component folder to the destination
    for k = 1:length(folders_used)
        source_folder = folders_used{k};
        [~, name] = fileparts(source_folder);
        destination_folder = fullfile(destination, name);

        [status, msg] = copyfile(source_folder, destination_folder);
        if ~status
            error('Failed to copy folder "%s" to "%s": %s', ...
                source_folder, destination_folder, msg);
        end
    end
end
