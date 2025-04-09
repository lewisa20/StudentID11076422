% Adam Lewis 3rd Year Individual Project
% Student ID 11076422

% ChatGPT o3-mini-high was used to aid debugging and production of the 
% MATLAB visualisations in this project.

% MATLAB code to generate a generic fragility curve

plotWidth = 500;   % Width in pixels
plotHeight = 400;  % Height in pixels

% Define intensity measure x as attack combos
attack_combinations = linspace(1, 5, 100);

% Define the failure probability (y-axis) with a sigmoidal function
failure_probability = 0.1 + 0.8 * (1 ./ (1 + exp(-2.0 * (attack_combinations - 3.0))));
failure_probability = max(0, min(1, failure_probability)); 

% Create figure
figure('Color','w', 'Units','pixels', 'Position',[100 100 plotWidth plotHeight]);

% Plot the fragility curve
plot(attack_combinations, failure_probability, 'k-', 'LineWidth', 2);
hold on;

% define intensity x where dots appear
dot_x = [1, 2, 3, 4, 5];

% get y values for dots at dot_x
dot_y = 0.1 + 0.8 * (1 ./ (1 + exp(-2.0 * (dot_x - 3.0))));
dot_y = max(0, min(1, dot_y));  % trim to [0,1] if needed

% Plot the red dots
plot(dot_x, dot_y, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');


% text labels for dots
text(dot_x(1) + 0.15, dot_y(1) -0.02, 'Initial Access', ...
    'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', 'Color', 'r');
text(dot_x(2) + 0.15, dot_y(2), 'Defense Evasion', ...
    'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', 'Color', 'r');
text(dot_x(3) - 0.15, dot_y(3), 'Lateral Movement', ...
    'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', 'Color', 'r');
text(dot_x(4) - 0.15, dot_y(4), 'Command & Control', ...
    'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', 'Color', 'r');
text(dot_x(5) - 0.15, dot_y(5) +0.02, 'Critical Impact', ...
    'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', 'Color', 'r');

% Label the main axis
xlabel('Attacks Moving Deeper in Purdue Model (x)');
ylabel('Probability of Comprimise (P)');

% Adjust axis limits
xlim([0.5, 5.5]);
ylim([0, 1]);

% Set bottom x-axis ticks/labels
xticks([1, 2, 3, 4, 5]);
xticklabels({'Level 5', 'Level 4', 'Level 3', 'Level 2', 'Level 1/0'});

grid on;
hold off;

% trim whitespace arund exterior of plot
ax = gca;
ti = get(ax, 'TightInset');
set(ax, 'LooseInset', [ti(1) + 0.02, ti(2) + 0.02, ti(3) + 0.05, ti(4) + 0.02]);

% save plot
saveas(gcf, 'img_chapter_5_3_generic_fragility_curve_events.png');
