% Adam Lewis 3rd Year Individual Project

% MATLAB script to generate fragility curves using
% Log Normal Cumulative Distribution Function from mean
% and standard deviation obtained from discrete model

% This script is used to generate 2 curves:
% Company B: High Resilience Modelled Company from simulated model inputs
% Company C: Low Resilience Modelled Company from simulated model inputs

m_norm_B = 1.8146;    % High resilience Modelled Company Normalised & scaled mean
s_norm_B = 0.6609;    % High resilience Modelled Company Normalised std deviation
m_norm_C = 1.3954;    % Low Resilience Modelled Company Normalised & scaled mean
s_norm_C = 0.4591;    % Low Resilience Modelled Company Normalised std deviation

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
figure;
plot(x, P_CompanyB, 'g-', 'LineWidth', 1); hold on;
plot(x, P_CompanyC, 'r-', 'LineWidth', 1);
xlabel('Cyber Attack Severity');
ylabel('Probability of Compromise');
set(gcf, 'Color', 'white');

% Create legend
leg = legend({'High Resilience (HR) Modelled Company', ...
              'Low Resilience (LR) Modelled Company'}, ...
             'Location','southeast');

% Text box for mean and SD input values
annotation_str = { ...
    sprintf('HR Inputs: m = %.4f, sd = %.4f', m_norm_B - 1, 1 - s_norm_B), ...
    sprintf('LR Inputs:  m = %.4f, sd = %.4f', m_norm_C - 1, 1 - s_norm_C)};

% Text box positioning
legPos = leg.Position;   % [left bottom width height]
textboxWidth  = 0.3;     % Adjust as needed
textboxHeight = 0.10;    % Adjust as needed
textboxLeft = legPos(1) + legPos(3) - textboxWidth -0.12;
textboxBottom = legPos(2) + legPos(4) + 0.02;  % small offset above legend

% Add text box to plot
annotation('textbox', [textboxLeft, textboxBottom, textboxWidth, textboxHeight], ...
           'String', annotation_str, ...
           'FitBoxToText', 'on', ...
           'EdgeColor', 'black', ...
           'BackgroundColor', 'white');

grid on;
hold off;

% Uncomment to save plot to local drive
% exportgraphics(gcf, 'myPlot.png', 'Resolution', 300);
