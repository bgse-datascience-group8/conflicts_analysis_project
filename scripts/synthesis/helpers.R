# Helper functions

my.lm <- function(y, X) solve(t(X)%*%X) %*% t(X) %*% y

my.rss <- function(y, X) {
  beta.hat <- my.lm(y, X)
  fitted.values <- X%*%beta.hat
  sum((y - fitted.values)**2)
}

my.tss <- function(y,X) {
  m <- mean(y)
  sum((y - m)**2)
}

my.ssm <- function(y,X) {
  beta.hat <- my.lm(y, X)
  fitted.values <- X%*%beta.hat
  sum((fitted.values - mean(y))**2)
}

my.rsquared <- function(y, X) {
  k <- ifelse(identical(dim(X), NULL), 1, ncol(X))
  n <- length(y)
  ((my.rss(y,X))/(n-k))/((my.tss(y,X))/(n-1))
}

my.fstat <- function(y, X) {
  n <- length(y)
  p <- ifelse(identical(dim(X), NULL), 1, ncol(X))
  rs <- my.rsquared(y,X)
  (rs/(1-rs)) * (n-p)/p
}

my.pvalue <- function(y, X) {
  p <- ifelse(identical(dim(X), NULL), 1, ncol(X))
  n <- length(y)
  
  f.stat <- my.fstat(y,X)
  pvalue <- 1-pf(f.stat, df1=p, df2=n-p)
  
  return(pvalue)
}

my.mse <- function(y,X) {
  k <- ifelse(identical(dim(X), NULL), 1, ncol(X))
  beta.hat <- my.lm(y, X)
  fitted.values <- X%*%beta.hat
  residuals <- y - fitted.values
  sum(residuals(m)**2)/(length(y)-k)
}

my.mst <- function(y, X) {
  k <- ifelse(identical(dim(X), NULL), 1, ncol(X))
  my.tss(y,X)/(length(y) - k)
}
