
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Lab3package

<!-- badges: start -->
<!-- badges: end -->

The goal of Lab3package is to thin the large shape files and convert it
into a data frame containing Longitude, Latitude, group and order so
that you can make a polygon figure using this data frame.

## Installation

You can install the development version of Lab3package from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("JinjiPang/Lab3package")
```

## Example

This is a basic example to show how to use functions in this package to
create geometric data frame and some implementations.

``` r
library(Lab3package)
#> Registered S3 method overwritten by 'geojsonlint':
#>   method         from 
#>   print.location dplyr
data("Yemen")
```

First, you can download a shape file of a country of your choice. Then,
you can either read the file using `sf::read_sf()`first or just use the
file path to try the following codes:

``` r
library(tidyverse)
#> -- Attaching packages --------------------------------------- tidyverse 1.3.1 --
#> v ggplot2 3.3.5     v purrr   0.3.4
#> v tibble  3.1.6     v dplyr   1.0.7
#> v tidyr   1.1.4     v stringr 1.4.0
#> v readr   2.1.1     v forcats 0.5.1
#> -- Conflicts ------------------------------------------ tidyverse_conflicts() --
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()

df <- team_2(Yemen, 0.1)

df %>%
  ggplot(aes(x = long, y = lat, group = group)) + geom_polygon()
```

<img src="man/figures/README-create polygon figure-1.png" width="100%" />
