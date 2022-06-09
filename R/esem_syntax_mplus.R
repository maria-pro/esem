#' Create a model syntax for ESEM-with-CFA compatible with MPlus
#'
#'
#' @param key_matrix is a key matrix with the primary factor items. It can be made with the make.keys() function.
#' The primary factor items in the matrix are  used as referent items.
#'
#' @return A character vector with a lavaan syntax for the ESEM model that imitates MPlus.
#' @export
#'
#' use Holzinger and Swineford (1939) dataset in lavaan package
#' hw_data <- lavaan::HolzingerSwineford1939
#' hw_data <- hw_data[,c(7:15)]
#'
#' esem_efa_results <- esem_efa(hw_data,3)
#' model_syntax <- esem_syntax_mplus(esem_efa_results)
#' writeLines(model_syntax)
#'
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
    dplyr::mutate(across(everything(), replace_last_0))%>%
    tidyr::pivot_longer(-item, names_to="latent", values_to="value" )%>%
    dplyr::mutate(
      syntax=paste0(value, "*", item)
    )%>%
    dplyr::group_by(latent)%>%
    dplyr::mutate(syntax=paste0(latent, "=~", paste0(syntax, collapse="+\n")))%>%
    dplyr::distinct(latent, .keep_all = TRUE)%>%
    dplyr::ungroup()%>%
    dplyr::select(-latent)


  esem_model<-paste0(esem_model$syntax, "\n", collapse="\n")

  esem_model


}