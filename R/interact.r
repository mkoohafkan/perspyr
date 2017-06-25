#' @name interact
#'
#' Interact with Python.
#'
NULL

#' @describeIn interact Execute a single line of Python code
#'
#' @param code The Python code to execute.
#'
#' @export
pyExec = function(code) {
  py()$exec(code)
}

#' @describeIn interact Execute a single line of Python code and
#'   print the result.
#'
#' @export
pyExecp = function(code) {
  cat(py()$exec(sprintf("print(%s)", code)))
  invisible(NULL)
}

#' @describeIn interact Execute multiple line of Python code and
#'   retrieve multiple variables using `pyGet`.
#'
#' @param returnValues A vector of variable names to
#'   retrieve from Python.
#' @return A list of variables from Python.
#'
#' @export
pyExecg = function(code, returnValues = character()) {
  pyExec(code)
  do.call(pyGet, returnValues)
}

#' @describeIn interact Execute Python code contained in a file.
#'
#' @param filename The file containing Python code to execute.
#'
#' @export
pyExecfile = function(filename) {
  py()$exec(file = filename)
}
