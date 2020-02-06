# CREATED   4 Mar 2017
# MODIFIED  6 Feb 2020


### Sample of age data
age.data <- read.csv("../Data/NSW yellowtail scad Age data.csv", row.names = 1)
age.data <- age.data[, -seq(20,25)]

# What if we replace NAs
#age.data[which(is.na(rowSums(age.data))),] <- age.data[sample(which(!is.na(rowSums(age.data))),8, replace = TRUE),]

# Put 10 times more data
#age.data <- 100 * age.data

# Create age-group 17 as a +group
#age.data.17Plus <- age.data[,1:19]
#age.data.17Plus[,19] <- rowSums(age.data[,19:25], na.rm = TRUE)

### Load purse seine catch and effort
ce <- read.csv("../Data/NSW yellowtail scad catch and effort.csv", row.names = 1)[, c("purseseine","PSdays")]

catch <- ce[1:nrow(age.data),1] * 1e3
effort.mat <- outer(ce[1:nrow(age.data),2], rep(1,ncol(age.data)))

### Mean weight at age
mwa <- read.csv("../Data/Mean weight at age.csv")
mean.weight.at.age.mat <- outer(rep(1, nrow(age.data)), mwa[1:19,2])

### Estimate the number of fish in the catch
source("UsefulFunctions.R")

estimated.nb.in.catch <- Estimate.NbOfFishInCatch(catch, age.data, mean.weight.at.age.mat)

# Correct age sample by the estimated number of fish in the catch
nb.at.age.wgt <- weighted.sample2(age.data, estimated.nb.in.catch)
nb.at.age.wgt<- as.matrix(nb.at.age.wgt)
