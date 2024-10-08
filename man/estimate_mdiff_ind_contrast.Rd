% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/estimate_mdiff_ind_contrast.R
\name{estimate_mdiff_ind_contrast}
\alias{estimate_mdiff_ind_contrast}
\title{Estimates for a multi-group design with a continuous outcome
variable}
\usage{
estimate_mdiff_ind_contrast(
  data = NULL,
  outcome_variable = NULL,
  grouping_variable = NULL,
  means = NULL,
  sds = NULL,
  ns = NULL,
  contrast = NULL,
  grouping_variable_levels = NULL,
  outcome_variable_name = "My outcome variable",
  grouping_variable_name = "My grouping variable",
  conf_level = 0.95,
  assume_equal_variance = FALSE,
  save_raw_data = TRUE
)
}
\arguments{
\item{data}{For raw data - a data frame or tibble}

\item{outcome_variable}{For raw data - The column name of the outcome
variable, or a vector of numeric data}

\item{grouping_variable}{For raw data - The column name of the grouping
variable, or a vector of group names}

\item{means}{For summary data - A vector of 2 or more means}

\item{sds}{For summary data - A vector of standard deviations, same length as
means}

\item{ns}{For summary data - A vector of sample sizes, same length as means}

\item{contrast}{A vector of group weights, same length as number of groups.}

\item{grouping_variable_levels}{For summary data - An optional vector of
group labels, same length as means}

\item{outcome_variable_name}{Optional friendly name for the outcome variable.
Defaults to 'My outcome variable' or the outcome variable column name if a
data frame is passed.}

\item{grouping_variable_name}{Optional friendly name for the grouping
variable.  Defaults to 'My grouping variable' or the grouping variable
column name if a data.frame is passed.}

\item{conf_level}{The confidence level for the confidence interval.  Given in
decimal form.  Defaults to 0.95.}

\item{assume_equal_variance}{Defaults to FALSE}

\item{save_raw_data}{For raw data; defaults to TRUE; set to FALSE to save
memory by not returning raw data in estimate object}
}
\value{
Returns object of class esci_estimate
\itemize{
\item \strong{es_mean_difference}
\itemize{
\item \emph{type} -
\item \emph{outcome_variable_name} -
\item \emph{grouping_variable_name} -
\item \emph{effect} -
\item \emph{effect_size} -
\item \emph{LL} -
\item \emph{UL} -
\item \emph{SE} -
\item \emph{df} -
\item \emph{ta_LL} -
\item \emph{ta_UL} -
}
\item \strong{es_median_difference}
\itemize{
\item \emph{type} -
\item \emph{outcome_variable_name} -
\item \emph{grouping_variable_name} -
\item \emph{effect} -
\item \emph{effect_size} -
\item \emph{LL} -
\item \emph{UL} -
\item \emph{SE} -
\item \emph{ta_LL} -
\item \emph{ta_UL} -
}
\item \strong{es_smd}
\itemize{
\item \emph{outcome_variable_name} -
\item \emph{grouping_variable_name} -
\item \emph{effect} -
\item \emph{effect_size} -
\item \emph{LL} -
\item \emph{UL} -
\item \emph{numerator} -
\item \emph{denominator} -
\item \emph{SE} -
\item \emph{df} -
\item \emph{d_biased} -
}
\item \strong{overview}
\itemize{
\item \emph{outcome_variable_name} -
\item \emph{grouping_variable_name} -
\item \emph{grouping_variable_level} -
\item \emph{mean} -
\item \emph{mean_LL} -
\item \emph{mean_UL} -
\item \emph{median} -
\item \emph{median_LL} -
\item \emph{median_UL} -
\item \emph{sd} -
\item \emph{min} -
\item \emph{max} -
\item \emph{q1} -
\item \emph{q3} -
\item \emph{n} -
\item \emph{missing} -
\item \emph{df} -
\item \emph{mean_SE} -
\item \emph{median_SE} -
}
\item \strong{raw_data}
\itemize{
\item \emph{grouping_variable} -
\item \emph{outcome_variable} -
}
}
}
\description{
Returns object
\code{estimate_mdiff_ind_contrast} is suitable for a multi-group design
(between subjects) with a continuous outcome variable.  It accepts
a user-defined set of contrast weights that allows estimation of any
1-df contrast.  It can express estimates as mean differences, standardized
mean differences (Cohen's d) or median differences (raw data only).  You can
pass raw data or summary data.
}
\details{
Reach for this function in place of a one-way ANOVA.

Once you generate an estimate with this function, you can visualize
it with \code{\link[=plot_mdiff]{plot_mdiff()}} and you can test hypotheses with
\code{\link[=test_mdiff]{test_mdiff()}}.

The estimated mean differences are from \code{\link[statpsych:ci.lc.mean.bs]{statpsych::ci.lc.mean.bs()}}.

The estimated SMDs are from \code{\link[=CI_smd_ind_contrast]{CI_smd_ind_contrast()}} which relies
on \code{\link[statpsych:ci.lc.stdmean.bs]{statpsych::ci.lc.stdmean.bs()}} unless there are only 2 groups.

The estimated median differences are from \code{\link[statpsych:ci.lc.median.bs]{statpsych::ci.lc.median.bs()}}
}
\examples{
# From raw data
data("data_rattanmotivation")

estimate_from_raw <- esci::estimate_mdiff_ind_contrast(
  esci::data_rattanmotivation,
  Motivation,
  Group,
  contrast = c("Challenge" = 1, "Control" = -1/2, "Comfort" = -1/2)
)

# To visualize the estimate
myplot_from_raw <- esci::plot_mdiff(
  estimate_from_raw,
  effect_size = "median"
)

# To conduct a hypothesis test
res_htest_from_raw <- esci::test_mdiff(
  estimate_from_raw,
  effect_size = "median"
)


# From summary data
data("data_halagappa")

estimate_from_summary <- estimate_mdiff_ind_contrast(
  means = data_halagappa$Mean,
  sds = data_halagappa$SD,
  ns = data_halagappa$n,
  grouping_variable_levels = as.character(data_halagappa$Groups),
  assume_equal_variance = TRUE,
  contrast = c(
    "NFree10" = 1/3,
    "AFree10" = 1/3,
    "ADiet10" = -1/3,
    "NFree17" = -1/3,
    "AFree17" = 1/3,
    "ADiet17" = -1/3
  ),
  grouping_variable_name = "Diet",
  outcome_variable_name = "\% time near target"
)

# To visualize the estimate
myplot <- esci::plot_mdiff(estimate_from_summary, effect_size = "mean")

# To conduct a hypothesis test
res_htest_from_raw <- esci::test_mdiff(
  estimate_from_summary,
  effect_size = "mean"
)

}
