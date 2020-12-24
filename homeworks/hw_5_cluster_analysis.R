library(cluster.datasets)
library(cluster)
library(MASS)


data("european.foods")
ef <- european.foods
rownames(ef) <- c(ef[2][,])
ef.features <- ef[3:18]

ef.hc <- hclust(dist(ef.features), method="ward.D2")
plot(ef.hc)

kl <- (nrow(ef.features) - 1) * sum(apply(ef.features, 2, var))
for (i in 2:15) kl[i] <- sum(kmeans(ef.features, centers=i)$withinss)
plot(1:15, kl, type="b", xlab="Число кластеров", 
     ylab="Сумма квадратов расстояний внутри кластеров")

opt_clusters <- 4
kc <- kmeans(ef.features, opt_clusters)
print(aggregate(ef.features,by=list(kc$cluster),FUN=mean))

ef.f <- fanny(ef.features, opt_clusters, maxit=2000)
print(ef.f$membership)
plot(ef.f, which=1)
