% Adam Lewis 3rd Year Individual Project
% Student ID 11076422

% ChatGPT o3-mini-high was used to aid debugging and production of the 
% MATLAB visualisations in this project.

% MATLAB code to generate a generic fragility curve

% Define desired figure size in pixels
plotWidth = 450;   % Width in pixels
plotHeight = 400;  % Height in pixels

% Define the attack combinations (x-axis)
attack_combinations = linspace(1, 5, 100);

% Define the failure probability (y-axis) with a sigmoidal function
failure_probability = 0.1 + 0.8 * (1 ./ (1 + exp(-2.0 * (attack_combinations - 3.0)))); % Increased steepness and trimmed ends

% Trim the curve by limiting the values at both ends
failure_probability = max(0, min(1, failure_probability));

% Create figure
figure('Color','w', 'Units','pixels', 'Position',[100 100 plotWidth plotHeight]);
plot(attack_combinations, failure_probability, 'k-', 'LineWidth', 2);
set(gcf, 'Color', 'white');
hold on;

% Label the axes
xlabel('Attacks Moving Deeper in Purdue Model (x)'); % Changed x-axis label
ylabel('Failure Probability (P)');

% Set the x-axis limits
xlim([0.5, 5.5]);

% Set the y-axis limits
ylim([0, 1]);

% Set the x-axis ticks
xticks([1, 2, 3, 4, 5]);
xticklabels({'Level 5', 'Level 4', 'Level 3', 'Level 2', 'Level 1/0'});

grid on;
hold off;

% trim whitespace arund exterior of plot
ax = gca;
ti = get(ax, 'TightInset');
set(ax, 'LooseInset', [ti(1) + 0.02, ti(2) + 0.02, ti(3) + 0.02, ti(4) + 0.02]);

% Save plot
saveas(gcf, 'img_chapter_5_2_generic_fragility_curve_purdue.png');
