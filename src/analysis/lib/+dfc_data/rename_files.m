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

function rename_files(folder, suffix)
%RENAME_FILES Renames all files in a folder with a sequential suffix
%
% This function renames all non-directory files in the specified FOLDER
% by appending a sequential index to the provided SUFFIX while preserving
% the original file extensions. Files are processed in alphabetical order.
%
% Syntax: rename_files(folder, suffix)
%
% Inputs:
%   folder  - Path to the folder containing files (char vector or string scalar)
%   suffix  - Base name/prefix for renamed files (e.g., 'image')
%
% Outputs:
%   (none)
%
% Notes:
%   - Only files in the top-level FOLDER are renamed (non-recursive).
%   - Original file extensions are preserved.
%   - Files are sorted alphabetically before renaming; indices start at 1.
%   - If a target filename already exists, the behavior depends on the platform.
%     Consider ensuring unique target names before running.
%   - Existing files whose names already match the target pattern for their
%     position are left unchanged.
%
% Example:
%   rename_files('C:\project\data', 'image')
%   % This will rename files to: image_1.ext, image_2.ext, image_3.ext, ...
%   % where '.ext' is each file's original extension.

%------------- BEGIN CODE --------------

    % Get all files (excluding directories)
    files = dir(fullfile(folder, '*.*'));
    files = files(~[files.isdir]);

    % Sort files alphabetically
    [~, idx] = sort({files.name});
    files = files(idx);

    % Rename files sequentially
    for i = 1:numel(files)
        old_name = fullfile(folder, files(i).name);

        % Preserve original extension
        [~, ~, ext] = fileparts(files(i).name);
        new_name = fullfile(folder, sprintf('%s_%d%s', suffix, i, ext));

        % Rename if different
        if ~strcmp(old_name, new_name)
            movefile(old_name, new_name);
        end
    end
end
