#' Estimates for a two-group study with a categorical outcome variable
#'
#'
#' @description Returns object
#' `estimate_pdiff_two` is suitable for a simple two-group design
#' with a categorical outcome variable.  It provides estimates and CIs for the
#' difference in proportions between the two groups, the odds ratio, and phi.
#' You can pass raw data or summary data.
#'
#'
#' @details
#' Once you generate an estimate with this function, you can visualize
#' it with [esci::plot_mdiff()] and you can test hypotheses with
#' [esci::test_mdiff()].
#'
#' The estimated mean differences are from [statpsych::ci.prop2()].
#'
#' The estimated odds ratio is from [statpsych::ci.oddsratio()].
#'
#' The estimated correlation (phi) is from [statpsych::ci.phi()].
#'
#'
#' @param data For raw data - a data frame or tibble
#' @param outcome_variable For raw data - The column name of the outcome
#'   variable which is a factor, or a vector that is a factor
#' @param grouping_variable For raw data - The column name of the grouping
#'   variable which is a factor, or a vector that is a factor
#' @param comparison_cases For summary data, a numeric integer >= 0
#' @param comparison_n For summary data, a numeric integer >= comparison_events
#' @param reference_cases For summary data, a numeric integer >= 0
#' @param reference_n For summary data, a numeric integer >= reference_events
#' @param case_label An optional numeric or character label for the
#'   case level.
#' @param not_case_label An optional numeric or character label for the
#'   not case level.
#' @param grouping_variable_levels For summary data - An optional vector of
#'   2 group labels
#' @param outcome_variable_name Optional friendly name for the outcome variable.
#'   Defaults to 'My outcome variable' or the outcome variable column name if a
#'   data frame is passed.
#' @param grouping_variable_name Optional friendly name for the grouping
#'   variable.  Defaults to 'My grouping variable' or the grouping variable
#'   column name if a data.frame is passed.
#' @param conf_level The confidence level for the confidence interval.  Given in
#'   decimal form.  Defaults to 0.95.
#' @param count_NA Logical to count NAs (TRUE) in total N or not (FALSE)
#'
#'
#' @return Returns object of class esci_estimate
#' - **es_proportion_difference**
#'     - *type* -
#'     - *outcome_variable_name* -
#'     - *case_label* -
#'     - *grouping_variable_name* -
#'     - *effect* -
#'     - *effect_size* -
#'     - *LL* -
#'     - *UL* -
#'     - *SE* -
#'     - *effect_size_adjusted* -
#'     - *ta_LL* -
#'     - *ta_UL* -
#' - **es_odds_ratio**
#'     - *outcome_variable_name* -
#'     - *case_label* -
#'     - *grouping_variable_name* -
#'     - *effect* -
#'     - *effect_size* -
#'     - *SE* -
#'     - *LL* -
#'     - *UL* -
#'     - *ta_LL* -
#'     - *ta_UL* -
#' - **overview**
#'     - *grouping_variable_name* -
#'     - *grouping_variable_level* -
#'     - *outcome_variable_name* -
#'     - *outcome_variable_level* -
#'     - *cases* -
#'     - *n* -
#'     - *P* -
#'     - *P_LL* -
#'     - *P_UL* -
#'     - *P_SE* -
#'     - *P_adjusted* -
#'     - *ta_LL* -
#'     - *ta_UL* -
#' - **es_phi**
#'     - *grouping_variable_name* -
#'     - *outcome_variable_name* -
#'     - *effect* -
#'     - *effect_size* -
#'     - *SE* -
#'     - *LL* -
#'     - *UL* -
#'
#'
#' @examples
#' data("data_campus_involvement")
#'
#' estimate_from_raw <- esci::estimate_pdiff_two(
#'   esci::data_campus_involvement,
#'   CommuterStatus,
#'   Gender
#' )
#'
#' # To visualize the estimate
#' myplot_from_raw <- esci::plot_pdiff(estimate_from_raw)
#'
#' # To conduct a hypothesis test
#' res_htest_from_raw <- esci::test_pdiff(estimate_from_raw)
#'
#'
#' # From summary_data
#' estimate_from_summary <- esci::estimate_pdiff_two(
#'   comparison_cases = 10,
#'   comparison_n = 20,
#'   reference_cases = 78,
#'   reference_n = 252,
#'   grouping_variable_levels = c("Original", "Replication"),
#'   conf_level = 0.95
#' )
#'
#' # To visualize the estimate
#' myplot_from_summary <- esci::plot_pdiff(estimate_from_summary)
#'
#' #' # To conduct a hypothesis test
#' res_htest_from_summary <- esci::test_pdiff(estimate_from_summary)
#'
#'
#' @export
estimate_pdiff_two <- function(
  data = NULL,
  outcome_variable = NULL,
  grouping_variable = NULL,
  comparison_cases = NULL,
  comparison_n = NULL,
  reference_cases = NULL,
  reference_n = NULL,
  case_label = 1,
  not_case_label = NULL,
  grouping_variable_levels = NULL,
  outcome_variable_name = "My outcome variable",
  grouping_variable_name = "My grouping variable",
  conf_level = 0.95,
  count_NA = FALSE
) {

  analysis_type <- "Undefined"

  # Check to see if summary data has been passed
  if (
    !is.null(comparison_cases) |
    !is.null(comparison_n) |
    !is.null(reference_cases) |
    !is.null(reference_n)
    ) {

    # Summary data is passed, so check to make sure raw data not included
    if(!is.null(data))  stop(
      "You have passed summary statistics,
      so don't pass the 'data' parameter used for raw data.")
    if(!is.null(grouping_variable)) stop(
      "You have passed summary statistics,
      so don't pass the 'grouping_variable' parameter used for raw data.")
    if(!is.null(outcome_variable)) stop(
      "You have passed summary statistics,
      so don't pass the 'outcome_variable' parameter used for raw data.")

    # Looks good, we can pass on to summary data
    analysis_type <- "summary"

  } else {
    # Raw data has been passed, first sure summary data is not passed
    if(!is.null(comparison_cases))  stop(
      "You have passed raw data,
      so don't pass the 'comparison_cases' parameter used for summary data.")
    if(!is.null(comparison_n))  stop(
      "You have passed raw data,
      so don't pass the 'comparison_n' parameter used for summary data.")
    if(!is.null(reference_cases))  stop(
      "You have passed raw data,
      so don't pass the 'reference_cases' parameter used for summary data.")
    if(!is.null(reference_n))  stop(
      "You have passed raw data,
      so don't pass the 'reference_n' parameter used for summary data.")
    if(!is.null(grouping_variable_levels))  stop(
      "You have passed raw data,
      so don't pass the 'grouping_variable_levels' parameter used for summary data.")

    if (is.null(data)) {
      analysis_type <- "vector"
      if (is.null(grouping_variable_name) | grouping_variable_name == "My grouping variable") {
        grouping_variable_name <-  deparse(substitute(grouping_variable))
      }
      if (outcome_variable_name == "My outcome variable") {
        outcome_variable_name <- deparse(substitute(outcome_variable))
      }
    } else {

      # Check grouping_variable -- if it is an unquoted column name
      #  turn it into a string and store back to grouping_variable
      is_char <- try(
        is.character(grouping_variable), silent = TRUE
      )
      if (is(is_char, "try-error")) {
        # If not a character, must have been quoted
        grouping_variable_enquo <- rlang::enquo(grouping_variable)
        grouping_variable_quoname <- try(
          eval(rlang::as_name(grouping_variable_enquo)), silent = TRUE
        )
        if (!is(grouping_variable_quoname, "try-error")) {
          # This only succeeds if outcome_variable was passed unquoted
          # Reset outcome_variable to be fully quoted
          grouping_variable <- grouping_variable_quoname
        } else {
          stop("Could not parse grouping_variable")
        }
      } else {
        grouping_variable_name <- grouping_variable
      }


      is_char <- try(
        is.character(outcome_variable), silent = TRUE
      )
      if (is(is_char, "try-error")) {
        # If not a character, must have been quoted
        outcome_variable_enquo <- rlang::enquo(outcome_variable)
        outcome_variable_quoname <- try(
          eval(rlang::as_name(outcome_variable_enquo)), silent = TRUE
        )
        if (!is(outcome_variable_quoname, "try-error")) {
          # This only succeeds if outcome_variable was passed unquoted
          # Reset outcome_variable to be fully quoted
          outcome_variable <- outcome_variable_quoname
        } else {
          stop("Could not parse outcome_variable")
        }
      }

      if (length(outcome_variable) == 1) {
        analysis_type <- "data.frame"
      } else {
        analysis_type <- "jamovi"
      }

    }

  }


  contrast <- c(-1, 1)

  if (analysis_type != "summary") {

    if (is.null(case_label)) {
      case_label <- 1
    }

    if (analysis_type == "vector") {
      grouping_variable_levels <- levels(as.factor(grouping_variable))
    } else {
      grouping_variable_levels <- levels(as.factor(data[[grouping_variable]]))
    }

    if (length(grouping_variable_levels) < 2) {
      stop(
        paste(
          "Not enough levels in grouping_variable; 2 required; only",
          length(grouping_variable_levels),
          "found in the grouping_variable",
          grouping_variable_name,
          sep = " "
        )
      )
    }

    level_warning <- NULL
    if (length(grouping_variable_levels) > 2) {
      level_warning <- paste(
          "The grouping variable (",
          grouping_variable_name,
          ") had",
          length(grouping_variable_levels),
          "levels.  Only the first 2 levels were used for effect-size calculations.",
          sep = " "
        )
    }

    names(contrast) <- grouping_variable_levels[1:2]
  }


  if(analysis_type == "data.frame") {
    return(
      esci_wrap_warning(
        estimate_pdiff_ind_contrast.data.frame(
          data = data,
          outcome_variable = outcome_variable,
          grouping_variable = grouping_variable,
          case_label = case_label,
          contrast = contrast,
          conf_level = conf_level,
          count_NA = count_NA
        ),
        level_warning
      )
    )
  } else if (analysis_type == "jamovi") {
    return(
      esci_wrap_warning(
        estimate_pdiff_ind_contrast.jamovi(
          data = data,
          outcome_variables = outcome_variable,
          grouping_variable = grouping_variable,
          case_label = case_label,
          contrast = contrast,
          conf_level = conf_level,
          count_NA = count_NA
        ),
        level_warning
      )
    )

  } else if (analysis_type == "summary") {


    if (is.null(case_label) | case_label == 1) {
      case_label <- "Affected"
    }

    estimate <- estimate_pdiff_ind_contrast.summary(
        cases = c(reference_cases, comparison_cases),
        ns = c(reference_n, comparison_n),
        contrast = contrast,
        case_label = case_label,
        grouping_variable_levels = grouping_variable_levels,
        outcome_variable_name = outcome_variable_name,
        grouping_variable_name = grouping_variable_name,
        conf_level = conf_level
    )


    if (!is.null(not_case_label)) {
      old_case_label <- paste("Not", case_label, sep = " ")
      estimate$overview[
        estimate$overview$outcome_variable_level == old_case_label,
      ]$outcome_variable_level = not_case_label
      if (!is.null(estimate$properties$chi_square)) {
        rownames(estimate$properties$chi_square$observed)[[
          which(rownames(estimate$properties$chi_square$observed) == old_case_label)

        ]] <- not_case_label

        rownames(estimate$properties$chi_square$expected)[[
          which(rownames(estimate$properties$chi_square$expected) == old_case_label)

        ]] <- not_case_label


      }
    }
    return(estimate)

  } else if (analysis_type == "vector") {
    return(
      esci_wrap_warning(
        estimate_pdiff_ind_contrast.vector(
          grouping_variable = grouping_variable,
          outcome_variable = outcome_variable,
          contrast = contrast,
          case_label = case_label,
          outcome_variable_name = outcome_variable_name,
          grouping_variable_name = grouping_variable_name,
          conf_level = conf_level,
          count_NA = count_NA
        ),
        level_warning
      )
    )
  }


  stop("Something went wrong dispatching this function")

}

esci_wrap_warning <- function(estimate, level_warning = NULL) {
  estimate$warnings <- c(
    estimate$warnings,
    level_warning
  )
  return(estimate)
}
