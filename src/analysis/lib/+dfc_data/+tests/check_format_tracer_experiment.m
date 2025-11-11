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

function check_format_tracer_experiment(folder)
%CHECK_FORMAT_TRACER_EXPERIMENT Validate tracer experiment folder format
%
% The tracer experiment folder must contain:
%   - processed_data/overview.csv
%   - processed_data/color_values.csv
%   - multiple experiment response files referenced in overview.csv
%
% Required columns in overview.csv:
%   experiment
%   serie
%   input
%   material_component
%   system_component
%   system_component_inlet
%   size
%   time_start
%   time_end
%   file_name
%   mean
%   variance
%   std
%   p1
%   p5
%   p50
%   p95
%   p99
%
% Required columns in color_values.csv:
%   time
%   R
%   G
%   B
%   X
%   Y
%   Z
%   L
%   a
%   b
%
% Required columns in experiment response files:
%   time
%   time_response
%   value
%   R
%   G
%   B
%   X
%   Y
%   Z
%   L
%   a
%   b
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

    % Check processed_data exists
    if ~isfolder(processed_data)
        issues{end+1} = "Missing subfolder: processed_data";
        show_summary(folder, issues);
        return;
    end

    overview_file = fullfile(processed_data, 'overview.csv');
    color_file = fullfile(processed_data, 'color_values.csv');

    % Check overview.csv
    if ~isfile(overview_file)
        issues{end+1} = "Missing overview.csv file.";
        show_summary(folder, issues);
        return;
    end

    % Try read overview.csv
    try
        overview = readtable(overview_file);
    catch ME
        issues{end+1} = sprintf("Failed to read overview.csv: %s", ME.message);
        show_summary(folder, issues);
        return;
    end

    % Required overview columns
    required_overview_cols = {
        'experiment'
        'serie'
        'input'
        'material_component'
        'system_component'
        'system_component_inlet'
        'size'
        'time_start'
        'time_end'
        'file_name'
        'mean'
        'variance'
        'std'
        'p1'
        'p5'
        'p50'
        'p95'
        'p99'
    };

    missing_cols = setdiff(required_overview_cols, overview.Properties.VariableNames);
    if ~isempty(missing_cols)
        issues{end+1} = sprintf("Missing required overview columns: %s", strjoin(missing_cols, ', '));
    end

    % Check color_values.csv
    if ~isfile(color_file)
        issues{end+1} = "Missing color_values.csv file.";
    else
        try
            color_values = readtable(color_file);
            required_color_cols = {
                'time'
                'R'
                'G'
                'B'
                'X'
                'Y'
                'Z'
                'L'
                'a'
                'b'
            };
            missing_color_cols = setdiff(required_color_cols, color_values.Properties.VariableNames);
            if ~isempty(missing_color_cols)
                issues{end+1} = sprintf("Missing columns in color_values.csv: %s", ...
                    strjoin(missing_color_cols, ', '));
            end
        catch ME
            issues{end+1} = sprintf("Failed to read color_values.csv: %s", ME.message);
        end
    end

    % If overview itself is corrupted, skip file_name processing
    if ~isempty(missing_cols)
        show_summary(folder, issues);
        return;
    end

    % Validate each experiment response file
    required_response_cols = {
        'time'
        'time_response'
        'value'
        'R'
        'G'
        'B'
        'X'
        'Y'
        'Z'
        'L'
        'a'
        'b'
    };

    for i = 1:height(overview)
        fname = overview.file_name{i};
        response_file = fullfile(processed_data, fname);

        if ~isfile(response_file)
            issues{end+1} = sprintf("Missing response file: %s", response_file);
            continue;
        end

        try
            response_data = readtable(response_file);
        catch ME
            issues{end+1} = sprintf("Failed to read response file %s: %s", fname, ME.message);
            continue;
        end

        missing_response_cols = setdiff(required_response_cols, response_data.Properties.VariableNames);
        if ~isempty(missing_response_cols)
            issues{end+1} = sprintf("Missing columns in %s: %s", fname, ...
                strjoin(missing_response_cols, ', '));
        end
    end

    % Output final summary
    show_summary(folder, issues);

end

function show_summary(folder, issues)
    fprintf("\n=== Validation report for %s ===\n", folder);

    if isempty(issues)
        fprintf("✅ Validation successful: Tracer experiment folder format is correct.\n\n");
    else
        fprintf("❌ Validation FAILED:\n");
        for i = 1:numel(issues)
            fprintf("   - %s\n", issues{i});
        end
        fprintf("\n");
    end
end
