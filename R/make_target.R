#Make a target matrix to be used for target rotation in the EFA stage of ESEM
#It is a wrapper function around make.keys() function from the psych package

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


