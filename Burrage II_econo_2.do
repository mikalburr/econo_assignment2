clear all

use "/Users/michaelburrageii/Library/Mobile Documents/com~apple~CloudDocs/Burrage II_OP_PhD/Year2/FA24/Econometrics/Assignment 2/cigarette.dta", clear

* load the dataset and clear existing data

* #1 get summary statistics for all variables
summarize

* #2 create real (inflation-adjusted) variables
gen real_pci = (pci / cpi) * 1000
gen real_state_tax = (state_tax / cpi) * 100
gen real_federal_tax = (federal_tax / cpi) * 100
gen real_tax = real_state_tax + real_federal_tax

* #3 run regressions with different models

* basic model with just real_tax
regress pcpacks real_tax

* adding real_pci to control for income
regress pcpacks real_tax real_pci

* adding year as a continuous variable to control for trends over time
regress pcpacks real_tax real_pci year

* using year dummies to control for fixed effects per year
regress pcpacks real_tax real_pci i.year

* #4 in pdf

* #5a regress real_tax on real_pci to get residuals
regress real_tax real_pci
predict residual_x, residuals

* #5b regress pcpacks on real_pci to get residuals
regress pcpacks real_pci
predict residual_y, residuals

* 5c regress residual_y on residual_x
regress residual_y residual_x

* 5d in pdf

* #5e check regression of pcpacks on residual_x
regress pcpacks residual_x

* 5f in pdf

* 6a regress real_tax on real_pci and year dummies, get new residuals
regress real_tax real_pci i.year
predict residual_x2, residuals

* 6b regress pcpacks on real_pci and year dummies, get new residuals
regress pcpacks real_pci i.year
predict residual_y2, residuals

* 6c regress residual_y2 on residual_x2
regress residual_y2 residual_x2

* #7 use reghdfe to absorb year fixed effects
reghdfe pcpacks real_tax real_pci, absorb(year)

* #8 check the relationship between real_pci and real_tax
regress real_pci real_tax

* #9 compare the real_tax coefficient in model 1 and model 3

* step 1: run model 1 (only real_tax)
regress pcpacks real_tax

* step 2: run model 3 (real_tax, real_pci, and year)
regress pcpacks real_tax real_pci year

* step 3: compare coefficients from the outputs of models 1 and 3
