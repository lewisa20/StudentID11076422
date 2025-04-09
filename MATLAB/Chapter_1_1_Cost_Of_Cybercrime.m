% Adam Lewis 3rd Year Individual Project
% Student ID 11076422

% ChatGPT o3-mini-high was used to aid debugging and production of the 
% MATLAB visualisations in this project.

% MATLAB script to draw bachart
% Data source: https://www.statista.com/study/31368/cyber-security-of-companies-in-the-united-kingdom/ 

% Create figure
plotWidth = 500;   % Width in pixels
plotHeight = 400;  % Height in pixels
figure('Color','w', 'Units','pixels', 'Position',[100 100 plotWidth plotHeight]);

% Define the data for plot
years = 2017:2028;
costs = [16.6, 19.5, 22.9, 27.0, 31.9, 37.5, 44.1, 51.8, 60.8, ...
         71.4, 83.8, 98.1];

% Create bar chart
hBar = bar(years, costs, 'FaceColor',[0.0 0.45 0.9]);
hold on;

% Format x/y axis
xlabel('Year');
ylabel('Cost (in billion U.S. dollars)');
xticks(years);

% Set y-axis limits
ylim([0 120]);

% Add text labels to each bar
for i = 1:length(costs)
    text(years(i), costs(i), sprintf('%.1f', costs(i)), ...
        'HorizontalAlignment','center', ...
        'VerticalAlignment','bottom', ...
        'FontSize', 9, ...
        'Color','k');
end

grid on;
hold off;

% trim whitespace around exterior of plot
ax = gca;
ti = get(ax, 'TightInset');
set(ax, 'LooseInset', [ti(1) + 0.02, ti(2) + 0.02, ti(3) + 0.02, ti(4) + 0.02]);

% Save plot image
saveas(gcf, 'img_chapter_1_1_cost_of_cybercrime_UK.png');
