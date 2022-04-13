#' esem
#' completes esem estimation using the provided parameters
#' @param animal is the parameter to control
#' @param sound is the parameter to control
#'
#' @return prints the string
#' @export
#'
#' @examples esem(awesome, beautiful)
esem <- function(animal, sound) {
  psych::bfi
  paste0("The ", animal, " goes ", sound, "!")
}
