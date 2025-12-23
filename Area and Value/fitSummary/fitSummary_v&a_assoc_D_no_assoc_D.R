
filenames = as.list(dir(pattern="summary_*"))

names(filenames)<-unlist(filenames)

Fitsummary<-list()


for(i in 1:200){

Fitsummary[i]<-list(get(load(paste(filenames[i]))))


}



names(Fitsummary) <- names(filenames)

df_summary = data.frame(matrix(vector(), 200, 55,
                        dimnames=list(c(), c("RData", 
                                            # "mean_alphaV","n_eff_alphaV", "Rhat_alphaV",
                                            # "mean_alphaD","n_eff_alphaD", "Rhat_alphaD",
                                           #  "mean_alphaA","n_eff_alphaA", "Rhat_alphaA",
                                           "mean_beta11","n_eff_beta11", "Rhat_beta11",
                                           "mean_beta12","n_eff_beta12", "Rhat_beta12",
                                           "mean_beta13","n_eff_beta13", "Rhat_beta13",
                                           "mean_beta21","n_eff_beta21", "Rhat_beta21",
                                           "mean_beta22","n_eff_beta22", "Rhat_beta22",
                                           "mean_beta23","n_eff_beta23", "Rhat_beta23",
                                             "mean_sigma1","n_eff_sigma1", "Rhat_sigma1",
                                             "mean_sigma2","n_eff_sigma2", "Rhat_sigma2",
                                             "mean_D11","n_eff_D11", "Rhat_D11",
                                             "mean_D12","n_eff_D12", "Rhat_D12",
                                             "mean_D13","n_eff_D13", "Rhat_D13",
                                             "mean_D14","n_eff_D14", "Rhat_D14",

                                             "mean_D22","n_eff_D22", "Rhat_D22",
                                             "mean_D23","n_eff_D23", "Rhat_D23",
                                             "mean_D24","n_eff_D24", "Rhat_D24",
                                             "mean_D33","n_eff_D33", "Rhat_D33",
                                             "mean_D34","n_eff_D34", "Rhat_D34",
                                             "mean_D44","n_eff_D44", "Rhat_D44"
                                            ))),
                        stringsAsFactors=F) 
for (i in 1:200){
  
    tmp_df = Fitsummary[[i]]
    df_summary[i,]$RData = filenames[i]

    
    df_summary[i,]$mean_beta11 = tmp_df[1,]$mean
    df_summary[i,]$n_eff_beta11 = tmp_df[1,]$n_eff
    df_summary[i,]$Rhat_beta11 = tmp_df[1,]$Rhat
    
    df_summary[i,]$mean_beta12 = tmp_df[2,]$mean
    df_summary[i,]$n_eff_beta12 = tmp_df[2,]$n_eff
    df_summary[i,]$Rhat_beta12 = tmp_df[2,]$Rhat
    
    df_summary[i,]$mean_beta13 = tmp_df[3,]$mean
    df_summary[i,]$n_eff_beta13 = tmp_df[3,]$n_eff
    df_summary[i,]$Rhat_beta13 = tmp_df[3,]$Rhat
    
    df_summary[i,]$mean_beta21 = tmp_df[4,]$mean
    df_summary[i,]$n_eff_beta21 = tmp_df[4,]$n_eff
    df_summary[i,]$Rhat_beta21 = tmp_df[4,]$Rhat
    
    df_summary[i,]$mean_beta22 = tmp_df[5,]$mean
    df_summary[i,]$n_eff_beta22 = tmp_df[5,]$n_eff
    df_summary[i,]$Rhat_beta22 = tmp_df[5,]$Rhat
    
    df_summary[i,]$mean_beta23 = tmp_df[6,]$mean
    df_summary[i,]$n_eff_beta23 = tmp_df[6,]$n_eff
    df_summary[i,]$Rhat_beta23 = tmp_df[6,]$Rhat

    df_summary[i,]$mean_sigma1 = tmp_df[7,]$mean
    df_summary[i,]$n_eff_sigma1 = tmp_df[7,]$n_eff
    df_summary[i,]$Rhat_sigma1 = tmp_df[7,]$Rhat
    
    df_summary[i,]$mean_sigma2 = tmp_df[8,]$mean
    df_summary[i,]$n_eff_sigma2 = tmp_df[8,]$n_eff
    df_summary[i,]$Rhat_sigma2 = tmp_df[8,]$Rhat
    
    df_summary[i,]$mean_D11 = tmp_df[9,]$mean
    df_summary[i,]$n_eff_D11 = tmp_df[9,]$n_eff
    df_summary[i,]$Rhat_D11 = tmp_df[9,]$Rhat
    
    df_summary[i,]$mean_D12 = tmp_df[10,]$mean
    df_summary[i,]$n_eff_D12 = tmp_df[10,]$n_eff
    df_summary[i,]$Rhat_D12 = tmp_df[10,]$Rhat
    
    
    df_summary[i,]$mean_D13 = tmp_df[11,]$mean
    df_summary[i,]$n_eff_D13 = tmp_df[11,]$n_eff
    df_summary[i,]$Rhat_D13 = tmp_df[11,]$Rhat
    
    df_summary[i,]$mean_D14 = tmp_df[12,]$mean
    df_summary[i,]$n_eff_D14 = tmp_df[12,]$n_eff
    df_summary[i,]$Rhat_D14 = tmp_df[12,]$Rhat
        
    df_summary[i,]$mean_D22 = tmp_df[14,]$mean
    df_summary[i,]$n_eff_D22 = tmp_df[14,]$n_eff
    df_summary[i,]$Rhat_D22 = tmp_df[14,]$Rhat
    
    df_summary[i,]$mean_D23 = tmp_df[15,]$mean
    df_summary[i,]$n_eff_D23 = tmp_df[15,]$n_eff
    df_summary[i,]$Rhat_D23 = tmp_df[15,]$Rhat
    
    
    df_summary[i,]$mean_D24 = tmp_df[16,]$mean
    df_summary[i,]$n_eff_D24 = tmp_df[16,]$n_eff
    df_summary[i,]$Rhat_D24 = tmp_df[16,]$Rhat
    
    df_summary[i,]$mean_D33 = tmp_df[19,]$mean
    df_summary[i,]$n_eff_D33 = tmp_df[19,]$n_eff
    df_summary[i,]$Rhat_D33 = tmp_df[19,]$Rhat
    
    df_summary[i,]$mean_D34 = tmp_df[20,]$mean
    df_summary[i,]$n_eff_D34 = tmp_df[20,]$n_eff
    df_summary[i,]$Rhat_D34 = tmp_df[20,]$Rhat
    
    df_summary[i,]$mean_D44 = tmp_df[24,]$mean
    df_summary[i,]$n_eff_D44 = tmp_df[24,]$n_eff
    df_summary[i,]$Rhat_D44 = tmp_df[24,]$Rhat
    
    }



save(df_summary,file="value+area_D_D_no_of_them.RData")


get_bias = function(estimate, truth) {
  (mean(estimate) - truth)/truth
}
get_mse = function(estimate, truth) {
  mean((estimate - truth) ^ 2)
}
