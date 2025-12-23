data {
  int n;
  int n_RE_1;
  int n_RE_2;
  int N1;
  int ncx1;
  int id1[N1];
  int RE_ind1[2];
  vector[N1] y1;
  matrix[N1, 2] Z_1;
  matrix[N1, 3] X1;
  int N2;
  int ncx2;
  int id2[N2];
  int RE_ind2[2];
  vector[N2] y2;
  matrix[N2, 2] Z_2;
  matrix[N2, 3] X2;
  real<lower=0> scale_betas1;
  real<lower=0> scale_betas2;
  real<lower=0> scale_sigmas;
  real<lower=0> scale_diag_D;
  real<lower=0> lkj_shape;
  
  
 
 // int ncXA_derivY1;
//  int ncZA_derivY1;
 // matrix[N1, ncXA_derivY1] XAderivY1;
 // matrix[N1, ncZA_derivY1] ZAderivY1;
  
  int ncXA_derivY2;
  int ncZA_derivY2;
  matrix[N2, ncXA_derivY2] XAderivY2;
  matrix[N2, ncZA_derivY2] ZAderivY2; 
  
  
}

parameters {
  vector[3] temp_betas1;
  real<lower = 0> sigma1;
  vector[3] temp_betas2;
  real<lower = 0> sigma2;
  matrix[n, n_RE_1] b_1;
  vector<lower = 0>[n_RE_1] L_var_D_1;
  cholesky_factor_corr[n_RE_1] L_corr_D_1;
  matrix[n, n_RE_2] b_2;
  vector<lower = 0>[n_RE_2] L_var_D_2;
  cholesky_factor_corr[n_RE_2] L_corr_D_2;

  real temp_alphaV;
  real temp_alphaA;
}

transformed parameters {
  vector[N1] y1_hat;
  vector[N2] y1_m;
  vector[N2] y2_hat;
 // vector[N1] fA_derivY1;
  vector[N2] fA_derivY1_m;
  
  
  for (j1 in 1:N1) {
    y1_hat[j1] = X1[j1, 1] * temp_betas1[1] + X1[j1, 2] * temp_betas1[2] + X1[j1, 3] * temp_betas1[3] + Z_1[j1,1] * b_1[id1[j1], RE_ind1[1]] + Z_1[j1,2] * b_1[id1[j1], RE_ind1[2]];
  }
 
 // for (j1 in 1:N1) {
   // fA_derivY1[j1]= XAderivY1[j1, 1] * temp_betas1[1] + XAderivY1[j1, 2] * temp_betas1[2]+ XAderivY1[j1, 3] * temp_betas1[3]+ ZAderivY1[j1, 1] * b[id1[j1], 1] + ZAderivY1[j1, 2] * b[id1[j1], 2];
 // }
  
 //  unstandardized version of fA_derivY1
  for (j2 in 1:N2) {
        y1_m[j2] = X2[j2, 1] * temp_betas1[1] + X2[j2, 2] * temp_betas1[2] + X2[j2, 3] * temp_betas1[3] + Z_2[j2,1] * b_1[id2[j2], RE_ind1[1]] + Z_2[j2,2] * b_1[id2[j2], RE_ind1[2]];
    
        fA_derivY1_m[j2]= XAderivY2[j2, 1] * temp_betas1[1] + XAderivY2[j2, 2] * temp_betas1[2] + XAderivY2[j2, 3] * temp_betas1[3] + ZAderivY2[j2, 1] * b_1[id2[j2], 1] + ZAderivY2[j2, 2] * b_1[id2[j2], 2];
    
    
    y2_hat[j2] = X2[j2, 1] * temp_betas2[1] + X2[j2, 2] * temp_betas2[2] + X2[j2, 3] * temp_betas2[3] + Z_2[j2,1] * b_2[id2[j2], RE_ind2[1]] + Z_2[j2,2] * b_2[id2[j2], RE_ind2[2]] + temp_alphaV * y1_m[j2]+ temp_alphaA * fA_derivY1_m[j2];
  }
  
}

model {
  matrix[n_RE_1, n_RE_1] L_D_1;
  vector[n_RE_1] mu_1;
  matrix[n_RE_2, n_RE_2] L_D_2;
  vector[n_RE_2] mu_2;
  
  L_D_1 = diag_pre_multiply(L_var_D_1, L_corr_D_1);
  L_var_D_1 ~ cauchy(0, scale_diag_D);
  L_corr_D_1 ~ lkj_corr_cholesky(lkj_shape);
  mu_1 = rep_vector(0, n_RE_1);
  for (i in 1:n) {
    b_1[i, ] ~ multi_normal_cholesky(mu_1, L_D_1);
  }

  L_D_2 = diag_pre_multiply(L_var_D_2, L_corr_D_2);
  L_var_D_2 ~ cauchy(0, scale_diag_D);
  L_corr_D_2 ~ lkj_corr_cholesky(lkj_shape);
  mu_2 = rep_vector(0, n_RE_2);
  for (i in 1:n) {
    b_2[i, ] ~ multi_normal_cholesky(mu_2, L_D_2);
  }


  for (k1 in 1:3) {
    temp_betas1[k1] ~ normal(0.0, scale_betas1);
  }
  for (k2 in 1:3) {
    temp_betas2[k2] ~ normal(0.0, scale_betas2);
  }
  sigma1 ~ cauchy(0, scale_sigmas);
  y1 ~ normal(y1_hat, sigma1);
  sigma2 ~ cauchy(0, scale_sigmas);
  y2 ~ normal(y2_hat, sigma2);
  temp_alphaV ~ normal(0.0, 10); 
  temp_alphaA ~ normal(0.0, 10);
}

generated quantities {
   matrix[n_RE_1, n_RE_1] D_1;
 matrix[n_RE_2, n_RE_2] D_2;
  D_1 = diag_pre_multiply(L_var_D_1, L_corr_D_1) * diag_pre_multiply(L_var_D_1, L_corr_D_1)';
  D_2 = diag_pre_multiply(L_var_D_2, L_corr_D_2) * diag_pre_multiply(L_var_D_2, L_corr_D_2)';

}
