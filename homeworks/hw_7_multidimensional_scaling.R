# metric scaling for USJudgeRatings
jr <- USJudgeRatings
dd.jr <- as.dist((1 - cor(jr))/2)
print(round(1000 * dd.jr)) # (prints more nicely)
loc1 <- cmdscale(dd.jr,k=2)
print(loc1)
px1 <- loc1[, 1]
py1 <- loc1[, 2]
plot(px1, py1,type = "n", xlab = "", ylab = "", asp = 1, axes = FALSE,
     main = "cmdscale(jr)")
text(px1, py1, rownames(loc1), cex = 0.6)

# metric scaling for eurodist
print(eurodist)
loc <- cmdscale(eurodist)
x <- loc[, 1]
y <- -loc[, 2] # reflect so North is at the top
## note asp = 1, to ensure Euclidean distances are represented correctly
plot(x, y, type = "n", xlab = "", ylab = "", asp = 1, axes = FALSE,
     main = "cmdscale(eurodist)")
text(x, y, rownames(loc), cex = 0.6)
