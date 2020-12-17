# retrieve staskloss data
data <- stackloss

plot(data$stack.loss, data$Air.Flow)
abline(lm(formula=data$Air.Flow~data$stack.loss),col="blue",lwd=1)

# pair regression for variables Air.Flow and stack.loss
lm.rat1<-lm(formula=data$Air.Flow~data$stack.loss)
print(summary(lm.rat1))

# dispersion analysis
print(anova(lm.rat1))

# confidence and predicted intervals
CPI.df <- cbind(predict(lm.rat1,interval ="conf"),
                predict(lm.rat1,interval ="pred"))
CPI.df <- CPI.df[,-4]
colnames(CPI.df) <- c("Y_fit","CI_l","CI_u","PI_l","PI_u")
print(head(CPI.df))

# regression 1 line
matplot(data$stack.loss, CPI.df,
        type="l",lwd=c(2,1,1,1,1),col=c(1,2,2,4,4),
        ylab="Air.Flow",xlab="stack.loss")
matpoints(data$stack.loss, data$Air.Flow,pch=20)

# multiple regression
print("Multiple regression")
fm1 <- lm(stack.loss~., data = data)
print(summary(fm1))

# dispersion analysis
print(anova(fm1))

predict.fm1 = predict.lm(fm1)
tabout <- cbind(data$stack.loss, predict.fm1)

print(predict.fm1)
print(head(tabout, n = 30))

qqplot(data$stack.loss, predict.fm1, main = "QQ-plot")

# step regression
print("Step regression")
fm2 <- step(lm(stack.loss~., data = data))

print(summary(fm2))

print(anova(fm2))

predict.fm2 <- predict.lm(fm2)
tabout2 <- cbind(data$stack.loss, predict.fm2)

print(head(tabout2, n = 30))

qqplot(data$stack.loss, predict.fm2, main = "QQ-plot")
