#' Estimate meta-analytic difference in means across multiple two-group studies.
#'
#'
#' @description
#' `meta_mdiff_two` is suitable for synthesizing across multiple two-group
#' studies (paired or independent) with a continuous outcome measure.  It takes
#' in raw data from each study.  If all studies used the same measurement scale,
#' a meta-analytic raw-score difference can be returned.  If studies used
#' different scales, a standardized mean difference can be returned.
#' Studies can be all paired, all independent, or a mix.  Equal variance can
#' be assumed, or not.  If standardized mean difference is the output, it is
#' d_s when equal variance is assumed and d_avg when equal variance is not
#' assumed.
#'
#'
#' @details
#' Once you generate an estimate with this function, you can visualize
#' it with [esci::plot_meta()].
#'
#' The meta-analytic effect size, confidence interval and heterogeneity
#' estimates all come from [metafor::rma()].
#'
#' The diamond ratio and its confidence interval come from
#' [esci::CI_diamond_ratio()].
#'
#' If reported_effect_size is smd_unbiased or smd the conversion to Cohen's d
#' is handled by [esci::CI_smd_ind_contrast()].
#'
#'
#' @param data A data frame or tibble
#' @param comparison_means Set of comparison_group means, 1 per study
#' @param comparison_sds Set of comparison_group standard deviations, 1
#'   per study, all > 0
#' @param comparison_ns Set of comparison_group sample sizes, positive integers,
#'   1 for each study
#' @param reference_means Set of reference_group means, 1 per study
#' @param reference_sds Set of comparison_group standard deviations, 1
#'   per study, all > 0
#' @param reference_ns Set of reference_group sample sizes, positive integers,
#'   1 for each study
#' @param r Optional correlation between measures for w-s studies, NA otherwise
#' @param labels An optional collection of study labels
#' @param moderator An optional factor to analyze as a categorical moderator,
#' must have k > 2 per groups
#' @param contrast An optional contrast to estimate between moderator levels;
#' express as a vector of contrast weights with 1 weight per moderator level.
#' @param effect_label Optional character giving a human-friendly name of
#' the effect being synthesized
#' @param reported_effect_size Character specifying effect size to return:
#'   Must be one of 'mean_difference', 'smd_unbiased' (to return an unbiased
#'   Cohen's d_s or d_avg) or 'smd' (to return d_s or d_avg without correction
#'   for bias).  Defaults to mean_difference.
#' @param random_effects TRUE for random effect model; FALSE for fixed effects
#' @param assume_equal_variance Defaults to FALSE
#' @param conf_level The confidence level for the confidence interval.  Given in
#'   decimal form.  Defaults to 0.95.
#'
#'
#' @inherit meta_any return
#'
#'
#' @examples
#' # Data set -- see Introduction to the New Statistics, 2nd edition
#' data("data_mccabemichael_brain")
#'
#' # Meta-analysis: random effects, no moderator
#' estimate <- esci::meta_mdiff_two(
#'   data = esci::data_mccabemichael_brain,
#'   comparison_means = "M Brain",
#'   comparison_sds = "s Brain",
#'   comparison_ns = "n Brain",
#'   reference_means = "M No Brain",
#'   reference_sds = "s No Brain",
#'   reference_ns = "n No Brain",
#'   labels = "Study name",
#'   effect_label = "Brain Photo Rating - No Brain Photo Rating",
#'   assume_equal_variance = TRUE,
#'   random_effects = TRUE
#' )
#
#' # Forest plot
#' myplot_forest <- esci::plot_meta(estimate)
#'
#'
#' # Meta-analysis: random effects, moderator
#' estimate_moderator <- esci::meta_mdiff_two(
#'   data = esci::data_mccabemichael_brain,
#'   comparison_means = "M Brain",
#'   comparison_sds = "s Brain",
#'   comparison_ns = "n Brain",
#'   reference_means = "M No Brain",
#'   reference_sds = "s No Brain",
#'   reference_ns = "n No Brain",
#'   labels = "Study name",
#'   moderator = "Research group",
#'   effect_label = "Brain Photo Rating - No Brain Photo Rating",
#'   assume_equal_variance = TRUE,
#'   random_effects = TRUE
#' )
#
#' # Forest plot
#' myplot_forest_moderator <- esci::plot_meta(estimate_moderator)
#'
#'
#' # Meta-analysis: random effects, moderator, output d_s
#' estimate_moderator_d <- esci::meta_mdiff_two(
#'   data = esci::data_mccabemichael_brain,
#'   comparison_means = "M Brain",
#'   comparison_sds = "s Brain",
#'   comparison_ns = "n Brain",
#'   reference_means = "M No Brain",
#'   reference_sds = "s No Brain",
#'   reference_ns = "n No Brain",
#'   labels = "Study name",
#'   moderator = "Research group",
#'   effect_label = "Brain Photo Rating - No Brain Photo Rating",
#   reported_effect_size = "smd_unbiased",
#'   assume_equal_variance = TRUE,
#'   random_effects = TRUE
#' )
#
#' # Forest plot
#' myplot_forest_moderator_d <- esci::plot_meta(estimate_moderator_d)
#'
#'
#' @export
meta_mdiff_two <- function(
  data,
  comparison_means,
  comparison_sds,
  comparison_ns,
  reference_means,
  reference_sds,
  reference_ns,
  r = NULL,
  labels = NULL,
  moderator = NULL,
  contrast = NULL,
  effect_label = "My effect",
  reported_effect_size = c("mean_difference", "smd_unbiased", "smd"),
  assume_equal_variance = FALSE,
  random_effects = TRUE,
  conf_level = .95
)  {

  # Initialization ---------------------------
  # Create quosures and quonames.
  # Stolen directly from dabestr
  comparison_means_enquo        <-  rlang::enquo(comparison_means)
  comparison_means_quoname      <-  rlang::quo_name(comparison_means_enquo)

  reference_means_enquo        <-  rlang::enquo(reference_means)
  reference_means_quoname      <-  rlang::quo_name(reference_means_enquo)

  comparison_sds_enquo        <-  rlang::enquo(comparison_sds)
  comparison_sds_quoname      <-  rlang::quo_name(comparison_sds_enquo)

  reference_sds_enquo        <-  rlang::enquo(reference_sds)
  reference_sds_quoname      <-  rlang::quo_name(reference_sds_enquo)

  comparison_ns_enquo        <-  rlang::enquo(comparison_ns)
  comparison_ns_quoname      <-  rlang::quo_name(comparison_ns_enquo)

  reference_ns_enquo        <-  rlang::enquo(reference_ns)
  reference_ns_quoname      <-  rlang::quo_name(reference_ns_enquo)

  r_enquo        <-  rlang::enquo(r)
  r_quoname      <-  rlang::quo_name(r_enquo)
  if (r_quoname == "NULL") r_quoname <- NULL

  moderator_enquo        <-  rlang::enquo(moderator)
  moderator_quoname      <-  rlang::quo_name(moderator_enquo)
  if (moderator_quoname == "NULL") moderator_quoname <- NULL

  labels_enquo        <-  rlang::enquo(labels)
  labels_quoname      <-  rlang::quo_name(labels_enquo)
  if (labels_quoname == "NULL") labels_quoname <- NULL

  warnings <- NULL

  # Input checks --------------------------------
  # * data must be a data frame
  #    all rows with an NA a parameter column will be dropped, warning issued
  # * the column comparison_means must exist and be numeric,
  #    with > 1 row after NAs removed
  # * the column reference_means must exist and be numeric,
  #    with > 1 row after NAs removed
  # * the column comparison_sds must exist and be numeric > 0
  #    with > 1 row after NAs removed
  # * the column reference_sds must exist and be numeric > 0
  #    with > 1 row after NAs removed
  # * the column comparison_ns must exist and be numeric integers > 0
  #    with > 1 row after NAs removed
  # * the column reference_ns must exist and be numeric integers > 0
  #    with > 1 row after NAs removed
  # * the column r is optional but if passed must be numeric fro -1 to 1 or NA
  # * the column labels is optional, but if passed must exist and
  #    have > 1 row after NAs removed
  # * the column moderator is optional; checks happen in meta_any
  # * contrast should only be passed in moderator is defined; checks in meta_any
  # * effect_label should be a character, checked in meta_any
  # * reported_effect_size must be mean_difference, smd_unbiased, or smd
  # * random_effect must be a logical, TRUE or FALSE, checked in meta_any
  # * assume_equal_variance must be logical
  # * conf_level must be a numeric >0 and < 1, checked in meta_any

  # Check that data is a data.frame
  esci_assert_type(data, "is.data.frame")

  # reference_means
  esci_assert_valid_column_name(data, reference_means_quoname)
  esci_assert_column_type(data, reference_means_quoname, "is.numeric")
  row_report <- esci_assert_column_has_valid_rows(
    data,
    reference_means_quoname,
    lower = 1,
    na.rm = TRUE
  )
  if (row_report$missing > 0) {
    warnings <- c(warnings, row_report$warning)
    warning(row_report$warning)
    data <- data[-row_report$NA_rows, ]
  }

  # comparison_means
  esci_assert_valid_column_name(data, comparison_means_quoname)
  esci_assert_column_type(data, comparison_means_quoname, "is.numeric")
  row_report <- esci_assert_column_has_valid_rows(
    data,
    comparison_means_quoname,
    lower = 1,
    na.rm = TRUE
  )
  if (row_report$missing > 0) {
    warnings <- c(warnings, row_report$warning)
    warning(row_report$warning)
    data <- data[-row_report$NA_rows, ]
  }

  # reference_sds
  esci_assert_valid_column_name(data, reference_sds_quoname)
  esci_assert_column_type(data, reference_sds_quoname, "is.numeric")
  if (!all(data[[reference_sds_quoname]] > 0, na.rm = TRUE)) {
    stop(
      glue::glue("
Some sd values in {reference_sds_quoname} are 0 or less.
These are rows {paste(which(data[[reference_sds_quoname]] <= 0), collapse = ', ')}.
      ")
    )
  }
  row_report <- esci_assert_column_has_valid_rows(
    data,
    reference_sds_quoname,
    lower = 1,
    na.rm = TRUE
  )
  if (row_report$missing > 0) {
    warnings <- c(warnings, row_report$warning)
    warning(row_report$warning)
    data <- data[-row_report$NA_rows, ]
  }

  # comparison_sds
  esci_assert_valid_column_name(data, comparison_sds_quoname)
  esci_assert_column_type(data, comparison_sds_quoname, "is.numeric")
  if (!all(data[[comparison_sds_quoname]] > 0, na.rm = TRUE)) {
    stop(
      glue::glue("
Some sd values in {comparison_sds_quoname} are 0 or less.
These are rows {paste(which(data[[comparison_sds_quoname]] <= 0), collapse = ', ')}.
      ")
    )
  }
  row_report <- esci_assert_column_has_valid_rows(
    data,
    comparison_sds_quoname,
    lower = 1,
    na.rm = TRUE
  )
  if (row_report$missing > 0) {
    warnings <- c(warnings, row_report$warning)
    warning(row_report$warning)
    data <- data[-row_report$NA_rows, ]
  }

  # reference_ns
  esci_assert_valid_column_name(data, reference_ns_quoname)
  esci_assert_column_type(data, reference_ns_quoname, "is.numeric")
  if (!all(data[[reference_ns_quoname]] > 0, na.rm = TRUE)) {
    stop(
      glue::glue("
Some n values in {reference_ns_quoname} are 0 or less.
These are rows {paste(which(data[[reference_ns_quoname]] <= 0), collapse = ', ')}.
      ")
    )
  }
  if (!all(is.whole.number(data[[reference_ns_quoname]]), na.rm = TRUE)) {
    stop(
      glue::glue("
Some n values in {reference_ns_quoname} are not integers.
These are rows {paste(which(!is.whole.number(data[[reference_ns_quoname]])), collapse = ', ')}.
      ")
    )
  }
  row_report <- esci_assert_column_has_valid_rows(
    data,
    reference_ns_quoname,
    lower = 1,
    na.rm = TRUE
  )
  if (row_report$missing > 0) {
    warnings <- c(warnings, row_report$warning)
    warning(row_report$warning)
    data <- data[-row_report$NA_rows, ]
  }

  # comparison_ns
  esci_assert_valid_column_name(data, comparison_ns_quoname)
  esci_assert_column_type(data, comparison_ns_quoname, "is.numeric")
  if (!all(data[[comparison_ns_quoname]] > 0, na.rm = TRUE)) {
    stop(
      glue::glue("
Some sample-size values in {comparison_ns_quoname} are 0 or less.
These are rows {paste(which(data[[comparison_ns_quoname]] <= 0), collapse = ', ')}.
      ")
    )
  }
  if (!all(is.whole.number(data[[comparison_ns_quoname]]), na.rm = TRUE)) {
    stop(
      glue::glue("
Some n values in {comparison_ns_quoname} are not integers.
These are rows {paste(which(!is.whole.number(data[[comparison_ns_quoname]])), collapse = ', ')}.
      ")
    )
  }
  row_report <- esci_assert_column_has_valid_rows(
    data,
    comparison_ns_quoname,
    lower = 1,
    na.rm = TRUE
  )
  if (row_report$missing > 0) {
    warnings <- c(warnings, row_report$warning)
    warning(row_report$warning)
    data <- data[-row_report$NA_rows, ]
  }


  # r
  if (!is.null(r_quoname)) {
    esci_assert_valid_column_name(data, r_quoname)
    esci_assert_column_type(data, r_quoname, "is.numeric")
    if (!all(data[[r_quoname]] >= -1, na.rm = TRUE)) {
      stop(
        glue::glue("
Some r values in {r_quoname} are < -1.
These are rows {paste(which(data[[r_quoname]] < -1), collapse = ', ')}.
      ")
      )
    }

    if (!all(data[[r_quoname]] <= 1, na.rm = TRUE)) {
      stop(
        glue::glue("
Some r values in {r_quoname} are > 1.
These are rows {paste(which(data[[r_quoname]] > 1), collapse = ', ')}.
      ")
      )
    }

    check_n <- data[!is.na(data[[r_quoname]]), ]
    if (!all(check_n[[reference_ns_quoname]] == check_n[[comparison_ns_quoname]])) {
      stop(
        glue::glue("
Some studies are passed with r but with n for reference and comparison not set the same.
The rows with r but mismatching n are:
{paste(check_n[which(check_n[[reference_ns_quoname]] != check_n[[comparison_ns_quoname]]), ], collapse = ', ')}.
      ")
      )

    }
  }

  # labels
  if (is.null(labels_quoname)) {
    data$esci_label <- paste("Study", seq(1:nrow(data)))
    labels_quoname <- "esci_label"
  } else {
    esci_assert_valid_column_name(data, labels_quoname)
  }
  row_report <- esci_assert_column_has_valid_rows(
    data,
    labels_quoname,
    lower = 1,
  )
  if (row_report$missing > 0) {
    warnings <- c(warnings, row_report$warning)
    warning(row_report$warning)
    data <- data[-row_report$NA_rows, ]
  }

  # moderator
  moderator <- !is.null(moderator_quoname)
  if (moderator) {
    esci_assert_valid_column_name(data, moderator_quoname)
    row_report <- esci_assert_column_has_valid_rows(
      data,
      moderator_quoname,
      lower = 1,
    )
    if (row_report$missing > 0) {
      warnings <- c(warnings, row_report$warning)
      warning(row_report$warning)
      data <- data[-row_report$NA_rows, ]
    }
  }

  # Check options
  reported_effect_size <- match.arg(reported_effect_size)
  esci_assert_type(assume_equal_variance, "is.logical")

  report_smd <- reported_effect_size != "mean_difference"
  correct_bias <- reported_effect_size == "smd_unbiased"

  # All other checks happen in meta_any
  # * additional constraints on moderator
  # * contrast
  # * effect_label
  # * random_effects
  # * conf_level


  # Data prep------------------------------------------
  # vector of passed column names
  just_cols <- c(
    labels_quoname,
    reference_means_quoname,
    reference_sds_quoname,
    reference_ns_quoname,
    comparison_means_quoname,
    comparison_sds_quoname,
    comparison_ns_quoname,
    if (!is.null(r_quoname)) r_quoname,
    if (moderator) moderator_quoname
  )

  # vector of cannonical column names
  numeric_cols <- c(
    "reference_mean",
    "reference_sd",
    "reference_n",
    "comparison_mean",
    "comparison_sd",
    "comparison_n",
    if (!is.null(r_quoname)) "r"
  )
  col_names <- c(
    "label",
    numeric_cols,
    if (moderator) "moderator"
  )

  # reduce data down to just needed columns with canonical names
  data <- data[ , just_cols]
  colnames(data) <- col_names


  # Calculations -------------------------------------------------
  # Get yi and vi for raw scores
  if (!report_smd) {
    es_data <- as.data.frame(
      t(
        apply(
          X = data[ , numeric_cols],
          MARGIN = 1,
          FUN = apply_ci_mdiff,
          assume_equal_variance = assume_equal_variance,
          conf_level = conf_level
        )
      )
    )
  } else {
    es_data <- as.data.frame(
      t(
        apply(
          X = data[ , numeric_cols],
          MARGIN = 1,
          FUN = apply_ci_stdmean_two,
          assume_equal_variance = assume_equal_variance,
          correct_bias = correct_bias,
          conf_level = conf_level
        )
      )
    )

  }


  res <- meta_any(
    data = cbind(data, es_data),
    yi = "yi",
    vi = "vi",
    moderator = !!if (moderator) "moderator" else NULL,
    contrast = contrast,
    labels = "label",
    effect_label = effect_label,
    effect_size_name = reported_effect_size,
    moderator_variable_name = if (moderator) moderator_quoname else "My moderator",
    random_effects = random_effects,
    conf_level = conf_level
  )

  data$label <- NULL
  data$moderator <- NULL
  data$df <- es_data$df
  data$p <- es_data$p
  if (is.null(r_quoname)) data$r <- NA

  es_data_include <- c("LL", "UL")


  res$raw_data <- cbind(res$raw_data, es_data[ , c("LL", "UL")], data)
  res$warnings <- c(res$warnings, warnings)


  # Effect size labels


  res$properties$effect_size_name <- switch(
    reported_effect_size,
    "mean_difference" = "Mean_diff",
    "smd" = if(assume_equal_variance) "d_s.biased" else "d_avg.biased",
    "smd_unbiased" = if(assume_equal_variance)"d_s" else "d_avg"
  )
  res$properties$effect_size_name_html <- switch(
    reported_effect_size,
    "mean_difference" = "Mean<sub>diff</sub>",
    "smd" = if(assume_equal_variance) "<i>d</i><sub>s.biased</sub>" else "<i>d</i><sub>avg.biased</sub>",
    "smd_unbiased" = if(assume_equal_variance) "<i>d</i><sub>s</sub>" else "<i>d</i><sub>avg</sub>"
  )
  res$properties$effect_size_name_ggplot <- switch(
    reported_effect_size,
    "mean_difference" = "*M*<sub>diff</sub>",
    "smd_unbiased" = if(assume_equal_variance) "*d*<sub>s</sub>" else "*d*<sub>avg</sub>",
    "smd" = if(assume_equal_variance) "*d*<sub>s.biased</sub>" else "*d*<sub>avg.biased</sub>"
  )


  return(res)
}


