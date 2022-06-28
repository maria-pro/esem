#' Exploratory factor analysis (EFA) for ESEM
#is a wrapper function for psych::fa()
#' @param data
#' @param nfactors
#' @param rotate
#' @param scores
#' @param Target
#' @param residuals
#' @param missing
#' @param ...
#'
#' @return
#' @export
#'
#' @examples

esem_efa<-function(data, nfactors, fm = 'ML',
                   rotate="geominT",
                   scores="regression",
                   residuals=TRUE,
                   Target=NULL,
                   missing=TRUE){

  if(is.null(Target)) {esem_efa_results<-psych::fa(data, nfactors =nfactors,
                               fm = fm,
                               rotate=rotate,
                               scores=scores,
                               residuals=residuals,
                               missing=missing)}
  else {esem_efa_results<-psych::fa(data, nfactors =nfactors,
                              fm = fm,
                              rotate=rotate,
                              scores=scores,
                              Target=Target,
                              residuals=residuals,
                              missing=missing)
  }
  esem_efa_results
}
