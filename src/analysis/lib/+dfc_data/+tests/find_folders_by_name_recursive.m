% SPDX-License-Identifier: GPL-3.0-or-later
% DFC.data
% Project: https://github.com/3DCP-TUe/DFC.data
%
% Copyright (c) 2025 Eindhoven University of Technology
%
% Authors:
%   - Arjen Deetman (2025)
%
% For license details, see the LICENSE file in the project root.

function results = find_folders_by_name_recursive(root, target)
% FIND_FOLDERS_BY_NAME_RECURSIVE Find all folders with a given name (recursive),
% but only if they are located within a folder containing "session" in its name.
%
%   results = find_folders_by_name_recursive(root, target)
%   root   : directory to search
%   target : folder name to look for
%   results: cell array of folder paths that meet criteria
%
%   Criteria:
%       - Folder name must equal target
%       - Parent folder name must contain "session"

    results = {};

    % Validate root directory
    if ~isfolder(root)
        error('Input must be a valid folder path.');
    end

    % Internal recursive search
    function searchDir(currentDir)
        items = dir(currentDir);
        folders = items([items.isdir] & ~ismember({items.name}, {'.','..'}));

        for i = 1:length(folders)
            fullPath = fullfile(currentDir, folders(i).name);
            folderName = folders(i).name;

            % Derive the parent folder name
            parentPath = currentDir;
            [~, parentFolderName] = fileparts(parentPath);

            % Check match and session condition
            if strcmp(folderName, target) && contains(lower(parentFolderName), "session")
                results{end+1} = fullPath; %#ok<AGROW>
            end

            % Recurse into subfolder
            searchDir(fullPath);
        end
    end

    searchDir(root);
end

