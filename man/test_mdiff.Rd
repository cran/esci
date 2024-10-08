% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hypothesis_evaluation.R
\name{test_mdiff}
\alias{test_mdiff}
\title{Test a hypothesis about a difference in a continuous outcome variable.}
\usage{
test_mdiff(
  estimate,
  effect_size = c("mean", "median"),
  rope = c(0, 0),
  rope_units = c("raw", "sd"),
  output_html = FALSE
)
}
\arguments{
\item{estimate}{\itemize{
\item An esci_estimate object generated by an
estimate_mdiff_ function
}}

\item{effect_size}{\itemize{
\item One of 'mean' or 'median'.  The effect size selected
must be available in the esci_estimate object; medians are only available
when the estimate was generated from raw data.
}}

\item{rope}{\itemize{
\item A two-element vector defining the Region of Practical
Equivalence (ROPE). Specify c(0, 0) to test a point null of exactly 0.
Specify any two ascending values to test an interval null (e.g. c(-1, 1) to
test the hypothesis tha the difference is between -1 and 1).
}}

\item{rope_units}{\itemize{
\item One of 'raw' (default) or 'sd', specifies the units of
the ROPE. If 'sd' is specified, the rope is defined in standard deviation
units (e.g. c(-1, 1) is taken as between -1 and 1 \emph{standard deviations}
from 0).  When sd is used, the ROPE is converted to raw scores and then
the test is conducted on raw scores.
}}

\item{output_html}{\itemize{
\item TRUE to return results in HTML; FALSE (default) to return
standard output
}}
}
\value{
Returns a list with 1-2 data frames
\itemize{
\item \strong{point_null}  - always returned
\itemize{
\item \emph{test_type} - 'Nil hypothesis test', meaning a test against H0 = 0
\item \emph{outcome_variable_name} - Name of the outcome variable
\item \emph{effect} - Label for the effect being tested
\item \emph{null_words} - Express the null in words
\item \emph{confidence} - Confidence level, integer (95 for 95\%, etc.)
\item \emph{LL} - Lower boundary of the confidence\% CI for the effect
\item \emph{UL} - Upper boundary of the confidence\% CI for the effect
\item \emph{CI} - Character representation of the CI for the effect
\item \emph{CI_compare} - Text description of relation between CI and null
\item \emph{t} - If applicable, t value for hypothesis test
\item \emph{df} - If applicable, degrees of freedom for hypothesis test
\item \emph{p} - If applicable, p value for hypothesis test
\item \emph{p_result} - Text representation of p value obtained
\item \emph{null_decision} - Text represention of the decision for the null
\item \emph{conclusion} - Text representation of conclusion to draw
\item \emph{significant} - TRUE/FALSE if significant at alpha = 1-CI
}
\item \strong{interval_null} - returned only if an interval null is specified
\itemize{
\item \emph{test_type} - 'Practical significance test', meaning a test against an
interval null
\item \emph{outcome_variable_name} -
\item \emph{effect} - Name of the outcome variable
\item \emph{rope} - Test representation of null interval
\item \emph{confidence} - Confidence level, integer (95 for 95\%, etc.)
\item \emph{CI} - Character representation of the CI for the effect
\item \emph{rope_compare} - Text description of relation between CI and null interval
\item \emph{p_result} - Text representation of p value obtained
\item \emph{conclusion} - Text representation of conclusion to draw
\item \emph{significant} - TRUE/FALSE if significant at alpha = 1-CI
}
}
}
\description{
\code{test_mdiff} is suitable for conducting a testing a hypothesis about the
magnitude of difference between two conditions for a continuous outcome
variable.  It can test hypotheses about differences in means or medians for
both independent and paired designs.
}
\details{
This function can be passed an esci_estimate object generated by
\code{\link[=estimate_mdiff_one]{estimate_mdiff_one()}}, \code{\link[=estimate_mdiff_two]{estimate_mdiff_two()}},
\code{\link[=estimate_mdiff_paired]{estimate_mdiff_paired()}}, or \code{\link[=estimate_mdiff_ind_contrast]{estimate_mdiff_ind_contrast()}}.

It can test hypotheses about a specific value for the difference (a
point null) or about a range of values (an interval null)
}
\examples{
# example code
data("data_penlaptop1")

estimate <- esci::estimate_mdiff_two(
  data = data_penlaptop1,
  outcome_variable = transcription,
  grouping_variable = condition,
  switch_comparison_order = TRUE,
  assume_equal_variance = TRUE
)

# Test mean difference against point null of 0
esci::test_mdiff(
  estimate,
  effect_size = "mean"
)

# Test median difference against point null of 0
#  Note that t, df, p return NA because test is completed
#  by interval.
esci::test_mdiff(
  estimate,
  effect_size = "median"
)

# Test mean difference against interval null of -10 to 10
esci::test_mdiff(
  estimate,
  effect_size = "mean",
  rope = c(-10, 10)
)

# Test mean difference against interval null of d (-0.20, 0.20) d = 0.2 is often
# thought of as a small effect, so this test examines if the effect is
# negligible (clearly between negligble and small), substantive (clearly more
# than small), or unclear. The d boundaries provided are converted to raw scores
# and then the CI of the observed effect is compared to the raw-score boundaries
esci::test_mdiff(
  estimate,
  effect_size = "mean",
  rope = c(-0.2, 0.2),
  rope_units = "sd"
)


}
