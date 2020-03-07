# Stock assessment of yellowtail scad (*Trachurus novaezelandiae*) in New South Wales (Australia)

## Introduction

This repository provides data, methods, scripts and results used to estimate the status of the yellowtail scad fishery in New South Wales (Australia). A complete description of this work is available from [Fisheries Management and Ecology](https://onlinelibrary.wiley.com/doi/abs/10.1111/fme.12286)

## Data

The data consist of measurements of [age from a sample of commercial catches](Data/NSW_yellowtail_scad_Age_data.csv), [weights from individual fish in specific intervals of age](Data/Mean_weight_at_age.csv), [total catch and purse seine catch and effort](Data/NSW_yellowtail_scad_catch_and_effort.csv).



Total catches in this fishery have been relatively stable, varying between 340 and 670 tonnes per year. The proportion caught using a purse seine varied between 56 and 86% of the total (excluding the unusual first year). The number of days the purse seine fleet fished between 1996/97 and 2017/18 has declined. In the last 8 years, purse seine catches varied in the directions as  effort. 

![alt text](https://github.com/mkienzle/NSW-yellowtail-scad-stock-assessment/blob/master/Script/Results/Graphics/CatchAndEffortVariations.png)



## Methods

Several models describing how mortality rates varied by age-group through time (depending on fishing effort, catchability and age-specific gear selectivity) were developed. All models assume a constant rate of mortality due to natural causes which was estimated. These mortality models have been expressed using hazard functions and converted into probabilities of dying at age from fishing using a method developed in the field of statistics called [survival analysis](https://link.springer.com/article/10.1007%2Fs13253-015-0237-y). These age-specific probabilities of dying from fishing were combined with age data sampled from commercial catches into a likelihood function. A range of hypotheses regarding gear selectivity and natural mortality expressed into the mortality models were compared with Akaike Information Criteria (AIC). 



## Mortality models for yellowtail scad

So far, three mortality models have been estimated from the data. All models estimate a constant natural mortality (M), catchability (q) and proportions selected by the gear at age between 0 and 6 years old

- Model 1 estimates 8 parameters (M, q and [6 selectivities for age-groups 0--1 to 5--6 years old](Script/Results/Models/Mod1-GearSelectivity.csv) to have remained constant throughout the entire time series. Gear selectivity was fixed to 1 for older age-groups.
- Model 2 estimated M, q and 2 parameters for a logistic gear selectivity (refer to this [article](https://onlinelibrary.wiley.com/doi/abs/10.1111/fme.12286) for details). Estimates of selectivity at age are provided [here](Script/Results/Models/Mod2-GearSelectivity.csv).
- Model 3 estimates 5 parameters assuming a double-logist gear selectivity.

## Results

Model 1 is most supported by the data according to [AIC](Script/Results/Data/ModelComparisonTable.csv). [This diagnostic plot](Script/Results/Graphics/NbAtAgeOverlayedWithModel.png) shows discrepancies between model 1 and age data: this model does not provide a great fit to the data. There is more variability in the observation of number at age than the model can account for. [Profiles](Script/Results/Graphics/Model1-ProfileLikelihood.png) of its negative log-likelihood function are smooth around the minimum for each parameter and allow to visualise parameter estimates uncertainties. 

## Conclusions

Results of applying hazard functions to yellowtail scad data to estimate mortality rates affecting this stock are not as satisfying as in the case of [sea garfish](https://github.com/mkienzle/NSW-sea-garfish-stock-assessment). One of the problem with the results presented here is that catchability is estimated to be extremely low, with great uncertainties. It is not clear whether this results from a problem with this analysis, from the data, the method or both. Or if it is really the case that fishing mortality on this stock is extremely low. An alternative analysis using catch curves suggests also that fishing mortality is very low [REF?].\\

The model best supported by the data suggests that fishing mortality is very low, well below estimates of natural mortality. Given those estimates, one would conclude that current level of exploitation are not unsustainable.

<!--

### Trends in populations quantities

#### Mortality rates

Fishing mortality rates have declined below natural mortality from 2009/10 onward. The decrease in age-group 0-1 retention, induced by the increased mesh size regulation initiated in 2006 and fully adopted in 2009/10, reduced fishing mortality on the youngest age-group to a negligible level.

![alt text](https://github.com/mkienzle/NSW-sea-garfish-stock-assessment/blob/master/Script/Results/Graphics/Mod2-MortalityEstimates.png)

#### Biomass estimates

Sea garfish biomass estimates have been trending upward since 2008/09: they remained above 100 tonnes since 2009/10. Biomass increased in the last 3 years and stayed above 200 tonnes in the last 2 years.

![alt text](https://github.com/mkienzle/NSW-sea-garfish-stock-assessment/blob/master/Script/Results/Graphics/EstimateOfBiomass.png)

#### Recruitment estimates

Recruitment was estimated to have varied between 1 and 5 millions fish each year until the most recent fishing season (2018/19) for which recruitment has been the largest estimated so far (approx. 7 millions fish). Such large estimate is the result of a combination of a large number of age-group 0-1 observed and the low probability of dying from fishing for that age-group in that year. This large estimate of recruitment relies on the observation of a single age-group of the youngest cohort in the fishery and will undoubtedly be revised by the observations of fish aged 1-2 year old in 2019/20. 2008/9 had the largest recruitment estimate prior to this year, presumably leading to the increase in biomass estimated in 2009/10. 2013/14 was estimated to be the fourth largest recruitment but did not translate into an increase in biomass in 2014/15. The most recent estimate of recruitment (2017/18) is the second largest and follows two very low recruitment in 2015/16 and 2016/17.

![alt text](https://github.com/mkienzle/NSW-sea-garfish-stock-assessment/blob/master/Script/Results/Graphics/EstimateOfRecruitment.png)


There start to be enough recruitment estimates (14) to begin looking at the relationship between stock and recruitment. We assumed that seagarfish age 1+ are sexually mature. The plot of recruitment estimates against spawning stock biomass (SSB) estimates, fitted with a Ricker stock-recruitment function, suggests that the Ricker model might provide useful information about the level of SSB that produces the largest amount of recruits.

![alt text](https://github.com/mkienzle/NSW-sea-garfish-stock-assessment/blob/master/Script/Results/Graphics/RickerSRROnNaturalScale.png)
-->