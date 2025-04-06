% Adam Lewis 3rd Year Individual Project

% MATLAB script to generate fragility curves using
% Log Normal Cumulative Distribution Function from mean
% and standard deviation obtained from discrete model

% This script is used to generate 2 curves:
%   Company B: High Resilience Modelled Company from simulated model inputs
%   Company C: Low Resilience Modelled Company from simulated model inputs
%
% Then shaded bands are added to the plot area depicting the relative risk
% of the 5 layers of the Purdue Model of a substation
%
% Finally a series of escalating events are added to each curve at set points
% along the intensity measure X axis

% Define desired figure size in pixels
plotWidth = 600;   % Width in pixels
plotHeight = 700;  % Height in pixels

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

% Define intensity measure X
x = linspace(0, 4, 100);

% Use normcdf to generate fragility curves
P_CompanyB = normcdf((log(x / theta_B)) / beta_B);
P_CompanyC = normcdf((log(x / theta_C)) / beta_C);

% Plot fragility curves
figure('Color','w', 'Units','pixels', 'Position',[100 0 plotWidth plotHeight]);
p1 = plot(x, P_CompanyB, 'g-', 'LineWidth', 1); hold on;
p2 = plot(x, P_CompanyC, 'r-', 'LineWidth', 1);
xlabel('Intensity Measure (Progress along attack path)');
ylabel('Probability of Compromise');
set(gcf, 'Color', 'white');

grid on;

%% Add Purdue level bands to plot area

% Get the current y-axis limits
yl = ylim;
% Get vertical midpint for text labels within bands
yMid = mean(yl); 

colorP5 = [0.85 0.85 0.85]; % P5
colorP4 = [0.75 0.75 0.75]; % P4
colorP3 = [0.64 0.64 0.64]; % P3
colorP2 = [0.52 0.52 0.52]; % P2
colorP1 = [0.40 0.40 0.40];

% Band P5
x_startP5 = 0.25;
x_endP5 = x_startP5 + 0.55; 
hP5 = patch([x_startP5 x_endP5 x_endP5 x_startP5], [yl(1) yl(1) yl(2) yl(2)], ...
      colorP5, 'FaceAlpha', 0.3, 'EdgeColor', 'none', 'DisplayName', 'Purdue Level 5');
x_midP5 = (x_startP5 + x_endP5)/2; 
text(x_midP5, yMid, 'Purdue Level 5', ...
    'Rotation', 90, 'HorizontalAlignment','center','VerticalAlignment','middle', ...
    'FontSize', 17,'Color',[0.80,0.80,0.80],'FontWeight', 'bold');

% Band P4
x_startP4 = x_endP5;  
x_endP4 = x_startP4 + 0.55; 
hP4 = patch([x_startP4 x_endP4 x_endP4 x_startP4], [yl(1) yl(1) yl(2) yl(2)], ...
      colorP4, 'FaceAlpha', 0.3, 'EdgeColor', 'none', 'DisplayName', 'Purdue Level 4');
x_midP4 = (x_startP4 + x_endP4)/2; 
text(x_midP4, yMid, 'Purdue Level 4', ...
    'Rotation', 90, 'HorizontalAlignment','center','VerticalAlignment','middle', ...
    'FontSize', 17,'Color',[0.8,0.8,0.8],'FontWeight', 'bold');

% Band P3
x_startP3 = x_endP4; 
x_endP3 = x_startP3 + 0.55; 
hP3 = patch([x_startP3 x_endP3 x_endP3 x_startP3], [yl(1) yl(1) yl(2) yl(2)], ...
      colorP3, 'FaceAlpha', 0.3, 'EdgeColor', 'none', 'DisplayName', 'Purdue Level 3');
x_midP3 = (x_startP3 + x_endP3)/2; 
text(x_midP3, yMid, 'Purdue Level 3', ...
    'Rotation', 90, 'HorizontalAlignment','center','VerticalAlignment','middle', ...
    'FontSize', 17,'Color',[0.75,0.75,0.75],'FontWeight', 'bold');

% Band P2
x_startP2 = x_endP3; 
x_endP2 = x_startP2 + 0.55;
hP2 = patch([x_startP2 x_endP2 x_endP2 x_startP2], [yl(1) yl(1) yl(2) yl(2)], ...
      colorP2, 'FaceAlpha', 0.3, 'EdgeColor', 'none', 'DisplayName', 'Purdue Level 2');
x_midP2 = (x_startP2 + x_endP2)/2; 
text(x_midP2, yMid, 'Purdue Level 2', ...
    'Rotation', 90, 'HorizontalAlignment','center','VerticalAlignment','middle', ...
    'FontSize', 17,'Color',[0.7,0.7,0.7],'FontWeight', 'bold');

% Band P1
x_startP1 = x_endP2; 
x_endP1 = x_startP1 + 0.55; 
hP1 = patch([x_startP1 x_endP1 x_endP1 x_startP1], [yl(1) yl(1) yl(2) yl(2)], ...
      colorP1, 'FaceAlpha', 0.3, 'EdgeColor', 'none', 'DisplayName', 'Purdue Level 1/0');
x_midP1 = (x_startP1 + x_endP1)/2; 
text(x_midP1, yMid, 'Purdue Level 1/0', ...
    'Rotation', 90, 'HorizontalAlignment','center','VerticalAlignment','middle', ...
    'FontSize', 17,'Color',[0.7,0.7,0.7],'FontWeight', 'bold');

%% Place 8 labeled points on the HR green curve

% define intensity measure of dot placement at
% 0.25 intervals from 0.75 to 2.75 aligning event
% intensity with applicable Purdue level
dotX = 0.75:0.25:2.75;
dotY = normcdf((log(dotX / theta_B)) / beta_B);

% place green dots and labels with percentage
plot(dotX(1), dotY(1), 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'g', 'HandleVisibility','off');
text(dotX(1)+0.06, dotY(1)+0.01, sprintf('Initial Access (%.0f%%)', dotY(1)*100), 'HorizontalAlignment','left','VerticalAlignment','middle');

plot(dotX(2), dotY(2), 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'g', 'HandleVisibility','off');
text(dotX(2)+0.06, dotY(2), sprintf('Persistance (%.0f%%)', dotY(2)*100), 'HorizontalAlignment','left','VerticalAlignment','middle');

plot(dotX(3), dotY(3), 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'g', 'HandleVisibility','off');
text(dotX(3)+0.06, dotY(3), sprintf('Priviledge Escalation (%.0f%%)', dotY(3)*100), 'HorizontalAlignment','left','VerticalAlignment','middle');

plot(dotX(4), dotY(4), 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'g', 'HandleVisibility','off');
text(dotX(4)+0.06, dotY(4), sprintf('Defense Evasion (%.0f%%)', dotY(4)*100), 'HorizontalAlignment','left','VerticalAlignment','middle');

plot(dotX(5), dotY(5), 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'g', 'HandleVisibility','off');
text(dotX(5)+0.06, dotY(5), sprintf('Lateral Movement (%.0f%%)', dotY(5)*100), 'HorizontalAlignment','left','VerticalAlignment','middle');

plot(dotX(6), dotY(6), 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'g', 'HandleVisibility','off');
text(dotX(6)+0.06, dotY(6), sprintf('Command & Control (%.0f%%)', dotY(6)*100), 'HorizontalAlignment','left','VerticalAlignment','middle');

plot(dotX(7), dotY(7), 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'g', 'HandleVisibility','off');
text(dotX(7)+0.06, dotY(7), sprintf('Inhibit Response Function (%.0f%%)', dotY(7)*100), 'HorizontalAlignment','left','VerticalAlignment','middle');

plot(dotX(8), dotY(8), 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'g', 'HandleVisibility','off');
text(dotX(8)+0.06, dotY(8), sprintf('Impair Process Control (%.0f%%)', dotY(8)*100), 'HorizontalAlignment','left','VerticalAlignment','middle');

plot(dotX(9), dotY(9), 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'g', 'HandleVisibility','off');
text(dotX(9)+0.06, dotY(9), sprintf('Critical Impact (%.0f%%)', dotY(9)*100), 'HorizontalAlignment','left','VerticalAlignment','middle');


%% Place 8 labeled points on the LR red curve

% define intensity measure of dot placement at
% 0.25 intervals from 0.75 to 2.75 aligning event
% intensity with applicable Purdue level
dotYg = normcdf((log(dotX / theta_C)) / beta_C);

% place red dots and labels with percentage
plot(dotX(1), dotYg(1), 'go', 'MarkerSize', 6, 'MarkerFaceColor', 'r', 'HandleVisibility','off');
text(dotX(1)-0.06, dotYg(1), sprintf('Initial Access (%.0f%%)', dotYg(1)*100), 'HorizontalAlignment','right','VerticalAlignment','middle');

plot(dotX(2), dotYg(2), 'go', 'MarkerSize', 6, 'MarkerFaceColor', 'r', 'HandleVisibility','off');
text(dotX(2)-0.06, dotYg(2), sprintf('Persistance (%.0f%%)', dotYg(2)*100), 'HorizontalAlignment','right','VerticalAlignment','middle');

plot(dotX(3), dotYg(3), 'go', 'MarkerSize', 6, 'MarkerFaceColor', 'r', 'HandleVisibility','off');
text(dotX(3)-0.06, dotYg(3), sprintf('Priviledge Escalation (%.0f%%)', dotYg(3)*100), 'HorizontalAlignment','right','VerticalAlignment','middle');

plot(dotX(4), dotYg(4), 'go', 'MarkerSize', 6, 'MarkerFaceColor', 'r', 'HandleVisibility','off');
text(dotX(4)-0.06, dotYg(4), sprintf('Defense Evasion (%.0f%%)', dotYg(4)*100), 'HorizontalAlignment','right','VerticalAlignment','middle');

plot(dotX(5), dotYg(5), 'go', 'MarkerSize', 6, 'MarkerFaceColor', 'r', 'HandleVisibility','off');
text(dotX(5)-0.06, dotYg(5), sprintf('Lateral Movement (%.0f%%)', dotYg(5)*100), 'HorizontalAlignment','right','VerticalAlignment','middle');

plot(dotX(6), dotYg(6), 'go', 'MarkerSize', 6, 'MarkerFaceColor', 'r', 'HandleVisibility','off');
text(dotX(6)-0.06, dotYg(6), sprintf('Command & Control (%.0f%%)', dotYg(6)*100), 'HorizontalAlignment','right','VerticalAlignment','middle');

plot(dotX(7), dotYg(7), 'go', 'MarkerSize', 6, 'MarkerFaceColor', 'r', 'HandleVisibility','off');
text(dotX(7)-0.06, dotYg(7), sprintf('Inhibit Response Function (%.0f%%)', dotYg(7)*100), 'HorizontalAlignment','right','VerticalAlignment','middle');

plot(dotX(8), dotYg(8), 'go', 'MarkerSize', 6, 'MarkerFaceColor', 'r', 'HandleVisibility','off');
text(dotX(8)-0.06, dotYg(8)+0.01, sprintf('Impair Process Control (%.0f%%)', dotYg(8)*100), 'HorizontalAlignment','right','VerticalAlignment','middle');

plot(dotX(9), dotYg(9), 'go', 'MarkerSize', 6, 'MarkerFaceColor', 'r', 'HandleVisibility','off');
text(dotX(9)-0.03, dotYg(9)+0.03, sprintf('Critical Impact (%.0f%%)', dotYg(9)*100), 'HorizontalAlignment','right','VerticalAlignment','middle');


% Add leged for curves and the 5 purdue bands
legendHandles = [p1, p2, hP5, hP4, hP3, hP2, hP1];
legendLabels  = {
    'High Resilience Company', ...
    'Low Resilience Company', ...
    'Purdue Level 5', 'Purdue Level 4', 'Purdue Level 3', ...
    'Purdue Level 2', 'Purdue Level 1/0'
};
legend(legendHandles, legendLabels, 'Location','southeast');

hold off;

ax = gca;
ti = get(ax, 'TightInset');
% Increase only the top margin by adding a small extra value (e.g., 0.05)
set(ax, 'LooseInset', [ti(1), ti(2), ti(3), ti(4) + 0.05]);
saveas(gcf, 'img_chapter_7_3_incorporate_events.png');
