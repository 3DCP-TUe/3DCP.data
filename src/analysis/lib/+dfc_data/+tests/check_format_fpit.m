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

function check_format_fpit(folder)
%CHECK_FORMAT_FPIT Validate FPIT folder structure and required data format
%
% This function checks whether the given FPIT data folder contains the
% required processed_data folder, a valid overview.csv file, and valid
% sample_i.csv files referenced in overview.csv.
%
% Required columns in overview.csv:
%   deposition_date          | yyyy-MM-dd
%   deposition_time_start    | HH:mm:ss
%   deposition_time_end      | HH:mm:ss
%   testing_date             | yyyy-MM-dd
%   testing_time             | HH:mm:ss
%   file_name                | -
%   loading_rate             | mm/s
%   indenter_radius          | mm
%   sample_radius            | mm
%   stiffness_modulus        | MPa
%   cohesion                 | MPa
%   friction_angle           | degrees
%
% Required columns in sample_i.csv:
%   time                     | HH:mm:ss.SSS
%   load                     | N
%   depth                    | mm
%
%------------- BEGIN CODE -----------------

    issues = {}; % container for validation problems

    % Validate folder
    if ~isfolder(folder)
        issues{end+1} = sprintf("Invalid folder: %s", folder);
        show_summary(folder, issues);
        return;
    end

    processed_data = fullfile(folder, 'processed_data');

    % processed_data must exist
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

    % Try loading overview.csv
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
        'testing_time'
        'file_name'
        'loading_rate'
        'indenter_radius'
        'sample_radius'
        'stiffness_modulus'
        'cohesion'
        'friction_angle'
    };

    % Check missing columns
    missing_cols = setdiff(required_overview_cols, overview.Properties.VariableNames);
    if ~isempty(missing_cols)
        issues{end+1} = sprintf("Missing required columns in overview.csv: %s", strjoin(missing_cols, ', '));
        show_summary(folder, issues);
        return;
    end

    % Validate each referenced sample file
    for i = 1:height(overview)
        fname = overview.file_name{i};
        sample_file = fullfile(processed_data, fname);

        % Check sample file exists
        if ~isfile(sample_file)
            issues{end+1} = sprintf("Referenced sample file does not exist: %s", sample_file);
            continue;
        end

        % Try loading sample file
        try
            sample_data = readtable(sample_file);
        catch ME
            issues{end+1} = sprintf("Failed to read sample file %s: %s", sample_file, ME.message);
            continue;
        end

        % Required sample columns
        required_sample_cols = {
            'time'
            'load'
            'depth'
        };

        missing_sample_cols = setdiff(required_sample_cols, sample_data.Properties.VariableNames);
        if ~isempty(missing_sample_cols)
            issues{end+1} = sprintf("Missing columns in %s: %s", fname, strjoin(missing_sample_cols, ', '));
        end
    end

    % Output summary
    show_summary(folder, issues);

end

function show_summary(folder, issues)
    fprintf("\n=== Validation report for %s ===\n", folder);

    if isempty(issues)
        fprintf("✅ Validation successful: FPIT folder format is correct.\n\n");
    else
        fprintf("❌ Validation FAILED:\n");
        for i = 1:numel(issues)
            fprintf("   - %s\n", issues{i});
        end
        fprintf("\n");
    end
end
