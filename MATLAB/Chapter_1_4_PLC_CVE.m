% Adam Lewis 3rd Year Individual Project
% Student ID 11076422

% ChatGPT o3-mini-high was used to aid debugging and production of the 
% MATLAB visualisations in this project.

% MATLAB script to draw bachart
% Data source: https://www.cve.org

% Create figure
plotWidth = 400;   % Width in pixels
plotHeight = 400;  % Height in pixels
figure('Color','w', 'Units','pixels', 'Position',[100 100 plotWidth plotHeight]);

% Data labels and values
labels = { ...
    'Honeywell\newlineExperion', ...
    'Mitsubishi\newlineMELSEC', ...
    'Rockwell\newlineControlLogix', ...
    'Siemens\newlineSIMATIC-S7', ...
    'Schneider\newlineModicon'};
values = [18, 77, 33, 29, 31];

% Plot the bar chart
hBar = bar(values, 'FaceColor',[0.0 0.45 0.9]);
hold on;

% Configure x-axis ticks and labels
xticks(1:length(values));
set(gca, 'XTickLabel', labels, 'TickLabelInterpreter','tex'); 
xtickangle(90);  % Angle labels verticaly

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

% trim whitespace arund exterior of plot
ax = gca;
ti = get(ax, 'TightInset');
set(ax, 'LooseInset', [ti(1) + 0.02, ti(2) + 0.02, ti(3) + 0.02, ti(4) + 0.02]);

% Save the plot as an img
saveas(gcf, 'img_chapter_1_4_plc_cve.png');
