py = function() {
  get("py", envir = pycon)
}

fun_template = function(fun.args, json.args, key, finalizer) {
  paste(
    paste0( 'function(', fun.args, ') {' ),
    paste0( '  py()$exec(sprintf("_ = JSON.loads(\\\"\\\"\\\"%s\\\"\\\"\\\")", rjson::toJSON(', json.args, ')))'),
    paste0( '  py()$exec("_ = ', key, '(**_)")'),
    paste0( '  py()$get("', finalizer, '")'),
    paste0( '}'),
    sep = "\n"
  )
}
