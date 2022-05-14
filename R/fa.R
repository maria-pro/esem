#' Title
#'
#' @param data
#' @param nfactors
#' @param rotate
#' @param scores
#' @param residuals
#' @param missing
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
fa<-function(data, nfactors=2, rotate="geominT", scores="regression", residuals=TRUE, missing=TRUE,...){
  results<-psych::fa(data, nfactors, rotate, scores, residuals, missing)
  #rotation does not work - need to check source for FA
  return (results)
}
