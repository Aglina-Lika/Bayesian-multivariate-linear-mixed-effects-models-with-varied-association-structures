# Bayesian-multivariate-linear-mixed-effects-models-with-varied-association-structures

This repository includes the code for fitting Bayesian multivariate linear mixed effects models (2 continuous longitudinal outcomes) assuming that the 2 continuous outcomes are associated from different association structures (value, area and both) and or via the random effects.

Specifically:
* folder "stan" includes the STAN codes for the fitting of the models.
* folder "simulations" include the R codes which simulate data from the STAN model that generated them or a model to which we have misspecified the relationship of the random effects or we have ingnored the asssociation strcucture (value, area and both).
