#' esem
#' completes esem estimation using the provided parameters
#' @param awesome is the parameter to control
#' @param beautiful is the parameter to control
#'
#' @return prints the string
#' @export
#'
#' @examples esem("awesome", "beautiful")
esem <- function(awesome, beautiful) {
  psych::bfi
  paste0("The ", awesome, " goes ", beautiful, "!")
}
