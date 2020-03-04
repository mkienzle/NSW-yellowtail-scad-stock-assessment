local.prob.for.ll.model1.2 <- function(par, fixedq, catch, effort, catchability.scaling.factor){

    #print(par)
    if(length(which(par<0)) > 0){ return(1e6)}
    # Re-arrange input data into cohorts
    catch.by.cohort <- Caaa2Coaa(catch)
    effort.by.cohort <- Caaa2Coaa(effort)

    # Allocate param to readable variable names
    q <- fixedq * catchability.scaling.factor
    M <- par[1]
    selectivity.at.age <- c(par[2], par[3], par[4], par[5], par[6], par[7], rep(1, ncol(catch) - 6))
    
    
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

local.ll.model1.2 <- function(par, fixedq, catch, effort, catchability.scaling.factor){

    #print(par)
    if(length(which(par<0)) > 0){ return(1e6)}
    # Re-arrange input data into cohorts
    catch.by.cohort <- Caaa2Coaa(catch)

    P <- local.prob.for.ll.model1.2(par, fixedq, catch, effort, catchability.scaling.factor)
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
lower.bound <- c(1e-2, 0,1e-2,1e-2,1e-2,1e-2,1e-2); upper.bound <- c(1,1e-1,5e-1,1,1,1,1)

my.res <- data.frame("q" = NA, "M" = NA, "s1" = NA, "s2" = NA, "s3" = NA, "s4" = NA, "s5" = NA, "s6" = NA, "log.lik" = NA)
counter <- 1

csf <- 1e-7 # catchability scaling factor

for( q in c(1e-3, 1e-2, 1e-1, seq(1, 500, length = 1e3))){
print(paste("Counter=", counter))

result1.2 <- optim(par = c(0.2,0.1,0.1, 0.3, 0.4,0.7, 0.9), fn = local.ll.model1.2, catch = nb.at.age.wgt, effort = effort.mat, catchability.scaling.factor = csf, fixedq = q, method = c("L-BFGS-B"),
       lower = lower.bound, upper = upper.bound, hessian = TRUE)

my.res[counter, "q"] <- q
my.res[counter, "log.lik"] <- result1.2$value
my.res[counter, c("M","s1","s2","s3","s4","s5","s6")] <- result1.2$par
counter <- counter +1;
#print(my.res)
}

write.csv(my.res, paste("Results/Data/ProfileLikelihoodOfCatchability-", format(Sys.time(), "%b%d%Y-%H-%M-%S"), ".csv", sep=""))

with(my.res, plot(q, log.lik, type = "l"))
