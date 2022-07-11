#' Exploratory Structural Equiation Modeling ESEM (ESEM)
#'
#' @param data
#' @param nfactors
#' @param fm
#' @param rotate
#' @param scores
#' @param residuals
#' @param Target
#' @param missing
#' @param mimic
#' @param std.lv
#' @param ordered
#'
#' @return
#' @export
#'
#' @examples
esem_cfa2<-function(
  data, nfactors, fm = 'ML',
  rotate="geominT",
  scores="regression",
  residuals=TRUE,
  Target=NULL,
  missing=TRUE,
  mimic =c("MPlus"),
  std.lv=TRUE,
  ordered = TRUE)

  {
    #EFA stage

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

    #model preparation for CFA

    esem_loadings <- as_tibble(matrix(round(esem_efa_results$loadings, esem_efa_results$factors),
                                      nrow = length(esem_efa_results$complexity), ncol = esem_efa_results$factors),
                               name_repair="minimal")

    names(esem_loadings) <- paste0("F", as.character(seq(1, esem_efa_results$factors, by=1)))

    esem_loadings$item<-names(esem_efa_results$complexity)

    esem_loadings<-esem_loadings%>%
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

    #CFA stage
  esem_cfa_results<-lavaan::cfa(model=esem_model,
                                data=data,
                                mimic=mimic,
                                std.lv=std.lv,
                                estimator = "WLSMV",
                                ordered=ordered)
  esem_cfa_results
}
