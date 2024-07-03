
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pmev

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/pmev)](https://CRAN.R-project.org/package=pmev)
<!-- badges: end -->

The goal of pmev is to implement project management tracking metrics as
outlined in the Project Management Body of Knowledge (PMBOK) manual
which can be found .

## Installation

You can install the development version of pmev from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("david-hammond/pmev")
```

## Example

``` r
library(pmev)
data(project)
ev = earned_value(start = project$start,
               end = project$end,
               progress = project$progress,
               planned_cost = project$planned_cost,
               project_value = 150000,
               cost_to_date = 10000,
               date = "2024-07-03")
```

The Earned Value can then be plotted in the following way.

``` r
library(ggplot2)
library(dplyr)
library(lubridate)
pvalue = data.frame(date = ev$pv$end, type = 'Planned Value', value = ev$pv$planned_value)
evalue = rbind(pvalue[1,] %>% mutate(type = "Earned Value"), data.frame(date = ev$ev$date,
                                                                            type = 'Earned Value',
                                                                            value = ev$ev$earned_value))
ac = rbind(pvalue[1,] %>% mutate(type = "Actual Cost"), data.frame(date = ev$ev$date,
                                                                           type = 'Actual Cost',
                                                                           value = ev$ev$actual_cost))
evalue = pvalue %>% rbind(evalue) %>% rbind(ac)
p = ggplot(evalue, aes(date, value, colour = type)) + geom_line(linewidth = 1.5) +
              scale_y_continuous(labels = scales::dollar, name = "Total Value",
                                 sec.axis = sec_axis(~ . / max(pvalue$value),
                                                     labels = scales::label_percent())) +
              labs(colour = "", title = "Earned Value Chart", x = "") + theme_bw() +
              theme(legend.position = c(0.8, 0.2)) +
              geom_vline(xintercept = ev$ev$date, linetype = "dashed", color = "cornflowerblue") +
              annotate("text", x = ev$ev$date + days(1), y = max(evalue$value),
                       label = "Today", hjust = 0, vjust = 1.5, color = "cornflowerblue")
p
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />
