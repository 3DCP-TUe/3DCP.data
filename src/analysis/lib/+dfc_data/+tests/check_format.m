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

function check_format(folder)

    % tracer_experiment
    % List all folders
    folders_tracer_experiment = dfc_data.tests.find_folders_by_name_recursive(folder, 'tracer_experiment');
    % Loop through each folder path and perform data format check
    for i = 1:numel(folders_tracer_experiment)
        dfc_data.tests.check_format_tracer_experiment(folders_tracer_experiment{i});
    end

    % slugs_test
    % List all folders
    folders_slugs_test= dfc_data.tests.find_folders_by_name_recursive(folder, 'slugs_test');
    % Loop through each folder path and perform data format check
    for i = 1:numel(folders_slugs_test)
        dfc_data.tests.check_format_slugs_test(folders_slugs_test{i});
    end

    % compression_test
    % List all folders
    folders_compression_test= dfc_data.tests.find_folders_by_name_recursive(folder, 'compression_test');
    % Loop through each folder path and perform data format check
    for i = 1:numel(folders_compression_test)
        dfc_data.tests.check_format_compression_test(folders_compression_test{i});
    end

    % fpit
    % List all folders
    folders_fpit = dfc_data.tests.find_folders_by_name_recursive(folder, 'fpit');
    % Loop through each folder path and perform data format check
    for i = 1:numel(folders_fpit)
        dfc_data.tests.check_format_fpit(folders_fpit{i});
    end

    % pocket_shear_vane
    % List all folders
    folders_pocket_shear_vane = dfc_data.tests.find_folders_by_name_recursive(folder, 'pocket_shear_vane');
    % Loop through each folder path and perform data format check
    for i = 1:numel(folders_pocket_shear_vane)
        dfc_data.tests.check_format_pocket_share_vane(folders_pocket_shear_vane{i});
    end

    % temperature_point
    % List all folders
    folders_temperature_point = dfc_data.tests.find_folders_by_name_recursive(folder, 'temperature_point');
    % Loop through each folder path and perform data format check
    for i = 1:numel(folders_temperature_point)
        dfc_data.tests.check_format_temperature_point(folders_temperature_point{i});
    end

    % uuct
    % List all folders
    folders_uuct = dfc_data.tests.find_folders_by_name_recursive(folder, 'uuct');
    % Loop through each folder path and perform data format check
    for i = 1:numel(folders_uuct)
        dfc_data.tests.check_format_uuct(folders_uuct{i});
    end

    % uwtt
    % List all folders
    folders_uwtt = dfc_data.tests.find_folders_by_name_recursive(folder, 'uwtt');
    % Loop through each folder path and perform data format check
    for i = 1:numel(folders_uwtt)
        dfc_data.tests.check_format_uwtt(folders_uwtt{i});
    end
end