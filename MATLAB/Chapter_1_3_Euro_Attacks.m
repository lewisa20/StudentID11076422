% Adam Lewis 3rd Year Individual Project
% Student ID 11076422

% ChatGPT o3-mini-high was used to aid debugging and production of the 
% MATLAB visualisations in this project.

% MATLAB script to draw bachart
% Data source: https://sektorcert.dk/wp-content/uploads/2022/09/Attacks-against-European-energy-and-utility-companies-2020-09-05-v3.pdf 

% Create figure
plotWidth = 450;   % Width in pixels
plotHeight = 400;  % Height in pixels
figure('Color','w', 'Units','pixels', 'Position',[100 100 plotWidth plotHeight]);

% Data labels and values
years = 2015:2022;
attacks = [1, 1, 2, 1, 3, 10, 10, 20]; 

% Create the bar chart
hBar = bar(years, attacks, 'FaceColor',[0.0 0.45 0.9]);
hold on;

% Label axes
xlabel('Year');
ylabel('Number of successful attacks per year');

% Set x-axis ticks and y-axis range
xticks(years);
ylim([0 25]); 

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

% trim whitespace around exterior of plot
ax = gca;
ti = get(ax, 'TightInset');
set(ax, 'LooseInset', [ti(1) + 0.02, ti(2) + 0.02, ti(3) + 0.02, ti(4) + 0.02]);

% Save the plot as an img
saveas(gcf, 'img_chapter_1_3_euro_attacks_per_year.png');
