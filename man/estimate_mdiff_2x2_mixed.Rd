% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/estimate_mdiff_2x2_mixed.R
\name{estimate_mdiff_2x2_mixed}
\alias{estimate_mdiff_2x2_mixed}
\title{Estimates for a 2x2 mixed factorial design with a continuous outcome
variable}
\usage{
estimate_mdiff_2x2_mixed(
  data,
  outcome_variable_level1,
  outcome_variable_level2,
  grouping_variable,
  outcome_variable_name = "My outcome variable",
  repeated_measures_name = "Time",
  conf_level = 0.95,
  save_raw_data = TRUE
)
}
\arguments{
\item{data}{For raw data - a dataframe or tibble}

\item{outcome_variable_level1}{The column name of the outcome
variable for level 1 of the repeated-measures factor}

\item{outcome_variable_level2}{The column name of the outcome
variable for level 2 of the repeated-measures factor}

\item{grouping_variable}{The column name of the grouping
variable; only 2 levels allowed; must be a factor}

\item{outcome_variable_name}{Optional friendly name for the outcome variable.
Defaults to 'My outcome variable' or the outcome variable column name if a
data frame is passed.}

\item{repeated_measures_name}{Optional friendly name for the repeated
measures factor.  Defaults to 'Time'}

\item{conf_level}{The confidence level for the confidence interval.  Given in
decimal form.  Defaults to 0.95.}

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
\item \emph{effect_type} -
\item \emph{effects_complex} -
\item \emph{t} -
\item \emph{p} -
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
\item \emph{effect_type} -
\item \emph{effects_complex} -
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
\item \emph{grouping_variable_A} -
\item \emph{grouping_variable_B} -
\item \emph{paired} -
}
}
}
\description{
Returns object
\code{estimate_mdiff_2x2_mixed} is suitable for a 2x2 mixed-factorial design
with a continuous outcome variable.  It estimates each main effect, the
simple effects for the repeated-measures factor, and the interaction.
It can express these estimates as mean differences, median difference,
or standardized mean differences.  This function accepts raw data only.
}
\details{
Reach for this function in place of a 2x2 mixed-factorial ANOVA.

Once you generate an estimate with this function, you can visualize
it with \code{\link[=plot_mdiff]{plot_mdiff()}} and you can visualize the interaction
specifically with \code{\link[=plot_interaction]{plot_interaction()}}.  You can test hypotheses
with \code{\link[=test_mdiff]{test_mdiff()}}.

The estimated mean differences are from \code{\link[statpsych:ci.2x2.mean.mixed]{statpsych::ci.2x2.mean.mixed()}}.
}
\examples{
# From raw data (summary data mode not available for this function)
example_data <- data.frame(
  pretest = c(
    19, 18, 19, 20, 17, 16, 16, 10, 12,  9, 13, 15
  ),
  posttest = c(
    18, 19, 20, 17, 20, 16, 19, 16, 16, 14, 16, 18
  ),
  condition = as.factor(
    c(
      rep("Control", times = 6),
      rep("Treated", times = 6)
    )
  )
)

estimates <- esci::estimate_mdiff_2x2_mixed(
  data = example_data,
  outcome_variable_level1 = pretest,
  outcome_variable_level2 = posttest,
  grouping_variable = condition,
  repeated_measures_name = "Time"
)
# To visualize the estimated mean difference for the interaction
myplot <- esci::plot_mdiff(estimates$interaction, effect_size = "mean")

# Line-plot of the interaction with fan effect representing each simple-effect CI
plot_interaction_line_CI <- esci::plot_interaction(
  estimates,
  show_CI = TRUE
)

# To conduct a hypothesis test
res_htest_from_raw <- esci::test_mdiff(
  estimates$interaction,
  effect_size = "mean"
 )

}
