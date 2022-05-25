#' Create a referent list
#'
#' @param esem_efa is a \cite{psych::fa()} object with the results of exploratory factor analysis (EFA)
#' The object can be created using psych::fa() or a wrapper esem_efa() function
#' The function uses efa object to identify referents

#' A referent indicator is selected for each factor
#' It is the item that has a large (target) loading for the factor it measures and
#small (non-target) cross-loadings.

#' The referents are used to ensure model identification and are used as starting values/ fixed values in the
#' the next step to create a lavaan model syntax.
#
#' @return A list with factors and corresponding referents (i.e. referents in that factor)
#' @export
#'
#' @examples
#'
#' # use Holzinger and Swineford (1939) dataset in lavaan package
#' hw_data <- lavaan::HolzingerSwineford1939
#' hw_data <- hw_data[,c(7:15)]
#'
#' #make exploratory analysis with geomin rotation
#' esem_efa_results <- esem_efa(hw_data,3)
#' referent_list <- create_referent(esem_efa_results)
create_referent<-function(esem_efa_results){

    if (!is(esem_efa_results, "fa")) {
    # msg <- "Please the object created using psych::fa() function."
    rlang::abort("bad argument", message = "Please the object created using psych::fa() function.")
  }

  loadings<-esem_efa_results$loadings
  loadings<- data.frame(matrix(as.numeric(loadings), attributes(loadings)$dim, dimnames=attributes(loadings)$dimnames))%>%
    tibble::rownames_to_column(var = "item")

  #names(test) <- paste0("F", as.character(seq(1, ncol(test), by=1)))

  loadings<-loadings%>%
    tidyr::pivot_longer(!item, names_to="latent", values_to="value")%>%
    dplyr::arrange(by=latent)

  referent_list<-loadings%>%
    dplyr::group_by(latent)%>%
    dplyr::mutate(max_per_factor = `item`[value == max(value)],
           is_anchor=dplyr::case_when(
             max_per_factor==item ~ TRUE,
             TRUE ~ FALSE
           )
    )%>%dplyr::ungroup()%>%
    dplyr::filter(is_anchor)%>%
    dplyr::select(item, latent)

  referent_list<-as.list(referent_list)
  referent_list
}
