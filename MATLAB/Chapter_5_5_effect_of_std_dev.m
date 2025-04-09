% Adam Lewis 3rd Year Individual Project
% Student ID 11076422

% ChatGPT o3-mini-high was used to aid debugging and production of the 
% MATLAB visualisations in this project.

% MATLAB code to generate a series of fragility curves to demonstrate the
% effect of standard deviation on the curve

% Define desired figure size in pixels
plotWidth = 500;   % Width in pixels
plotHeight = 450;  % Height in pixels

m_norm_A = 1.0;     % Curve A mean
s_norm_A = 0.3;     % Curve A stdDev
m_norm_B = 1.25;    % Curve B mean
s_norm_B = 0.45;    % Curve B stdDev
m_norm_C = 1.5;     % Curve C mean
s_norm_C = 0.6;     % Curve C stdDev
m_norm_D = 1.75;    % Curve D mean
s_norm_D = 0.75;    % Curve D stdDev
m_norm_E = 2.0;     % Curve E mean
s_norm_E = 0.9;     % Curve E stdDev

% Convert mean and stdDev to beta/theta for companies A, B, C, D and E
beta_A = sqrt(log(1 + (s_norm_A/m_norm_A)^2));
theta_A = m_norm_A * exp(-0.5 * beta_A^2);
beta_B = sqrt(log(1 + (s_norm_B/m_norm_B)^2));
theta_B = m_norm_B * exp(-0.5 * beta_B^2);
beta_C = sqrt(log(1 + (s_norm_C/m_norm_C)^2));
theta_C = m_norm_C * exp(-0.5 * beta_C^2);
beta_D = sqrt(log(1 + (s_norm_D/m_norm_D)^2));
theta_D = m_norm_D * exp(-0.5 * beta_D^2);
beta_E = sqrt(log(1 + (s_norm_E/m_norm_E)^2));
theta_E = m_norm_E * exp(-0.5 * beta_E^2);

% Define X
x = linspace(0, 4, 100); 

% Use normcdf to generate fragility curves
P_CompanyA = normcdf((log(x / theta_A)) / beta_A);
P_CompanyB = normcdf((log(x / theta_B)) / beta_B);
P_CompanyC = normcdf((log(x / theta_C)) / beta_C);
P_CompanyD = normcdf((log(x / theta_D)) / beta_D);
P_CompanyE = normcdf((log(x / theta_E)) / beta_E);

% Plot fragility Curves
figure('Color','w', 'Units','pixels', 'Position',[100 100 plotWidth plotHeight]);
plot(x, P_CompanyA, 'b-', 'LineWidth', 1); hold on; 
plot(x, P_CompanyB, 'r-', 'LineWidth', 1);         
plot(x, P_CompanyC, 'g-', 'LineWidth', 1);
plot(x, P_CompanyD, 'm-', 'LineWidth', 1);
plot(x, P_CompanyE, 'k-', 'LineWidth', 1);
xlabel('Hazard Intensity (x)');
ylabel('Probability of Compromise (P)');
set(gcf, 'Color', 'white');

% Main legend -
legend({ '1: Lowest resilience', ...
         '2: (increasing resilience)', ...
         '3: (increasing resilience)', ...
         '4: (increasing resilience)', ...
         '5: Highest resilience' }, ...
         'Location', 'southeast');

% Text box for mean and SD inputs
annotation_str = {...
    sprintf('1: μ = %.4f, σ = %.4f', m_norm_A, 1-s_norm_A), ...
    sprintf('2: μ = %.4f, σ = %.4f', m_norm_B, 1-s_norm_B), ...
    sprintf('3: μ = %.4f, σ = %.4f', m_norm_C, 1-s_norm_C), ...
    sprintf('4: μ = %.4f, σ = %.4f', m_norm_D, 1-s_norm_D), ...
    sprintf('5: μ = %.4f, σ = %.4f', m_norm_E, 1-s_norm_E)};
annotation('textbox', [0.54, 0.25, 0.5, 0.3], 'String', annotation_str, ...
           'FitBoxToText', 'on', 'EdgeColor', 'black', ...
           'BackgroundColor', 'white');
grid on;

% Compute the x-values corresponding to 0.8 probability:
% x = theta * exp(beta * norminv(0.8))
x_A_0_8 = theta_A * exp(beta_A * norminv(0.8));
x_E_0_8 = theta_E * exp(beta_E * norminv(0.8));

% Company A (blue) at 0.8 probability
plot(x_A_0_8, 0.8, 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 8, 'HandleVisibility','off');
text(x_A_0_8-0.15, 0.8, sprintf('%.2f', x_A_0_8), ...
    'VerticalAlignment','middle', 'HorizontalAlignment','right', ...
    'Rotation', 0, 'FontSize',10, 'Color','k');

% Company E (black) at 0.8 probability
plot(x_E_0_8, 0.8, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 8, 'HandleVisibility','off');
text(x_E_0_8+0.15, 0.8, sprintf('%.2f', x_E_0_8), ...
    'VerticalAlignment','middle', 'HorizontalAlignment','left', ...
    'Rotation', 0, 'FontSize',10, 'Color','k');
hold off;
saveas(gcf, 'img_chapter_5_4_effect_of_std_dev.png');
