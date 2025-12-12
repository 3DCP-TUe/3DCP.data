% SPDX-License-Identifier: GPL-3.0-or-later
% 3DCP.data
% Project: https://github.com/3DCP-TUe/3DCP.data
%
% Copyright (c) 2025 Eindhoven University of Technology
%
% Authors:
%   - Arjen Deetman (2025)
%
% For license details, see the LICENSE file in the project root.

function test_datarecord_root(root_dir)
% TEST_DATARECORD_ROOT Validates the root directory of a data record.
%
% INPUT:
%   root_dir : path to the data record root directory
%
% Checks:
%   1. Required files exist:
%       - metadata_data_sources.yml
%       - metadata_record.yml
%       - LICENSE_GPL-3.0.txt
%       - LICENSE_CC-BY-SA-4.0.txt
%       - LICENSE.txt
%   2. Only allowed folders exist in root:
%       - misc
%       - analysis
%       - session folders (yyyymmdd_session_i)

    fprintf('--- Testing data record root: %s ---\n', root_dir);

    % -----------------------------
    % Check required files
    required_files = {
        'metadata_data_sources.yml'
        'metadata_record.yml'
        'LICENSE_GPL-3.0.txt'
        'LICENSE_CC-BY-SA-4.0.txt'
        'LICENSE.txt'
    };

    all_ok = true;

    for i = 1:numel(required_files)
        fpath = fullfile(root_dir, required_files{i});
        if exist(fpath, 'file') ~= 2
            fprintf('[FAILED] Missing required file: %s\n', required_files{i});
            all_ok = false;
        else
            fprintf('[ OK ] Found: %s\n', required_files{i});
        end
    end

    % -----------------------------
    % Check allowed folders
    d = dir(root_dir);
    d = d([d.isdir]); % only directories
    folder_names = {d.name};

    % Exclude '.' and '..'
    folder_names = folder_names(~ismember(folder_names, {'.', '..'}));

    session_pattern = '^\d{8}_session_\d+$';
    allowed_folders = {'misc', 'analysis'};
    
    for i = 1:numel(folder_names)
        fname = folder_names{i};
        if ~ismember(fname, allowed_folders) && isempty(regexp(fname, session_pattern, 'once'))
            fprintf('[FAILED] Unexpected folder in root: %s\n', fname);
            all_ok = false;
        else
            fprintf('[ OK ] Folder allowed: %s\n', fname);
        end
    end

    if all_ok
        fprintf('✔ Root-level files and folders are valid.\n\n');
    else
        error('⚠ Root-level validation failed.\n\n');
    end
end
