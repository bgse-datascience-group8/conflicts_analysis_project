
lasso.reg <- function(y, X, lambda) {
  max.iter <- 1000
  P <- ncol(X)
  
  beta <- solve(t(X)%*%X, t(X)%*%y)
  beta.prev <- beta
  
  # Do until convergence
  for (iter in 1:max.iter) {
    cat('.')
    for (k in 1:P) {
      y.minus_k <- y - X[,setdiff(1:P,k)] %*% beta[setdiff(1:P,k)]
      x.k <- X[,k]
      cov <- sum(y.minus_k * x.k)
      var <- sum(x.k * x.k)
      
      beta.k.ls <- cov/var
      beta[k] <- sign(beta.k.ls)*max(c(abs(beta.k.ls) - lambda/(2*var), 0))
    }
    if (sum((beta - beta.prev)**2) < 1e-6) {
      print(paste0('finished in ', iter, 'iterations'))
      return(beta)
    }
    beta.prev <- beta
  }
  beta
}
