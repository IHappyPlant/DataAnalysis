library(sm)
library(pastecs)

# retrieve staskloss data
data <- stackloss

print(summary(data))
print(cor(data))

print(stat.desc(data))


# test hypothesis of normality
print(t.test(data$Air.Flow, mu = mean(data$Air.Flow)))
print(wilcox.test(
    data$Air.Flow,
    mu = median(data$Air.Flow),
    conf.int = TRUE
))
print(t.test(data$stack.loss, mu = mean(data$stack.loss)))
print(wilcox.test(
    data$stack.loss,
    mu = median(data$stack.loss),
    conf.int = TRUE
))
print(shapiro.test(data$Air.Flow))
print(ks.test(data$Air.Flow, "pnorm"))
print(shapiro.test(data$stack.loss))
print(ks.test(data$stack.loss, "pnorm"))


# data visualization
qqnorm(data$Air.Flow, main = "Air.Flow")
qqline(data$Air.Flow, col = 2)
qqnorm(data$stack.loss, main = "stack.loss")
qqline(data$stack.loss, col = 2)

# density plots
sm.density(data$Air.Flow,
           model = "Normal",
           xlab = "Air.Flow",
           ylab = "Distribution density")
sm.density(data$stack.loss,
           model = "Normal",
           xlab = " stack.loss ",
           ylab = "Distribution density")

# common plots
plot(data$Air.Flow, xlab = "Cases", ylab = "Air.Flow")
plot(data$stack.loss, xlab = "Cases", ylab = "stack.loss")

# histograms
hist(data$Air.Flow, breaks = 6, freq = FALSE, col = "lightblue", 
     xlab = "Cases", ylab = "Air.Flow", main = "Histogram by Air.Flow")
hist(data$stack.loss, breaks = 6, freq = FALSE, col = "lightblue", 
     xlab = "Cases", ylab = "stack.loss", main = "Histogram by stack.loss")
