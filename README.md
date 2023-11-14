
<!-- README.md is generated from README.Rmd. Please edit that file -->

# TRNValStandVis

<!-- badges: start -->
<!-- badges: end -->

## Description

`TRNValStandVis` is an R packacge that validates and It combines
transcription factor - target gene interaction data from four data sets,
the Molecular Signatures Database (MSigDB) by GSEA, hTFtarget by Zhang
et al., the ChIP-X Enrichment Analysis Version 3 (ChEA3) by Ma’ayan lab,
and TFLink by Liska et al. to create a single combined dataset, where
all TF’s and TG’s are standardized to be HGNC compliant. The combined
data was used to create a qualitative score to evaluate the quality of
TF-TG interactions as well a score to assess the overall quality of a
specific TF. Further abilities include visualizing TF-TG regulons and
networks and comparing different TF’s qualitatively. This package will
allow for the validation of TF-TG’s across different sources, quality
metrics in regards to level of validation for each TF-TG, as well as
standardization in regards to nomenclature. The `TRNValStandVis` package
was developed using `R version 4.1.1 (2021-08-10)`,
`Platform: x86_64-apple-darwin17.0 (64-bit)` and
`Running under: macOS Big Sur 11.6`

## Installation

In order to install the latest version of this package:

``` r
install.packages("devtools")
library("devtools)
devtools::install_github("Mogtaba-Alim/TRNValStandVis", build_vignettes = TRUE)
library("TRNValStandVis")
```

## Overview

``` r
ls("package:TRNValStandVis")
data(package = "TRNValStandVis")
browseVignettes("TRNValStandVis")
```

`TRNValStandVis` consists of 8 functions.

1.  ***get_TGs***

-   Take in a TF and return all its target genes. Can be adjusted based
    on number of datasets TF-TG appears in.

2.  ***get_TFs***

-   Take in a gene and return all the transcription factors that
    regulate it. Can be adjusted based on number of datasets TF-TG
    appears in.

3.  ***plot_TF_regulon***

-   Take in a gene and plot that gene’s regulon including regulators and
    targets.

4.  ***plot_TFs_network***

-   Take in up to 3 gene names and plot the network involving all the
    genes regulons combined.

5.  ***get_TF_TG_val***

-   Take in a TF and return the validity score for all the TG’s of that
    TF

6.  ***plot_TF_TG_val***

-   Take in a TF and plot the validity score for all the TG’s of that TF

7.  ***get_TF_total_val***

-   Takes in a TF and provides the average validty score for that TF

9.  ***plot_TF_total_val***

-   Take in a collection of TF names and plots their average validity
    score

The packcage will also have 2 datasets. The first will be the combined
dataset of TF-TG’s and will contain columns for the number of times an
interaction has appeared in the different datasets, the validation score
for each TF-TG and a normalized validation score.

The second dataset, will be of all the TF’s and their overall average
validation score.

## Contributions

The author of this package is Mogtaba Alim. All functions and processes
including the processing and the creation of valdity scores were done by
the author without any external help.

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(TRNValStandVis)
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/v1/examples>.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
