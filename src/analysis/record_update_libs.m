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

%% Update libs 

% Directory of library
%library = uigetdir(); % Open a dialog to select the folder
%library = 'D:\OneDrive - TU Eindhoven\Paper - Indentation test - clean\fem\flat punch\lib\+indent';
%library = 'D:\GitHub\3DCP.data\src\analysis\lib\+dfc_data';
%library = 'D:\GitHub\ConcreteCandyTracker\src\analysis\lib\+candy';
library = 'D:\GitHub\Node-RED-3DSeeP\src\analysis\lib\+nr3dseep';

% Directory of record
%record = uigetdir(); % Open a dialog to select the folder
record = 'D:\OneDrive - TU Eindhoven\99_Project Vivaldi\05 Data records' ;

% Apply
dfc_data.copy_to_matching_folders(library, record, true)

%% End
disp('End')

