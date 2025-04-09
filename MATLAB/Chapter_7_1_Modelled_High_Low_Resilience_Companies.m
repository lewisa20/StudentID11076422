% Adam Lewis 3rd Year Individual Project
% Student ID 11076422

% ChatGPT o3-mini-high was used to aid debugging and production of the 
% MATLAB visualisations in this project.

% This script is used to generate 2 curves:
% Company B: High Resilience Modelled Company from simulated model inputs
% Company C: Low Resilience Modelled Company from simulated model inputs

% Define desired figure size in pixels
plotWidth = 450;   % Width in pixels
plotHeight = 500;  % Height in pixels

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
figure('Color','w', 'Units','pixels', 'Position',[100 100 plotWidth plotHeight]);
plot(x, P_CompanyB, 'g-', 'LineWidth', 1); hold on;
plot(x, P_CompanyC, 'r-', 'LineWidth', 1);
xlabel('Cyber Attack Severity (x)');
ylabel('Probability of Compromise (P)');
set(gcf, 'Color', 'white');

% Plot marker on the Company B curve at P = 0.5
plot(theta_B, 0.5, 'ko', 'MarkerFaceColor', 'g', 'MarkerSize', 8);
text(theta_B+0.1, 0.5, sprintf('%.2f', theta_B), 'VerticalAlignment', 'middle', 'HorizontalAlignment', 'left');

% Plot marker on the Company C curve at P = 0.5
plot(theta_C, 0.5, 'ko', 'MarkerFaceColor', 'r', 'MarkerSize', 8);
text(theta_C-0.1, 0.5, sprintf('%.2f', theta_C), 'VerticalAlignment', 'middle', 'HorizontalAlignment', 'right');


% Create legend
leg = legend({'1: High Resilience Modelled Co. (HR)', ...
              '2: Low Resilience Modelled Co. (LR-1)'}, ...
             'Location','southeast');

% Text box for mean and SD inputs
annotation_str = {...
    sprintf('1: μ = %.4f, σ = %.4f', m_norm_B, 1-s_norm_B), ...
    sprintf('2: μ = %.4f, σ = %.4f', m_norm_C, 1-s_norm_C)}; ...
annotation('textbox', [0.12, 0.6, 0.5, 0.3], 'String', annotation_str, ...
           'FitBoxToText', 'on', 'EdgeColor', 'black', ...
           'BackgroundColor', 'white');

grid on;
hold off;

ax = gca;
ti = get(ax, 'TightInset');
set(ax, 'LooseInset', [ti(1), ti(2), ti(3), ti(4) + 0.05]);
saveas(gcf, 'img_chapter_7_1_modelled_high_low_resilience_companies.png');
