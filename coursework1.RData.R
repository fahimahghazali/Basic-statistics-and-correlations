white_wine=read.table("white_wine.csv", sep = ";", header = TRUE)

#1 part i#
tsd<-white_wine$total.sulfur.dioxide
summary(tsd)
sd(tsd)
lq <- quantile(tsd)[2]; lq
med <- quantile(tsd)[3]; med
uq <- quantile(tsd)[4]; uq
L = quantile(tsd)[2] - 1.5* IQR(tsd); L
U = quantile(tsd)[4] + 1.5* IQR(tsd); U
q <- c(L, lq, med, uq, U)

par(mfrow=c(2,1), mai = c(0.8, 0.6, 0.5, 0.3))
boxplot(tsd, horizontal=TRUE, xlab="total sulfur dioxide")
text(x = q+0.1, y= 0.65, labels = c(expression(L), expression(Q[1]), expression(Q[2]), expression(Q[3]),expression(U)))
plot(density(tsd), main="", xlab="total sulfur dioxide")

library(e1071)
skewness(tsd)
kurtosis(tsd) #excess kurtosis#

mymode<-funtion(x){
  d <- density(x)
  return(d$x[which(d$y == max(d$y))])
}
mymode(tsd)


#1 part ii#
boxplot(total.sulfur.dioxide~quality, data = white_wine, xlab="quality", ylab = "total sulfur dioxide", col = "red")

wwq <- white_wine$quality
s3 <- skewness(tsd[wwq==3])
s4 <- skewness(tsd[wwq==4])
s5 <- skewness(tsd[wwq==5])
s6 <- skewness(tsd[wwq==6])
s7 <- skewness(tsd[wwq==7])
s8 <- skewness(tsd[wwq==8])
s9 <- skewness(tsd[wwq==9])
skew <- c(skewness(tsd[wwq==3]), skewness(tsd[wwq==4]), skewness(tsd[wwq==5]), skewness(tsd[wwq==6]), skewness(tsd[wwq==7]), skewness(tsd[wwq==8]), skewness(tsd[wwq==9]))

v3 <- var(tsd[wwq==3])
v4 <- var(tsd[wwq==4])
v5 <- var(tsd[wwq==5])
v6 <- var(tsd[wwq==6])
v7 <- var(tsd[wwq==7])
v8 <- var(tsd[wwq==8])
v9 <- var(tsd[wwq==9])
vary <- c(var(tsd[wwq==3]), var(tsd[wwq==4]), var(tsd[wwq==5]), var(tsd[wwq==6]), var(tsd[wwq==7]), var(tsd[wwq==8]), var(tsd[wwq==9]))

cbind(skew, vary)

xtable(cbind(skew, vary))
#1 part iii#
wwd<-white_wine$density

twodim.Npdf = function(xlimits, ylimits, mu, covar){
x.points <- seq(xlimits[1], xlimits[2], length.out = 100)
y.points <- seq(ylimits[1], ylimits[2], length.out = 100)
zz <- matrix(0, nrow = 100, ncol = 100)
for( i in 1:100){
for( j in 1:100){
zz[i,j] <- dmvnorm( c(x.points[i], y.points[j]), mean = mu, sigma = covar)
}
}
results = list(x.points, y.points, zz)
return (results)
}

CN1 = function (n, mux, sdx, muy, sdy, rho, text){
means = c(mux,muy)
C = matrix(c(sdx^2, rho*sdx*sdy, rho*sdx*sdy, sdy^2), nrow = 2, ncol = 2)
NVals <- twodim.Npdf(xlimits = c(0,400), ylimits = c(0.99, 1.04), mu = means, covar = C)
contour(NVals[[1]], NVals[[2]], NVals[[3]], col = "red", xlab = "x (total sulfur dioxide)", ylab = "y (density)", main = paste(text), sub = "Bivariate Normal Contours in Red", col.sub = "red", cex.sub = 0.8, cex.lab = 1.2, cex.axis = 1.0)
points(tsd, wwd, "p", pch = ".", cex = 1.0)
scor = cor(tsd,wwd, method = "pearson")
print("sample correlation matrix")
scor
}

par(mfrow = c(1,1), mai = c(1.3, 0.9, 0.9, 0.5))
set.seed(11)

CN1(4894, mean(tsd), sd(tsd), mean(wwd), sd(wwd),0.45, "contours with rho = 0.45")
CN1(4894, mean(tsd), sd(tsd), mean(wwd), sd(wwd),0.50, "")
CN1(4894, mean(tsd), sd(tsd), mean(wwd), sd(wwd),0.55, "contours with rho = 0.55")
CN1(4894, mean(tsd), sd(tsd), mean(wwd), sd(wwd),0.60, "contours with rho = 0.60")

#2#
cor(tsd, wwd, method = "pearson")
cor(tsd, wwd, method = "spearman")
cor(log(tsd), log(wwd), method = "pearson")
cor(log(tsd), log(wwd), method = "spearman")



#3#
cor.test(tsd, wwd, method = "pearson")

#zts is the z statistic
n1 <- 4898
r <- cor(tsd, wwd, method = "pearson")
rho <- 0.5
zts <- sqrt(n1-3)*(atanh(r)-atanh(rho))
zts
#pvalue
pval <- 2*(1-pnorm(q = zts, mean = 0, sd = 1)); pval

#confidence interval
ztwot <- qnorm (p = 0.025); ztwot
u <- exp(-2*ztwot/sqrt(n1-3))
v <- exp(2*ztwot/sqrt(n1-3))
lb <- ((1 + r - (1-r)*u)/(1 + r + (1-r)*u))
ub <- ((1 + r - (1-r)*v)/(1 + r + (1-r)*v))
ci <- c(lb, ub)
ci

#4#
fishersz = function(N, n, mux, muy, sdx, sdy){
z = 0
r = 0
for (i in 1:N) {
x = rnorm(n, mux, sdx)
y = rnorm(n, muy, sdy)
r[i] = cor(x, y)
z[i] = log((1 + r[i])/(1 - r[i]))/2
}
zx<- seq(from = -1, to = 1, length.out = 100)
szpdf <- dnorm(x= zx, mean(log((1 + r)/(1 - r))/2), sqrt(1/(n-3)))
plot( zx, szpdf, "l", xlab = "z", ylab = "P(Z = z)")
lines(density(z), col = "blue", cex = 0.1)
legend('topright', c('z-transform sample distribution','Normal pdf'), lty=1,col=c('red','black'),bty='n',cex= 0.75)
lines(density(z),col="red")
xycor = cor(x, y, method = "pearson")
print("sample correlation coefficient")
xycor
}

fishersz(1000, 100, 5, 3, 6, 2)

#5#
cor.test(tsd, wwd, method = "spearman", exact = FALSE)
