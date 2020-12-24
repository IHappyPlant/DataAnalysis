mt <- mtcars
print(summary(mt))
print(cor(mt))

res <- princomp(mt, scores=TRUE)
print(res)
print(summary(res))
print(loadings(res))
plot(res)
biplot(res)
head(res$scores)
mt.pc <- prcomp(mt, retx=TRUE, tol=0.2)

# factor analysis
fc.mt <- factanal(mt, factors=2, start=NULL,  scores="Bartlett", STATISTIC)
print(fc.mt)
print(fc.mt$scores)
plot(fc.mt$scores)
