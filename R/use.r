#' Use Python Classes
#'
#' Define methods for retrieving non-primitive Python objects.
#'
#' @name py_use
#' @seealso pysockr::use_class
NULL

#' @describeIn py_use Use numpy classes.
#'
#' @export
useNumpy = function() {
  pysockr::use_numpy(py())
  invisible(NULL)
}

#' @describeIn py_use Use pandas classes.
#'
#' @export
usePandas = function(){
  pysockr::use_pandas(py())
  invisible(NULL)
}

#' @describeIn py_use Use a custom class.
#'
#' @param method A Python function definition for serializing the
#'   class to a JSON string.
#'
#' @export
useClass = function(method) {
  pysockr::use_class(py(), method)
  invisible(NULL)
}
