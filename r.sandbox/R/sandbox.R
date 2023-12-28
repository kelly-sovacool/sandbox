greet <- function() {
  print('hello world!')
}

get_docker_version <- function(event_name, github_ref) {
  if (event_name == 'release') {
   version <- github_ref
  } else {
   version <- paste(packageVersion('r.sandbox'), github_ref, sep = '_')
  }
  return(as.character(version))
}
