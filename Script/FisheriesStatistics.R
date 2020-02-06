# CREATED   6 Feb 2020
# MODIFIED  6 Feb 2020

# PURPOSE plot fisheries statistics

# Read the data
#total.catch = read.csv("../Data/NSW yellowtail scad total catch data.csv")
#PurseSeine.catch.effort = read.csv("../Data/NSW yellowtail scad Purse Seine catch and effort data.csv")
catch.effort = read.csv("../Data/NSW yellowtail scad catch and effort.csv")

# Format the data into a data.frame
my.df = with(catch.effort, data.frame(year = Year, 'Fishing method' = "Purse seine", catch = purseseine))
my.df = rbind(my.df,
               with(catch.effort, data.frame(year = Year, 'Fishing method' = "Other", catch = Total - purseseine)))

# re-order factors
my.df$Fishing.method = factor(my.df$Fishing.method, levels = c("Other", "Purse seine"))

# Plot
library(ggplot2)

my.p = ggplot(data = my.df) +
       geom_bar(aes(year, catch, fill = Fishing.method), stat = "identity") +
       theme_bw() + xlab("") + ylab("Catch (tonnes)") + scale_fill_discrete(name = "Fishing method") +
       scale_x_discrete( breaks = unique(my.df$year)[c(TRUE,FALSE,FALSE)],
                         labels = unique(my.df$year)[c(TRUE,FALSE,FALSE)]) +
       geom_point(data = catch.effort, aes(Year, PSdays/3), size = 2.0) +
       geom_line(data = catch.effort, aes(x = Year, y = PSdays/3, group = 1)) +
       scale_y_continuous(sec.axis = sec_axis(trans=~ . * 3,
                                         name = 'Purse seine effort (days)'))
 

       
plot(my.p)

png("Results/Graphics/CatchAndEffortVariations.png", width = 800, height = 480)
plot(my.p)
dev.off()


# #postscript("Results/Graphics/CatchAndEffortVariations.ps")
# png("Results/Graphics/CatchAndEffortVariations.png", width = 800, height = 480)
# #par(fg = "black", col.main = "black", col.axis = "black", col.lab = "black", cex = 1.5, cex.lab = 2, cex.axis = 1.5, cex.main = 2.5, mai = c(1.2, 1.8, 1.02, 1.5), mgp = c(4, 1, 0))



# par(mfrow=c(1,2))
# par(mai = c(0.6, 1, 0.5, 1.5), mgp = c(4, 1, 0))

# mp <- with(catch, barplot(t(1e-3 * Catch.in.kg), las = 1, beside = T, border = "lightgrey", col = "lightgrey",
#                         ylab = "Catch (tonnes)", ylim = c(0, 120), axes = FALSE, xlab = ""))

# axis(side = 1, at = mp, label = catch$Year)
# axis(side = 2, at = seq(0, 100, 20), label = seq(0,100,20), las = 1)

# with(effort, lines(mp, Effort.in.days / 10, type = "b", pch = 19))
# #lines(mp, catch$Catch.in.kg / effort$Effort.in.days / 3, type = "b", pch = 15)


# #with(tmp, lines(mp, .5e3 * Catch/Effort, type = "b", pch = 19, col = "black"))
# #lines(mp, .5e3 * tmmp2[,1]/tmmp[,1], type = "b", pch = 15, col = "black")
# #lines(mp, .5e3 * tmmp2[,2]/tmmp[,2], type = "b", pch = 17, col = "black")

# axis(side = 4, at = seq(0, 100, 20), label = seq(0, 1000, 200), las = 1)
# mtext(expression(paste("Effort (", boat.days^-1, ")", sep = "")), side=4,line=3)
# box()
# #abline( h = seq(0,3e4, 5e3), lty = 2, col = "grey")
# legend(21, 115, legend = c("Catch", "Effort"), col = c("lightgrey", "black"), pch = c(15,19), cex = 1, bg = "white")

# ## Plot CPUE
# par(mai = c(0.6, 1, 0.5, 0.5), mgp = c(4, 1, 0))
# plot( 1:length(catch$Year), catch$Catch.in.kg/effort$Effort.in.days,
#       pch = 19,
#       xlab = "Fishing year", ylab = "Catch per unit effort (kg/boat-day)",
#       las = 1, axes = FALSE, ylim = c(0,350));

# axis(1, at = seq(1, length(catch$Year))[c(TRUE,FALSE,FALSE)], catch$Year[c(TRUE,FALSE,FALSE)]);
# axis(2, las = 1);
# box();

# abline(h = seq(0,300,50), col = "lightgrey")

# dev.off()
