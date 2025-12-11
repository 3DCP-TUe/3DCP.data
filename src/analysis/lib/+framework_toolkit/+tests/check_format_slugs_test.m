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

function check_format_slugs_test(folder)
%CHECK_FORMAT_SLUGS_TEST Validate folder structure for slugs_test data format.
%
% This function checks whether the slugs_test processed_data folder contains
% the required CSV files and whether each file (when present) has the
% correct columns.
%
% Unlike other tests, slugs_test may contain optional files depending on
% whether a camera was used.
%
% Required file:
%   yield_stress.csv
%
% Optional files:
%   mass_flow.csv
%   volumes.csv
%   volumes_grouped.csv
%   volumetric_flow.csv
%
% The function prints validation results instead of throwing errors.
%
% Syntax: check_format_slugs_test(folder)
%
% Example:
%   check_format_slugs_test("C:\data\slugs_test")
%
%------------- BEGIN CODE -----------------

    issues = {};
    status_ok = true; % track if everything passes

    % Validate folder
    if ~isfolder(folder)
        issues{end+1} = sprintf("❌ Invalid folder: %s\n", folder);
        return;
    end

    processed_data = fullfile(folder, "processed_data");

    if ~isfolder(processed_data)
        issues{end+1} = sprintf("❌ Missing subfolder: processed_data\n");
        return;
    end

    % Required file: yield_stress.csv
    file = fullfile(processed_data, "yield_stress.csv");
    if ~isfile(file)
        issues{end+1} = sprintf("❌ Missing required file: yield_stress.csv\n");
        status_ok = false;
    else
        required_cols = {'time','droplet_mass','yield_stress'};
        [ok, issues] = check_file_columns(file, required_cols, issues);
        status_ok = ok && status_ok;
    end

    % Optional files
    % mass_flow.csv
    % volumes.csv
    % volumes_grouped.csv
    % volumetric_flow.csv

    optional_files = {
        "mass_flow.csv",          {'deposition_time_start','deposition_time_mid','deposition_time_end','mass_flow'};
        "volumes.csv",            {'time','droplet_volume'};
        "volumes_grouped.csv",    {'time','mean_droplet_volume','std_droplet_volume'};
        "volumetric_flow.csv",    {'deposition_time_start','deposition_time_mid','deposition_time_end','volumetric_flow_rate'};
    };

    for i = 1:size(optional_files,1)
        filename = optional_files{i,1};
        required_cols = optional_files{i,2};
        fpath = fullfile(processed_data, filename);

        if isfile(fpath)
            issues{end+1} = sprintf("Optional file found: %s\n", filename);
            [ok, issues] = check_file_columns(fpath, required_cols, issues);
            status_ok = ok && status_ok;
        else
            issues{end+1} = sprintf("Optional file NOT found: %s (OK)\n", filename);
        end
    end

    % FINAL REPORT
    % Output final summary
    show_summary(folder, issues, status_ok);
end

% Helper function: check columns
function [ok, issues] = check_file_columns(filepath, required_columns, issues)
    ok = true;
    data = readtable(filepath);

    missing = setdiff(required_columns, data.Properties.VariableNames);

    if isempty(missing)
        issues{end+1} = sprintf("✅ %s columns (OK)\n", filepath);
    else
        issues{end+1} = sprintf("❌ %s missing columns: %s\n", filepath, strjoin(missing, ", "));
        ok = false;
    end
end

function show_summary(folder, issues, status_ok)
    fprintf("\n=== Validation report for %s ===\n", folder);

    if status_ok
        fprintf("✅ Validation successful: Slugs test folder format is correct.");
    else
        fprintf("❌ Validation FAILED:");
    end

    for i = 1:numel(issues)
            fprintf("   - %s", issues{i});
    end
    sprintf("\n \n");
end

