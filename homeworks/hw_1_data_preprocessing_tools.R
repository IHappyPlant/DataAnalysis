library(sm)

mytrees <- as.data.frame(trees)
print(summary(mytrees))
print(cor(mytrees))

# Tests for Girth and Volume
print(t.test(mytrees$Girth, mu = mean(mytrees$Girth)))
print(wilcox.test(
    mytrees$Volume,
    mu = median(mytrees$Volume),
    conf.int = TRUE
))
print(shapiro.test(mytrees$Girth))
print(ks.test(mytrees$Girth, "pnorm"))

# Tests for Height
print(t.test(mytrees$Height, mu = mean(mytrees$Height)))
print(wilcox.test(
    mytrees$Height,
    mu = median(mytrees$Height),
    conf.int = TRUE
))
print(shapiro.test(mytrees$Height))
print(ks.test(mytrees$Height, "pnorm"))


# qqnorm and qqline for Girth and Volume
qqnorm(mytrees$Girth, main = "Girth")
qqline(mytrees$Girth, col = 2)
qqnorm(mytrees$Volume, main = "Volume")
qqline(mytrees$Volume, col = 2)


# sm.density examples
sm.density(mytrees$Girth,
           model = "Normal",
           xlab = "Girth",
           ylab = "Distribution density")
sm.density(mytrees$Height,
           model = "Normal",
           xlab = " Height ",
           ylab = "Distribution density")
sm.density(mytrees$Volume,
           model = "Normal",
           xlab = " Volume",
           ylab = "Distribution density")

# plot and histograms for Girth
plot(mytrees$Girth, xlab = "Cases", ylab = "Girth")
hist(mytrees$Girth)
hist(mytrees$Girth, freq = FALSE)
hist(
    mytrees$Girth,
    breaks = 6,
    freq = FALSE,
    col = "lightblue",
    xlab = "Cases",
    ylab = "Girth",
    main = "Histogram by Girth"
)
lines(density(mytrees$Girth), col = "red", lwd = 2)


# histograms for Height and Volume
hist(
    mytrees$Height,
    freq = FALSE,
    col = "lightblue",
    xlab = "Cases",
    ylab = "Height",
    main = "Histogram by Height"
)
hist(
    mytrees$Volume,
    freq = FALSE,
    col = "lightblue",
    xlab = "Cases",
    ylab = "Volume",
    main = "Histogram by Volume"
)


# Box%Whisher plot
boxplot(mytrees$Girth,
        mytrees$Height,
        mytrees$Volume,
        main = "Box&Whisker Plot",
        xlab = "Girth Height Volume")
print(boxplot.stats(
    mytrees$Girth,
    coef = 1.5,
    do.conf = TRUE,
    do.out = TRUE
))
print(boxplot.stats(
    mytrees$Girth,
    coef = 1,
    do.conf = TRUE,
    do.out = TRUE
))
print(boxplot.stats(
    mytrees$Volume,
    coef = 1.5,
    do.conf = TRUE,
    do.out = TRUE
))


# different boxplots
boxplot(
    mytrees$Girth,
    mytrees$Height,
    mytrees$Volume,
    main = "Box&Whisker Plot",
    xlab = "Girth Height Volume",
    range = 0.5,
    col = "lightblue"
)
boxplot(
    mytrees$Girth,
    mytrees$Height,
    mytrees$Volume,
    main = "Box&Whisker Plot",
    xlab = "Girth Height Volume",
    range = 0.5,
    col = "lightblue",
    pars = list(
        boxwex = 0.4,
        staplewex = 0.7,
        outwex = 0.2
    )
)


plot(
    mytrees$Height,
    mytrees$Girth,
    type = "p",
    col = "red",
    cex = 1,
    xlab = "Height",
    ylab = "Girth",
    main = "Height vs Girth"
)
plot(
    mytrees$Girth,
    mytrees$Volume,
    type = "p",
    col = "red",
    cex = 1,
    xlab = "Girth",
    ylab = "Volume",
    main = "Girth vs Volume"
)
abline(lm(mytrees$Volume ~ mytrees$Girth),
       col = "blue",
       lwd = 1)
pairs(mytrees[1:3], main = " Matrix Diagram ")

x <- cbind(mytrees$Girth, mytrees$Height, mytrees$Volume)
pairs(
    x,
    gap = 0,
    diag.panel = function(x) {
        par(new = TRUE)
        hist(x, col = "light pink",
             probability = TRUE)
        
        lines(density(x), col = "red", lwd = 2)
    }
)
