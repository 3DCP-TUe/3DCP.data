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

function remove_files_by_extension(folder, extension)
%REMOVE_FILES_BY_EXTENSION Recursively deletes files with a given extension
%
% This function searches recursively in the input folder FOLDER for files
% matching the specified EXTENSION. For each folder visited, it collects the
% files with the given extension and prompts the user for confirmation via a
% dialog before deleting them. The extension check is case-insensitive, and
% the leading dot is optional (e.g., '.asv'  or 'asv').
%
% Syntax: remove_files_by_extension(folder, extension)
%
% Inputs:
%   folder    - Root folder to start searching (char vector or string scalar)
%   extension - File extension to delete (e.g., '.txt' or 'txt'); case-insensitive
%
% Outputs:
%  (none)
%
% Notes:
%   - The function prompts once per folder encountered during recursion
%     (i.e., confirmation dialogs are shown for each folder that contains
%     matching files).
%   - The match on EXTENSION is case-insensitive.
%   - EXTENSION may be provided with or without a leading dot; both are accepted.
%   - FOLDER must exist and be accessible.
%   - Requires interactive use (uses QUESTDLG for confirmation).
%
% Example:
%   remove_files_by_extension('C:\project\data', '.asv')

%------------- BEGIN CODE --------------

    % Ensure extension starts with a dot
    if extension(1) ~= '.'
        extension = ['.', extension];
    end

    % Get all items in the folder
    items = dir(folder);
    files_to_delete = {};

    for i = 1:numel(items)
        name = items(i).name;
        item_path = fullfile(folder, name);

        % Skip '.' and '..'
        if strcmp(name, '.') || strcmp(name, '..')
            continue;
        end

        if items(i).isdir
            % Recurse into subfolder
            framework_toolkit.remove_files_by_extension(item_path, extension);
        else
            % Check extension
            [~, ~, ext] = fileparts(name);
            if strcmpi(ext, extension)
                files_to_delete{end+1} = item_path; %#ok<AGROW>
            end
        end
    end

    % Confirm deletion
    if ~isempty(files_to_delete)
        msg = sprintf('Folder: %s\nDelete %d file(s) with extension "%s"?', ...
                      folder, numel(files_to_delete), extension);
        choice = questdlg(msg, 'Confirm Deletion', 'Yes', 'No', 'No');

        if strcmp(choice, 'Yes')
            for i = 1:numel(files_to_delete)
                delete(files_to_delete{i});
                fprintf('Deleted: %s\n', files_to_delete{i});
            end
            disp('Deletion completed.');
        else
            disp('Deletion canceled.');
        end
    else
        disp('No files found to delete.');
    end
end
