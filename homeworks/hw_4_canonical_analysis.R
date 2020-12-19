lcs <- LifeCycleSavings

x <- lcs[2:4]
y <- cbind(lcs[1], lcs[5])

print(cor(x))
print(cor(y))

cxy <- cancor(x, y)
print(cxy)

n <- dim(x)[1] # number of observations
p <- dim(x)[2] # number of dependent variables
q <- dim(y)[2] # number of independent variables
print(n)
print(p)
print(q)

library(CCP)
wilks_test <- p.asym(rho=cxy$cor, n, p, q, tstat = "Wilks")
plt.asym(wilks_test, rhostart = 1)
plt.asym(wilks_test, rhostart = 2)
p.perm(x, y, rhostart=1)
out <- p.perm(x, y, rhostart=2)
plt.perm(out)
