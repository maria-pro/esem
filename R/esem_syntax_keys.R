#' Title
#'
#' @param key_matrix
#' @param fixed
#'
#' @return
#' @export
#'
#' @examples
esem_syntax_keys<-function(key_matrix, fixed){

  syntax<-key_matrix%>%
    pivot_longer(-item, names_to="latent", values_to="value" )%>%
    mutate(is_anchor=case_when(
      value==1 ~ TRUE,
      TRUE ~ FALSE
    ),
    syntax=case_when(
      is_anchor ~ item,
      TRUE ~ paste0("start(",fixed,")*", item)
    )
    )%>%
    select(latent, syntax)

  esem_model<-syntax%>%
    group_by(latent)%>%
    mutate(syntax=paste0(latent, "=~", paste0(syntax, collapse="+\n")))%>%
    distinct(latent, .keep_all = TRUE)%>%
    ungroup()%>%
    select(-latent)

  esem_model<-paste0(esem_model$syntax, "\n", collapse="\n")

  return (esem_model)
}
