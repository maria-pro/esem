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
