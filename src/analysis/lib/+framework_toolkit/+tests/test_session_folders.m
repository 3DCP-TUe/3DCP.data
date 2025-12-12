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

function test_session_folders(root_dir)
% TEST_SESSION_FOLDERS  Validates all session folders in a data record.
%
% INPUT:
%   root_dir : path to the data record root directory
%
% Checks:
%   - Folders contain 'session' in their name
%   - Folder name matches pattern: yyyymmdd_session_i
%   - Each folder contains metadata_session.yml

    fprintf('--- Testing session folders in: %s ---\n', root_dir);

    d = dir(root_dir);
    d = d([d.isdir]); % keep only directories
    session_folders = {};

    % Find folders containing 'session'
    for i = 1:length(d)
        fname = d(i).name;
        if contains(lower(fname), 'session')
            session_folders{end+1} = fname; %#ok<AGROW>
        end
    end

    if isempty(session_folders)
        error('No session folders found in root directory.\n\n');
    end

    fprintf('Found %d session folder(s).\n', numel(session_folders));

    all_ok = true;
    pattern = '^\d{8}_session_\d+$'; % regex: 8 digits, _session_, number

    for i = 1:numel(session_folders)
        folder_name = session_folders{i};
        folder_path = fullfile(root_dir, folder_name);

        % Check folder name pattern
        if isempty(regexp(folder_name, pattern, 'once'))
            fprintf('[FAILED] Folder name does not match pattern: %s\n', folder_name);
            all_ok = false;
        else
            fprintf('[ OK ] Folder name valid: %s\n', folder_name);
        end

        % Check metadata_session.yml exists
        metadata_file = fullfile(folder_path, 'metadata_session.yml');
        if exist(metadata_file, 'file') ~= 2
            fprintf('[FAILED] Missing metadata_session.yml in: %s\n', folder_name);
            all_ok = false;
        else
            fprintf('[ OK ] Found metadata_session.yml\n');
        end
    end

    if all_ok
        fprintf('✔ All session folders validated successfully.\n\n');
    else
        error('⚠ One or more session folders are invalid.\n\n');
    end
end
