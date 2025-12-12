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

function test_data_record_sessions(root_dir)
% TEST_DATA_RECORD_SESSIONS  Validate all session folders in a data record
%
% INPUT:
%   root_dir : path to the root of the data record
%
% This function:
%   1. Finds all session folders in the root directory
%   2. Loads the metadata_data_sources.yml
%   3. Loops over each session folder and validates its data sources

    fprintf('=== Testing all session folders in data record: %s ===\n', root_dir);

    % -----------------------------
    % Load metadata file
    metadata_file = fullfile(root_dir, 'metadata_data_sources.yml');
    if ~exist(metadata_file, 'file')
        error('Missing metadata_data_sources.yml in root directory.');
    end

    % -----------------------------
    % List session folders
    d = dir(root_dir);
    d = d([d.isdir]); % keep only directories
    folder_names = {d.name};
    folder_names = folder_names(~ismember(folder_names, {'.', '..'})); % exclude . and ..

    % Session folder pattern: yyyymmdd_session_i
    session_pattern = '^\d{8}_session_\d+$';
    session_folders = {};

    for i = 1:numel(folder_names)
        if ~isempty(regexp(folder_names{i}, session_pattern, 'once'))
            session_folders{end+1} = folder_names{i}; %#ok<AGROW>
        end
    end

    if isempty(session_folders)
        warning('No session folders found in root directory.');
        return;
    end

    fprintf('Found %d session folder(s) to validate.\n', numel(session_folders));

    % -----------------------------
    % Loop over session folders
    for i = 1:numel(session_folders)
        session_path = fullfile(root_dir, session_folders{i});
        fprintf('\n--- Validating session folder: %s ---\n', session_folders{i});
        framework_toolkit.tests.test_session_data_sources(session_path, metadata_file);
    end

    fprintf('\n=== Finished validating all session folders ===\n');

end
