% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/estimate_mdiff_two.R
\name{estimate_mdiff_two}
\alias{estimate_mdiff_two}
\title{Estimates for a two-group study with a continuous outcome variable}
\usage{
estimate_mdiff_two(
  data = NULL,
  outcome_variable = NULL,
  grouping_variable = NULL,
  comparison_mean = NULL,
  comparison_sd = NULL,
  comparison_n = NULL,
  reference_mean = NULL,
  reference_sd = NULL,
  reference_n = NULL,
  grouping_variable_levels = NULL,
  outcome_variable_name = "My outcome variable",
  grouping_variable_name = "My grouping variable",
  conf_level = 0.95,
  assume_equal_variance = FALSE,
  save_raw_data = TRUE,
  switch_comparison_order = FALSE
)
}
\arguments{
\item{data}{For raw data - a data.frame or tibble}

\item{outcome_variable}{For raw data - The column name of the outcome
variable, or a vector of numeric data}

\item{grouping_variable}{For raw data - The column name of the grouping
variable, or a vector of group names}

\item{comparison_mean}{For summary data, a numeric}

\item{comparison_sd}{For summary data, numeric > 0}

\item{comparison_n}{For summary data, a numeric integer > 0}

\item{reference_mean}{For summary data, a numeric}

\item{reference_sd}{For summary data, numeric > 0}

\item{reference_n}{For summary data, a numeric integer > 0}

\item{grouping_variable_levels}{For summary data - An optional vector of
2 group labels}

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

\item{switch_comparison_order}{Defaults to FALSE}
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
\item \strong{es_mean_ratio}
\itemize{
\item \emph{outcome_variable_name} -
\item \emph{grouping_variable_name} -
\item \emph{effect} -
\item \emph{effect_size} -
\item \emph{LL} -
\item \emph{UL} -
\item \emph{comparison_mean} -
\item \emph{reference_mean} -
}
\item \strong{es_median_ratio}
\itemize{
\item \emph{outcome_variable_name} -
\item \emph{grouping_variable_name} -
\item \emph{effect} -
\item \emph{effect_size} -
\item \emph{LL} -
\item \emph{UL} -
\item \emph{comparison_median} -
\item \emph{reference_median} -
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
\code{estimate_mdiff_two} is suitable for a simple two-group design
with a continuous outcome variable.  It provides estimates and CIs for the
population mean difference between the repeated measures, the standardized
mean difference (SMD; Cohen's d) between the repeated measures, and the
median difference between the repeated measures (raw data only).  You can
pass raw data or summary data.
}
\details{
Reach for this function in place of an independent-samples \emph{t}-test.

Once you generate an estimate with this function, you can visualize
it with \code{\link[=plot_mdiff]{plot_mdiff()}} and you can test hypotheses with
\code{\link[=test_mdiff]{test_mdiff()}}.

The estimated mean differences are from \code{\link[statpsych:ci.mean2]{statpsych::ci.mean2()}}.

The estimated SMDs are from \code{\link[=CI_smd_ind_contrast]{CI_smd_ind_contrast()}}.

The estimated median differences are from \code{\link[statpsych:ci.median2]{statpsych::ci.median2()}}.
}
\examples{
# From raw data
data("data_penlaptop1")

estimate_from_raw <- esci::estimate_mdiff_two(
  data = data_penlaptop1,
  outcome_variable = transcription,
  grouping_variable = condition,
  switch_comparison_order = TRUE,
  assume_equal_variance = TRUE
)

# To visualize the estimated median difference (raw data only)
myplot_from_raw <- esci::plot_mdiff(
  estimate_from_raw,
  effect_size = "median"
)

# To conduct a hypothesis test
res_htest_from_raw <- esci::test_mdiff(
  estimate_from_raw,
  effect_size = "median",
  rope = c(-2, 2)
)


# From summary data
estimate_from_summary <- esci::estimate_mdiff_two(
  comparison_mean = 12.09,
  comparison_sd = 5.52,
  comparison_n = 103,
  reference_mean = 6.88,
  reference_sd = 4.22,
  reference_n = 48,
  grouping_variable_levels = c("Ref-Laptop", "Comp-Pen"),
  outcome_variable_name = "\% Transcription",
  grouping_variable_name = "Note-taking type",
  assume_equal_variance = TRUE
)

# To visualize the estimated mean difference
myplot <- esci::plot_mdiff(
  estimate_from_summary,
  effect_size = "mean"
)

# To conduct a hypothesis test
res_htest_from_summary <- esci::test_mdiff(
  estimate_from_summary,
  effect_size = "mean",
  rope = c(-2, 2)
)

}
