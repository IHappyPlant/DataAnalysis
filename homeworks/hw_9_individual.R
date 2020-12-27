library(MASS)
bs <- Boston
print(head(bs))
print(summary(bs))
print(cor(bs))


# pair regression for variables medv and rm
plot(bs$medv, bs$rm)
abline(lm(formula=bs$rm~bs$medv),col="blue",lwd=3)

lm.rat1 <- lm(formula=bs$medv~bs$rm)
print(summary(lm.rat1))
print(anova(lm.rat1))

# confidence and predicted intervals
CPI.df <- cbind(predict(lm.rat1,interval ="conf"),
                predict(lm.rat1,interval ="pred"))
CPI.df <- CPI.df[,-4]
colnames(CPI.df) <- c("Y_fit","CI_l","CI_u","PI_l","PI_u")
print(head(CPI.df))

# regression 1 line
matplot(bs$rm, CPI.df,
        type="l",lwd=c(2,1,1,1,1),col=c(1,2,2,4,4),
        ylab="medv",xlab="rm")
matpoints(bs$rm, bs$medv,pch=20)

# pair regression for medv and lstat
plot(bs$medv, bs$lstat)
abline(lm(formula=bs$lstat~bs$medv),col="blue",lwd=3)

lm.rat2 <- lm(formula=bs$medv~bs$lstat)
print(summary(lm.rat2))
print(anova(lm.rat2))

# confidence and predicted intervals
CPI.df1 <- cbind(predict(lm.rat2,interval ="conf"),
                predict(lm.rat2,interval ="pred"))
CPI.df1 <- CPI.df1[,-4]
colnames(CPI.df1) <- c("Y_fit","CI_l","CI_u","PI_l","PI_u")
print(head(CPI.df1))

# regression 1 line
matplot(bs$lstat, CPI.df1,
        type="l",lwd=c(2,1,1,1,1),col=c(1,2,2,4,4),
        ylab="medv",xlab="lstat")
matpoints(bs$lstat, bs$medv,pch=20)


# multiple regression
fm1 <- lm(medv~., data = bs)
print(summary(fm1))
print(anova(fm1))

predict.fm1 = predict.lm(fm1)
tabout <- cbind(bs$medv, predict.fm1)
print(head(tabout, n = 10))
qqplot(bs$medv, predict.fm1, main = "QQ-plot")
