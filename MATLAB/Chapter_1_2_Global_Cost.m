% Adam Lewis 3rd Year Individual Project
% Student ID 11076422

% ChatGPT o3-mini-high was used to aid debugging and production of the 
% MATLAB visualisations in this project.

% MATLAB script to draw bachart
% Data source: https://www-statista-com.manchester.idm.oclc.org/forecasts/1280009/cost-cybercrime-worldwide

% Create figure
plotWidth = 500;   % Width in pixels
plotHeight = 400;  % Height in pixels
figure('Color','w', 'Units','pixels', 'Position',[100 100 plotWidth plotHeight]);

% Define the data for plot
years = 2018:2029;
costs = [0.86, 1.16, 2.95, 5.49, 7.08, 8.15, 9.22, 10.29, 11.36, 12.43, 13.82, 15.63];

% Create bar chart
hBar = bar(years, costs, 'FaceColor', [0.00 0.45 0.90]);
hold on;

% Format x/y axis
xlabel('Year');
ylabel('Cost (in trillion U.S. dollars)');
xticks(years);

% Set y-axis limits
ylim([0 17.5]);

grid on;

% Add text labels to each bar
for i = 1:length(costs)
    text(years(i), costs(i), sprintf('%.1f', costs(i)), ...
        'HorizontalAlignment','center', ...
        'VerticalAlignment','bottom', ...
        'FontSize', 9, ...
        'Color','k');
end

hold off;


% trim whitespace arund exterior of plot
ax = gca;
ti = get(ax, 'TightInset');
set(ax, 'LooseInset', [ti(1) + 0.02, ti(2) + 0.02, ti(3) + 0.02, ti(4) + 0.02]);
% Save plot image
saveas(gcf, 'img_chapter_1_2_cost_of_cybercrime_global.png');
