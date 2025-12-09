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

%% Get session data

% Folder path to setupinfo of data record (destination)
cd(filepath);
cd('test/system_components')
setupinfo = pwd;

% Read session metadata file
cd(filepath);
cd('../template/yyyymmdd_session_1/')
metadata = dfc_data.readyaml(pwd + "/system_data/setupinfo/metadata.yml");

%% Check IO

for i = 1:length(metadata.io_configuration)
    component = metadata.io_configuration{i}.component;
    
    for j = 1:length(metadata.io_configuration{i}.channels)
        
        % Info from host
        host = metadata.io_configuration{i}.component;
        host_channel = metadata.io_configuration{i}.channels{j}.name; % Look in host metatdata to look up this channel details

        % Info from client
        client = metadata.io_configuration{i}.channels{j}.component;
        client_channel = metadata.io_configuration{i}.channels{j}.channel; % Look in client metatdata to look up this channel details: e.g., signal conversion factors.

    end
end

%% End
disp('End')