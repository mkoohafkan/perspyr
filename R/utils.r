py = function() {
  tryCatch(
    get("py", pos = pycon),
    error = function(e)
      stop("Python is not connected")
    )
}



