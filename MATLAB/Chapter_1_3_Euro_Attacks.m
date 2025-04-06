% Define the desired figure size in pixels
plotWidth = 450;   % Width in pixels
plotHeight = 400;  % Height in pixels

% Create figure with specified size and white background
figure('Color','w', 'Units','pixels', 'Position',[100 100 plotWidth plotHeight]);

% Example data (years and number of successful attacks)
years = 2015:2022;
attacks = [1, 1, 2, 1, 3, 10, 10, 20];  % Adjust as needed

% Create the bar chart
hBar = bar(years, attacks, 'FaceColor',[0.0 0.45 0.9]);
hold on;

% Label axes
xlabel('Year');
ylabel('Number of successful attacks per year');

% Set x-axis ticks and y-axis range
xticks(years);
ylim([0 25]);  % Adjust if you need a higher or lower maximum

% Turn on grid lines
grid on;

% Add numeric values on top of each bar
for i = 1:length(attacks)
    text(years(i), attacks(i), sprintf('%d', attacks(i)), ...
        'HorizontalAlignment','center', ...
        'VerticalAlignment','bottom', ...
        'FontSize',9);
end

hold off;

% Save the generated plot as a PNG file
saveas(gcf, 'img_chapter_1_3_euro_attacks_per_year.png');
