#' Interact with Python.
#' @name py_interact
#'
NULL

#' @describeIn py_interact Execute a single line of Python code.
#'
#' @param code The Python code to execute.
#'
#' @export
pyExec = function(code) {
  py()$exec(code)
}

#' @describeIn py_interact Execute a single line of Python code and
#'   print the result.
#'
#' @export
pyExecp = function(code) {
  cat(py()$exec(sprintf("print(%s)", code)))
  invisible(NULL)
}

#' @describeIn py_interact Execute multiple lines of Python code 
#'   and retrieve variables using `pyGet`.
#'
#' @param returnValues A vector of variable names to
#'   retrieve from Python.
#' @return A list of variables from Python.
#'
#' @export
pyExecg = function(code, returnValues = character()) {
  pyExec(paste(code, collapse = "\n"))
  do.call(pyGet, as.list(returnValues))
}

#' @describeIn py_interact Execute Python code contained in a file.
#'
#' @param filename The file containing Python code to execute.
#'
#' @export
pyExecfile = function(filename) {
  py()$exec(file = filename)
}
