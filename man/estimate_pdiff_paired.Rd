% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/estimate_pdiff_paired.R
\name{estimate_pdiff_paired}
\alias{estimate_pdiff_paired}
\title{Estimates for a repeated-measures study with two measures of a categorical
variable}
\usage{
estimate_pdiff_paired(
  data = NULL,
  comparison_measure = NULL,
  reference_measure = NULL,
  cases_consistent = NULL,
  cases_inconsistent = NULL,
  not_cases_consistent = NULL,
  not_cases_inconsistent = NULL,
  case_label = 1,
  not_case_label = NULL,
  comparison_measure_name = "Comparison measure",
  reference_measure_name = "Reference measure",
  conf_level = 0.95,
  count_NA = FALSE
)
}
\arguments{
\item{data}{For raw data - a data.frame or tibble}

\item{comparison_measure}{For raw data - The comparison measure, a factor.  Can
be the column name of a data frame of a vector.}

\item{reference_measure}{For raw data - The reference measure, a factor.  Can
be the column name of a data frame of a vector.}

\item{cases_consistent}{Count of \emph{cases} in measure 1 that \emph{are} also cases at
measure 2; measure 1 = 0, measure 2 = 0; cell 0_0}

\item{cases_inconsistent}{Count of \emph{cases} in measure 1 that are \emph{not} cases at
measure 2; measure 1 = 0, measure 2 = 1; cell 0_1}

\item{not_cases_consistent}{Count of \emph{not cases} in measure 1 that \emph{are} also
not cases at measure 2; measure 1 = 1, measure 2 = 1, cell 1_1}

\item{not_cases_inconsistent}{Count of \emph{not cases} in measure 1 that are \emph{not}
cases at measure 2; measure 1 = 1, measure 2 = 0, cell 1_0}

\item{case_label}{An optional numeric or character label for the
case level.}

\item{not_case_label}{An optional numeric or character label for the
not case level.}

\item{comparison_measure_name}{For summary data - An optional character
label for the comparison measure.  Defaults to 'Comparison measure'}

\item{reference_measure_name}{For summary data - An optional character
label for the reference measure.  Defaults to 'Reference measure'}

\item{conf_level}{The confidence level for the confidence interval.  Given in
decimal form.  Defaults to 0.95.}

\item{count_NA}{Logical to count NAs (TRUE) in total N or not (FALSE)}
}
\value{
Returns object of class esci_estimate
}
\description{
Returns object
\code{estimate_pdiff_paired} is suitable for a simple paired design
with a categorical outcome variable.  It provides estimates and CIs for the
population proportion difference between the repeated measures.  You can
pass raw data or summary data.
}
\details{
Once you generate an estimate with this function, you can visualize
it with \code{\link[=plot_pdiff]{plot_pdiff()}} and you can test hypotheses with
\code{\link[=test_pdiff]{test_pdiff()}}.

The estimated proportion differences are from \code{\link[statpsych:ci.prop.ps]{statpsych::ci.prop.ps()}}.
}
\examples{
# From summary data
# Example 1 from Bonett & Price, 2012
estimate_from_summary <- esci::estimate_pdiff_paired(
  cases_consistent = 60,
  cases_inconsistent = 50,
  not_cases_inconsistent = 22,
  not_cases_consistent = 68,
  case_label = "Answered True",
  not_case_label = "Answered False",
  reference_measure_name = "9th grade",
  comparison_measure_name = "12th grade",
  conf_level = 0.95
)

# To visualize the estimate
myplot_from_summary <- esci::plot_pdiff(estimate_from_summary)

# To conduct a hypothesis test
res_htest_from_summary <- esci::test_pdiff(estimate_from_summary)


}
