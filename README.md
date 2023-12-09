
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
library("devtools")
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

- Take in a TF and return all its target genes. Can be adjusted based on
  number of datasets TF-TG appears in.

2.  ***get_TFs***

- Take in a gene and return all the transcription factors that regulate
  it. Can be adjusted based on number of datasets TF-TG appears in.

3.  ***plot_TF_regulon***

- Take in a gene and plot that gene’s regulon including regulators and
  targets.

4.  ***plot_TFs_network***

- Take in up to 3 gene names and plot the network involving all the
  genes regulons combined.

5.  ***get_TF_TG_val***

- Take in a TF and return the validity score for all the TG’s of that TF

6.  ***plot_TF_TG_val***

- Take in a TF and plot the validity score for all the TG’s of that TF

7.  ***get_TF_total_val***

- Takes in a TF and provides the average validty score for that TF

8.  ***plot_TF_total_val***

- Take in a collection of TF names and plots their average validity
  score

Below is an example overview of the visualization features available
with this package:

<div style="text-align: center;">

<table>
<tr>
<td>
![1. plot_TF_regulon]() <br> <em>Explanation for Image 1: \[Your
two-sentence explanation here.\]</em>
</td>
<td>
![2.
plot_TF_regulon](/private/var/folders/kc/38g1669d0nl88m5qg06psg3w0000gn/T/RtmpD3ehRX/temp_libpathbfa36675231d/TRNValStandVis/extdata/plot_TF_TG_val_Example.png)
<br> <em>Explanation for Image 2: \[Your two-sentence explanation
here.\]</em>
</td>
</tr>
<tr>
<td>
![3.
plot_TF_regulon](/private/var/folders/kc/38g1669d0nl88m5qg06psg3w0000gn/T/RtmpD3ehRX/temp_libpathbfa36675231d/TRNValStandVis/extdata/plot_TF_total_val_Example.png)
<br> <em>Explanation for Image 3: \[Your two-sentence explanation
here.\]</em>
</td>
<td>
![4.
plot_TF_regulon](/private/var/folders/kc/38g1669d0nl88m5qg06psg3w0000gn/T/RtmpD3ehRX/temp_libpathbfa36675231d/TRNValStandVis/extdata/plot_TFs_network_Example.png)
<br> <em>Explanation for Image 4: \[Your two-sentence explanation
here.\]</em>
</td>
</tr>
</table>

</div>

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

I used the following three external packages, igraph, ggplot2 and igraph
throughout the package.

## References

Wickham H, François R, Henry L, Müller K, Vaughan D (2023). *dplyr: A
Grammar of Data Manipulation*. R package version 1.1.4,
<https://CRAN.R-project.org/package=dplyr>.

Fujiyoshi, K., Bruford, E. A., Mroz, P., Sims, C. L., O’Leary, T. J.,
Lo, A. W. I., … Ogino, S. (2021). Standardizing gene product
nomenclature—a call to action. Proceedings of the National Academy of
Sciences of the United States of America, 118(3).
<doi:10.1073/pnas.2025207118>

H. Wickham. ggplot2: Elegant Graphics for Data Analysis. Springer-Verlag
New York, 2016.

Csardi G, Nepusz T (2006). “The igraph software package for complex
network research.” *InterJournal*, *Complex Systems*, 1695.
<https://igraph.org>.

Lachmann, A., Xu, H., Krishnan, J., Berger, S. I., Mazloom, A. R., &
Ma’ayan, A. (2010). ChEA: transcription factor regulation inferred from
integrating genome-wide ChIP-X experiments. Bioinformatics (Oxford,
England), 26(19), 2438–2444. <doi:10.1093/bioinformatics/btq466>

Liberzon, A., Birger, C., Thorvaldsdóttir, H., Ghandi, M., Mesirov, J.
P., & Tamayo, P. (2015). The molecular signatures database hallmark gene
set collection. Cell Systems, 1(6), 417–425.
<doi:10.1016/j.cels.2015.12.004>

Liska, O., Bohár, B., Hidas, A., Korcsmáros, T., Papp, B., Fazekas, D.,
& Ari, E. (2022). TFLink: an integrated gateway to access transcription
factor–target gene interactions for multiple species. Database: The
Journal of Biological Databases and Curation, 2022, baac083.
<doi:10.1093/database/baac083>

The R project for statistical computing. (n.d.). Retrieved November 15,
2023, from R-project.org website: <http://www.R-project.org>

Zhang, Q., Liu, W., Zhang, H.-M., Xie, G.-Y., Miao, Y.-R., Xia, M., &
Guo, A.-Y. (2020). HTFtarget: A comprehensive database for regulations
of human transcription factors and their targets. Genomics, Proteomics &
Bioinformatics, 18(2), 120–128. <doi:10.1016/j.gpb.2019.09.006>

## Acknowledgements

This package was developed as part of an assessment for 2023 BCB410H:
Applied Bioinformat- ics course at the University of Toronto, Toronto,
CANADA. `TRNValStandVis` welcomes issues, enhancement requests, and
other contributions. To submit an issue, use the GitHub issues.
