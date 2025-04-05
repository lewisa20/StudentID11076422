% Adam Lewis 3rd Year Individual Project

% MATLAB script to generate fragility curves using
% Log Normal Cumulative Distribution Function from mean
% and standard deviation obtained from discrete model

% This script is used to generate 2 curves:
% Company B: High Resilience Modelled Company from simulated model inputs
% Company C: Low Resilience Modelled Company from simulated model inputs

% Define desired figure size in pixels
plotWidth = 500;   % Width in pixels
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
xlabel('Cyber Attack Severity');
ylabel('Probability of Compromise');
set(gcf, 'Color', 'white');

% Create legend
leg = legend({'High Resilience Modelled Company', ...
              'Low Resilience Modelled Company'}, ...
             'Location','southeast');

% Text box for mean and SD inputs
annotation_str = {...
    sprintf('High Resilience: m = %.4f, sd = %.4f', m_norm_B, 1-s_norm_B), ...
    sprintf('Low Resilience: m = %.4f, sd = %.4f', m_norm_C, 1-s_norm_C)}; ...
annotation('textbox', [0.44, 0.0, 0.5, 0.3], 'String', annotation_str, ...
           'FitBoxToText', 'on', 'EdgeColor', 'black', ...
           'BackgroundColor', 'white');

grid on;
hold off;

ax = gca;
ti = get(ax, 'TightInset');
% Increase only the top margin by adding a small extra value (e.g., 0.05)
set(ax, 'LooseInset', [ti(1), ti(2), ti(3), ti(4) + 0.05]);
saveas(gcf, 'img_chapter_7_1_modelled_high_low_resilience_companies.png');
