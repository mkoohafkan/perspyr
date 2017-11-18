#' Python Interface Basics
#' @name basics
#'
NULL

#' @describeIn basics Print Python help documents.
#'
#' @param key The Python function or object to get help on.
#'
#' @export
pyHelp = function(key) {
  py()$exec('import pydoc')
  py()$exec(sprintf("_ = pydoc.render_doc(%s)", shQuote(key)))
  cat(pyGet("_"))
}

#' @describeIn basics Print Python version information.
#'
#' @export
pyVersion = function() {
  paste(py()$get("SYS.version_info[0:3]"), collapse = ".")
}

#' @describeIn basics Check if Python is connected.
#'
#'@export
pyIsConnected <- function() {
  py()$running
}

#' @describeIn basics Disconnect from Python.
#'
#'@export
pyExit = function(){
  py()$stop(TRUE)
  invisible(NULL)
}


#' @describeIn basics Connect to Python.
#'
#' @param path The path to the Python executable.
#' @param port A port number to use for communicating with Python.
#' @param host The hostname to use for communicating with Python.
#' @param timeout Maximum time to wait for a response from Python.
#'
#' @export
pyConnect = function(path, port = 6000L, host = 'localhost', timeout = 10000L) {
  if(pyIsConnected())
    suppressMessages(pyExit())
  py = expyr::PythonEnv$new(path = path, port = port, host = host)
  py$timeout = timeout
  assign("py", py, envir = pycon)
  py()$start()
  print(py())
  invisible(NULL)
}
