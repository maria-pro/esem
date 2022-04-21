#' Plot the ESEM model
#'
#' This is a wrapper function for lavaanPlot() from lavaanPlot() package.
#' For more information see https://cran.r-project.org/web/packages/lavaanPlot/index.html
#'
#' @param name A string of the name of the plot.
#' @param labels An optional named list of variable labels.
#' @param ... Additional parameters as in lavaanPlot()
#'
#' @return A DiagrammeR plot of the path diagram for model
#' @export
#'
#' @examples
#' library(lavaan)
#' model <- 'mpg ~ cyl + disp + hp
#'           qsec ~ disp + hp + wt'
#' fit <- sem(model, data = mtcars)
#' lavaanPlot(model = fit, node_options = list(shape = "box", fontname = "Helvetica"),
#'           edge_options = list(color = "grey"), coefs = FALSE)
lavaanPlot<-function(name = "plot", labels = NULL, ...){
  lavaanPlot::lavaanPlot(...)
}
