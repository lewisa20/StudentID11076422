% Define desired figure size in pixels
plotWidth = 500;   % Width in pixels
plotHeight = 400;  % Height in pixels

% Define the attack combinations (x-axis)
attack_combinations = linspace(1, 5, 100);

% Define the failure probability (y-axis) with a sigmoidal function
failure_probability = 0.1 + 0.8 * (1 ./ (1 + exp(-2.0 * (attack_combinations - 3.0))));
failure_probability = max(0, min(1, failure_probability));  % Ensure values are within [0,1]

% Create figure with white background
figure('Color','w', 'Units','pixels', 'Position',[100 100 plotWidth plotHeight]);

% Plot the fragility curve on the main (bottom) axis
plot(attack_combinations, failure_probability, 'k-', 'LineWidth', 2);
hold on;

% -------------------------------------------------------------------------
% ADD RED DOTS & LABELS
% Choose x-values where you want to place dots
dot_x = [1, 2, 3, 4, 5];

% Compute corresponding y-values using the same fragility function
dot_y = 0.1 + 0.8 * (1 ./ (1 + exp(-2.0 * (dot_x - 3.0))));
dot_y = max(0, min(1, dot_y));  % trim to [0,1] if needed

% Plot the red dots
plot(dot_x, dot_y, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');


% Place each label at (x + offset, y) with vertical alignment = middle
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
% -------------------------------------------------------------------------

% Label the main (bottom) axis
xlabel('Attacks Moving Deeper in Purdue Model');
ylabel('Probability of Comprimise');

% Adjust axis limits
xlim([0.5, 5.5]);
ylim([0, 1]);

% Set bottom x-axis ticks/labels
xticks([1, 2, 3, 4, 5]);
xticklabels({'Level 5', 'Level 4', 'Level 3', 'Level 2', 'Level 1/0'});

grid on;

hold off;

saveas(gcf, 'img_chapter_5_3_generic_fragility_curve_events.png');
