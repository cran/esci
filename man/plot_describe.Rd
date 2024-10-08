% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_describe.R
\name{plot_describe}
\alias{plot_describe}
\title{Plot a histogram or dotplot of an estimated magnitude with raw data}
\usage{
plot_describe(
  estimate,
  type = c("histogram", "dotplot"),
  mark_mean = FALSE,
  mark_median = FALSE,
  mark_sd = FALSE,
  mark_quartiles = FALSE,
  mark_z_lines = FALSE,
  mark_percentile = NULL,
  histogram_bins = 12,
  ylim = c(0, NA),
  ybreaks = NULL,
  xlim = c(NA, NA),
  xbreaks = NULL,
  fill_regular = "#008DF9",
  fill_highlighted = "#E20134",
  color = "black",
  marker_size = 5,
  ggtheme = NULL
)
}
\arguments{
\item{estimate}{A esci_estimate object with raw data an es_mean}

\item{type}{histogram or dotplot}

\item{mark_mean}{should mean be marked?}

\item{mark_median}{should median be marked?}

\item{mark_sd}{should mean be marked?}

\item{mark_quartiles}{should mean be marked?}

\item{mark_z_lines}{should z lines be marked?}

\item{mark_percentile}{a percentile (0 to 1) to be marked}

\item{histogram_bins}{number of bins if a histogram}

\item{ylim}{2-length numeric vector}

\item{ybreaks}{numeric >= 1}

\item{xlim}{2-length numeric vector}

\item{xbreaks}{numeric >= 1}

\item{fill_regular}{color for}

\item{fill_highlighted}{color for}

\item{color}{outline color}

\item{marker_size}{Size of markers}

\item{ggtheme}{theme to apply, if any}
}
\value{
Returns a ggplot object
}
\description{
\code{plot_describe} Takes an estimate produced from \link{estimate_magnitude}
and produces a dotplot or histogram.  It can mark various descriptive
statistics on the plot, including mean, median, sd, quartiles, and z lines.
If a percentile is passed, it color-codes data based on if it is above
or below that percentile.
}
\details{
This function was developed primarily for student use within jamovi when
learning along with the text book Introduction to the New Statistics, 2nd
edition (Cumming & Calin-Jageman, 2024).

Expect breaking changes as this function is improved for general use.  Work
still do be done includes:
\itemize{
\item Revise to avoid deprecated ggplot features
\item Revise for consistent ability to control aesthetics and consistent
layer names
}
}
\examples{
# example code
# Generate an estimate on a single continuous variable
estimate <- esci::estimate_magnitude(esci::data_latimier_3groups, `Test\%`)

# Now describe the result, with a histogram
myplot_hist <- plot_describe(estimate)

# Same, but as a dotplot and mark the mean
myplot_dots <- plot_describe(estimate, type = "dotplot", mark_mean = TRUE)



}
