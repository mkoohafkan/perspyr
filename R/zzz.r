.onLoad = function(libname, pkgname){
}

.onAttach = function(libname, pkgname){
  ns = getNamespace("pynterface")
  assign("pycon", new.env(parent = ns), envir = ns)
}

.onDetach = function(libname){
  py()$kill()
  rm(py, envir = getNamespace("pynterface"))
}
