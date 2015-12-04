## Todo

### Web App

* Remove / Fix 2013-05-13 & 2013-05-14
* Fix size of circles

### Analysis

* Are the results of the partial correlation network significant?
* Are the results of the partial correlation network significant when you include the interaction of distance?
* Can we use a gibbs sampling or monte carlo experiment to get the same results?
* Should we include a quadratic term for the `log.lag_num_conflicts`
* What other endogenous or exogenous variables might be influencing conflicts? (Try a difference from the estimated effect of lag)
* Are the results of the auto-correlation effect evidence of intra-city spread? Is there a way to prove this?
* Include weights for significance.

### Presentation

* Covariance matrix is used to perform partial correlation analysis and assess contemporaneous conditional independence of dependent variables given everyone else in the system.
* Neighborhood selection - sparsity is imposed for each neighborhood, which does not handle the idea of hubs well.
* NS has possibility of sign difference (contradictory neighborhoods), SPACE assures sign consistency
* Joint model takes into consider prior knowledge
