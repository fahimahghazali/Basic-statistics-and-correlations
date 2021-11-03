<h1 align="center">Basic statistics and correlations</h1>

### Project Objective
This repository is a compilation of the R codes and the final submission of my first coursework doing MATH20811 Practical Statistics. The whole report focuses on correlation coefficients, mainly Pearson's and Spearman's as well as an introduction consisting of descriptive statistics. The main body of the report talks about hypothesis testing on the correlation coefficient using Fisher's Z-transform statistic. The distribution of said statistic is then further explored through data simulation in R.
#### -- Project Status: [Completed]

### Methods used
- summary statistics
- correlation coefficients
- hypotheses testing

### Technologies
- LateX
- R

## Project Description
The  data used for this project can be obtained from [white wine](https://github.com/fahimahghazali/Basic-statistics-and-correlations/blob/main/white_wine.csv). In this project, the variables that are looked into are `total.sulfur.dioxide`, `density`, and `quality`. The introduction summarises all the descriptive statistics of the variable `total.sulfur.dioxide` including the boxplot and kernel density estimate of the data. Further, the distribution of the `total.sulfur.dioxide` against the `quality` is looked at through boxplots at each class of `quality`. The variable `total.sulfur.dioxide`is then paired up with `density`, the bivariate Normal distribution being proposed as suitable model through the scatterplot of the data and contours of a bivariate Normal distribution itself.

The next part of the report is based on Pearson's and Spearman's correlation coefficients between `total.sulfur.dioxide` and `density`. Their Pearson's correlation coefficient is then put through a hypothesis test, the null being that the true value is zero. Fisher's Z-transform statistic is used in the test, in calculating the p-value, as well as the corresponding confidence interval. The statistic itself is then simulated in R to confirm its Normality under the null hypothesis. The report is finally drawn to a close with a final hypothesis test on whether or not there is a monotonic association between `total.sulfur.dioxide` and `density` in their joint distribution.

The final report is writen using LateX and can be read [here](https://github.com/fahimahghazali/Basic-statistics-and-correlations/blob/main/MATH20811_CW1.pdf).

## Needs of this project

- descriptive statistics
- statistical modeling
- writeup

## Author
**Nurfahimah Mohd Ghazali**

- [Profile](https://github.com/fahimahghazali "Fahimah Ghazali")
- [Email](mailto:fahimahghazali@icloud.com?subject=Hi% "Hi!")
