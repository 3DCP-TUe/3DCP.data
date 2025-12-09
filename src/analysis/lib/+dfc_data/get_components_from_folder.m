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

function [names, folders] = get_components_from_folder(root_folder)
%GET_COMPONENTS_FROM_FOLDER Retrieve component names and folders from .yml files
%
% This function searches recursively in a given library folder for `.yml` 
% files that represent component definitions. It returns the folder names 
% and corresponding full paths for each `.yml` file found.
%
% Syntax: [names, folders] = get_components_from_folder(root_folder)
%
% Inputs:
%   root_folder - string or char array specifying the path to the library 
%                 folder containing component `.yml` files
%
% Outputs:
%   names   - cell array of folder names containing `.yml` files
%   folders - cell array of full folder paths where `.yml` files are located
%
% Notes:
%   - The search is recursive and includes all subfolders under root_folder.
%   - Each entry in `names` corresponds to the folder where the `.yml` file 
%     resides, not the file itself.
%
% Example:
%   [names, folders] = get_components_from_folder('C:\lib\components')
%   % Returns all component folders under the library that contain .yml files.

%------------- BEGIN CODE --------------

    % Find all .yml files recursively
    files = dir(fullfile(root_folder, '**', '*.yml'));
    n = numel(files);

    % Preallocate cell arrays
    names = cell(n, 1);
    folders = cell(n, 1);

    for i = 1:n
        % Extract folder name and full path
        [~, name] = fileparts(files(i).folder);
        folders{i} = files(i).folder;
        names{i} = name;
    end
end
