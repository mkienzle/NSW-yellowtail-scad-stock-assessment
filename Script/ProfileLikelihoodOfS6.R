
# CREATED   3 March 2017
# MODIFIED 14 March 2017

# PURPOSE characterise the profile likelihood of a mortality model for yellowtail scad

local.prob.for.ll.model1 <- function(par, fixeds6, catch, effort, catchability.scaling.factor){

    #print(par)
    if(length(which(par<0)) > 0){ return(1e6)}
    # Re-arrange input data into cohorts
    catch.by.cohort <- Caaa2Coaa(catch)
    effort.by.cohort <- Caaa2Coaa(effort)

    # Allocate param to readable variable names
    q <- par[1] * catchability.scaling.factor
    M <- par[2]
    selectivity.at.age <- c("s1" = par[3], "s2" = par[4], "s3" = par[5], "s4" = par[6], "s5" = par[7], fixeds6, rep(1, ncol(catch) - 6))
    
    
    # matrix of fishing mortality
    F <- q * effort.by.cohort * outer(rep(1, nrow(effort.by.cohort)), selectivity.at.age)

    # total mortality
    Z <- M + F

    # cumulative mortality
    cum.Z <- my.cumsum(Z)

    # Calculate the probability of observation in each interval
    prob1 <- F/Z * (1 - exp(-cum.Z))
    prob2 <- F/Z * (1 - exp(-(cum.Z-Z)))

    P <- prob1-prob2
return(P)
}

# log-likelihood function for a catch-at-age matrix

local.ll.model1 <- function(par, fixeds6, catch, effort, catchability.scaling.factor){

    #print(par)
    if(length(which(par<0)) > 0){ return(1e6)}
    # Re-arrange input data into cohorts
    catch.by.cohort <- Caaa2Coaa(catch)

    P <- local.prob.for.ll.model1(par, fixeds6, catch, effort, catchability.scaling.factor)
    # discard zeroes and NA from sum of logs
    index <- which(!is.na(catch.by.cohort) & P!=0)

    # Negative log-likelihood
    -sum(catch.by.cohort[index] * log( P[index] / total.over.lines(P)[index]))
}


# Load usefull libraries
library(SAFR)
#source("UsefulFunctions.R")

# Load data available for analysis
source("PrepareData.R")

#########################################################
### Fit models
#########################################################

## First model 

# boundaries for parameters
bound <- data.frame(lower = c("q" = 1e-2, "M" = 1e-3, "s1" = 0, "s2" = 1e-2, "s3" = 1e-2, "s5" = 1e-2, "s6" = 1e-2),
                    upper = c("q" = 15,   "M" = 1, "s1" = 1e-1, "s2" = 1, "s3" = 1, "s5" = 1, "s6" = 1))

my.res <- data.frame("q" = NA, "M" = NA, "s1" = NA, "s2" = NA, "s3" = NA, "s4" = NA, "s5" = NA, "s6" = NA, "log.lik" = NA)
counter <- 1

csf <- 1e-7 # catchability scaling factor

for(s6 in seq(0.5, 1.0, length = 1e3)){
print(paste("Counter=", counter))

result1 <- optim(par = c("q" = 5, "M" = 0.2, "s1" = 0, "s2" = 0.05, "s3" = 0.17, "s4" = 0.26, "s5" = 0.55), fn = local.ll.model1, catch = nb.at.age.wgt, effort = effort.mat, catchability.scaling.factor = csf, fixeds6 = s6, method = c("L-BFGS-B"),
       lower = bound[, "lower"] , upper = bound[, "upper"], hessian = TRUE)

my.res[counter, "s6"] <- s6
my.res[counter, "log.lik"] <- result1$value
my.res[counter, c("q", "M","s1","s2","s3","s4","s5")] <- result1$par
counter <- counter + 1;
#print(my.res)
}

write.csv(my.res, paste("Results/Data/ProfileLikelihoodOfS6-", format(Sys.time(), "%b%d%Y-%H-%M-%S"), ".csv", sep=""))

with(my.res, plot(s6, log.lik, type = "l"))
