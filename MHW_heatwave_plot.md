MHW_analysis
================
Juyeon Kim
2023-10-10

## MHW_Event

``` r
library(heatwaveR)
library(lubridate)
```

    ## 
    ## Attaching package: 'lubridate'

    ## The following objects are masked from 'package:base':
    ## 
    ##     date, intersect, setdiff, union

``` r
library(ggplot2)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
df<- read.csv("heatwave_practice.csv")
df$t <- as.Date(df$t, format =  "%Y.%m.%d")
df <- df[c("t", "temp")]
head(df)
```

    ##            t     temp
    ## 1 1982-01-01 14.76999
    ## 2 1982-01-02 14.61999
    ## 3 1982-01-03 14.67001
    ## 4 1982-01-04 14.70001
    ## 5 1982-01-05 14.98001
    ## 6 1982-01-06 15.00000

\##heatwaveR이용

``` r
# #30년기후평균/임계값  구하기
ts <- ts2clm(df, climatologyPeriod = c("1982-01-01", "2021-12-31"))
head(ts)
```

    ## # A tibble: 6 × 5
    ##     doy t           temp  seas thresh
    ##   <int> <date>     <dbl> <dbl>  <dbl>
    ## 1     1 1982-01-01  14.8  15.3   16.4
    ## 2     2 1982-01-02  14.6  15.2   16.3
    ## 3     3 1982-01-03  14.7  15.1   16.2
    ## 4     4 1982-01-04  14.7  15.0   16.1
    ## 5     5 1982-01-05  15.0  15.0   16.1
    ## 6     6 1982-01-06  15    14.9   16.0

``` r
#mhw분석
mhw <- detect_event(ts)
mhw_event  <-mhw$event
mhw_clim <-mhw$climatology
head(mhw_event)
```

    ## # A tibble: 6 × 22
    ##   event_no index_start index_peak index_end duration date_start date_peak 
    ##      <int>       <int>      <int>     <int>    <dbl> <date>     <date>    
    ## 1        1        1304       1308      1319       16 1985-07-27 1985-07-31
    ## 2        2        1324       1332      1355       32 1985-08-16 1985-08-24
    ## 3        3        3131       3139      3141       11 1990-07-28 1990-08-05
    ## 4        4        3687       3689      3691        5 1992-02-04 1992-02-06
    ## 5        5        4040       4042      4046        7 1993-01-22 1993-01-24
    ## 6        6        4579       4585      4587        9 1994-07-15 1994-07-21
    ## # ℹ 15 more variables: date_end <date>, intensity_mean <dbl>,
    ## #   intensity_max <dbl>, intensity_var <dbl>, intensity_cumulative <dbl>,
    ## #   intensity_mean_relThresh <dbl>, intensity_max_relThresh <dbl>,
    ## #   intensity_var_relThresh <dbl>, intensity_cumulative_relThresh <dbl>,
    ## #   intensity_mean_abs <dbl>, intensity_max_abs <dbl>, intensity_var_abs <dbl>,
    ## #   intensity_cumulative_abs <dbl>, rate_onset <dbl>, rate_decline <dbl>

\##2010\~2021 MHW event 시각화

    ## Warning: The `guide` argument in `scale_*()` cannot be `FALSE`. This was deprecated in
    ## ggplot2 3.3.4.
    ## ℹ Please use "none" instead.
    ## ℹ The deprecated feature was likely used in the heatwaveR package.
    ##   Please report the issue at
    ##   <https://github.com/robwschlegel/heatwaveR/issues>.
    ## This warning is displayed once every 8 hours.
    ## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
    ## generated.

![](MHW_heatwave_plot_files/figure-gfm/pressure-1.png)<!-- -->![](MHW_heatwave_plot_files/figure-gfm/pressure-2.png)<!-- -->![](MHW_heatwave_plot_files/figure-gfm/pressure-3.png)<!-- -->![](MHW_heatwave_plot_files/figure-gfm/pressure-4.png)<!-- -->

    ## NULL

![](MHW_heatwave_plot_files/figure-gfm/pressure-5.png)<!-- -->![](MHW_heatwave_plot_files/figure-gfm/pressure-6.png)<!-- -->![](MHW_heatwave_plot_files/figure-gfm/pressure-7.png)<!-- -->![](MHW_heatwave_plot_files/figure-gfm/pressure-8.png)<!-- -->![](MHW_heatwave_plot_files/figure-gfm/pressure-9.png)<!-- -->

    ## Warning: Removed 1 rows containing missing values (`geom_flame()`).

![](MHW_heatwave_plot_files/figure-gfm/pressure-10.png)<!-- -->![](MHW_heatwave_plot_files/figure-gfm/pressure-11.png)<!-- -->

\##강도
![](MHW_heatwave_plot_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

``` r
#최대강도
lolli_plot(mhw ,metric = "intensity_mean")
```

![](MHW_heatwave_plot_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

\##누적강도
![](MHW_heatwave_plot_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

\##시간에따른 MHW의 지속시간

    ## Warning: Using the `size` aesthetic with geom_segment was deprecated in ggplot2 3.4.0.
    ## ℹ Please use the `linewidth` aesthetic instead.
    ## This warning is displayed once every 8 hours.
    ## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
    ## generated.

![](MHW_heatwave_plot_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

\##시간에따른 MHW의 지속시간이 가장긴 3개
![](MHW_heatwave_plot_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

\##Rate onset?
![](MHW_heatwave_plot_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->
