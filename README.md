# Adam Lewis 3rd Year Individual Project

Repository for documents and code.

- MATLAB scripts created using R2024b, Update 2, version 24.2.0.27731420
  - No special instructions. Open any file and click run.
- Spreadsheet files created using Microsoft 365 Excel
- Diagrams created using draw.io on https://app.diagrams.net/

# List of MATLAB Scripts
- Chapter_1_1_Cost_Of_Cybercrime.m
  - Plots barchart of estimated UK cost of cybercrime.
  - Fig 1 in the report
- Chapter_1_2_Global_Cost.m
  - Plots barchart of estimated global cost of cybercrime.
  - Fig 2 in the report
- Chapter_1_3_Euro_Attacks.m
  - Plots barchart of known succesful cyber attacks against energy sector.
  - Fig 3 in the report
- Chapter_1_4_PLC_CVE.m
  - Plots barchart of CVE vulnerabilities of programmable logic controllers.
  - Fig 4 in the report
- Chapter_5_1_Generic_Fragility_Curve.m
  - Plots a generic fragility curve using log normal cumulative distribution function defining the intensity measure as a sequence of cumulative attacks
  - Fig 8 in the report
- Chapter_5_2_Generic_Fragility_Curve_Purdue.m
  - Plots a generic fragility curve using log normal cumulative distribution function defining the intensity measure as level in the Purdue model
  - Fig 9 in the report
- Chapter_5_3_Generic_Fragility_Curve_Events.m
  - Plots a generic fragility curve using log normal cumulative distribution function defining the intensity measure as level in the Purdue model and plots dots on the curve representing a sequence of escalating cyber-attack scenarios.
  - Fig 11 in the report
- Chapter_5_4_effect_of_mean.m
  - Plots a series of fragility curves demonstrating the effect of mean on the curves.
  - Fig 15 in report
- Chapter_5_5_effect_of_std_dev.m
  - Plots a series of fragility curves demonstrating the effect of std deviation on the curves.
  - Fig 16 in the report
- Chapter_6_1_Base_Cases_meanSD.m
  - Plots 3 fragility curve of the base case outputs from the model
  - Fig 18 in the report
- Chapter_7_1_Modelled_High_Low_Resilience_Companies.m
  - Plots the fragilty curve of high and low resilience modelled companies
  - Fig 19 in the report
- Chapter_7_2_Incorporate_Purdue.m
  - Plots the fragility curves of high low reslience modelled companies and maps the Purdue model over the curves.
  - Fig 20 in the report
- Chapter_7_3_Incorporate_events_modelling.m
  - Introduces events-based attack paths on the fragility curves of HR and LR-1 companies
  - Fig 21 in the report
- Chapter_7_4_Incorporate_events_modelling_adjusted_inputs.m
  - Introduces event based attack paths on the fragility curves of HR and LR-2 companies
  - Fig 22 in the report
- Chapter_7_5_Comparison_With_Base_Cases_Low.m
  - Position HR and LR-1 company against best and worst base case fragility curves
  - Fig 23 in the report


# List of Excel Files
- Model_Inputs_Outputs_Set_1.xlsx
  - Set 1 of Inputs/Outputs for statistical model
  - Model inputs and outputs for HR and LR-1 companies
  - The spreadsheet gives all imputs to the performance against CAF for base cases and high/low resilience modelled companies. The mean and standard deviation outputs from the model are used in the relevent MATLAB scripts to generate fragility curves.
- Model_Inputs_Outputs_Set_2_Adjusted.xlsx
  - Set 2 of Inputs/Outputs for statistical model
  - Model inputs and outputs for HR and LR-2 companies
  - Statistical model inputs/outputs with deteriorating CAF performance than LR-1.

# List of Diagrams
- Chapter_4_1_CAF_Objective_B.drawio
  - A block diagram overview of CAF Objective B
  - Fig 5 in the report
- Chapter_4_2_CAF_Assessment_Flowchart.drawio
  - A flowchart depicting the process of asessment against CAF
  - Fig 6 in the report
- Chapter_5_1_Methodology_Block_Diagram.drawio
  - A block diagram giving a high level overview of the methodology
  - Fig 7 in the report
- Chapter_5_2_Purdue_Model.drawio
  - A block diagram depicting a Purdue model of an IEC 61850 substation
  - Fig 10 in the report
- Chapter_6_1_Inputs_to_model.drawio
  - An annotated snapshot showing a representative example of high perfromance in the survey model inputs and calculations
  - Fig 13 in the report
- Chapter_6_2_Inputs_to_model_Failed.drawio
  - An annotated snapshot showing a representative example of low performace in  the survey model inputs and calculations
  - Fig 14 in the report
