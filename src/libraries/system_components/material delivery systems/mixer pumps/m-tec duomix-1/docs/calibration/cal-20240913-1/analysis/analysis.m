% SPDX-License-Identifier: GPL-3.0-or-later
% 3DCP.data
% Project: https://github.com/3DCP-TUe/3DCP.data
%
% Copyright (c) 2026 Eindhoven University of Technology
%
% Authors:
%   - Arjen Deetman (2026)
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

%% Import data

cd('..');
data = readtable('data.csv');

%% Correlation: flowrate-valve-fit

for i = [21, 7]

    fig = default_layout();
    
    % Plot data
    ind = data.temperature == i;
    x = data.valve_position(ind);
    y = data.mass_flowrate(ind);
    plot(x, y, '.', 'Color', 'k', 'MarkerSize', 24)
    
    % Fit trend line
    [f, g] = fit(x,y,'poly1');
    x_fit = min(x):(max(x)-min(x))/10:max(x);
    y_fit = feval(f, x_fit);
    plot(x_fit, y_fit, '--k', 'LineWidth', 1.5)
    
    % Add to figure
    eqn_text = sprintf('$y = %.4f \\cdot x + %.4f$', f.p1, f.p2);
    r2_text = sprintf('$R^2_{adj} = %.3f$', g.adjrsquare);
    text(0.25, 0.65, eqn_text, 'Units', 'normalized', 'Interpreter', 'latex', 'FontSize', 18, 'HorizontalAlignment', 'center');
    text(0.25, 0.55, r2_text, 'Units', 'normalized', 'Interpreter', 'latex', 'FontSize', 18, 'HorizontalAlignment', 'center');
    
    % Layout
    xlim([0 40])
    ylim([0 8])
    xlabel('Valve position [\%]', 'interpreter', 'latex');
    ylabel('Mass flowrate [kg/min]', 'interpreter', 'latex');
    
    % Save figure
    cd(filepath);
    if i == 21
        save_figure(fig, 'flowrate-valve-fit-room-temperature')
    else
        save_figure(fig, 'flowrate-valve-fit-cold')
    end
end

%% Correlation: valve-flowrate-fit

for i = [21, 7]

    fig = default_layout();
    
    % Plot data
    ind = data.temperature == i;
    y = data.valve_position(ind);
    x = data.mass_flowrate(ind);
    plot(x, y, '.', 'Color', 'k', 'MarkerSize', 24)
    
    % Fit trend line
    [f, g] = fit(x,y,'poly1');
    x_fit = min(x):(max(x)-min(x))/10:max(x);
    y_fit = feval(f, x_fit);
    plot(x_fit, y_fit, '--k', 'LineWidth', 1.5)
    
    % Add to figure
    eqn_text = sprintf('$y = %.4f \\cdot x %.4f$', f.p1, f.p2);
    r2_text = sprintf('$R^2_{adj} = %.3f$', g.adjrsquare);
    text(0.25, 0.65, eqn_text, 'Units', 'normalized', 'Interpreter', 'latex', 'FontSize', 18, 'HorizontalAlignment', 'center');
    text(0.25, 0.55, r2_text, 'Units', 'normalized', 'Interpreter', 'latex', 'FontSize', 18, 'HorizontalAlignment', 'center');
    
    % Layout
    ylim([0 40])
    xlim([0 8])
    ylabel('Valve position [\%]', 'interpreter', 'latex');
    xlabel('Mass flowrate [kg/min]', 'interpreter', 'latex');
    
    % Save figure
    cd(filepath);
    if i == 21
        save_figure(fig, 'valve-flowrate-fit-room-temperature')
    else
        save_figure(fig, 'valve-flowrate-fit-cold')
    end
end

%% End
disp('End of script')

%% Functions

% Figure layout
function fig = default_layout()
    fig = figure;
    hold on
    grid on
    box on
    set(gca, 'FontSize', 24);
    set(gca,'YColor',[0,0,0])
    set(gca,'XColor',[0,0,0])
    set(gcf, 'PaperUnits', 'inches');
    set(gcf, 'Units', 'inches');
    fig_width = 4^(3/2);
    fig_height = 3^(3/2);
    set(gcf, 'PaperPosition', [0 0 fig_width fig_height]); 
    set(gcf, 'PaperSize', [fig_width fig_height]); 
    set(gcf, 'Position', [1 1 fig_width, fig_height]);
end

% Write figure
function [] = save_figure(fig, name) 
    width = fig.Position(3);
    height = fig.Position(4);
    set(gcf, 'PaperPosition', [0 0 width height]);
    set(gcf, 'PaperSize', [width height]); 
    saveas(fig, name, 'pdf')
end