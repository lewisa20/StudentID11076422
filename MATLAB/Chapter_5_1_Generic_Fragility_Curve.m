% MATLAB code to generate a generic fragility curve

% Define desired figure size in pixels
plotWidth = 450;   % Width in pixels
plotHeight = 400;  % Height in pixels

% Define the attack combinations (x-axis)
attack_combinations = linspace(1, 5, 100);

% Define the failure probability (y-axis) with a sigmoidal function
failure_probability = 0.1 + 0.8 * (1 ./ (1 + exp(-2.0 * (attack_combinations - 3.0)))); % Increased steepness and trimmed ends

% Trim the curve by limiting the values at both ends
failure_probability = max(0, min(1, failure_probability)); % Trimming

% Plotting the fragility curve
% Create figure with specified size and white background
figure('Color','w', 'Units','pixels', 'Position',[100 100 plotWidth plotHeight]);
plot(attack_combinations, failure_probability, 'k-', 'LineWidth', 2);
set(gcf, 'Color', 'white');
hold on;

% Labeling the axes
xlabel('Cumulative Attacks Against Company'); % Changed x-axis label
ylabel('Failure Probability');

% Setting the x-axis limits to shift the curve as requested
xlim([0.5, 5.5]);  % Expands the x-axis slightly at both ends

% Setting the y-axis limits from 0 to 1
ylim([0, 1]);  % Set the y-axis to range from 0 to 1

% Setting the x-axis ticks to match the provided categories
xticks([1, 2, 3, 4, 5]);
xticklabels({'Attack A', 'Attack B', 'Attack C', 'Attack D', 'Attack E'});



% Display the grid
grid on;

% Show the figure
hold off;

% Save the generated plot as a PNG file
saveas(gcf, 'img_chapter_5_1_generic_fragility_curve.png');