# K-means clustering
# 1) choose initial values for mu_{k}
#    Given k = 4 and data has 2 vars
#    Take the 2 values at the 4 quantiles of each var as initial mu_{k} (e.g. mu_{k} will have 2 values)
# 2) assign each n obs to an r_{nk}
#    find the mu_k such that (x_n - mu_k)**2 is minimized
#    r_{n,k} <- mu_k ^^
# 3) Recalculate mu_k
#    mu_{k} = sum(r_{n,k==k}*x_{n})/{r_{n,k==k}}

k.means <- function(X, k) {
  max.iters <- 50
  nvars <- ncol(X)
  mus <- matrix(0, nrow=k, ncol=nvars)
  for (i in 1:nvars) {
    vars <- X[,i]
    mus[,i] <- unlist(quantile(vars, probs=setdiff(seq(0,1,1/(k+1)), c(0,1))))
  }
  mus.prev <- mus

  for (iter in 1:max.iters) {
    print(paste('iter', iter))
    r.nks <- matrix(0, nrow = nrow(X), ncol = k)
    for (i in 1:nrow(X)) {
      obs <- X[i,]
      diffs <- c()
      for (c in 1:nrow(mus)) {
        mu_k <- mus[c,]
        diffs <- append(diffs, sqrt(sum(obs - mu_k)**2))
      }
      r.nks[i,which.min(diffs)] <- 1
    }

    #new_mus <- matrix(0, nrow=k, ncol=nvars)
    for (i in 1:ncol(r.nks)) {
      mus[i,] <- r.nks[,i]%*%as.matrix(X)/sum(r.nks[,i])
      # for every row in X, if assigned to the group
    }
    if (sum((mus-mus.prev)**2) < 1e-6) {
      return(list(mus=mus, r.nks=r.nks))
    }
    mus.prev <- mus
  }

  list(mus=mus, r.nks=r.nks)
}
