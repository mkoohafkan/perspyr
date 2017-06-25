#' Python help
#'
pyHelp = function(x) {
  pyImport('pydoc')
  py()$exec(sprintf("_ = pydoc.renderdoc(%s)", x))
  cat(pyGet("_"))
}

#' Python Version Information
#'
pyInfo = function() {
  print(py())
}

#' Check if Python is connected
#'
pyIsConnected <- function() {
  py()$running
}

#' Disconnect from Python
#'
pyExit = function(){
  py()$stop(TRUE)
  invisible(NULL)
}


#' Connect R to Python
#'
pyConnect = function(path, port = 6000, host = 'localhost', timeout = 10000L) {
  temp = try(pyExit())
  py = pysockr::PythonEnv$new(path, port, host)
  py$timeout = timeout
  assign("py", py, envir = pycon)
  py()$start
  invisible(NULL)
}
