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

%% Check format of files in processed data folders of experiments

% Folder path
folder = uigetdir(); % Open a dialog to select the data record root folder
%folder = 'D:\OneDrive - TU Eindhoven\99_Project Vivaldi\05 Data records\data_record_1_tracer_experiments\v1.x.x';
%folder = 'D:\OneDrive - TU Eindhoven\99_Project Vivaldi\05 Data records\data_record_2_hardened_state_strength\v1.x.x';
%folder = 'D:\OneDrive - TU Eindhoven\99_Project Vivaldi\05 Data records\data_record_3_indentation_test\v1.0.0';
%folder = 'D:\OneDrive - TU Eindhoven\99_Project Vivaldi\05 Data records\data_record_4_frankenstein\v1.0.0';

if folder == 0
    error('No folder selected.');
end

% Run test methods
framework_toolkit.tests.test_data_record_root(folder);
framework_toolkit.tests.test_session_folders(folder);
framework_toolkit.tests.test_data_record_sessions(folder);

%% End
disp('End')