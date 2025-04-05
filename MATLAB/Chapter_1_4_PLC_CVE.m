% Define desired figure size in pixels
plotWidth = 400;   % Width in pixels
plotHeight = 400;  % Height in pixels

% Create figure with specified size
figure('Color','w', 'Units','pixels', 'Position',[100 100 plotWidth plotHeight]);

% Data (example values)
labels = { ...
    'Honeywell\newlineExperion', ...
    'Mitsubishi\newlineMELSEC', ...
    'Rockwell\newlineControlLogix', ...
    'Siemens\newlineSIMATIC-S7', ...
    'Schneider\newlineModicon'};
values = [18, 77, 33, 29, 31];  % Example CVE counts

% Plot the bar chart
hBar = bar(values, 'FaceColor',[0.0 0.45 0.9]);
hold on;

% Configure x-axis ticks and labels
xticks(1:length(values));
set(gca, 'XTickLabel', labels, 'TickLabelInterpreter','tex');  % Enable line breaks with \newline
xtickangle(90);  % Angle labels so they remain legible when the graph is shrunk in the x-dimension

% Set axis labels and limits
xlabel('PLC Manufacturer and Range');
ylabel('Number of Known CVE');
ylim([0 90]);  % Y-axis from 0 to 90
grid on;

% Add numeric value on top of each bar
for i = 1:length(values)
    text(i, values(i), sprintf('%d', values(i)), ...
        'HorizontalAlignment','center', ...
        'VerticalAlignment','bottom', ...
        'FontSize',9);
end

hold off;

% Save the generated plot as a PNG file
saveas(gcf, 'img_chapter_1_4_plc_cve.png');
