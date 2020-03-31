#'
#'Method that format a number with four digits
#'
#'@param x number
#'@param k number of decimals
#'
#'@return a number convert to string with four digits
#'
#'@keywords internal
#'

specify_decimal <-
  function(x, k)
    trimws(format(round(x, k), nsmall = k))



#' Method that return a list of files that exists in a directory
#'
#' @param path of the directory
#'
#' @return a vector with the files existing into of a directory
#'
#' @keywords internal
#'

path_dataset = function (path) {

  directory <- getwd()
  on.exit(setwd(directory))

  files <- list.files(path = directory, pattern = "\\.dat")

  if (!is.null(files) && length(files) > 0)
    return (files)

  else
    return (CONST_NULL)
}


#' Method that fill vector
#'
#' @param data matriz or dataframe with dataset
#' @param appcluster data with the information of the appcluster object
#'
#' @return a vector fill with information
#'
#' @keywords internal
#'

fill_cluster_vector = function(data, appcluster) {
  cluster_vector = array(dim = nrow(data))
  for (i in 1:length(appcluster@clusters)) {
    for (j in 1:length(appcluster@clusters[[i]])) {
      array_cluster = appcluster@clusters[[i]]
      pos = array_cluster[j]

      cluster_vector[[pos]] = i

    }
  }

  return (cluster_vector)

}

#' Method in charge of detecting the limit of a dataset header.
#'
#' @param path of the dataset
#'
#' @return The row where the dataset attributes definition ends
#'
#' @keywords internal
#'

detect_definition_attribute = function(path) {
  con = file(path, "r")
  numeroFilas = 1
  while (TRUE) {
    line = readLines(con, n = 1)
    if (!grepl("@", line)) {
      break

    }
    numeroFilas = numeroFilas + 1
  }

  close(con)

  return (numeroFilas - 1)
}

#'
#'Method that returns the number of variables in a dataset directory
#'
#'@param path dataset directory
#'
#'@return returns the number of variables in a dataset directory
#'
#'@keywords internal
#'

number_variables_dataset <- function(path){

  files <- path_dataset(path)

  number_variables <- 0

  if (!is.null(files)){

    for (pos in 1:length(files)) {

      df <- as.matrix(
        read.csv(
          file = files[pos],
          header = CONST_FALSE,
          comment.char = '@'
        )
      )

      number_variables <- number_variables + ncol(df);
    }

  }

  return (number_variables)

}
