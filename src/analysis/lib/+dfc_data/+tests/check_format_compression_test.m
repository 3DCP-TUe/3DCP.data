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

function check_format_compression_test(folder)
%CHECK_FORMAT_COMPRESSION_TEST Validate compression_test folder structure
%
% This function checks whether the given compression_test data folder
% contains the required processed_data folder and a properly structured
% overview.csv file.
%
% Required columns in overview.csv:
%   deposition_date          | yyyy-MM-dd
%   deposition_time_start    | HH:mm:ss
%   deposition_time_end      | HH:mm:ss
%   testing_date             | yyyy-MM-dd
%   testing_time_start       | HH:mm:ss
%   sample_diameter          | mm
%   sample_height            | mm
%   sample_mass              | g
%   loading_rate             | kN/s
%   density                  | kg/m³
%   failure_load             | kN
%   compressive_strength     | MPa
%
%------------- BEGIN CODE -----------------

    issues = {}; % store validation failures

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

    % Required columns
    required_overview_cols = {
        'deposition_date'
        'deposition_time_start'
        'deposition_time_end'
        'testing_date'
        'testing_time_start'
        'sample_diameter'
        'sample_height'
        'sample_mass'
        'loading_rate'
        'density'
        'failure_load'
        'compressive_strength'
    };

    % Check for missing columns
    missing_cols = setdiff(required_overview_cols, overview.Properties.VariableNames);
    if ~isempty(missing_cols)
        issues{end+1} = sprintf("Missing required columns in overview.csv: %s", strjoin(missing_cols, ', '));
    end

    % Show validation summary
    show_summary(folder, issues);

end

function show_summary(folder, issues)
    fprintf("\n=== Validation report for %s ===\n", folder);

    if isempty(issues)
        fprintf("✅ Validation successful: compression_test folder format is correct.\n\n");
    else
        fprintf("❌ Validation FAILED:\n");
        for i = 1:numel(issues)
            fprintf("   - %s\n", issues{i});
        end
        fprintf("\n");
    end
end
