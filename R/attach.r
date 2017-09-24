#' Attach Python objects to R.
#' @name py_attach
#'
NULL

#' @describeIn py_attach Import Python module into R.
#'
#' @param name Name of the Python objemodule to import.
#' @param env (Optional) environment to assign the Python objects to.
#'
pyImport = function(name, env = parent.frame()) {
  py()$exec(sprintf("import %s", name))
  if (is.null(env))
    return(invisible(NULL))

  py()$exec("import inspect as INSPECT")
  py()$exec(
    sprintf("_ = [X for (X,Y) in INSPECT.getmembers(%s, INSPECT.isfunction)]",
      name)
  )
  funs = pyGet("_")
  fun.list = vector("list", length(funs))
  names(fun.list) = funs
  for (n in funs) {
    fun.list[[n]] = tryCatch(pyFunction(paste(name, n, sep = ".")),
      error = function(e) NULL)
  }
  err.funs = which(!(funs %in% names(fun.list)))
  if (length(err.funs) > 0L)
    warning("The following functions could not be imported: ",
            paste(funs[err.funs], collapse = ", "))
  for(n in names(fun.list))
    assign(n, fun.list[[n]], pos = env)
  invisible(NULL)
}


#' @describeIn py_attach import a Python function into R.
#'
#' @param key The Python function name.
#' @param finalizer An additional operation to perform on the
#'   function output prior to returning to R. Use the character
#'   "_" as a placeholder for the Python output variable.
#'
#' @importFrom utils head tail
#' @export
pyFunction = function(key, finalizer = "_") {
  # get Python function specs
  py()$exec(
    "import inspect as INSPECT",
    sprintf("_ = INSPECT.getargspec(%s)", key)
  )
  # parse arguments and defaults
  args = py()$get("_.args")
  arg.defaults = lapply(py()$get("_.defaults"), deparse)
  required.args = head(args, -length(arg.defaults))
  optional.args = tail(args, length(arg.defaults))
  # format arguments
  arglist = paste(args, collapse = ", ")
  fun.args = paste(
    c(required.args, sprintf("%s = %s", optional.args, arg.defaults)),
    collapse = ", ")
  json.args = sprintf("list(%s)",
    paste(sprintf("%s = %s", args, args), collapse = ", "))
  # build function from template
  fun.string = fun_template(fun.args, json.args, key, finalizer)
  # return the R function interface
  eval(parse(text = fun.string))
}
