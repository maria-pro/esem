#' Title
#'
#' @param esem_efa
#'
#' @return
#' @export
#'
#' @examples
#'
esem_cfa_syntax<-function(loadings){
#loadings = tibble/matrix with items as rows and factors as columns, their values= item loadings on a factor

  esem_loadings<-loadings%>%
    pivot_longer(!item, names_to="latent", values_to="value")%>%
    arrange(by=latent)


  syntax<-esem_loadings%>%
    group_by(latent)%>%
    mutate(max_per_factor = `item`[value == max(value)],
           is_anchor=case_when(
             max_per_factor==item ~ TRUE,
             TRUE ~ FALSE
           )
    )%>%ungroup()%>%
    group_by(item)%>%
    mutate(
      is_anchor_total=sum(is_anchor),
      syntax=case_when(
        is_anchor_total!=0 ~ paste0(value,"*", item),
        TRUE ~ paste0("start(",value,")*", item)
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
