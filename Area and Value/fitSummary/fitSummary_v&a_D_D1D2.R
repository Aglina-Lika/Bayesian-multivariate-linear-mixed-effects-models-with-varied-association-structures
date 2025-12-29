
filenames = as.list(dir(pattern="summary_*"))


names(filenames)<-unlist(filenames)

Fitsummary<-list()


for(i in 1:200){
  
  Fitsummary[i]<-list(get(load(paste(filenames[i]))))
  
  
}



names(Fitsummary) <- names(filenames)

df_summary = data.frame(matrix(vector(), 200, 49,
                               dimnames=list(c(), c("RData", 
                                                     "mean_alphaV","n_eff_alphaV", "Rhat_alphaV",
                                                    # "mean_alphaD","n_eff_alphaD", "Rhat_alphaD",
                                                    "mean_alphaA","n_eff_alphaA", "Rhat_alphaA",
                                                    "mean_beta11","n_eff_beta11", "Rhat_beta11",
                                                    "mean_beta12","n_eff_beta12", "Rhat_beta12",
                                                    "mean_beta13","n_eff_beta13", "Rhat_beta13",
                                                    "mean_beta21","n_eff_beta21", "Rhat_beta21",
                                                    "mean_beta22","n_eff_beta22", "Rhat_beta22",
                                                    "mean_beta23","n_eff_beta23", "Rhat_beta23",
                                                    "mean_sigma1","n_eff_sigma1", "Rhat_sigma1",
                                                    "mean_sigma2","n_eff_sigma2", "Rhat_sigma2",
                                                    "mean_D111","n_eff_D111", "Rhat_D111",
                                                    "mean_D112","n_eff_D112", "Rhat_D112",
                                                    
                                                    "mean_D122","n_eff_D122", "Rhat_D122",
                                                    
                                                    "mean_D211","n_eff_D211", "Rhat_D211",
                                                    "mean_D212","n_eff_D212", "Rhat_D212",
                                                    
                                                    "mean_D222","n_eff_D222", "Rhat_D222"
                                                    
                                                    
                               ))),
                        stringsAsFactors=F) 
for (i in 1:200){
  
  tmp_df = Fitsummary[[i]]
  df_summary[i,]$RData = filenames[i]
  
   df_summary[i,]$mean_alphaV = tmp_df[1,]$mean
   df_summary[i,]$n_eff_alphaV = tmp_df[1,]$n_eff
   df_summary[i,]$Rhat_alphaV = tmp_df[1,]$Rhat
 
  
  df_summary[i,]$mean_alphaA = tmp_df[2,]$mean
  df_summary[i,]$n_eff_alphaA = tmp_df[2,]$n_eff
  df_summary[i,]$Rhat_alphaA = tmp_df[2,]$Rhat
  
  df_summary[i,]$mean_beta11 = tmp_df[3,]$mean
  df_summary[i,]$n_eff_beta11 = tmp_df[3,]$n_eff
  df_summary[i,]$Rhat_beta11 = tmp_df[3,]$Rhat
  
  df_summary[i,]$mean_beta12 = tmp_df[4,]$mean
  df_summary[i,]$n_eff_beta12 = tmp_df[4,]$n_eff
  df_summary[i,]$Rhat_beta12 = tmp_df[4,]$Rhat
  
  df_summary[i,]$mean_beta13 = tmp_df[5,]$mean
  df_summary[i,]$n_eff_beta13 = tmp_df[5,]$n_eff
  df_summary[i,]$Rhat_beta13 = tmp_df[5,]$Rhat
  
  df_summary[i,]$mean_beta21 = tmp_df[6,]$mean
  df_summary[i,]$n_eff_beta21 = tmp_df[6,]$n_eff
  df_summary[i,]$Rhat_beta21 = tmp_df[6,]$Rhat
  
  df_summary[i,]$mean_beta22 = tmp_df[7,]$mean
  df_summary[i,]$n_eff_beta22 = tmp_df[7,]$n_eff
  df_summary[i,]$Rhat_beta22 = tmp_df[7,]$Rhat
  
  df_summary[i,]$mean_beta23 = tmp_df[8,]$mean
  df_summary[i,]$n_eff_beta23 = tmp_df[8,]$n_eff
  df_summary[i,]$Rhat_beta23 = tmp_df[8,]$Rhat
  
  df_summary[i,]$mean_sigma1 = tmp_df[9,]$mean
  df_summary[i,]$n_eff_sigma1 = tmp_df[9,]$n_eff
  df_summary[i,]$Rhat_sigma1 = tmp_df[9,]$Rhat
  
  df_summary[i,]$mean_sigma2 = tmp_df[10,]$mean
  df_summary[i,]$n_eff_sigma2 = tmp_df[10,]$n_eff
  df_summary[i,]$Rhat_sigma2 = tmp_df[10,]$Rhat
  
  df_summary[i,]$mean_D111 = tmp_df[11,]$mean
  df_summary[i,]$n_eff_D111 = tmp_df[11,]$n_eff
  df_summary[i,]$Rhat_D111 = tmp_df[11,]$Rhat
  
  df_summary[i,]$mean_D112 = tmp_df[12,]$mean
  df_summary[i,]$n_eff_D112 = tmp_df[12,]$n_eff
  df_summary[i,]$Rhat_D112 = tmp_df[12,]$Rhat
  
  df_summary[i,]$mean_D122 = tmp_df[14,]$mean
  df_summary[i,]$n_eff_D122 = tmp_df[14,]$n_eff
  df_summary[i,]$Rhat_D122 = tmp_df[14,]$Rhat
  
  df_summary[i,]$mean_D211 = tmp_df[15,]$mean
  df_summary[i,]$n_eff_D211 = tmp_df[15,]$n_eff
  df_summary[i,]$Rhat_D211 = tmp_df[15,]$Rhat
  
  df_summary[i,]$mean_D212 = tmp_df[16,]$mean
  df_summary[i,]$n_eff_D212 = tmp_df[16,]$n_eff
  df_summary[i,]$Rhat_D212 = tmp_df[16,]$Rhat
  
  df_summary[i,]$mean_D222 = tmp_df[18,]$mean
  df_summary[i,]$n_eff_D222 = tmp_df[18,]$n_eff
  df_summary[i,]$Rhat_D222 = tmp_df[18,]$Rhat
  

}


save(df_summary,file="value+area_D_D1D2.RData")


get_bias = function(estimate, truth) {
  (mean(estimate) - truth)/truth
}
get_mse = function(estimate, truth) {
  mean((estimate - truth) ^ 2)
}


bias_alphaV = round(get_bias(df_summary$mean_alphaV, 1.63),5)
bias_alphaV
mse_alphaV = get_mse(df_summary$mean_alphaV, 1.63)
mse_alphaV
var(df_summary$mean_alphaV)


bias_alphaA = round(get_bias(df_summary$mean_alphaA, 0.9),5)
bias_alphaA
mse_alphaA = get_mse(df_summary$mean_alphaA, 0.9)
mse_alphaA
var(df_summary$mean_alphaA)
