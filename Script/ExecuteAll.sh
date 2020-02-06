#!/bin/bash

# CREATED   3 Mar 2017
# MODIFIED  6 Feb 2020

# PURPOSE summarise all analyses performed for NSW sea garfish stock assessment

### Plot the data
Rscript FisheriesStatistics.R

### Estimate mortality rates
Rscript FitModels.R

# Model 1
#Rscript ProfileLikelihoodOfCatchability.R
#Rscript ProfileLikelihoodOfNaturalMortality.R
#Rscript ProfileLikelihoodOfS1.R
#Rscript ProfileLikelihoodOfS2.R
#Rscript ProfileLikelihoodOfS3.R
#Rscript ProfileLikelihoodOfS4.R
#Rscript ProfileLikelihoodOfS5.R
#Rscript ProfileLikelihoodOfS6.R

# Model 2
#Rscript Model2-ProfileLikelihoodOfCatchability.R
#Rscript Model2-ProfileLikelihoodOfNaturalMortality.R
#Rscript Model2-ProfileLikelihoodOfAlpha.R
#Rscript Model2-ProfileLikelihoodOfBeta.R

# Model 3
#Rscript Model3-ProfileLikelihoodOfCatchability.R
Rscript Model3-ProfileLikelihoodOfNaturalMortality.R
#Rscript Model3-ProfileLikelihoodOfAlpha.R
#Rscript Model3-ProfileLikelihoodOfBeta.R
Rscript Model3-ProfileLikelihoodOfGamma.R

