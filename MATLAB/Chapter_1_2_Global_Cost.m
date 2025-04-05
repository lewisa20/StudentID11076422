% Define desired figure size in pixels
plotWidth = 500;   % Width in pixels
plotHeight = 400;  % Height in pixels

% Create figure with specified size and white background
figure('Color','w', 'Units','pixels', 'Position',[100 100 plotWidth plotHeight]);

% 1) Define the data (in million U.S. dollars)
years = 2018:2029;
costs = [0.86, 1.16, 2.95, 5.49, 7.08, 8.15, 9.22, 10.29, 11.36, 12.43, 13.82, 15.63];

% 2) Create the bar chart
% Try a shade of blue similar to the provided image
barColor = [0.00 0.45 0.90];  % Adjust if needed
hBar = bar(years, costs, 'FaceColor', barColor);
hold on;  % Hold the current plot so we can add text

% 3) Format the axes
xlabel('Year');
ylabel('Cost (in trillion U.S. dollars)');
xticks(years);

% Set the y-axis range to accommodate the highest bar comfortably
ylim([0 17.5]);

% Turn on the grid
grid on;

% 4) Add text labels above each bar
for i = 1:length(costs)
    text(years(i), costs(i), sprintf('%.1f', costs(i)), ...
        'HorizontalAlignment','center', ...
        'VerticalAlignment','bottom', ...
        'FontSize', 9, ...
        'Color','k');
end

hold off;  % Release the plot

% 5) Save the generated plot as a PNG file
saveas(gcf, 'img_chapter_1_2_cost_of_cybercrime_global.png');
