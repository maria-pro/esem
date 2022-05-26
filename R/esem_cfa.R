#' Confirmatory factor anaysis (CFA) step for ESEM-with-CFA
#'
#' is a wrapper for lavaan::cfa() function
#'
#' @param model is a character vector with a lavaan syntax for the ESEM model.
#' @param data
#' @param mimic
#' @param std.lv
#' @param ordered
#'
#' @return
#' @export
#'
#' @examples
esem_cfa<-function(model,
         data,
         mimic =c("MPlus"),
         std.lv=TRUE,
         ordered = TRUE){

  esem_cfa_results<-lavaan::cfa(model=model,
                                data=data,
                                mimic=mimic,
                                std.lv=std.lv,
                                estimator = "WLSMV",
                                ordered=ordered)
  esem_cfa_results

}
