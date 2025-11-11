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

function check_format_pocket_share_vane(folder)
%CHECK_FORMAT_POCKET_SHARE_VANE Validate Pocket Share Vane folder structure
%
% This function checks whether the given Pocket Share Vane folder contains
% a correctly formatted overview.csv file. No sample_i.csv files exist for
% this test type.
%
% Syntax:
%   check_format_pocket_share_vane(folder)
%
% Required columns in overview.csv:
%   deposition_date          | yyyy-MM-dd
%   deposition_time_start    | HH:mm:ss
%   deposition_time_end      | HH:mm:ss
%   testing_date             | yyyy-MM-dd
%   testing_time_start       | HH:mm:ss
%   vane_diameter            | mm
%   vane_height              | mm
%   vane_material            | mm
%   shear_strength           | kPa
%
%------------- BEGIN CODE -----------------

    issues = {};

    % Validate base folder
    if ~isfolder(folder)
        issues{end+1} = sprintf("Invalid folder: %s", folder);
        show_summary(folder, issues);
        return;
    end

    processed_data = fullfile(folder, 'processed_data');

    % Check processed_data subfolder
    if ~isfolder(processed_data)
        issues{end+1} = "Missing subfolder: processed_data";
        show_summary(folder, issues);
        return;
    end

    overview_file = fullfile(processed_data, 'overview.csv');

    % Check file existence
    if ~isfile(overview_file)
        issues{end+1} = sprintf("Missing overview.csv file in %s", processed_data);
        show_summary(folder, issues);
        return;
    end

    % Read table
    try
        overview = readtable(overview_file);
    catch ME
        issues{end+1} = sprintf("Failed to read overview.csv: %s", ME.message);
        show_summary(folder, issues);
        return;
    end

    % Required overview columns
    required_cols = {
        'deposition_date'
        'deposition_time_start'
        'deposition_time_end'
        'testing_date'
        'testing_time_start'
        'vane_diameter'
        'vane_height'
        'vane_material'
        'shear_strength'
    };

    missing_cols = setdiff(required_cols, overview.Properties.VariableNames);

    if ~isempty(missing_cols)
        issues{end+1} = sprintf("Missing required columns in overview.csv: %s", strjoin(missing_cols, ', '));
    end

    % Show summary
    show_summary(folder, issues);

end

function show_summary(folder, issues)
    % Summary reporting helper (same style as other functions)
    fprintf("\n=== Validation report for %s ===\n", folder);

    if isempty(issues)
        fprintf("✅ Validation successful: Pocket share vane folder format is correct.\n\n");
    else
        fprintf("❌ Validation FAILED:\n");
        for i = 1:numel(issues)
            fprintf("   - %s\n", issues{i});
        end
        fprintf("\n");
    end
end
