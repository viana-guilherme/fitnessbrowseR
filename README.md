
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fitnessbrowseR

<!-- badges: start -->
<!-- badges: end -->

`fitnessbrowseR` is an R package that provides utilities for retrieving
information from the [fitnessb browser](https://fit.genomics.lbl.gov/),
a website that compiles data from RB-TnSeq experiments for a variety of
microbial hosts and conditions (please, consider reading their
[publication](https://mbio.asm.org/content/6/3/e00306-15.full)).

This package is still under development, please report any bug that you
find to me at my [email address](viana.guilherme@proton.me), or create a
pull request.

Thank you for checking `fitnessbrowseR` out!

## Installation

You can install the development version of fitnessbrowseR with the
command below:

``` r
devtools::install_github("viana-guilherme/fitnessbrowseR")
```

## Usage

The package contains three functions at this time

``` r
library(fitnessbrowseR)

# prints all organism codes available in the database
getOrganismCodes()
#> # A tibble: 51 × 2
#>    Organism                                   OrgID          
#>    <chr>                                      <chr>          
#>  1 Acidovorax sp. GW101-3H11                  acidovorax_3H11
#>  2 Azospirillum brasilense Sp245              azobra         
#>  3 Bacteroides thetaiotaomicron VPI-5482      Btheta         
#>  4 Bifidobacterium breve UCC2003              Bifido         
#>  5 Burkholderia phytofirmans PsJN             BFirm          
#>  6 Caulobacter crescentus NA1000              Caulo          
#>  7 Cupriavidus basilensis FW507-4G11          Cup4G11        
#>  8 Dechlorosoma suillum PS                    PS             
#>  9 Desulfovibrio vulgaris Hildenborough JW710 DvH            
#> 10 Desulfovibrio vulgaris Miyazaki F          Miya           
#> # ℹ 41 more rows

# lists all experimental condition groups for Pseudomonas putida KT2440
getConditions(OrgID = "Putida")
#> # A tibble: 10 × 3
#>    Group                            Conditions Experiments
#>    <chr>                                 <int>       <int>
#>  1 carbon source                            75         128
#>  2 nitrogen source                          52         104
#>  3 r2a control                               1           6
#>  4 r2a control with 0.2% methanol            1           5
#>  5 r2a control with 0.2x vogels              1           4
#>  6 reactor                                   1          15
#>  7 reactor_pregrowth                         1           7
#>  8 stress                                    2          21
#>  9 supernatant                               2           6
#> 10 supernatant control:fungal media          1           4

# searches fitness data in all available conditions for genes PP_2675 and PP_2676 in P. putida
searchFitnessBrowser(gene = c("PP_2675", "PP_2676"), OrgID = "Putida")
#> retrieving fitness data for PP_2675
#> retrieving fitness data for PP_2676
#> # A tibble: 600 × 5
#>    group         condition           fitness `t score` gene   
#>    <chr>         <chr>                 <dbl>     <dbl> <chr>  
#>  1 carbon source 1,2-Propanediol (C)    -1.1      -3.1 PP_2675
#>  2 carbon source 1,2-Propanediol (C)    -0.8      -3   PP_2675
#>  3 carbon source 1,3-Butandiol (C)      -1.1      -3.6 PP_2675
#>  4 carbon source 1,3-Butandiol (C)      -1.9      -4.5 PP_2675
#>  5 carbon source 1,4-Butanediol (C)     -1.2      -2.9 PP_2675
#>  6 carbon source 1,4-Butanediol (C)     -1.1      -3.1 PP_2675
#>  7 carbon source 1,5-Pentanediol (C)    -2.6      -3.2 PP_2675
#>  8 carbon source 1,5-Pentanediol (C)    -3.7      -4.2 PP_2675
#>  9 carbon source 1-Pentanol (C)         -3.2      -6.1 PP_2675
#> 10 carbon source 1-Pentanol (C)         -3.5      -6.5 PP_2675
#> # ℹ 590 more rows
```
