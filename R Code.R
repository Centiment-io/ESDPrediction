data<-read.csv("C:/Users/Keith/Desktop/structured.csv")
setwd("C:/Users/Keith/Desktop")
#install.packages("TSA")
#install.packages("astsa")
library(TSA)
library(astsa)
#plot data
date <- seq(as.Date("2011/11/1"), as.Date("2015/07/31"), by = "month")
job<-as.vector(data$TotalJobs)
plot(date,job,xlab="Time",ylab="Total Jobs", main = NULL)
abline(a=mean(job),b=0)
#correlation detection
acf(job, main = NULL)
pacf(job, main = NULL)
plot(diff(job,lag=12))
acf(diff(job,lag=12),lag.max=36)
pacf(diff(job,lag=12),lag.max=36)
#build model
demean.job<-job-mean(job)
jobmodel<-arima(demean.job, order=c(1,0,0), seasonal = list(order=c(1,1,0),period = 12))
#check residuals corr?
plot(window(rstandard(jobmodel)),type="o", ylab="Standardized Residual")
acf(as.vector(window(rstandard(jobmodel))))
pacf(as.vector(window(rstandard(jobmodel))))
#predict
job.pred.0<-plot(jobmodel,n.ahead = 60, ylab="Total Jobs - Mean")$pred
abline(a=0,b=0)
job.pred<-as.vector(job.pred.0+mean(job))
#plot result
TotalJobs<-c(job,job.pred)
new.date<-seq(as.Date("2011/11/1"), as.Date("2020/07/31"), by = "month")
plot(new.date,TotalJobs, type = "o",xlab = "Time", ylab = "Total Jobs")
abline(a=mean(job),b=0)
#save prediced values for 5 years
write.csv(job.pred, "PreDicted Total jobs.csv")
