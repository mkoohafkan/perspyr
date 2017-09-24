.onLoad = function(libname, pkgname){
  ns = getNamespace("perspyr")
  assign("pycon", new.env(parent = ns), envir = ns)
}

.onAttach = function(libname, pkgname){
  py = expyr::PythonEnv$new(path = NULL, port = NULL, host = NULL)
  assign("py", py, envir = pycon)
}

.onDetach = function(libname){
  py()$stop(force = TRUE)
  rm(py, envir = getNamespace("perspyr"))
}
