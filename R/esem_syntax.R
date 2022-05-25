#' Create a model syntax for ESEM-with-CFA
#'
#' @param esem_efa_results is a \cite{psych::fa()} object with the results of exploratory factor analysis (EFA)
#' The object can be created using psych::fa() or a wrapper esem_efa() function
#'
#' @param referent_list is a list with latent variables (factors) and their corresponding referent items.
#' referent_list can be generated using create_referent() function.
#' If no referent_list is provided, the list is generated automatically
#'
#' @return A character vector with a lavaan syntax for the ESEM model.

#' @export
#'
#' @examples

#' use Holzinger and Swineford (1939) dataset in lavaan package
#' hw_data <- lavaan::HolzingerSwineford1939
#' hw_data <- hw_data[,c(7:15)]
#'
#' esem_efa_results <- esem_efa(hw_data,3)
#' model_syntax <- esem_syntax(esem_efa_results)
#' writeLines(model_syntax)
esem_syntax<-function(esem_efa_results, referent_list=NULL){

    if (!is(esem_efa_results, "fa")) {
    # msg <- "Please the object created using psych::fa() function."
    rlang::abort("bad argument", message = "Please the object created using esem_efa() or psych::fa() function.")
    }


  loadings<-esem_efa_results$loadings
  loadings<- data.frame(matrix(as.numeric(loadings), attributes(loadings)$dim, dimnames=attributes(loadings)$dimnames))%>%
    tibble::rownames_to_column(var = "item")

 # names(esem_loadings) <- paste0("F", as.character(seq(1, esem_efa$factors, by=1)))

  esem_loadings<-loadings%>%
    tidyr::pivot_longer(!item, names_to="latent", values_to="value")%>%
    dplyr::arrange(by=latent)


  syntax<-esem_loadings%>%
    dplyr::group_by(latent)%>%
    dplyr::mutate(max_per_factor = `item`[value == max(value)],
           is_anchor=dplyr::case_when(
             max_per_factor==item ~ TRUE,
             TRUE ~ FALSE
           )
    )%>%dplyr::ungroup()%>%
    dplyr::group_by(item)%>%
    dplyr::mutate(
      is_anchor_total=sum(is_anchor),
      syntax=dplyr::case_when(
        is_anchor_total!=0 ~ paste0(value,"*", item),
        TRUE ~ paste0("start(",value,")*", item)
      )
    )%>%
    dplyr::select(item, latent, syntax)

  esem_model<-syntax%>%
    dplyr::group_by(latent)%>%
    dplyr::mutate(syntax=paste0(latent, "=~", paste0(syntax, collapse="+\n")))%>%
    dplyr::distinct(latent, .keep_all = TRUE)%>%
    dplyr::ungroup()%>%
    dplyr::select(-latent)

  esem_model<-paste0(esem_model$syntax, "\n", collapse="\n")
  return (esem_model)
}
