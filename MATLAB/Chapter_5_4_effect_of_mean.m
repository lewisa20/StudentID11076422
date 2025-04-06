% Generate Fragility Curves using Log Normal Cumulative Distribution 
% Function from Mean and Standard Deviation Inputs

% Define desired figure size in pixels
plotWidth = 500;   % Width in pixels
plotHeight = 450;  % Height in pixels

m_norm_A = 1.0;     % Company A(high resilience) Normalised & scaled mean
s_norm_A = 0.5;     % Company A(high resilience) Normalised std deviation
m_norm_B = 1.25;    % Company B(moderate resilience) Normalised & scaled mean
s_norm_B = 0.5;     % Company B(moderate resilience) Normalised std deviation
m_norm_C = 1.5;     % Company C(low resilience) Normalised & scaled mean
s_norm_C = 0.5;     % Company C(low resilience) Normalised std deviation
m_norm_D = 1.75;    % Company D(slightly achieved CAF) Normalised & scaled mean
s_norm_D = 0.5;     % Company D Normalised std deviation
m_norm_E = 2.0;     % Company E(mostly achieved CAF) Normalised & scaled mean
s_norm_E = 0.5;     % Company E Normalised std deviation

% Convert mean and std to beta/theta for companies A, B, C, D and E
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
xlabel('Hazard Intensity');
ylabel('Probability of Compromise');
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
    sprintf('1: m = %.4f, sd = %.4f', m_norm_A, 1-s_norm_A), ...
    sprintf('2: m = %.4f, sd = %.4f', m_norm_B, 1-s_norm_B), ...
    sprintf('3: m = %.4f, sd = %.4f', m_norm_C, 1-s_norm_C), ...
    sprintf('4: m = %.4f, sd = %.4f', m_norm_D, 1-s_norm_D), ...
    sprintf('5: m = %.4f, sd = %.4f', m_norm_E, 1-s_norm_E)};
annotation('textbox', [0.523, 0.25, 0.5, 0.3], 'String', annotation_str, ...
           'FitBoxToText', 'on', 'EdgeColor', 'black', ...
           'BackgroundColor', 'white');
grid on;
hold off;
saveas(gcf, 'img_chapter_5_4_effect_of_mean.png');
