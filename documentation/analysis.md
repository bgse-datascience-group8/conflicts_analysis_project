# Analysis Milestone

The analysis in the app is structured as follows:

1. Data Summary
2. Analysis
3. Results and Cross-Validation
4. Conclusions

## 1. Data Summary

In the data summary, the subselection of data is detailed and graphs demonstrate the endogenous characterstics of the data. We found that:

* The data is stationary over the period of interest, so it does not need to be standardized over time. It does however demonstrate on a logarithmic scale.
* Washington D.C. has a much higher mean than the rest of the data.
* Weekends have a lower mean than weekdays.
* Population has a positive and non-linear relationship with number of conflicts.

## 2. Analysis

To study the question `How does conflict spread?`, the analysis includes a study of both time and space.

#### Auto-Regression

A vector auto-regressive matrix was used to regress 1 to n-days worth of lags. These tests were all found to be highly significant, with the first day's lag having the highest correlation.

#### Networks

Basic Lasso and the SPACE algorithm were used to explore the partial correlation across cities. Both algorithms exposed cities with a greater number of correlations across the set, and these 'high-influence' cities were often represented in the results of both algorithms. However, SPACE resulted in a power law distribution of the degree of edges and basic lasso did not. There is a natural expectation of a "hub" phenomena in partial correlation analysis that suggests the result of the SPACE algorithm is more realistic.

Using a k-means algorithm, the data was clustered into regions. This clustering method was used as a proxy to study the effect of distance between cities. That is, cities which are in the same region as city x are closer to city x and thus we might expect a higher correlation with what happens in the same region than in other regions.

Using these regions, the number of conflicts was regressed on the average value for all cities in the same region as well as the average value for each other region. This yielded inconsistent results but the quantiles of coefficients suggested there may be a greater "same region" effect than the effect of any other region.

## 3. Results and Cross-Validation

Using the terms from the auto-regression and network analyses, the first aggregated model fit was:

```r
log_num_conflicts ~ 0 + (lag.log_num_conflicts + same_region + 
    region.1 + region.2 + region.3 + region.4 + region.5 + log_population + 
    log_population_sq + isWashingtonDC + weekend)
```

This model had a high level of significance and a high R-squared (see table below). However the region effects were small and did not reflect previous estimations. So a second model was fit without the regions.

```{r}
log_num_conflicts ~ 0 + (lag.log_num_conflicts + log_population + 
    log_population_sq + isWashingtonDC + weekend)
```

This model demonstrated nearly the same level of fit.


<table style="text-align:center">

<tbody>

<tr>

<td colspan="2">_Dependent variable:_</td>

</tr>

<tr>

<td colspan="2">log_num_conflicts</td>

</tr>

<tr>

<td>(1)</td>

<td>(2)</td>

</tr>

<tr>

<td style="text-align:left">lag.log_num_conflicts</td>

<td>0.594<sup>***</sup></td>

<td>0.597<sup>***</sup></td>

</tr>

<tr>

<td>(0.003)</td>

<td>(0.003)</td>

</tr>

<tr>

<td style="text-align:left">same_region</td>

<td>-0.056<sup>***</sup></td>

</tr>

<tr>

<td>(0.007)</td>

</tr>

<tr>

<td style="text-align:left">region.1</td>

<td>-0.041<sup>***</sup></td>

</tr>

<tr>

<td>(0.004)</td>

</tr>

<tr>

<td style="text-align:left">region.2</td>

<td>0.005</td>

</tr>

<tr>

<td>(0.006)</td>

</tr>

<tr>

<td style="text-align:left">region.3</td>

<td>0.018<sup>***</sup></td>

</tr>

<tr>

<td>(0.006)</td>

</tr>

<tr>

<td style="text-align:left">region.4</td>

<td>0.025<sup>***</sup></td>

</tr>

<tr>

<td>(0.005)</td>

</tr>

<tr>

<td style="text-align:left">region.5</td>

<td>0.047<sup>***</sup></td>

</tr>

<tr>

<td>(0.008)</td>

</tr>

<tr>

<td style="text-align:left">log_population</td>

<td>-0.166<sup>***</sup></td>

<td>-0.176<sup>***</sup></td>

</tr>

<tr>

<td>(0.004)</td>

<td>(0.003)</td>

</tr>

<tr>

<td style="text-align:left">log_population_sq</td>

<td>0.018<sup>***</sup></td>

<td>0.018<sup>***</sup></td>

</tr>

<tr>

<td>(0.0003)</td>

<td>(0.0003)</td>

</tr>

<tr>

<td style="text-align:left">isWashingtonDC</td>

<td>1.681<sup>***</sup></td>

<td>1.678<sup>***</sup></td>

</tr>

<tr>

<td>(0.030)</td>

<td>(0.030)</td>

</tr>

<tr>

<td style="text-align:left">weekend</td>

<td>-0.407<sup>***</sup></td>

<td>-0.410<sup>***</sup></td>

</tr>

<tr>

<td>(0.006)</td>

<td>(0.006)</td>

</tr>

<tr>

<td style="text-align:left">Observations</td>

<td>85,800</td>

<td>85,800</td>

</tr>

<tr>

<td style="text-align:left">R<sup>2</sup></td>

<td>0.821</td>

<td>0.821</td>

</tr>

<tr>

<td style="text-align:left">Adjusted R<sup>2</sup></td>

<td>0.821</td>

<td>0.821</td>

</tr>

<tr>

<td style="text-align:left">Residual Std. Error</td>

<td>0.818 (df = 85789)</td>

<td>0.818 (df = 85795)</td>

</tr>

<tr>

<td style="text-align:left">_Note:_</td>

<td colspan="2" style="text-align:right"><sup>*</sup>p<0.1; <sup>**</sup>p<0.05; <sup>***</sup>p<0.01</td>

</tr>

</tbody>

</table>

The condition of the design matrix however was very high. Cross-validation of the design matrix exposed the instability in the fit of the model:

<table border=1>
<tr> <th>  </th> <th> Test 1 </th> <th> Test 2 </th> <th> Test 3 </th> <th> Test 4 </th> <th> Average </th>  </tr>
  <tr> <td align="right"> R-squared </td> <td align="right"> 0.62 </td> <td align="right"> 0.51 </td> <td align="right"> 0.62 </td> <td align="right"> 0.53 </td> <td align="right"> 0.57 </td> </tr>
  <tr> <td align="right"> Adjusted R-Squared </td> <td align="right"> 0.71 </td> <td align="right"> 0.66 </td> <td align="right"> 0.71 </td> <td align="right"> 0.67 </td> <td align="right"> 0.69 </td> </tr>
  <tr> <td align="right"> Mean Squared Error </td> <td align="right"> 0.62 </td> <td align="right"> 0.51 </td> <td align="right"> 0.62 </td> <td align="right"> 0.53 </td> <td align="right"> 0.57 </td> </tr>
   </table>

## 4. Conclusions

* Time matters but we have found no evidence to support that space matters.
* A model capturing the effects of a single-day lag, population, and whether the date is on a weekend fits the data well but is not well-conditioned.
* There is some evidence to suggest that big cities matter.

![graph](/conflict_analysis_app/publict/images/summary_num_conflicts_raw.png)
![graph](/conflict_analysis_app/publict/images/summary_num_conflicts_smooth.png)
![graph](/conflict_analysis_app/publict/images/summary_weekly_trends.png)
![graph](/conflict_analysis_app/publict/images/summary_population.png)
![graph](/conflict_analysis_app/publict/images/analysis_boston_ex1.png)
![graph](/conflict_analysis_app/publict/images/analysis_lag_all_cities.png)
![graph](/conflict_analysis_app/publict/images/analysis_lag_boxplot.png)
![graph](/conflict_analysis_app/publict/images/analysis_lag_coeffs.png)
![graph](/conflict_analysis_app/publict/images/analysis_network_heatmap.png)
![graph](/conflict_analysis_app/publict/images/analysis_network_lasso.png)
![graph](/conflict_analysis_app/publict/images/analysis_network_lasso_hist.png)
![graph](/conflict_analysis_app/publict/images/analysis_network_space.png)
![graph](/conflict_analysis_app/publict/images/analysis_network_space_hist.png)
![graph](/conflict_analysis_app/publict/images/analysis_kluster_map.png)
![graph](/conflict_analysis_app/publict/images/analysis_kluster_region_coeffs_boxplot.png)

