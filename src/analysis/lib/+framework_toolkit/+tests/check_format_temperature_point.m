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

function check_format_temperature_point(folder)
%CHECK_FORMAT_TEMPERATURE_POINT Validate Temperature Point folder structure
%
% This function checks whether the given Temperature Point data folder
% contains the required processed_data folder, a valid overview.csv file,
% and valid sample_i.csv files referenced in overview.csv.
%
% Required columns in overview.csv:
%   deposition_date          | yyyy-MM-dd
%   deposition_time_start    | HH:mm:ss
%   deposition_time_end      | HH:mm:ss
%   testing_date             | yyyy-MM-dd
%   testing_time_start       | HH:mm:ss
%   file_name                | -
%   position_x               | mm
%   position_y               | mm
%   position_z               | mm
%
% Required columns in sample_i.csv:
%   time                     | HH:mm:ss.SSS
%   age                      | HH:mm:ss.SSS
%   temperature              | °C
%
%------------- BEGIN CODE -----------------

    issues = {};

    % Validate folder
    if ~isfolder(folder)
        issues{end+1} = sprintf("Invalid folder: %s", folder);
        show_summary(folder, issues);
        return;
    end

    processed_data = fullfile(folder, 'processed_data');

    % processed_data folder must exist
    if ~isfolder(processed_data)
        issues{end+1} = "Missing subfolder: processed_data";
        show_summary(folder, issues);
        return;
    end

    overview_file = fullfile(processed_data, 'overview.csv');

    % overview.csv must exist
    if ~isfile(overview_file)
        issues{end+1} = sprintf("Missing overview.csv file in %s", processed_data);
        show_summary(folder, issues);
        return;
    end

    % Try reading overview.csv
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
        'position_x'
        'position_y'
        'position_z'
    };

    % Check missing columns
    missing_cols = setdiff(required_overview_cols, overview.Properties.VariableNames);
    if ~isempty(missing_cols)
        issues{end+1} = sprintf("Missing required columns in overview.csv: %s", strjoin(missing_cols, ', '));
        show_summary(folder, issues);
        return;
    end

    % Loop through sample file references
    for i = 1:height(overview)
        fname = overview.file_name{i};
        sample_file = fullfile(processed_data, fname);

        if ~isfile(sample_file)
            issues{end+1} = sprintf("Referenced sample file does not exist: %s", sample_file);
            continue;
        end

        % Read sample file
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
            'temperature'
        };

        missing_sample_cols = setdiff(required_sample_cols, sample_data.Properties.VariableNames);

        if ~isempty(missing_sample_cols)
            issues{end+1} = sprintf("Missing columns in %s: %s", fname, strjoin(missing_sample_cols, ', '));
        end
    end

    % Final report
    show_summary(folder, issues);

end

function show_summary(folder, issues)
    fprintf("\n=== Validation report for %s ===\n", folder);

    if isempty(issues)
        fprintf("✅ Validation successful: Temperature point folder format is correct.\n\n");
    else
        fprintf("❌ Validation FAILED:\n");
        for i = 1:numel(issues)
            fprintf("   - %s\n", issues{i});
        end
        fprintf("\n");
    end
end
