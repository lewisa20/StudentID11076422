% Adam Lewis 3rd Year Individual Project
% Student ID 11076422

% ChatGPT o3-mini-high was used to aid debugging and production of the 
% MATLAB visualisations in this project.

% MATLAB code to generate a generic fragility curve

plotWidth = 450;   % Width in pixels
plotHeight = 400;  % Height in pixels

% Define the attack combinations (x-axis)
attack_combinations = linspace(1, 5, 100);

% Define the failure probability (y-axis) with a sigmoidal function
failure_probability = 0.1 + 0.8 * (1 ./ (1 + exp(-2.0 * (attack_combinations - 3.0))));

% Trim the curve
failure_probability = max(0, min(1, failure_probability));

% Plot the fragility curve
figure('Color','w', 'Units','pixels', 'Position',[100 100 plotWidth plotHeight]);
plot(attack_combinations, failure_probability, 'k-', 'LineWidth', 2);
set(gcf, 'Color', 'white');
hold on;

% Label axes
xlabel('Cumulative Attacks Against Company (x)'); % Changed x-axis label
ylabel('Failure Probability (P)');

% x-axis limits
xlim([0.5, 5.5]); 

% y-axis limits
ylim([0, 1]); 

% x-axis ticks to match labels
xticks([1, 2, 3, 4, 5]);
xticklabels({'Attack A', 'Attack B', 'Attack C', 'Attack D', 'Attack E'});

grid on;
hold off;

% trim whitespace arund exterior of plot
ax = gca;
ti = get(ax, 'TightInset');
set(ax, 'LooseInset', [ti(1) + 0.02, ti(2) + 0.02, ti(3) + 0.06, ti(4) + 0.02]);

% Save the plot img
saveas(gcf, 'img_chapter_5_1_generic_fragility_curve.png');