# Bayesian-multivariate-linear-mixed-effects-models-with-varied-association-structures

This repository includes the code for fitting Bayesian multivariate linear mixed effects models (of 2 continuous longitudinal outcomes $Y_1$ and $Y_2$) assuming that the continuous outcome $Y_2$ (primary outcome of interest) is associated with the outcome $Y_1$ via the random effects and/or different association structures. Specifically, including as time-varying covariates different functional forms of the outcome $Y_1$ in the submodel of $Y_2$: current value of $Y_1$ at time t (V), total cumulative effect (area under the curve) of $Y_1$ until time t (A) or both of them (V+A). 


Every folder (i.e., Area, Value, and Area and Value) contains these subfolders:  
* **STAN codes:** includes the STAN codes for fitting the desired models. For example in the folder Area we have the STAN codes:
   - *funcForm_a_assoc_D_no_assoc_D.stan:* a Bayesian multivariate linear mixed effects model where the outcomes are associated only from the random effects assuming a stacked vector of random effects $b_i~MVN(0,D)$ ($\boldsymbol{b}^\top_{i}={(\boldsymbol{b}^\top_{i,1},\boldsymbol{b}^\top_{i,2})} \sim \text{MVN}(\boldsymbol{0},\boldsymbol{D})$) 
   - *funcForm_a_assoc_D1D2_no_assoc_D1D2.stan:* a Bayesian multivariate linear mixed effects model where the outcomes are not associated at all. Independent random effects (unstacked random effects vector) so that we have $\boldsymbol{b}_{i,1}^\top \sim \text{MVN}(\boldsymbol{0},\boldsymbol{D_1})$ and $\boldsymbol{b}_{i,2}^\top \sim \text{MVN}(\boldsymbol{0},\boldsymbol{D_2})$ 
   - *funcForm_a_D.stan:* a Bayesian multivariate linear mixed effects model where the outcomes are associated via the random effects and via the area under the curve of the outcome $Y_1$ 
   - *funcForm_a_D1D2.stan:*  a Bayesian multivariate linear mixed effects model where the outcomes are not associated via the random effects but only via the area under the curve of the outcome $Y_1$

**Note:** The naming of the STAN codes in the other folders is similar to this with the difference that we have different functional form of the outcome $Y_1$. Therefore, in the naming it is observed v if we include the current value of $Y_1$ or v&a if we include the current value and the area under the curve of the outcome $Y_1$.

* **Simulation+Fit":** includes the R codes which simulate data under a specific scenario and fits the STAN model that generated them or a model to which we have misspecified the relationship of the random effects or we have ingnored the asssociation strcucture (i.e., value, area or both depending on which case we are). For example for the Area we have:
   - *simFunc_a_assoc_D_no_assoc_D:* simulate data from a multivariate linear mixed effects model at which the 2 outcomes are associated via the area under the curve of the outcome $Y_1$ and the random effects but fit for them a Bayesian multivariate linear mixed effects model which assumes that they are associated only via their random effects. 
   - *simFunc_a_assoc_D1D2_no_assoc_D1D2:* simulate data from a multivariate linear mixed effects model at which the 2 outcomes are associated only via the area under the curve of the outcome $Y_1$ but fit for them a Bayesian multivariate linear mixed effects model which assumes that they are not associated at all.
   - *simFunc_a_D_D:* simulate data from a multivariate linear mixed effects model at which the 2 outcomes are associated via the area under the curve of the outcome $Y_1$ and the random effects and fit for them a Bayesian multivariate linear mixed effects model which assumes the same association structure. 
   - *simFunc_a_D_D1D2:* simulate data from a multivariate linear mixed effects model at which the 2 outcomes are associated via the area under the curve of the outcome $Y_1$ and the random effects and fit for them a Bayesian multivariate linear mixed effects model which assumes that they are associated only via the area under the curve of the outcome $Y_1$.  
   - *simFunc_a_D1D2_D:* simulate data from a multivariate linear mixed effects model at which the 2 outcomes are associated only via the area under the curve of the outcome $Y_1$ and fit for them a Bayesian multivariate linear mixed effects model which assumes that they are associated via the area under the curve of the outcome $Y_1$ and the random effects.  
   - *simFunc_a_D1D2_D1D2:* simulate data from a multivariate linear mixed effects model at which the 2 outcomes are associated only via the area under the curve of the outcome $Y_1$ and fit for them a Bayesian multivariate linear mixed effects model which assumes the same association structure. 

**Note:** The naming of the files in the other subfolders "Simulation+Fit" is similar to this with the difference that we have different functional form of the outcome $Y_1$. Therefore, in the naming it is observed v if we include the current value of $Y_1$ or v&a if we include the current value and the area under the curve of the outcome $Y_1$.

* **FitSummary:** includes the R codes which create the .RData file which containts all the estimates from all 200 fitted models of each case. The naming of each code in this file is similar to the code of the model that was fitted with the only difference that we do not have "simFunc_" but "funcForm_". 

In this repository, we also need the attached R files:
* **extractFrames_new:** R function that everytime provides us the tables that are required for a specific parametrization and variable transformation.
* **check_rhat_1_2:** R functions that checks if the Rhats of the estimated parameters are greater than 1.2 or not. If there are, it deletes from the provided dataset the lines that had Rhat >1.2. The function provides in the end a list with objects such as number of lines with Rhat >1.2, new dataset and its dimensions etc. 
  
How does it work:
*	Download all files and folders and place them in one folder as they are specified here.
*	in the folders Area, Value and, Area and Value create subfolders as specified below

For Area
  - A_D_D, A_D1D2_D1D2, A_D_D1D2, A_D1D2_D, A_assoc_D_no_assoc_D, A_assoc_D1D2_no_assoc_D1D2 and gathered_results
  - 
For value
  - V_D_D, V_D1D2_D1D2, V_D_D1D2, V_D1D2_D, V_assoc_D_no_assoc_D, V_assoc_D1D2_no_assoc_D1D2 and gathered_results
    
For Area and Value
   - V_A_D_D, V_A_D1D2_D1D2, V_A_D_D1D2, V_A_D1D2_D, V_A_assoc_D_no_assoc_D, V_A_assoc_D1D2_no_assoc_D1D2 and gathered_results

**Note:** The naming of the subfolders is similar to the R codes of the fitted models in the subfolder Simulation+Fit. 

*	Set as working directory in all R codes of the subfolders Simulation+Fit and FitSummary the main folder that you saved the downloaded files and folders.
*	Run the codes in the subfolders Simulation+Fit to simulate datasets and fit the desired Bayesian multivariate linear mixed effects models
*	Run the codes the subfolders FitSummary to create a dataframe which contains all the summary tables of the 200 simulated datasets of the specified model. This overall summary table (data frame) is saved in the subfolder gathered_results of the folders Area, Value, or, Area and Value.   
