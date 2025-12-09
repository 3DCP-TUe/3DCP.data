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
folder = uigetdir(); % Open a dialog to select the folder

if folder == 0
    error('No folder selected.');
end

% This function finds the folders with experiments in session folders.
% It checks the format of the processed data files, 
% if all files exists and contain the required columns.
% A provided folder can contain multiple data records, or
% you can just select one data record, or an individual session.
dfc_data.tests.check_format(folder)

%% End
disp('End')