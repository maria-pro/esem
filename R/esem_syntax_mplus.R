#' Create a model syntax for ESEM-with-CFA compatible with MPlus
#'
#'
#' @param key_matrix is a key matrix with the primary factor items. It can be made with the make.keys() function.
#' The primary factor items in the matrix are  used as referent items.
#'
#' @return A character vector with a lavaan syntax for the ESEM model that imitates MPlus.
#' @export
esem_syntax_mplus<-function(key_matrix=NULL){


  replace_last_0 <- function(x) {
    x[tail(which(x == 0), 1)] <- "NA"
    x
  }


  if (is.null(key_matrix)) {
    rlang::abort("bad argument", message = "Please provide the key_matrix.")
  }

  loadings<- data.frame(matrix(as.numeric(key_matrix), attributes(key_matrix)$dim, dimnames=attributes(key_matrix)$dimnames))%>%
    tibble::rownames_to_column(var = "item")

  esem_model<-loadings%>%
# dplyr::mutate(across(everything(), replace_last_0))%>%
    tidyr::pivot_longer(-item, names_to="latent", values_to="value" )%>%
    dplyr::mutate(
#      syntax=paste0(value, "*", item)
#   )
# (
#    is_anchor_total=sum(is_anchor),
    syntax=dplyr::case_when(
      value=="NA" ~ paste0(value,"*", item),
      value==1 ~ item,
      TRUE ~ paste0("start(0)*", item)
    )
  )%>%
    dplyr::group_by(latent)%>%
    dplyr::mutate(syntax=paste0(latent, "=~", paste0(syntax, collapse="+\n")))%>%
    dplyr::distinct(latent, .keep_all = TRUE)%>%
    dplyr::mutate(syntax_variance=paste0(latent, " ~~ 1*",latent, collapse="\n"))%>%
    dplyr::ungroup()%>%
    dplyr::select(-latent)


  esem_model<-paste0(esem_model$syntax, "\n",
                 esem_model$syntax_variance, "\n",
                     collapse="\n")


}
