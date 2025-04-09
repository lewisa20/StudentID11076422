% Adam Lewis 3rd Year Individual Project
% Student ID 11076422

% ChatGPT o3-mini-high was used to aid debugging and production of the 
% MATLAB visualisations in this project.

% MATLAB code to generate 3 base case fragility curves

% Define desired figure size in pixels
plotWidth = 500;   % Width in pixels
plotHeight = 450;  % Height in pixels

% Define Mean and StdDev for base cases
m_norm_A = 2.2000;    % Company A(high resilience) Normalised & scaled mean
s_norm_A = 0.9989;    % Company A(high resilience) Normalised std deviation
m_norm_B = 1.7580;    % Company B(moderate resilience) Normalised & scaled mean
s_norm_B = 0.8638;    % Company B(moderate resilience) Normalised std deviation
m_norm_C = 1.1963;    % Company C(low resilience) Normalised & scaled mean
s_norm_C = 0.4189;    % Company C(low resilience) Normalised std deviation

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
figure('Color','w', 'Units','pixels', 'Position',[100 100 plotWidth plotHeight]);
plot(x, P_CompanyA, 'g-', 'LineWidth', 1); hold on; 
plot(x, P_CompanyB, 'b-', 'LineWidth', 1);         
plot(x, P_CompanyC, 'r-', 'LineWidth', 1);          
xlabel('Cyber Attack Severity (x)');
ylabel('Probability of Compromise (P)');
set(gcf, 'Color', 'white');

% Main legend -
legend({ 'Case A: Fully Achieved CAF', ...
         'Case B: Partially Achieved CAF', ...
         'Case C: Not Achieved CAF' }, ...
         'Location', 'southeast');

% Text box for mean and SD inputs
annotation_str = {...
    sprintf('A: μ = %.4f, σ = %.4f', m_norm_A, 1-s_norm_A), ...
    sprintf('B: μ = %.4f, σ = %.4f', m_norm_B, 1-s_norm_B), ...
    sprintf('C: μ = %.4f, σ = %.4f', m_norm_C, 1-s_norm_C)};
annotation('textbox', [0.62 0.25, 0.3, 0.15], 'String', annotation_str,...
           'FitBoxToText', 'on', 'EdgeColor', 'black', ...
           'BackgroundColor', 'white');
grid on;
hold off;

ax = gca;
ti = get(ax, 'TightInset');
set(ax, 'LooseInset', [ti(1), ti(2), ti(3), ti(4) + 0.02]);

saveas(gcf, 'img_chapter_6_1_base_cases.png');
