% SPDX-License-Identifier: GPL-3.0-or-later
% 3DCP.data
% Project: https://github.com/3DCP-TUe/3DCP.data
%
% Copyright (c) 2024-2025 Eindhoven University of Technology
%
% Authors:
%   - Arjen Deetman (2024-2025)
%
% For license details, see the LICENSE file in the project root.

%% Clear and close
close all; 
clear;
clc;

%% Get file path
path = mfilename('fullpath');
[filepath, name, ext] = fileparts(path);
cd(filepath);

%% Add lib
addpath('lib');

%% Read file

cd(filepath)
cd("..\template\yyyymmdd_session_1\tracer_experiment\setupinfo")
file = pwd + "\metadata.yml";
yml = dfc_data.readyaml(file);
fields = fieldnames(yml.software_settings.white_balance_ratio);

for i = 1:numel(fields)
    field_name = fields{i};
    field_value = yml.software_settings.white_balance_ratio.(field_name);
    fprintf('%s: %f\n', field_name, field_value);
end


%% End

disp('End')

