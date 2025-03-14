% Adam Lewis 3rd Year Individual Project

% MATLAB script to generate fragility curves using
% Log Normal Cumulative Distribution Function from mean
% and standard deviation ontained from discrete model

m_norm_A = 1.9000;    % Company A(high resilience) Normalised & scaled mean
s_norm_A = 0.9990;    % Company A(high resilience) Normalised std deviation
m_norm_B = 1.7998;    % Company B(moderate resilience) Normalised & scaled mean
s_norm_B = 0.9980;    % Company B(moderate resilience) Normalised std deviation
m_norm_C = 1.2129;    % Company C(low resilience) Normalised & scaled mean
s_norm_C = 0.6880;    % Company C(low resilience) Normalised std deviation

% Convert mean and std to beta/theta for companies A, B and C
beta_A = sqrt(log(1 + (s_norm_A/m_norm_A)^2));
theta_A = m_norm_A * exp(-0.5 * beta_A^2);
beta_B = sqrt(log(1 + (s_norm_B/m_norm_B)^2));
theta_B = m_norm_B * exp(-0.5 * beta_B^2);
beta_C = sqrt(log(1 + (s_norm_C/m_norm_C)^2));
theta_C = m_norm_C * exp(-0.5 * beta_C^2);

% Define intensity measure X
x = linspace(0, 4, 100); 

% Use normcdf to generate fragility curves
P_CompanyA = normcdf((log(x / theta_A)) / beta_A);
P_CompanyB = normcdf((log(x / theta_B)) / beta_B);
P_CompanyC = normcdf((log(x / theta_C)) / beta_C);

% Plot fragility Curve
figure;
plot(x, P_CompanyA, 'g-', 'LineWidth', 1); hold on; 
plot(x, P_CompanyB, 'b-', 'LineWidth', 1);         
plot(x, P_CompanyC, 'r-', 'LineWidth', 1);          
xlabel('Cyber Attack Severity');
ylabel('Probability of Compromise');
set(gcf, 'Color', 'white');

% Main legend -
legend({ 'Base Case A: Fully Achieved CAF', ...
         'Base Case B: Partially Achieved CAF', ...
         'Base Case C: Not Achieved CAF' }, ...
         'Location', 'southeast');

% Text box for mean and SD inputs
annotation_str = {...
    sprintf('Base Case A: m = %.4f, sd = %.4f', m_norm_A-1, 1-s_norm_A), ...
    sprintf('Base Case B: m = %.4f, sd = %.4f', m_norm_B-1, 1-s_norm_B), ...
    sprintf('Base Case C: m = %.4f, sd = %.4f', m_norm_C-1, 1-s_norm_C)};
annotation('textbox', [0.45, 0.28, 0.3, 0.15], 'String', annotation_str,...
           'FitBoxToText', 'on', 'EdgeColor', 'black', ...
           'BackgroundColor', 'white');
grid on;
hold off;

% Uncomment to save plot to local drive
% exportgraphics(gcf, 'baseCases.png', 'Resolution', 300);
