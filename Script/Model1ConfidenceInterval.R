# CREATED  14 March 2017
# MODIFIED  6 March 2020

# PURPOSE calculate 95% Confidence intervals for parameters of model 1
#         using the values from the profile likelihood

source("FitModels.R")

# Range of log-likelihood for model 1
max.boundary <- result1$value + 0.5 * qchisq(0.95, df = length(result1$par) )

#pdf(file = "Results/Graphics/ProfileLikelihood.pdf")
png(file = "Results/Graphics/Model1-ProfileLikelihood.png")
par(mfrow = c(3,3))

### Natural mortality
print("Natural mortality")
#prof.M <- read.csv("Results/Data/ProfileLikelihoodOfNaturalMortality-Apr052017-03-09-06.csv")
prof.M <- read.csv("Results/Data/ProfileLikelihoodOfNaturalMortality-Mar032020-03-23-47.csv")
tmp <- with(subset(prof.M, log.lik <= max.boundary), range(M))
print(tmp)
# Plot
with(prof.M, plot(M, log.lik, type = "l", xlab = "Natural mortality (M)", ylab = "Negative log-likelihood"))
abline(h = max.boundary, lty = 3)

### Selectivity of first age group (s1)
print("s1")
#prof.s1 <- read.csv("Results/Data/ProfileLikelihoodOfS1-Apr052017-15-52-07.csv")
prof.s1 <- read.csv("Results/Data/ProfileLikelihoodOfS1-Mar032020-04-51-55.csv")
tmp <- with(subset(prof.s1, log.lik <= max.boundary), range(s1))
print(tmp)

# plot
with(prof.s1, plot(s1, log.lik, type = "l", xlab = "Selectivity of age-group 1", ylab = "Negative log-likelihood"))
abline(h = max.boundary, lty = 3)

### Selectivity of first age group (s2)
print("s2")
#prof.s2 <- read.csv("Results/Data/ProfileLikelihoodOfS2-Apr062017-04-19-20.csv")
prof.s2 <- read.csv("Results/Data/ProfileLikelihoodOfS2-Mar032020-06-14-41.csv")
tmp <- with(subset(prof.s2, log.lik <= max.boundary), range(s2))
print(tmp)

# plot
with(prof.s2, plot(s2, log.lik, type = "l", xlab = "Selectivity of age-group 2", ylab = "Negative log-likelihood"))

abline(h = max.boundary, lty = 3)

### Selectivity of first age group (s3)
print("s3")
prof.s3 <- read.csv("Results/Data/ProfileLikelihoodOfS3-Apr102017-05-12-38.csv")
prof.s3 <- read.csv("Results/Data/ProfileLikelihoodOfS3-Mar032020-07-44-52.csv")
tmp <- with(subset(prof.s3, log.lik <= max.boundary), range(s3))
print(tmp)

# plot
with(prof.s3, plot(s3, log.lik, type = "l", xlab = "Selectivity of age-group 3", ylab = "Negative log-likelihood"))

abline(h = max.boundary, lty = 3)

### Selectivity of first age group (s4)
print("s4")
#prof.s4 <- read.csv("Results/Data/ProfileLikelihoodOfS4-Apr092017-17-00-13.csv")
prof.s4 <- read.csv("Results/Data/ProfileLikelihoodOfS4-Mar032020-11-52-42.csv")
tmp <- with(subset(prof.s4, log.lik <= max.boundary), range(s4))
print(tmp)

# plot
with(prof.s4, plot(s4, log.lik, type = "l", xlab = "Selectivity of age-group 4", ylab = "Negative log-likelihood"))

abline(h = max.boundary, lty = 3)

### Selectivity of first age group (s5)
print("s5")
#prof.s5 <- read.csv("Results/Data/ProfileLikelihoodOfS5-Apr082017-06-29-30.csv")
#prof.s5 <- read.csv("Results/Data/ProfileLikelihoodOfS5-Mar032020-14-34-16.csv")
prof.s5 <- read.csv("Results/Data/ProfileLikelihoodOfS5-Mar042020-00-41-56.csv")
tmp <- with(subset(prof.s5, log.lik <= max.boundary), range(s5))
print(tmp)

# plot
with(prof.s5, plot(s5, log.lik, type = "l", xlab = "Selectivity of age-group 5", ylab = "Negative log-likelihood"))

abline(h = max.boundary, lty = 3)

### Selectivity of first age group (s6)
print("s6")
#prof.s6 <- read.csv("Results/Data/ProfileLikelihoodOfS6-Apr082017-16-53-59.csv")
prof.s6 <- read.csv("Results/Data/ProfileLikelihoodOfS6-Mar032020-20-00-53.csv")
tmp <- with(subset(prof.s6, log.lik <= max.boundary), range(s6))
print(tmp)

# plot
with(prof.s6, plot(s6, log.lik, type = "l", xlab = "Selectivity of age-group 6", ylab = "Negative log-likelihood"))
abline(h = max.boundary, lty = 3)

### Catchability
print("Catchability (q)")
#prof.q <- read.csv("Results/Data/ProfileLikelihoodOfCatchability-Apr042017-22-02-10.csv")
prof.q <- read.csv("Results/Data/ProfileLikelihoodOfCatchability-Mar032020-02-59-43.csv")
tmp <- with(subset(prof.q, log.lik <= max.boundary), range(q))
print(tmp)

# plot
with(prof.q, plot(q, log.lik, type = "l", xlab = "Catchility (q) x 1e-7", ylab = "Negative log-likelihood"))

abline(h = max.boundary, lty = 3)

dev.off()

### Is min(log.lik) consistent across all data.set ?

print(paste("Min log-likelihood when varying q =", with(prof.q, min(log.lik))))
print(paste("Min log-likelihood when varying M =", with(prof.M, min(log.lik))))
print(paste("Min log-likelihood when varying s1 =", with(prof.s1, min(log.lik))))
print(paste("Min log-likelihood when varying s2 =", with(prof.s2, min(log.lik))))
print(paste("Min log-likelihood when varying s3 =", with(prof.s3, min(log.lik))))
print(paste("Min log-likelihood when varying s4 =", with(prof.s4, min(log.lik))))
print(paste("Min log-likelihood when varying s5 =", with(prof.s5, min(log.lik))))
print(paste("Min log-likelihood when varying s6 =", with(prof.s6, min(log.lik))))
