library("sm")

data <- npk
print(lapply(list(data), summary))

means <- tapply(data$yield, data$block, mean)
print(means)

stripchart(yield ~ block, data = data)
plot(yield ~ block, data = data)

hist(data$yield, breaks = 6, freq = FALSE, col = "lightblue",
     xlab = "yield", ylab = "", main = "Histogram")
lines(density(data$yield), col = "red", lwd = 2)

sm.density.compare(data$yield, data$block, lwd = 2, xlab = "yield", main = "Density by yield")
legend("topright", levels(data$block), fill = c(2:5))

print(shapiro.test(data$yield))

print(bartlett.test(data$yield, data$block))

# one-factor analysis
print(summary(aov(yield ~ block, data = data)))

print(summary(lm(yield ~ block, data = data)))

print(oneway.test(yield ~  block, data = data))

# two-factor analysis
plot.design(data)
interaction.plot(data$block, data$N, data$yield)
interaction.plot(data$block, data$P, data$yield)
interaction.plot(data$block, data$K, data$yield)

print(summary(aov(yield ~ N + block + N:block, data = data)))
print(summary(aov(yield ~ P + block + P:block, data = data)))
print(summary(aov(yield ~ P + block + P:block, data = data)))
