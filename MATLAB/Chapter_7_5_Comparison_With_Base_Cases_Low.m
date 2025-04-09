% Adam Lewis 3rd Year Individual Project
% Student ID 11076422

% ChatGPT o3-mini-high was used to aid debugging and production of the 
% MATLAB visualisations in this project.

% This script is used to generate 4 curves:
%   A: Base Case Lowest resilience Company
%   B: High Resilience Modelled Company 
%   C: Low Resilience Modelled Company 
%   D: base case highest resilience company
%
% Then shaded bands are added to the plot area depicting the relative risk
% of the 5 layers of the Purdue Model of a substation.
%
% Finally a series of escalating events are added as labeled points

m_norm_A = 1.1963;    % Base Case Lowest Resilience mean (blue)
s_norm_A = 0.4189;    % Base Case Lowest resilience std deviation
m_norm_B = 1.8294;    % High Resilience Modelled Company Normalised & scaled mean (green)
s_norm_B = 0.6988;    % High Resilience Modelled Company Normalised std deviation
m_norm_C = 1.4577;    % Low Resilience Modelled Company Normalised & scaled mean (red)
s_norm_C = 0.4902;    % Low Resilience Modelled Company Normalised std deviation
m_norm_D = 2.2000;    % Base Case highest Resilience mean
s_norm_D = 0.9989;    % Base Case highest Resilience std dev

% Convert mean/std -> beta/theta for each company
beta_A = sqrt(log(1 + (s_norm_A/m_norm_A)^2));
theta_A = m_norm_A * exp(-0.5 * beta_A^2);
beta_B = sqrt(log(1 + (s_norm_B/m_norm_B)^2));
theta_B = m_norm_B * exp(-0.5 * beta_B^2);
beta_C = sqrt(log(1 + (s_norm_C/m_norm_C)^2));
theta_C = m_norm_C * exp(-0.5 * beta_C^2);
beta_D = sqrt(log(1 + (s_norm_D/m_norm_D)^2));
theta_D = m_norm_D * exp(-0.5 * beta_D^2);

% Define intensity measure X
x = linspace(0, 4, 100);

% Generate fragility curves
P_CompanyA = normcdf((log(x / theta_A)) / beta_A);  % Base Case Low 
P_CompanyB = normcdf((log(x / theta_B)) / beta_B);  % High Resilience 
P_CompanyC = normcdf((log(x / theta_C)) / beta_C);  % Low Resilience
P_CompanyD = normcdf((log(x / theta_D)) / beta_D);  % Base case High 

% Plot fragility curves
plotWidth = 700;   % Width in pixels
plotHeight = 750;  % Height in pixels
figure('Color','w', 'Units','pixels', 'Position',[100 0 plotWidth plotHeight]);
p0 = plot(x, P_CompanyA, 'b-', 'LineWidth', 1); hold on;  % Base Case
p1 = plot(x, P_CompanyB, 'g-', 'LineWidth', 1);           % High Resilience
p2 = plot(x, P_CompanyC, 'r-', 'LineWidth', 1);           % Low Resilience
p3 = plot(x, P_CompanyD, 'm-', 'LineWidth', 1);           % Base case high

xlabel('Progress along attack path (x)');
ylabel('Probability of Compromise (P)');
set(gcf, 'Color', 'white');
grid on;

% x/y offsets for positioning text and %age labels
blueEventLabelXOffsets = [-0.32, -0.32, -0.32, -0.3, -0.3, -0.3, -0.3, -0.3, -0.3];
bluePercentageXOffsets = [-0.04, -0.02, -0.03, -0.02, -0.02, -0.03, -0.04, 0.0, 0.0];
blueEventLabelYOffsets = [0.00, 0.00, 0.02, 0.00, 0.00, 0.00, 0.005, 0.02, 0.032]; % Modify as needed
bluePercentageYOffsets = [0.00, 0.00, 0.02, 0.00, 0.00, 0.00, 0.005, 0.02, 0.032]; % Modify as needed

% Add grey bands for purdue levels
yl = ylim;         % Current y-axis limits
yMid = mean(yl);   % Vertical midpoint for band labels

colorP5 = [0.85 0.85 0.85]; % P5
colorP4 = [0.75 0.75 0.75]; % P4
colorP3 = [0.64 0.64 0.64]; % P3
colorP2 = [0.52 0.52 0.52]; % P2
colorP1 = [0.40 0.40 0.40]; % P1/0

% Band P5
x_startP5 = 0.25;
x_endP5   = x_startP5 + 0.55; 
hP5 = patch([x_startP5 x_endP5 x_endP5 x_startP5], [yl(1) yl(1) yl(2) yl(2)], colorP5, ...
      'FaceAlpha', 0.3, 'EdgeColor', 'none');
x_midP5 = (x_startP5 + x_endP5)/2; 
text(x_midP5, yMid, 'Purdue Level 5', 'Rotation', 90, 'HorizontalAlignment','center', ...
    'VerticalAlignment','middle', 'FontSize', 17, 'Color',[0.80,0.80,0.80], 'FontWeight', 'bold');

% Band P4
x_startP4 = x_endP5;  
x_endP4   = x_startP4 + 0.55; 
hP4 = patch([x_startP4 x_endP4 x_endP4 x_startP4], [yl(1) yl(1) yl(2) yl(2)], colorP4, ...
      'FaceAlpha', 0.3, 'EdgeColor', 'none');
x_midP4 = (x_startP4 + x_endP4)/2; 
text(x_midP4, yMid, 'Purdue Level 4', 'Rotation', 90, 'HorizontalAlignment','center', ...
    'VerticalAlignment','middle', 'FontSize', 17, 'Color',[0.8,0.8,0.8], 'FontWeight', 'bold');

% Band P3
x_startP3 = x_endP4; 
x_endP3   = x_startP3 + 0.55; 
hP3 = patch([x_startP3 x_endP3 x_endP3 x_startP3], [yl(1) yl(1) yl(2) yl(2)], colorP3, ...
      'FaceAlpha', 0.3, 'EdgeColor', 'none');
x_midP3 = (x_startP3 + x_endP3)/2; 
text(x_midP3, yMid, 'Purdue Level 3', 'Rotation', 90, 'HorizontalAlignment','center', ...
    'VerticalAlignment','middle', 'FontSize', 17, 'Color',[0.75,0.75,0.75], 'FontWeight', 'bold');

% Band P2
x_startP2 = x_endP3; 
x_endP2   = x_startP2 + 0.55;
hP2 = patch([x_startP2 x_endP2 x_endP2 x_startP2], [yl(1) yl(1) yl(2) yl(2)], colorP2, ...
      'FaceAlpha', 0.3, 'EdgeColor', 'none');
x_midP2 = (x_startP2 + x_endP2)/2; 
text(x_midP2, yMid, 'Purdue Level 2', 'Rotation', 90, 'HorizontalAlignment','center', ...
    'VerticalAlignment','middle', 'FontSize', 17, 'Color',[0.7,0.7,0.7], 'FontWeight', 'bold');

% Band P1
x_startP1 = x_endP2; 
x_endP1   = x_startP1 + 0.55; 
hP1 = patch([x_startP1 x_endP1 x_endP1 x_startP1], [yl(1) yl(1) yl(2) yl(2)], colorP1, ...
      'FaceAlpha', 0.3, 'EdgeColor', 'none');
x_midP1 = (x_startP1 + x_endP1)/2; 
text(x_midP1, yMid, 'Purdue Level 1/0', 'Rotation', 90, 'HorizontalAlignment','center', ...
    'VerticalAlignment','middle', 'FontSize', 17, 'Color',[0.7,0.7,0.7], 'FontWeight', 'bold');

% Define dot placement for events, X=0.75:0.25:2.75
dotX   = 0.75 : 0.25 : 2.75;
dotY_A = normcdf((log(dotX / theta_A)) / beta_A);  % Base Case low
dotY_B = normcdf((log(dotX / theta_B)) / beta_B);  % High Resilience
dotY_C = normcdf((log(dotX / theta_C)) / beta_C);  % Low Resilience 
dotY_D = normcdf((log(dotX / theta_D)) / beta_D);  % Base case high

% event labels array
events = {
    'Initial Access'
    'Persistence'
    'Privilege Escalation'
    'Defense Evasion'
    'Lateral Movement'
    'Command & Control'
    'Inhibit Response Function'
    'Impair Process Control'
    'Critical Impact'
};

% Loop events
for i = 1:length(dotX)
    xVal = dotX(i);
    
    % get Y vals for dots
    yA = dotY_A(i);
    yB = dotY_B(i);
    yC = dotY_C(i);
    yD = dotY_D(i);
    
    % draw connecting dashed line across linked events
    yMin = min([yA, yB, yC, yD]);
    yMax = max([yA, yB, yC, yD]);
    plot([xVal xVal], [yMin yMax], 'k--', 'HandleVisibility','off');

    % Base Case low this one has the text labels
    plot(xVal, yA, 's', 'MarkerSize', 6, ...
         'MarkerFaceColor','b', 'MarkerEdgeColor','b', 'HandleVisibility','off');
    % event label
    text(xVal + blueEventLabelXOffsets(i), yA + blueEventLabelYOffsets(i), events{i}, ...
         'HorizontalAlignment','right','VerticalAlignment','middle', 'Color','k');
    % percentage text
    text(xVal + bluePercentageXOffsets(i), yA + bluePercentageYOffsets(i), sprintf('(%.0f%%)', yA*100), ...
         'HorizontalAlignment','right','VerticalAlignment','middle', 'Color','k');

    % High Resilience 
    plot(xVal, yB, 'o', 'MarkerSize', 6, ...
         'MarkerFaceColor','g', 'MarkerEdgeColor','g', 'HandleVisibility','off');
    text(xVal + 0.06, yB, sprintf('%.0f%%', yB*100), ...
         'HorizontalAlignment','left','VerticalAlignment','middle', 'Color','k');

    % Low Resilience
    plot(xVal, yC, 'o', 'MarkerSize', 6, ...
         'MarkerFaceColor','r', 'MarkerEdgeColor','r', 'HandleVisibility','off');
    text(xVal + 0.06, yC, sprintf('%.0f%%', yC*100), ...
         'HorizontalAlignment','left','VerticalAlignment','middle', 'Color','k');

    % base case high resilience
    plot(xVal, yD, 'd', 'MarkerSize', 6, ...
         'MarkerFaceColor','m', 'MarkerEdgeColor','m', 'HandleVisibility','off');
    text(xVal + 0.06, yD, sprintf('%.0f%%', yD*100), ...
         'HorizontalAlignment','left','VerticalAlignment','middle', 'Color','k');
end

% legend
legendHandles = [p0, p2, p1, p3, hP5, hP4, hP3, hP2, hP1];
legendLabels  = {
    '1: Base Case CAF Total Non-Compliance', ...  
    '2: Low Resilience Modelled Company (LR-1)', ...
    '3: High Resilience Modelled Company (HR)', ...
    '4: Base Case CAF Total Compliance ', ...
    'Purdue Level 5', 'Purdue Level 4', 'Purdue Level 3', ...
    'Purdue Level 2', 'Purdue Level 1/0'
};
legend(legendHandles, legendLabels, 'Location','southeast');

% Text box for mean and SD inputs
annotation_str = {...
    sprintf('1: μ = %.4f, σ = %.4f', m_norm_A, 1-s_norm_A), ...
    sprintf('2: μ = %.4f, σ = %.4f', m_norm_C, 1-s_norm_C), ...
    sprintf('3: μ = %.4f, σ = %.4f', m_norm_B, 1-s_norm_B), ...
    sprintf('4: μ = %.4f, σ = %.4f', m_norm_D, 1-s_norm_D)};
annotation('textbox', [0.728, 0.09, 0.5, 0.3], 'String', annotation_str, ...
           'FitBoxToText', 'on', 'EdgeColor', 'black', ...
           'BackgroundColor', 'white');

hold off;

% trim whitespace arund exterior of plot
ax = gca;
ti = get(ax, 'TightInset');
set(ax, 'LooseInset', [ti(1), ti(2), ti(3), ti(4) + 0.05]);
% save plot image as local img
saveas(gcf, 'img_chapter_7_5_comparison_with_base_cases.png');
