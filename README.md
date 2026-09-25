# Analyzing Correlation between Patient Attributes and Heart Disease

STA3000 project examining which patient attributes are associated with the
presence of heart disease, using chi-square tests to screen categorical predictors and a
logistic regression model to estimate adjusted effects.

**Data:** UCI Statlog (Heart) dataset — 270 patient records, 13 attributes, no missing values.
**Tools:** R (`glm`, `chisq.test`)

## Process

1. **Cleaning** — recoded the binary response from 1/2 to 0/1, converted 8 categorical
   predictors to factors with readable labels
2. **Distribution checks** — histograms for the five continuous predictors; skipped
   Shapiro-Wilk given n = 270 and checked shape visually instead
3. **Association screening** — boxplots of each continuous predictor against the response,
   chi-square tests of independence for each categorical predictor
4. **Modeling** — multiple logistic regression, then exponentiated coefficients to
   odds ratios for the significant predictors

## Findings

Every categorical predictor except fasting blood sugar showed a significant association
with heart disease under chi-square testing. In the logistic model, six predictors were
significant at the 5% level: sex, asymptomatic chest pain, ST depression (oldpeak), a flat
ST slope, reversible thalassemia defect, and number of major vessels.

The largest single effect was asymptomatic chest pain — roughly ten times the odds of
heart disease compared to typical angina, holding other attributes constant. That cuts
against the intuition that the most recognizable symptom is the most predictive one, which
matters for awareness: more than half of U.S. adults do not know heart disease is the
leading cause of death.

## What this analysis cannot support

- **n = 270 is small** for a model with this many predictors. The odds ratios on major
  vessels in particular are likely unstable.
- **The data is cross-sectional**, so these are associations, not causal effects.
- **The records date from 1988.** Diagnostic standards have changed since.
- **These are patients already referred for cardiac testing**, not a general population
  sample, so base rates here are far higher than they would be in the community.

No packages required beyond base R.
