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

function check_format_uwtt(folder)
%CHECK_FORMAT_UWTT Validate UWTT folder structure and required data format
%
% This function checks whether the given UWTT data folder contains the
% required processed data files and whether their formats comply with the
% expected column structure. The function validates the existence of
% overview.csv and all required columns, checks that files referenced in
% the "file_name" column exist, and validates the structure of the
% corresponding sample_i.csv files.
%
% Syntax: check_format_uwtt(folder)
%
% Inputs:
%   folder - string or char array specifying the UWTT folder path
%
% Outputs:
%   (none)
%
% Notes:
%   - The function expects a subfolder named 'processed_data'
%     inside the given folder.
%   - overview.csv must contain all required columns listed below.
%   - For each entry in the "file_name" column of overview.csv, the
%     corresponding file must exist in the processed_data.
%   - Each referenced sample file must contain the required columns.
%   - Does not throw errors; prints validation summary instead.
%
% Required columns in overview.csv:
%   deposition_date          | yyyy-MM-dd
%   deposition_time_start    | HH:mm:ss
%   deposition_time_end      | HH:mm:ss
%   testing_date             | yyyy-MM-dd
%   testing_time_start       | HH:mm:ss
%   file_name                | -
%   distance                 | mm
%
% Required columns in sample_i.csv:
%   time                     | HH:mm:ss
%   age                      | HH:mm:ss
%   velocity                 | m/s
%   acceleration             | m/s²
%   temperature              | °C
%
% Example:
%   check_format_uwtt('C:\dfc_data\data_records\record_1\20251016_session_1\uwtt');
%
%------------- BEGIN CODE --------------

    issues = {}; % store validation failures

    % Validate folder
    if ~isfolder(folder)
        issues{end+1} = sprintf("Invalid folder: %s", folder);
        show_summary(folder, issues);
        return;
    end

    processed_data = fullfile(folder, 'processed_data');

    if ~isfolder(processed_data)
        issues{end+1} = "Missing subfolder: processed_data";
        show_summary(folder, issues);
        return;
    end

    overview_file = fullfile(processed_data, 'overview.csv');

    % Check overview.csv exists
    if ~isfile(overview_file)
        issues{end+1} = sprintf("Missing overview.csv file in %s", processed_data);
        show_summary(folder, issues);
        return;
    end

    % Try reading overview.csv safely
    try
        overview = readtable(overview_file);
    catch ME
        issues{end+1} = sprintf("Failed to read overview.csv: %s", ME.message);
        show_summary(folder, issues);
        return;
    end

    % Required columns in overview.csv
    required_overview_cols = {
        'deposition_date'
        'deposition_time_start'
        'deposition_time_end'
        'testing_date'
        'testing_time_start'
        'file_name'
        'distance'
    };

    % Check column existence
    missing_cols = setdiff(required_overview_cols, overview.Properties.VariableNames);
    if ~isempty(missing_cols)
        issues{end+1} = sprintf("Missing required columns in overview.csv: %s", strjoin(missing_cols, ', '));
    end

    % skip deeper checks if overview is invalid
    if ~isempty(issues)
        show_summary(folder, issues);
        return;
    end

    % For each file_name entry, verify file exists and validate content
    for i = 1:height(overview)
        fname = overview.file_name{i};
        sample_file = fullfile(processed_data, fname);

        if ~isfile(sample_file)
            issues{end+1} = sprintf("Referenced sample file does not exist: %s", sample_file);
            continue;
        end

        % Read sample file safely
        try
            sample_data = readtable(sample_file);
        catch ME
            issues{end+1} = sprintf("Failed to read sample file %s: %s", sample_file, ME.message);
            continue;
        end

        % Required sample columns
        required_sample_cols = {
            'time'
            'age'
            'velocity'
            'acceleration'
            'temperature'
        };

        missing_sample_cols = setdiff(required_sample_cols, sample_data.Properties.VariableNames);

        if ~isempty(missing_sample_cols)
            issues{end+1} = sprintf("Missing columns in %s: %s", fname, strjoin(missing_sample_cols, ', '));
        end
    end

    % Show summary of results
    show_summary(folder, issues);

end

function show_summary(folder, issues)
    % Helper function for printing result summary
    fprintf("\n=== Validation report for %s ===\n", folder);

    if isempty(issues)
        fprintf("✅ Validation successful: UWTT folder format is correct.\n\n");
    else
        fprintf("❌ Validation FAILED:\n");
        for i = 1:numel(issues)
            fprintf("   - %s\n", issues{i});
        end
        fprintf("\n");
    end
end
