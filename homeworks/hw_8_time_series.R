dsc <- discoveries
print(dsc)
print(is.ts(dsc))
acf(dsc)
pacf(dsc)

# gaussian model fitting
dsc.st <- StructTS(dsc, type = "trend")
print(dsc.st)
plot(dsc.st.fitted)
tsdiag(dsc.st)
print(predict(dsc.st, n.ahead = 5))

# auto-regression model fitting
# yule-walker method
dsc.arw <- ar(dsc)
print(dsc.arw)
print(predict(dsc.arw, n.ahead = 5))

# ols method
dsc.arw <- ar(dsc, method = "ols")
print(dsc.arw)
print(predict(dsc.arw, n.ahead = 5))

# burg method
dsc.arw <- ar(dsc, method = "burg")
print(dsc.arw)
print(predict(dsc.arw, n.ahead = 5))

# arima model fitting
d <- 1
p <- 1
q <- 0
dsc.arima <- arima(dsc.d, order=c(p, d, q))
tsdiag(dsc.arima)
print(predict(dsc.arima, n.ahead = 5, se.fit = TRUE))

# other params for arima
dsc.arima <- arima(dsc.d, order=c(0, 0, 2))
tsdiag(dsc.arima)
print(predict(dsc.arima, n.ahead = 5, se.fit = TRUE))
