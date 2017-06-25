#' @name variables
#'
#' Interact with Python variables.
NULL

#' @describeIn variables Print a Python object to the R console.
#'
#' @param objName The Python object to print.
#'
#' @return A character string.
#'
#' @details This is basically the same as `pyExecp` but prints to the
#' console using `print` instead of `cat`.
#'
#' @export
pyPrint = function(objName) {
  print(py()$exec(sprintf("print(%s)", code)))
}

#' @describeIn variables Retrieve variables from Python. Only applicable
#'   to objects that can be serialized to JSON. Otherwise, use `pyPrint`.
#'
#' @param ... One or more variable names to retrieve from Python.
#' @return The return value (for one variable) or a named list of
#'   values (for multiple variables) returned from Python.
#'
#' @export
pyGet = function(...) {
  dots = list(...)
  if(any(!is.null(names(dots))))
    stop('Input is not valid. Provide a series of Python object names, ',
         'e.g. "a"')
  names(dots) = dots
  if(length(dots) == 1L)
    py()$get(...)
  else
    lapply(dots, py()$get)
}


#' @describeIn variables Set variables in Python. Only applicable to
#'   objects that can be serialized to JSON. Otherwise, use `pyExec`.
#'
#' @param ... One or more named variables to set in Python.
#'
#' @export
pySet = function(...) {
  py()$set(...)
}
