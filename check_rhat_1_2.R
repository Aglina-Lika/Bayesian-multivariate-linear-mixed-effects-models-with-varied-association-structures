
#---------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------

# function to check which coefs have converged and which not 

f_rhat<-function(data,r_hat_num){
  
  
  w_a_d_d<-l_a_d_d<-rhat_a_d_d<-NULL 
  
  for (i in r_hat_num){
    
    l_a_d_d<-c(l_a_d_d,length(which(round(data[,i],1)>=1.2)))
    w_a_d_d<-c(w_a_d_d,which(round(data[,i],1)>=1.2)) 
    rhat_a_d_d<-c(rhat_a_d_d,data[which(round(data[,i],1)>=1.2),i])
  }
  
  
    
    if(length(w_a_d_d)!=0){
      
      u1<-unique(w_a_d_d) # 4, 85, 9, 147
      n<-length(unique(w_a_d_d)) # 4 
      
      data_new<-data[-u1,]
      n_new<-dim(data_new)[1] 
      
    }else{
      
      u1<-0# 4, 85, 9, 147
      n<-0 # 4 
      
      data_new<-data
      n_new<-dim(data_new)[1] 
      
    }
    
    
    return(list(l_a_d_d=l_a_d_d,w_a_d_d=w_a_d_d,u1=u1,n=n,data_new=data_new,n_new=n_new,rhat_a_d_d=rhat_a_d_d))
  }
  
  