% Adam Lewis 3rd Year Individual Project

% MATLAB script to generate fragility curves using
% Log Normal Cumulative Distribution Function from mean
% and standard deviation obtained from discrete model

% This script is used to generate 2 curves:
%   Company B: High Resilience Modelled Company from simulated model inputs
%   Company C: Low Resilience Modelled Company from simulated model inputs
% and overlays them with shaded bands depicting the relative risk
% of the 5 layers of the Purdue Model of a substation:

% Define desired figure size in pixels
plotWidth = 550;   % Width in pixels
plotHeight = 565;  % Height in pixels

% NEW MODEL
m_norm_B = 1.8294;    % High resilience Modelled Company Normalised & scaled mean
s_norm_B = 0.6988;    % High resilience Modelled Company Normalised std deviation
m_norm_C = 1.4577;    % Low Resilience Modelled Company Normalised & scaled mean
s_norm_C = 0.4902;    % Low Resilience Modelled Company Normalised std deviation

% Convert mean and std to beta/theta for companies B and C
beta_B = sqrt(log(1 + (s_norm_B/m_norm_B)^2));
theta_B = m_norm_B * exp(-0.5 * beta_B^2);
beta_C = sqrt(log(1 + (s_norm_C/m_norm_C)^2));
theta_C = m_norm_C * exp(-0.5 * beta_C^2);

% Define Intensity Measure X
x = linspace(0, 4, 100); 

% Use normcdf to generate fragility curves
P_CompanyB = normcdf((log(x / theta_B)) / beta_B);
P_CompanyC = normcdf((log(x / theta_C)) / beta_C);

% Plot fragility curves
figure('Color','w', 'Units','pixels', 'Position',[100 100 plotWidth plotHeight]);
hHR = plot(x, P_CompanyB, 'g-', 'LineWidth', 1); hold on;
hLR = plot(x, P_CompanyC, 'r-', 'LineWidth', 1);
xlabel('Cyber Attack Severity');
ylabel('Probability of Compromise');
set(gcf, 'Color', 'white');
grid on;

% Get the current y-axis limits
yl = ylim;
% Get vertical midpint for text labels within bands
yMid = mean(yl); 

% Define colors for each band
colorP5 = [0.85 0.85 0.85]; 
colorP4 = [0.75 0.75 0.75]; 
colorP3 = [0.64 0.64 0.64]; 
colorP2 = [0.52 0.52 0.52]; 
colorP1 = [0.40 0.40 0.40];

% Purdue Level 5 Band P5:
x_startP5 = 0.35;
x_endP5   = x_startP5 + 0.55;
hP5 = patch([x_startP5 x_endP5 x_endP5 x_startP5], [yl(1) yl(1) yl(2) yl(2)], ...
    colorP5, 'FaceAlpha', 0.3, 'EdgeColor', 'none', 'DisplayName', 'Purdue Level 5');
x_midP5 = (x_startP5 + x_endP5)/2;  % Midpoint in x
text(x_midP5, yMid, 'Purdue Level 5', ...
    'Rotation', 90, 'HorizontalAlignment','center','VerticalAlignment','middle');

% Purdue Level 4 Band P4:
x_startP4 = x_endP5;
x_endP4   = x_startP4 + 0.55;
hP4 = patch([x_startP4 x_endP4 x_endP4 x_startP4], [yl(1) yl(1) yl(2) yl(2)], ...
    colorP4, 'FaceAlpha', 0.3, 'EdgeColor', 'none', 'DisplayName', 'Purdue Level 4');
x_midP4 = (x_startP4 + x_endP4)/2;
text(x_midP4, yMid, 'Purdue Level 4', ...
    'Rotation', 90, 'HorizontalAlignment','center','VerticalAlignment','middle');

% Purdue Level 3 Band P3:
x_startP3 = x_endP4;
x_endP3   = x_startP3 + 0.55;
hP3 = patch([x_startP3 x_endP3 x_endP3 x_startP3], [yl(1) yl(1) yl(2) yl(2)], ...
    colorP3, 'FaceAlpha', 0.3, 'EdgeColor', 'none', 'DisplayName', 'Purdue Level 3');
x_midP3 = (x_startP3 + x_endP3)/2;
text(x_midP3, yMid, 'Purdue Level 3', ...
    'Rotation', 90, 'HorizontalAlignment','center','VerticalAlignment','middle');

% Purdue Level 2 Band P2:
x_startP2 = x_endP3;
x_endP2   = x_startP2 + 0.55;
hP2 = patch([x_startP2 x_endP2 x_endP2 x_startP2], [yl(1) yl(1) yl(2) yl(2)], ...
    colorP2, 'FaceAlpha', 0.3, 'EdgeColor', 'none', 'DisplayName', 'Purdue Level 2');
x_midP2 = (x_startP2 + x_endP2)/2;
text(x_midP2, yMid, 'Purdue Level 2', ...
    'Rotation', 90, 'HorizontalAlignment','center','VerticalAlignment','middle');

% Purdue Level 1 Band P1:
x_startP1 = x_endP2;
x_endP1   = x_startP1 + 0.55;
hP1 = patch([x_startP1 x_endP1 x_endP1 x_startP1], [yl(1) yl(1) yl(2) yl(2)], ...
    colorP1, 'FaceAlpha', 0.3, 'EdgeColor', 'none', 'DisplayName', 'Purdue Level 1/0');
x_midP1 = (x_startP1 + x_endP1)/2;
text(x_midP1, yMid, 'Purdue Level 1/0', ...
    'Rotation', 90, 'HorizontalAlignment','center','VerticalAlignment','middle');

% Draw dashed vertical lines at the band boundaries
boundaries = [x_startP5, x_endP5, x_endP4, x_endP3, x_endP2, x_endP1];
for j = 1:length(boundaries)
    xline(boundaries(j), 'k--', 'LineWidth', 1.2);
end

% Add leged for curves and the 5 purdue bands
legendHandles = [hHR, hLR, hP5, hP4, hP3, hP2, hP1];
legendLabels  = {
    'High Resilience Company', ...
    'Low Resilience Company', ...
    'Purdue Level 5', 'Purdue Level 4', 'Purdue Level 3', ...
    'Purdue Level 2', 'Purdue Level 1/0'
};
legend(legendHandles, legendLabels, 'Location','southeast');

% Text box for mean and SD inputs
annotation_str = {...
    sprintf('High Resilience: m = %.4f, sd = %.4f', m_norm_B, 1-s_norm_B), ...
    sprintf('Low Resilience: m = %.4f, sd = %.4f', m_norm_C, 1-s_norm_C)}; ...
annotation('textbox', [0.49, 0.10, 0.5, 0.3], 'String', annotation_str, ...
           'FitBoxToText', 'on', 'EdgeColor', 'black', ...
           'BackgroundColor', 'white');

hold off;
ax = gca;
ti = get(ax, 'TightInset');
% Increase only the top margin by adding a small extra value (e.g., 0.05)
set(ax, 'LooseInset', [ti(1), ti(2), ti(3), ti(4) + 0.05]);
saveas(gcf, 'img_chapter_7_2_incorporate_purdue.png');
