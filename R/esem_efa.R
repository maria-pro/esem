#is a wrapper function for psych::fa()
esem_efa<-function(data, nfactors, fm = 'ML',
                   rotate="geominT",
                   scores="regression",
                   residuals=TRUE,
                   missing=TRUE){
  esem_efa_results<-psych::fa(data, nfactors =nfactors,
                              fm = fm,
                              rotate=rotate,
                              scores=scores,
                              residuals=residuals,
                              missing=missing)
  esem_efa_results
}
