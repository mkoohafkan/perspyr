#' @name attach
#'
#' Attach Python objects to R.
#'
NULL

#' @describeIn attach Import Python objects into R.
#'
#' @param import Names of the Python objects to import.
#' @param from (Optional) the name of the module.
#' @param as (Optional) An alias for the module name.
#' @param env (Optional) environment to assign the Python objects to.
#'
pyImport = function(name, from = NULL, as = NULL, attach = parent.frame()) {
  if (all(is.null(c(from, as))))
    py()$exec(sprintf("import %s", name))
  else if (!any(is.null(c(from, as))))
    py()$exec(sprintf("from %s import %s as %s", from, name, as))
  else if(is.null(from))
    py()$exec(sprintf("import %s as %s", name, as))
  else if (is.null(as))
    py()$exec(sprintf("from %s import %s", from))
  else if (all(is.null(c(name, as))))
    py()$exec(sprintf("from %s import *", from))

  if (is.null(attach))
    return(invisible(NULL))

  stop("not implemented!")
  # inspect name
  # import with pyAttach
}

#' @describeIn attach import a Python function into R.
#'
#' @param key The Python function name.
#'
pyFunction = function(key) {
  # get Python function specs
  py$exec(
    "import inspect",
    sprintf("_ = inspect.getargspec(%s)", key)
  )
  # parse arguments and defaults
  args = py$get("_.args")
  arg.defaults = lapply(py$get("_.defaults"), deparse)
  required.args = head(args, -length(arg.defaults))
  optional.args = tail(args, length(arg.defaults))
  # format arguments
  arglist = paste(args, collapse = ", ")
  fun.args = paste(
    c(required.args, sprintf("%s = %s", optional.args, arg.defaults)),
    collapse = ", ")
  json.args = sprintf("rjson::toJSON(list(%s))",
    paste(sprintf("%s = %s", args, args), collapse = ", "))
  # format function
  fun.string = paste(
    sprintf('function(%s) {', fun.args),
    sprintf('  py()$exec(sprintf("_ = %s(**%s)", %s))', key, "%s", json.args),
    '  py()$get("_")',
    '}',
    sep = '\n')
  # return the R function interface
  eval(parse(text = fun.string))
}


#' @describeIn attach
#'
#' @param what Vector of names of Python objects to attach to R.
pyAttach = function(what, env = parent.frame()){
  stop("Not implemented!")

  # inspect
  # attach
}