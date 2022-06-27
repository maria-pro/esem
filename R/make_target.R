#Make a target matrix to be used for target rotation in the EFA stage of ESEM
#It is a wrapper function around make.keys() function from the psych package

#' Title
#'
#' @param data is a dataset to be used in EFA
#' @param keys is a key matrix with the primary factor items. It can be made with the make.keys() function.
#' The primary factor items in the matrix are  used as referent items.
#' @return a list with target matrix
#' @export
#'
#' @examples
make_target<-function(data, keys){
  if (is.null(data)) {
    rlang::abort("bad argument", message = "Please provide the dataset")
  }
  if (is.null(keys)) {
    rlang::abort("bad argument", message = "Please provide the list of scoring keys")
  }
target <- psych::make.keys(data, keys)
target<-psych::scrub(target, isvalue=1)
target<-list(target)
}


