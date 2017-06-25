#' Python help
#'
pyHelp = function(x) {
  py()$exec('import pydoc')
  py()$exec(sprintf("_ = pydoc.render_doc(%s)", x))
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
  if(pyIsConnected())
    suppressMessages(pyExit())
  py = pysockr::PythonEnv$new(path = path, port = port, host = host)
  py$timeout = timeout
  assign("py", py, envir = pycon)
  py()$start()
  pyInfo()
  invisible(NULL)
}
