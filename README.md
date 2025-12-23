# Bayesian-multivariate-linear-mixed-effects-models-with-varied-association-structures

This repository includes the code for fitting Bayesian multivariate linear mixed effects models (2 continuous longitudinal outcomes) assuming that the 2 continuous outcomes are associated from different association structures (value, area and both) and or via the random effects.

Specifically:
* the subfolders "STAN codes" include the STAN codes for the fitting the desired models.
* the subfolders "simulations+Fit" include the R codes which simulate data and fits the STAN model that generated them or a model to which we have misspecified the relationship of the random effects or we have ingnored the asssociation strcucture (i.e., value, area and both depending on which case we are).
* the folder "FitSummary" includes the R codes which create the .RData file which containt all the estimates from the fitted model.
* The extractFrames_new is a function that everytime provides us the tables that are required for a specific parametrization and variable transformation.
  
How does it work:
*	Download all files and place them in one folder as they are specified here.
*	Set as working directory in R the folder of the model that you would like to fit.
*	Run the codes which contain the name with "simFunc_" to simulate dataset and fit the desired Bayesian multivariate linear mixed effects models. 
