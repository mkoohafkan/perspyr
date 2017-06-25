.onLoad = function(libname, pkgname){
  ns = getNamespace("pynterface")
  assign("pycon", new.env(parent = ns), envir = ns)
}

.onAttach = function(libname, pkgname){
  py = pysockr::PythonEnv$new(path = NULL, port = NULL, host = NULL)
  assign("py", py, envir = pycon)
}

.onDetach = function(libname){
  py()$stop(force = TRUE)
  rm(py, envir = getNamespace("pynterface"))
}
