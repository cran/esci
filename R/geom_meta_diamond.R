draw_panel_meta_diamond_h <- function(self, data, panel_params, coord, height = NULL, lineend = "butt") {
  # This function turns each row of data
  # Into the vertices of a diamond polygon
  # The diamond has a length from LL to UL with middle points at x
  # The ends of the diamond are a y
  # The middle points are at y - height and y + height, so technically the
  #   height of the diamond is 2 * the height parameter
  # With lots of help from
  #  https://stackoverflow.com/questions/52539301/creating-geom-stat-from-scratch

  # Initialize a data frame to store the vertices
  diamond.df <- NULL

  # Cycle through the data
  for (x in 1:nrow(data)) {
    # Get the first row
    tdata <- data[x, ]

    # Pull in aesthetics
    #  Note group = x so that each row of data becomes its own polygon
    common <- data.frame(colour = tdata$colour,
                         size = tdata$size,
                         linetype = tdata$linetype,
                         fill = alpha(tdata$fill, tdata$alpha),
                         group = x,
                         stringsAsFactors = FALSE)

    # Get height and make sure it is value, otherwise default it
    height <- tdata$height
    if (height <= 0) {
      height <- (resolution(data$y, FALSE) * 0.9)
    }

    # Create the data frame: 4 rows defining the 4 vertices of the diamond
    diamond.df <- rbind(
      diamond.df,
      data.frame(
        x = c(tdata$xmin, tdata$x, tdata$xmax, tdata$x),
        y = c(tdata$y, tdata$y + height, tdata$y, tdata$y - height),
        alpha = tdata$alpha,
        common,
        stringsAsFactors = FALSE
      )
    )


  }




  # Now that all the data is assembled, draw it
  #   Apparently the draw_panel can only be called once
  #   Not sure why this is wrapped in ggname and grobTree but
  #   I suspect the ggname gives it a friendly name for that layer
  #   And perhaps grobTree organizes the various polygons into an accessible
  #    structure... not sure
  grob <- grid::grobTree(
    GeomPolygon$draw_panel(
      diamond.df,
      panel_params,
      coord
    )
  )

  grob$name <- grid::grobName(grob, "geom_meta_diamond_h")

  #
  # ggplot2:::ggname(
  #   "geom_meta_diamond_h",
  #   grid::grobTree(
  #     GeomPolygon$draw_panel(
  #       diamond.df,
  #       panel_params,
  #       coord
  #     )
  #   )
  # )

  return(grob)

}

#' Meta-analysis diamond
#'
#' `geom_meta_diamond_h` creates a horizontal meta-analytic diamond
#' defined by an `x` value (horizontal center of diamond), `xmin` and `xmax`
#' values (for the horizontal ends of the diamond), a `y` value (for the
#' vertical placement of the diamond) and a `height` (for the vertical height
#' of the diamond).  Note the use of `xmin` and `xmax` allows for representation
#' of asymmetric confidence intervals with this geom.
#'
#'
#' @inheritParams ggplot2::geom_line
#' @param ...  Other arguments passed to the geom. These are often aesthetics,
#' used to set an aesthetic to a fixed value, like `colour = "red"` or
#' `linewidth = 3` (see **Aesthetics**, below).
#'
#'
#' ##Aesthetics ##
#' `geom_meta_diamond_h` understands the following aesthetics (required are
#' in bold):
#' - **`x`** - The horizontal center of the diamond
#' - **`y`** - The vertical placement of the diamond
#' - **`xmin`** - The left-side start of the diamond
#' - **`xmax`** - The right-side start of the diamond
#' - **`height`** - The vertical span of the diamond
#'
#' @examples
#' # example code
#' library(ggplot2)
#'
#' my_effects <- data.frame(
#'   effect_size = c(1, 2, 1, 0),
#'   UL = c(2, 3, 2, 1),
#'   LL = c(0, 1, 0, -1),
#'   y = c(1, 2, 3, 4)
#' )
#'
#'
#' myplot <- ggplot2::ggplot()
#' myplot <- myplot + geom_meta_diamond_h(
#'   data = my_effects,
#'   ggplot2::aes(
#'     x = effect_size,
#'     xmin = LL,
#'     xmax = UL,
#'     y = y
#'   ),
#'   height = 0.25,
#'   color = "black",
#'   fill = "red",
#' )
#'
#'
#' @export
geom_meta_diamond_h <- function(mapping = NULL, data = NULL,
                                stat = "identity", position = "identity",
                                ...,
                                na.rm = FALSE,
                                show.legend = NA,
                                inherit.aes = TRUE) {
  ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = Geom_meta_diamond_h,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = rlang::list2(
      na.rm = na.rm,
      ...
    )
  )
}


Geom_meta_diamond_h <- ggproto("Geom_meta_diamond_h", Geom,
                               default_aes = aes(
                                 colour = "black",
                                 fill = "red",
                                 linewidth = 0.5,
                                 size = 0.5,
                                 linetype = 1,
                                 height = 0.5,
                                 alpha = NA
                               ),

                               draw_key = draw_key_path,

                               required_aes = c("x", "xmin", "xmax", "y"),

                               setup_data = function(data, params) {
                                 # If no height param passed or <= 0, set it to a default
                                 if (is.null(params$height)) {
                                   params$height <- (resolution(data$y, FALSE) * 0.9)
                                 } else {
                                   if (params$height <= 0) {
                                     params$height <- (resolution(data$y, FALSE) * 0.9)
                                   }
                                 }
                                 # If height is not an aes, set it into data
                                 if (is.null(data$height)) {
                                   data$height <- params$height
                                 }
                                 return(data)
                               },

                               draw_panel = draw_panel_meta_diamond_h,
                               rename_size = TRUE
)


test_geom_meta_diamond_h <- function() {


  effect_size <- UL <- LL <- myheight <- NULL
  species <- somevalue <- somefactor <- NULL


  summary <- data.frame(
    effect_size = c(5, 6, 6.5),
    species = as.factor(c("setosa", "versicolor", "virginica")),
    LL = c(4.5, 5, 6),
    UL = c(5.5, 7, 8),
    line = c(1, 2, 3),
    myheight = c(0.1, 0.5, 1),
    somefactor = as.factor(c("Ctl", "Ctl", "Exp")),
    somevalue = c(-1, -2, -1.5)
  )

  myplot <- ggplot2::ggplot()
  myplot <- myplot + geom_meta_diamond_h(
    data = summary,
    ggplot2::aes(
      x = effect_size,
      xmax = UL,
      xmin = LL,
      y = line,
      height = myheight,
      fill = species,
      alpha = myheight,
      size = somevalue,
      colour = somefactor,
      linetype = somefactor
    )
  )

  return(myplot)

}
