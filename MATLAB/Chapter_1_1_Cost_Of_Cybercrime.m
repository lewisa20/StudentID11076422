% Define desired figure size in pixels
plotWidth = 500;   % Width in pixels
plotHeight = 400;  % Height in pixels

% Create figure with specified size and white background
figure('Color','w', 'Units','pixels', 'Position',[100 100 plotWidth plotHeight]);

% 1) Define the data
years = 2017:2028;
costs = [16.6, 19.5, 22.9, 27.0, 31.9, 37.5, 44.1, 51.8, 60.8, ...
         71.4, 83.8, 98.1];  % in billion U.S. dollars

% 2) Create the bar chart
hBar = bar(years, costs, 'FaceColor',[0.0 0.45 0.9]);
hold on;  % Hold the current plot so we can add text

% 3) Format the axes
% title('Estimated Annual Cost of Cybercrime in the UK (2017–2028)');
xlabel('Year');
ylabel('Cost (in billion U.S. dollars)');
xticks(years);

% Set the y-axis range
ylim([0 120]);

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

% Save the generated plot as a PNG file
saveas(gcf, 'img_chapter_1_1_cost_of_cybercrime_UK.png');
