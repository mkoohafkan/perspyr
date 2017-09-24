#' Use Python Classes
#'
#' Define methods for retrieving non-primitive Python objects.
#'
#' @name py_use
#' @seealso transpyr::use_class
NULL

#' @describeIn py_use Use numpy classes.
#'
#' @export
useNumpy = function() {
  transpyr::use_numpy(py())
  invisible(NULL)
}

#' @describeIn py_use Use pandas classes.
#'
#' @export
usePandas = function(){
  transpyr::use_pandas(py())
  invisible(NULL)
}

#' @describeIn py_use Use a custom class.
#'
#' @param method A Python function definition for serializing the
#'   class to a JSON string.
#'
#' @export
useClass = function(method) {
  transpyr::use_class(py(), method)
  invisible(NULL)
}
