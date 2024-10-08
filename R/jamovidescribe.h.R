
# This file is automatically generated, you probably don't want to edit this

jamovidescribeOptions <- if (requireNamespace("jmvcore", quietly=TRUE)) R6::R6Class(
    "jamovidescribeOptions",
    inherit = jmvcore::Options,
    public = list(
        initialize = function(
            outcome_variable = NULL,
            show_details = FALSE,
            mark_mean = FALSE,
            mark_median = FALSE,
            mark_sd = FALSE,
            mark_quartiles = FALSE,
            mark_z_lines = FALSE,
            mark_percentile = "0",
            histogram_bins = "12",
            es_plot_width = "500",
            es_plot_height = "400",
            ymin = "auto",
            ymax = "auto",
            breaks = "auto",
            xmin = "auto",
            xmax = "auto",
            xbreaks = "auto",
            ylab = "auto",
            xlab = "auto",
            axis.text.y = "14",
            axis.title.y = "15",
            axis.text.x = "14",
            axis.title.x = "15",
            fill_regular = "#008DF9",
            fill_highlighted = "#E20134",
            color = "black", ...) {

            super$initialize(
                package="esci",
                name="jamovidescribe",
                requiresData=TRUE,
                ...)

            private$..outcome_variable <- jmvcore::OptionVariable$new(
                "outcome_variable",
                outcome_variable,
                suggested=list(
                    "continuous"),
                permitted=list(
                    "numeric"))
            private$..show_details <- jmvcore::OptionBool$new(
                "show_details",
                show_details,
                default=FALSE)
            private$..mark_mean <- jmvcore::OptionBool$new(
                "mark_mean",
                mark_mean,
                default=FALSE)
            private$..mark_median <- jmvcore::OptionBool$new(
                "mark_median",
                mark_median,
                default=FALSE)
            private$..mark_sd <- jmvcore::OptionBool$new(
                "mark_sd",
                mark_sd,
                default=FALSE)
            private$..mark_quartiles <- jmvcore::OptionBool$new(
                "mark_quartiles",
                mark_quartiles,
                default=FALSE)
            private$..mark_z_lines <- jmvcore::OptionBool$new(
                "mark_z_lines",
                mark_z_lines,
                default=FALSE)
            private$..mark_percentile <- jmvcore::OptionString$new(
                "mark_percentile",
                mark_percentile,
                default="0")
            private$..histogram_bins <- jmvcore::OptionString$new(
                "histogram_bins",
                histogram_bins,
                default="12")
            private$..es_plot_width <- jmvcore::OptionString$new(
                "es_plot_width",
                es_plot_width,
                default="500")
            private$..es_plot_height <- jmvcore::OptionString$new(
                "es_plot_height",
                es_plot_height,
                default="400")
            private$..ymin <- jmvcore::OptionString$new(
                "ymin",
                ymin,
                default="auto")
            private$..ymax <- jmvcore::OptionString$new(
                "ymax",
                ymax,
                default="auto")
            private$..breaks <- jmvcore::OptionString$new(
                "breaks",
                breaks,
                default="auto")
            private$..xmin <- jmvcore::OptionString$new(
                "xmin",
                xmin,
                default="auto")
            private$..xmax <- jmvcore::OptionString$new(
                "xmax",
                xmax,
                default="auto")
            private$..xbreaks <- jmvcore::OptionString$new(
                "xbreaks",
                xbreaks,
                default="auto")
            private$..ylab <- jmvcore::OptionString$new(
                "ylab",
                ylab,
                default="auto")
            private$..xlab <- jmvcore::OptionString$new(
                "xlab",
                xlab,
                default="auto")
            private$..axis.text.y <- jmvcore::OptionString$new(
                "axis.text.y",
                axis.text.y,
                default="14")
            private$..axis.title.y <- jmvcore::OptionString$new(
                "axis.title.y",
                axis.title.y,
                default="15")
            private$..axis.text.x <- jmvcore::OptionString$new(
                "axis.text.x",
                axis.text.x,
                default="14")
            private$..axis.title.x <- jmvcore::OptionString$new(
                "axis.title.x",
                axis.title.x,
                default="15")
            private$..fill_regular <- jmvcore::OptionList$new(
                "fill_regular",
                fill_regular,
                default="#008DF9",
                options=list(
                    "black",
                    "#00C2F9",
                    "#008DF9",
                    "#009F81",
                    "#FF5AAF",
                    "#9F0162",
                    "#A40122",
                    "#00FCCF",
                    "#FF6E3A",
                    "#FFB2FD",
                    "#8400CD",
                    "#E20134",
                    "#FFC33B",
                    "white",
                    "NA",
                    "NA",
                    "gray0",
                    "gray5",
                    "gray10",
                    "gray15",
                    "gray20",
                    "gray25",
                    "gray30",
                    "gray35",
                    "gray40",
                    "gray45",
                    "gray50",
                    "gray55",
                    "gray60",
                    "gray65",
                    "gray70",
                    "gray75",
                    "gray80",
                    "gray85",
                    "gray90",
                    "gray95",
                    "gray100"))
            private$..fill_highlighted <- jmvcore::OptionList$new(
                "fill_highlighted",
                fill_highlighted,
                default="#E20134",
                options=list(
                    "black",
                    "#00C2F9",
                    "#008DF9",
                    "#009F81",
                    "#FF5AAF",
                    "#9F0162",
                    "#A40122",
                    "#00FCCF",
                    "#FF6E3A",
                    "#FFB2FD",
                    "#8400CD",
                    "#E20134",
                    "#FFC33B",
                    "white",
                    "NA",
                    "NA",
                    "gray0",
                    "gray5",
                    "gray10",
                    "gray15",
                    "gray20",
                    "gray25",
                    "gray30",
                    "gray35",
                    "gray40",
                    "gray45",
                    "gray50",
                    "gray55",
                    "gray60",
                    "gray65",
                    "gray70",
                    "gray75",
                    "gray80",
                    "gray85",
                    "gray90",
                    "gray95",
                    "gray100"))
            private$..color <- jmvcore::OptionList$new(
                "color",
                color,
                default="black",
                options=list(
                    "black",
                    "#00C2F9",
                    "#008DF9",
                    "#009F81",
                    "#FF5AAF",
                    "#9F0162",
                    "#A40122",
                    "#00FCCF",
                    "#FF6E3A",
                    "#FFB2FD",
                    "#8400CD",
                    "#E20134",
                    "#FFC33B",
                    "white",
                    "NA",
                    "NA",
                    "gray0",
                    "gray5",
                    "gray10",
                    "gray15",
                    "gray20",
                    "gray25",
                    "gray30",
                    "gray35",
                    "gray40",
                    "gray45",
                    "gray50",
                    "gray55",
                    "gray60",
                    "gray65",
                    "gray70",
                    "gray75",
                    "gray80",
                    "gray85",
                    "gray90",
                    "gray95",
                    "gray100"))

            self$.addOption(private$..outcome_variable)
            self$.addOption(private$..show_details)
            self$.addOption(private$..mark_mean)
            self$.addOption(private$..mark_median)
            self$.addOption(private$..mark_sd)
            self$.addOption(private$..mark_quartiles)
            self$.addOption(private$..mark_z_lines)
            self$.addOption(private$..mark_percentile)
            self$.addOption(private$..histogram_bins)
            self$.addOption(private$..es_plot_width)
            self$.addOption(private$..es_plot_height)
            self$.addOption(private$..ymin)
            self$.addOption(private$..ymax)
            self$.addOption(private$..breaks)
            self$.addOption(private$..xmin)
            self$.addOption(private$..xmax)
            self$.addOption(private$..xbreaks)
            self$.addOption(private$..ylab)
            self$.addOption(private$..xlab)
            self$.addOption(private$..axis.text.y)
            self$.addOption(private$..axis.title.y)
            self$.addOption(private$..axis.text.x)
            self$.addOption(private$..axis.title.x)
            self$.addOption(private$..fill_regular)
            self$.addOption(private$..fill_highlighted)
            self$.addOption(private$..color)
        }),
    active = list(
        outcome_variable = function() private$..outcome_variable$value,
        show_details = function() private$..show_details$value,
        mark_mean = function() private$..mark_mean$value,
        mark_median = function() private$..mark_median$value,
        mark_sd = function() private$..mark_sd$value,
        mark_quartiles = function() private$..mark_quartiles$value,
        mark_z_lines = function() private$..mark_z_lines$value,
        mark_percentile = function() private$..mark_percentile$value,
        histogram_bins = function() private$..histogram_bins$value,
        es_plot_width = function() private$..es_plot_width$value,
        es_plot_height = function() private$..es_plot_height$value,
        ymin = function() private$..ymin$value,
        ymax = function() private$..ymax$value,
        breaks = function() private$..breaks$value,
        xmin = function() private$..xmin$value,
        xmax = function() private$..xmax$value,
        xbreaks = function() private$..xbreaks$value,
        ylab = function() private$..ylab$value,
        xlab = function() private$..xlab$value,
        axis.text.y = function() private$..axis.text.y$value,
        axis.title.y = function() private$..axis.title.y$value,
        axis.text.x = function() private$..axis.text.x$value,
        axis.title.x = function() private$..axis.title.x$value,
        fill_regular = function() private$..fill_regular$value,
        fill_highlighted = function() private$..fill_highlighted$value,
        color = function() private$..color$value),
    private = list(
        ..outcome_variable = NA,
        ..show_details = NA,
        ..mark_mean = NA,
        ..mark_median = NA,
        ..mark_sd = NA,
        ..mark_quartiles = NA,
        ..mark_z_lines = NA,
        ..mark_percentile = NA,
        ..histogram_bins = NA,
        ..es_plot_width = NA,
        ..es_plot_height = NA,
        ..ymin = NA,
        ..ymax = NA,
        ..breaks = NA,
        ..xmin = NA,
        ..xmax = NA,
        ..xbreaks = NA,
        ..ylab = NA,
        ..xlab = NA,
        ..axis.text.y = NA,
        ..axis.title.y = NA,
        ..axis.text.x = NA,
        ..axis.title.x = NA,
        ..fill_regular = NA,
        ..fill_highlighted = NA,
        ..color = NA)
)

jamovidescribeResults <- if (requireNamespace("jmvcore", quietly=TRUE)) R6::R6Class(
    "jamovidescribeResults",
    inherit = jmvcore::Group,
    active = list(
        debug = function() private$.items[["debug"]],
        help = function() private$.items[["help"]],
        overview = function() private$.items[["overview"]],
        describe_plot_warnings = function() private$.items[["describe_plot_warnings"]],
        describe_plot = function() private$.items[["describe_plot"]],
        describe_dotplot = function() private$.items[["describe_dotplot"]]),
    private = list(),
    public=list(
        initialize=function(options) {
            super$initialize(
                options=options,
                name="",
                title="Describe")
            self$add(jmvcore::Preformatted$new(
                options=options,
                name="debug",
                visible=FALSE))
            self$add(jmvcore::Html$new(
                options=options,
                name="help",
                visible=FALSE))
            self$add(jmvcore::Table$new(
                options=options,
                name="overview",
                title="Overview",
                rows="(outcome_variable)",
                clearWith=list(
                    "outcome_variable",
                    "show_details"),
                columns=list(
                    list(
                        `name`="outcome_variable_name", 
                        `title`="Outcome variable", 
                        `type`="text", 
                        `combineBelow`=TRUE),
                    list(
                        `name`="mean", 
                        `type`="number", 
                        `title`="<i>M</i>"),
                    list(
                        `name`="mean_LL", 
                        `title`="LL", 
                        `type`="number", 
                        `visible`="(show_details)"),
                    list(
                        `name`="mean_UL", 
                        `title`="UL", 
                        `type`="number", 
                        `visible`="(show_details)"),
                    list(
                        `name`="moe", 
                        `type`="number", 
                        `title`="<i>MoE</i>", 
                        `visible`="(show_details)"),
                    list(
                        `name`="mean_SE", 
                        `title`="<i>SE</i><sub>Mean</sub>", 
                        `type`="number", 
                        `visible`="(show_details)"),
                    list(
                        `name`="median", 
                        `title`="<i>Mdn</i>", 
                        `type`="number"),
                    list(
                        `name`="median_LL", 
                        `title`="LL", 
                        `type`="number", 
                        `visible`="(show_details)"),
                    list(
                        `name`="median_UL", 
                        `title`="UL", 
                        `type`="number", 
                        `visible`="(show_details)"),
                    list(
                        `name`="sd", 
                        `type`="number", 
                        `title`="<i>s</i>"),
                    list(
                        `name`="min", 
                        `title`="Minimum", 
                        `type`="number"),
                    list(
                        `name`="max", 
                        `title`="Maximum", 
                        `type`="number"),
                    list(
                        `name`="q1", 
                        `title`="25th", 
                        `type`="number", 
                        `superTitle`="Percentile"),
                    list(
                        `name`="q3", 
                        `title`="75th", 
                        `type`="number", 
                        `superTitle`="Percentile"),
                    list(
                        `name`="n", 
                        `title`="<i>N</i>", 
                        `type`="integer"),
                    list(
                        `name`="missing", 
                        `type`="integer", 
                        `title`="Missing"),
                    list(
                        `name`="df", 
                        `title`="<i>df</i>", 
                        `type`="integer", 
                        `visible`="(show_details)"))))
            self$add(jmvcore::Html$new(
                options=options,
                name="describe_plot_warnings",
                title="Figure Warnings",
                visible=TRUE))
            self$add(jmvcore::Image$new(
                options=options,
                name="describe_plot",
                title="Histogram",
                requiresData=TRUE,
                width=400,
                height=300,
                renderFun=".describe_plot"))
            self$add(jmvcore::Image$new(
                options=options,
                name="describe_dotplot",
                title="Dotplot",
                requiresData=TRUE,
                width=400,
                height=300,
                renderFun=".describe_plot"))}))

jamovidescribeBase <- if (requireNamespace("jmvcore", quietly=TRUE)) R6::R6Class(
    "jamovidescribeBase",
    inherit = jmvcore::Analysis,
    public = list(
        initialize = function(options, data=NULL, datasetId="", analysisId="", revision=0) {
            super$initialize(
                package = "esci",
                name = "jamovidescribe",
                version = c(1,0,0),
                options = options,
                results = jamovidescribeResults$new(options=options),
                data = data,
                datasetId = datasetId,
                analysisId = analysisId,
                revision = revision,
                pause = NULL,
                completeWhenFilled = FALSE,
                requiresMissings = FALSE,
                weightsSupport = 'auto')
        }))

#' Describe
#'
#' 
#' @param data .
#' @param outcome_variable .
#' @param show_details .
#' @param mark_mean .
#' @param mark_median .
#' @param mark_sd .
#' @param mark_quartiles .
#' @param mark_z_lines .
#' @param mark_percentile .
#' @param histogram_bins .
#' @param es_plot_width .
#' @param es_plot_height .
#' @param ymin .
#' @param ymax .
#' @param breaks .
#' @param xmin .
#' @param xmax .
#' @param xbreaks .
#' @param ylab .
#' @param xlab .
#' @param axis.text.y .
#' @param axis.title.y .
#' @param axis.text.x .
#' @param axis.title.x .
#' @param fill_regular .
#' @param fill_highlighted .
#' @param color .
#' @return A results object containing:
#' \tabular{llllll}{
#'   \code{results$debug} \tab \tab \tab \tab \tab a preformatted \cr
#'   \code{results$help} \tab \tab \tab \tab \tab a html \cr
#'   \code{results$overview} \tab \tab \tab \tab \tab a table \cr
#'   \code{results$describe_plot_warnings} \tab \tab \tab \tab \tab a html \cr
#'   \code{results$describe_plot} \tab \tab \tab \tab \tab an image \cr
#'   \code{results$describe_dotplot} \tab \tab \tab \tab \tab an image \cr
#' }
#'
#' Tables can be converted to data frames with \code{asDF} or \code{\link{as.data.frame}}. For example:
#'
#' \code{results$overview$asDF}
#'
#' \code{as.data.frame(results$overview)}
#'
#' @export
jamovidescribe <- function(
    data,
    outcome_variable,
    show_details = FALSE,
    mark_mean = FALSE,
    mark_median = FALSE,
    mark_sd = FALSE,
    mark_quartiles = FALSE,
    mark_z_lines = FALSE,
    mark_percentile = "0",
    histogram_bins = "12",
    es_plot_width = "500",
    es_plot_height = "400",
    ymin = "auto",
    ymax = "auto",
    breaks = "auto",
    xmin = "auto",
    xmax = "auto",
    xbreaks = "auto",
    ylab = "auto",
    xlab = "auto",
    axis.text.y = "14",
    axis.title.y = "15",
    axis.text.x = "14",
    axis.title.x = "15",
    fill_regular = "#008DF9",
    fill_highlighted = "#E20134",
    color = "black") {

    if ( ! requireNamespace("jmvcore", quietly=TRUE))
        stop("jamovidescribe requires jmvcore to be installed (restart may be required)")

    if ( ! missing(outcome_variable)) outcome_variable <- jmvcore::resolveQuo(jmvcore::enquo(outcome_variable))
    if (missing(data))
        data <- jmvcore::marshalData(
            parent.frame(),
            `if`( ! missing(outcome_variable), outcome_variable, NULL))


    options <- jamovidescribeOptions$new(
        outcome_variable = outcome_variable,
        show_details = show_details,
        mark_mean = mark_mean,
        mark_median = mark_median,
        mark_sd = mark_sd,
        mark_quartiles = mark_quartiles,
        mark_z_lines = mark_z_lines,
        mark_percentile = mark_percentile,
        histogram_bins = histogram_bins,
        es_plot_width = es_plot_width,
        es_plot_height = es_plot_height,
        ymin = ymin,
        ymax = ymax,
        breaks = breaks,
        xmin = xmin,
        xmax = xmax,
        xbreaks = xbreaks,
        ylab = ylab,
        xlab = xlab,
        axis.text.y = axis.text.y,
        axis.title.y = axis.title.y,
        axis.text.x = axis.text.x,
        axis.title.x = axis.title.x,
        fill_regular = fill_regular,
        fill_highlighted = fill_highlighted,
        color = color)

    analysis <- jamovidescribeClass$new(
        options = options,
        data = data)

    analysis$run()

    analysis$results
}

