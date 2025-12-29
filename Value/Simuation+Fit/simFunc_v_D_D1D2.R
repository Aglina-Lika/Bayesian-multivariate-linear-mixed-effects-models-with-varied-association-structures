library(MASS)
library(nlme)
library(rstan)
#library(JMbayes)
library(splines)

N = 100; K = 5; t.max = 15; # number of subject; number of planned repeated measurements per subject, per outcome; maximum time of follow-up
beta11 = 3.01; beta12 = 0.47; beta13=1.5; # parameters for the linear mixed effects model 1  
beta21 = 2.15; beta22 = 0.91; beta23=1.3; # parameters for the linear mixed effects model 2
sigma2 = 1 # measurement error standard deviation

alphaV = 1.63 # association parameters - value
# variance-covariance matrix for the random effects
D = diag(1, nrow=4, ncol=4) # var-cov matrix
#####################################################################################
# request the extractFrames_NEW.R

source("extractFrames_NEW.R")

extractFrames<-extractFrames_new
#####################################################################################
# define an empty object to save the time that is requested for the STAN model to run
time_ela<-NULL
# for loop simulate 200 datasets and fit the STAN model to each of these datasets 
for (i in 191:200){
  
  set.seed(i+1234)
  ############
  # Simulate #
  ############
  
  n <- N  # number of subjects 
  K <- K  # number of planned repeated measurements per subject 
  t.max <- t.max # maximum follow-up time
  
  # Parameters for the linear mixed effects model 1
  betas1 <- c("(Intercept)" = beta11, "year" = beta12, "sex"=beta13)
  # Parameters for the linear mixed effects model 2
  betas2 <- c("(Intercept)" = beta21, "year" = beta22, "sex"=beta23)
  sigma.y <- sqrt(sigma2)  # measurement error standard deviation
  
  year1 = c(replicate(N, c(0, sort(runif(K-1, 0, t.max))))) # replicate time values for each subject who has values for the 1st outcome                    
  year2 = c(replicate(N, c(0, sort(runif(K-1, 0, t.max))))) # replicate time values for each subject who has values for the 2nd outcome                 
  sex <- sample(c(rep(0, n/2), rep(1, n/2))) # rep(0:1, each = n/2) # group indicator, i.e., '0' male, '1' female
  # create a data frame which contains sex, year1 and year2 
  DF <- data.frame(sex = factor(rep(sex, each = K)), year1, year2)  
  
  #####################################################################################
  # design matrices for the longitudinal measurement model(1 and 2)
  # but this can be easily generalized 
  X1 <- model.matrix(~ year1+sex , data = DF)
  X2 <- model.matrix(~ year2+sex,  data = DF)
  Z1 <- model.matrix(~ year1, data = DF)
  Z2 <- model.matrix(~ year2, data = DF)
  
  
  #####################################################################################
  # simulate random effects 
  b <- mvrnorm(n, rep(0, 4), Sigma = D)
  b <- as.matrix(b)
  
  # Simulate longitudinal responses
  id <- rep(1:n, each = K)
  eta.y1 <- as.vector(X1 %*% betas1 + rowSums(Z1 * b[id, 1:2])) # underlying value but, at the times of y1 
  y1 <- rnorm(n * K, eta.y1, sigma.y)
  
  eta.y1_m <- as.vector(X2 %*% betas1 + rowSums(Z2 * b[id, 1:2])) # underlying value at the times of the 2nd outcome
  
  eta.y2 <- as.vector(X2 %*% betas2 + rowSums(Z2 * b[id, 3:4])) + alphaV * eta.y1_m
  y2 <- rnorm(n * K, eta.y2, sigma.y)
  
  # Final data set
  data <- data.frame(y1 = y1, y2 = y2, id = id, year1 = DF$year1, year2 = DF$year2, sex=DF$sex)
  
  #####################################################################################
  
  #######
  # Fit #
  #######
  
  formulas = list(y1 ~ year1 + sex + ( year1 | id),
                  y2 ~ year2 + sex + ( year2 | id))
  data = data
  families = list(gaussian, gaussian)
  engine =  "STAN"
  overdispersion = FALSE
  priors = NULL
  init = NULL
  control = NULL
  optionHC = "NHC" # "NHC"
  scaling =  "standardize"  
  
  #########################################################################
  # to run the STAN model you need to create a list with all the required tables and vectors  
  Data <- list(n=n,n_RE_1=2,n_RE_2=2,N1=n*K,ncx1=3,id1=id,RE_ind1=1:2,y1=y1,Z_1=Z1,X1=X1,
               N2=n*K,ncx2=3,id2=id,RE_ind2=1:2,y2=y2,Z_2=Z2,X2=X2,
               scale_betas1=10,scale_betas2=10,scale_sigmas=5,scale_diag_D=3,lkj_shape=2)
  
  # fit the STAN model 
  
  fit <- stan(file = "Value//STAN codes//funcForm_value_D1D2.stan", 
              data = Data, chains = 4, iter = 2000, thin = 1, 
              control = list(max_treedepth = 20, adapt_delta = 0.99))
  # save the time of the STAN model of the i-th simulation  
   time_ela[i]<-sum(get_elapsed_time(fit))/(60*60)  
   # save the summary table of the model but only for the parameters specified in the pars
  summary1 = as.data.frame(summary(fit, 
                                  pars = c("temp_alphaV","temp_betas1","temp_betas2","sigma1","sigma2","D_1","D_2"))$summary)
  
  save(summary1, file = paste0("Value//V_D_D1D2//summary_", i, ".RData"))
}

