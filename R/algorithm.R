#' Method that returns the list of used packages
#'
#' @return package listing array
#'
#' @keywords internal
#'

packages <- function() {
  return (
    c(
      CONST_ALGORITHM_ADVCLUST,
      CONST_ALGORITHM_AMAP,
      CONST_ALGORITHM_APCLUSTER,
      CONST_ALGORITHM_CLUSTER,
      CONST_ALGORITHM_CLUSTERR,
      CONST_ALGORITHM_GAMA,
      CONST_ALGORITHM_PVCLUST
    )
  )
}

#' Method that returns the list of used algorithms
#'
#' @return algorithm listing array
#'
#' @keywords internal
#'

algorithms <- function() {
  return (
    c(
      CONST_FUZZY_CM,
      CONST_FUZZY_GG,
      CONST_FUZZY_GK,
      CONST_HCLUST,
      CONST_APCLUSTERK,
      CONST_AGNES,
      CONST_CLARA,
      CONST_DAISY,
      CONST_DIANA,
      CONST_FANNY,
      CONST_MONA,
      CONST_PAM,
      CONST_GMM,
      CONST_KMEANS_ARMA,
      CONST_KMEANS_RCPP,
      CONST_MINI_KMEANS,
      CONST_GAMA,
      CONST_PVCLUST
    )
  )
}

#' Method that returns the list of used metrics
#'
#' @return metrics listing array
#'
#' @keywords internal
#'

metrics <- function() {
  return (
    c(
      CONST_ENTROPY_METRIC,
      CONST_VARIATION_INFORMATION_METRIC,
      CONST_PRECISION_METRIC,
      CONST_RECALL_METRIC,
      CONST_F_MEASURE_METRIC,
      CONST_FOWLKES_MALLOWS_INDEX_METRIC,
      CONST_CONNECTIVITY_METRIC,
      CONST_DUNN_METRIC,
      CONST_SILHOUETTE_METRIC
    )
  )

}

#' Method that returns the list of used external metrics
#'
#' @return external metrics listing array
#'
#' @keywords internal
#'
#'

metrics_external <- function() {
  return (
    c(
      CONST_ENTROPY_METRIC,
      CONST_VARIATION_INFORMATION_METRIC,
      CONST_PRECISION_METRIC,
      CONST_RECALL_METRIC,
      CONST_F_MEASURE_METRIC,
      CONST_FOWLKES_MALLOWS_INDEX_METRIC
    )
  )

}

#' Method that returns the list of used internal metrics
#'
#' @return internal metrics listing array
#'
#' @keywords internal
#'

metrics_internal <- function() {
  return (c(
    CONST_CONNECTIVITY_METRIC,
    CONST_DUNN_METRIC,
    CONST_SILHOUETTE_METRIC
  ))

}


#' Method that checks for external metrics
#'
#' @param metrics array with the metrics used in the execution of the package
#'
#' @return true if it exists and false otherwise
#'
#' @keywords internal
#'

is_External_Metrics <- function(metrics) {
  if (is.null(metrics))
    return (TRUE)


  for (i in 1:length(metrics)) {
    if (tolower(metrics[i]) %in% metrics_external())
      return (TRUE)

  }

  return (FALSE)
}

#' Method that checks for internal metrics
#'
#' @param metrics array with the metrics used in the execution of the package
#'
#' @return true if it exists and false otherwise
#'
#' @keywords internal
#'

is_Internal_Metrics <- function(metrics) {
  if (is.null(metrics))
    return (TRUE)


  for (i in 1:length(metrics)) {
    if (tolower(metrics[i]) %in% metrics_internal())
      return (TRUE)

  }

  return (FALSE)


}

#' Method that returns how many external metrics there are in the array of metrics used in the calculation
#'
#' @param metrics array with the metrics used in the execution of the package
#'
#' @return returns the number of occurrences
#'
#' @keywords internal
#'

number_columnas_external <- function(metrics) {
  numberColumnasExternal <- 0

  for (i in 1:length(metrics)) {
    if (tolower(metrics[i] %in% metrics_external())) {
      numberColumnasExternal <- numberColumnasExternal + 1
    }

  }

  return (numberColumnasExternal)

}


#' Method that returns an array with the internal information of the cluster
#'
#' @param metrics array with the metrics used in the execution of the package
#' @param info list with internal clustering information
#' @param size internal number of columns
#' @param variables Null returns the position of the variable, otherwise it returns the value of the variable
#'
#' @return array with the information from the calculation of the internal evaluation of the clustering
#'
#' @keywords internal
#'

info_internal <- function (metrics, info, size, variables) {
  result <- array(data = NA, dim = size)

  result[1] <- info$algorith
  result[2] <- info$distance
  result[3] <- info$cluster
  result[4] <- info$dataset
  result[5] <- info$ranking

  if (!is.null(variables))
    result[6] <- info$timeInternal
  else
    result[6] <- round(as.numeric(info$timeInternal), digits = 4)

  position <- 7

  for (i in 1:length(metrics)) {

    if (tolower(metrics[i] == CONST_CONNECTIVITY_METRIC)) {
      if (!is.null(variables))
        result[position] <- info$connectivity
      else
        result[position] <-
          as.numeric(format(as.numeric(info$connectivity), digits = 4))
      position <- position + 1
    }

    if (tolower(metrics[i] == CONST_DUNN_METRIC)) {
      if (!is.null(variables))
        result[position] <- info$dunn
      else
        result[position] <-
          as.numeric(format(as.numeric(info$dunn), digits = 4))
      position <- position + 1
    }

    if (tolower(metrics[i] == CONST_SILHOUETTE_METRIC)) {
      if (!is.null(variables))
        result[position] <- info$silhouette
      else
        result[position] <-
          as.numeric(format(as.numeric(info$silhouette), digits = 4))
      position <- position + 1
    }
  }

  return(result)
}

#' Method that returns an array with the external information of the cluster
#'
#' @param metrics array with the metrics used in the execution of the package
#' @param info list with external clustering information
#' @param size external number of columns
#' @param variables Null returns the position of the variable, otherwise it returns the value of the variable
#'
#' @return array with the information from the calculation of the external evaluation of the clustering
#'
#' @keywords internal
#'

info_external <- function (metrics, info, size, variables) {
  result <- array(data = NA, dim = size)

  result[1] <- info$algorith
  result[2] <- info$distance
  result[3] <- info$cluster
  result[4] <- info$dataset
  result[5] <- info$ranking

  if (!is.null(variables))
    result[6] <- info$timeExternal
  else
    result[6] <- round(as.numeric(info$timeExternal), digits = 4)

  position <- 7

  for (i in 1:length(metrics)) {
    if (tolower(metrics[i] == CONST_ENTROPY_METRIC)) {
      if (!is.null(variables))
        result[position] <- info$entropy
      else
        result[position] <-
          as.numeric(format(as.numeric(info$entropy), digits = 4))
      position <- position + 1
    }

    if (tolower(metrics[i] == CONST_VARIATION_INFORMATION_METRIC)) {
      if (!is.null(variables))
        result[position] <- info$variation_information
      else
        result[position] <-
          as.numeric(format(as.numeric(info$variation_information), digits = 4))
      position <- position + 1
    }

    if (tolower(metrics[i] == CONST_PRECISION_METRIC)) {
      if (!is.null(variables))
        result[position] <- info$precision
      else
        result[position] <-
          as.numeric(format(as.numeric(info$precision), digits = 4))
      position <- position + 1
    }

    if (tolower(metrics[i] == CONST_RECALL_METRIC)) {
      if (!is.null(variables))
        result[position] <- info$recall
      else
        result[position] <-
          as.numeric(format(as.numeric(info$recall), digits = 4))

      position <- position + 1
    }

    if (tolower(metrics[i] == CONST_FOWLKES_MALLOWS_INDEX_METRIC)) {
      if (!is.null(variables))
        result[position] <- info$fowlkes_mallows_index
      else
        result[position] <-
          as.numeric(format(as.numeric(info$fowlkes_mallows_index), digits = 4))

      position <- position + 1
    }

    if (tolower(metrics[i] == CONST_F_MEASURE_METRIC)) {
      if (!is.null(variables))
        result[position] <- info$f_measure
      else
        result[position] <-
          as.numeric(format(as.numeric(info$f_measure), digits = 4))

      position <- position + 1
    }
  }

  return(result)
}

#' Method that returns how many internal metrics there are in the array of metrics used in the calculation
#'
#' @param metrics array with the metrics used in the execution of the package
#'
#' @return returns the number of occurrences
#'
#' @keywords internal
#'

number_columnas_internal <- function(metrics) {
  numberColumnasInternal <- 0

  for (i in 1:length(metrics)) {
    if (tolower(metrics[i] %in% metrics_internal())) {
      numberColumnasInternal <- numberColumnasInternal + 1
    }

  }

  return (numberColumnasInternal)

}


#' Method that returns all the algorithms executed by the package
#'
#' @param packages package array
#'
#' @return array with the algorithms we're going to run
#'
#' @keywords internal
#'

algorithms_package <- function(packages) {
  algorithms <- vector()

  if (is.null(packages)) {
    # All algorithm
    algorithms <- c(algorithms, algorithm_advclust())
    algorithms <- c(algorithms, algorithm_amap())
    algorithms <- c(algorithms, algorithm_apcluster())
    algorithms <- c(algorithms, algorithm_cluster())
    algorithms <- c(algorithms, algorithm_clusterr())
    algorithms <- c(algorithms, algorithm_gama())
    algorithms <- c(algorithms, algorithm_pvclust())

  } else {
    for (i in 1:length(packages)) {
      if (tolower(packages[i]) == CONST_ALGORITHM_ADVCLUST) {
        algorithms <- c(algorithms, algorithm_advclust())
      }

      if (tolower(packages[i]) == CONST_ALGORITHM_AMAP) {
        algorithms <- c(algorithms, algorithm_amap())
      }

      if (tolower(packages[i]) == CONST_ALGORITHM_APCLUSTER) {
        algorithms <- c(algorithms, algorithm_apcluster())
      }

      if (tolower(packages[i]) == CONST_ALGORITHM_CLUSTER) {
        algorithms <- c(algorithms, algorithm_cluster())
      }

      if (tolower(packages[i]) == CONST_ALGORITHM_CLUSTERR) {
        algorithms <- c(algorithms, algorithm_clusterr())
      }

      if (tolower(packages[i]) == CONST_ALGORITHM_GAMA) {
        algorithms <- c(algorithms, algorithm_gama())
      }

      if (tolower(packages[i]) == CONST_ALGORITHM_PVCLUST) {
        algorithms <- c(algorithms, algorithm_pvclust())
      }
    }
  }

  return(algorithms)

}

#' Method that returns all the measures executed by the package from the indicated algorithms
#'
#' @param algorithm algorithms array
#'
#' @return array with the measures we're going to run
#'
#' @keywords internal
#'

measure_calculate <- function(algorithm) {
  result <- vector()

  for (i in 1:length(algorithm)) {
    if (tolower(algorithm[i]) == CONST_FUZZY_CM) {
      result <- c(result, CONST_FUZZY_CM)
    }

    if (tolower(algorithm[i]) == CONST_FUZZY_GG) {
      result <- c(result, CONST_FUZZY_GG)
    }

    if (tolower(algorithm[i]) == CONST_FUZZY_GK) {
      result <- c(result, CONST_FUZZY_GK)
    }

    if (tolower(algorithm[i]) == CONST_HCLUST) {
      result <- c(result, CONST_HCLUST_EUCLIDEAN)
    }

    if (tolower(algorithm[i]) == CONST_APCLUSTERK) {
      result <- c(result, CONST_APCLUSTERK_EUCLIDEAN)
      result <- c(result, CONST_APCLUSTERK_MANHATTAN)
      result <- c(result, CONST_APCLUSTERK_MINKOWSKI)
    }

    if (tolower(algorithm[i]) == CONST_AGNES) {
      result <- c(result, CONST_AGNES_EUCLIDEAN)
      result <- c(result, CONST_AGNES_MANHATTAN)
    }

    if (tolower(algorithm[i]) == CONST_CLARA) {
      result <- c(result, CONST_CLARA_EUCLIDEAN)
      result <- c(result, CONST_CLARA_MANHATTAN)
    }

    if (tolower(algorithm[i]) == CONST_DAISY) {
      result <- c(result, CONST_DAISY_MANHATTAN)
      result <- c(result, CONST_DAISY_GOWER)
      result <- c(result, CONST_DAISY_EUCLIDEAN)
    }

    if (tolower(algorithm[i]) == CONST_DIANA) {
      result <- c(result, CONST_DIANA_EUCLIDEAN)
    }

    if (tolower(algorithm[i]) == CONST_FANNY) {
      result <- c(result, CONST_FANNY_EUCLIDEAN)
      result <- c(result, CONST_FANNY_MANHATTAN)
    }

    if (tolower(algorithm[i]) == CONST_MONA) {
      result <- c(result, CONST_MONA)
    }

    if (tolower(algorithm[i]) == CONST_PAM) {
      result <- c(result, CONST_PAM_EUCLIDEAN)
      result <- c(result, CONST_PAM_MANHATTAN)
    }

    if (tolower(algorithm[i]) == CONST_GMM) {
      result <- c(result, CONST_GMM_EUCLIDEAN)
      result <- c(result, CONST_GMM_MANHATTAN)
    }

    if (tolower(algorithm[i]) == CONST_KMEANS_ARMA) {
      result <- c(result, CONST_KMEANS_ARMA)
    }

    if (tolower(algorithm[i]) == CONST_KMEANS_RCPP) {
      result <- c(result, CONST_KMEANS_RCPP)
    }

    if (tolower(algorithm[i]) == CONST_MINI_KMEANS) {
      result <- c(result, CONST_MINI_KMEANS)
    }

    if (tolower(algorithm[i]) == CONST_GAMA) {
      result <- c(result, CONST_GAMA_EUCLIDEAN)
    }

    if (tolower(algorithm[i]) == CONST_PVCLUST) {
      result <- c(result, CONST_PVCLUST_EUCLIDEAN)
      result <- c(result, CONST_PVLCUST_CORRELATION)
    }
  }


  return(result)
}


#' Method that returns all the measures executed by the package
#'
#' @param package package array
#'
#' @return array with the measures we're going to run
#'
#' @keywords internal
#'

measure_package <- function(package) {
  result <- vector()

  if (is.null(package)) {
    # All measures
    result <- c(result, measure_advclust())
    result <- c(result, measure_amap())
    result <- c(result, measure_apcluster())
    result <- c(result, measure_cluster())
    result <- c(result, measure_clusterr())
    result <- c(result, measure_gama())
    result <- c(result, measure_pvclust())
  } else {
    for (i in 1:length(package)) {
      if (tolower(package[i]) == CONST_ALGORITHM_ADVCLUST) {
        result <- c(result, measure_advclust())
      }

      if (tolower(package[i]) == CONST_ALGORITHM_AMAP) {
        result <- c(result, measure_amap())
      }

      if (tolower(package[i]) == CONST_ALGORITHM_APCLUSTER) {
        result <- c(result, measure_apcluster())
      }

      if (tolower(package[i]) == CONST_ALGORITHM_CLUSTER) {
        result <- c(result, measure_cluster())
      }

      if (tolower(package[i]) == CONST_ALGORITHM_CLUSTERR) {
        result <- c(result, measure_clusterr())
      }

      if (tolower(package[i]) == CONST_ALGORITHM_GAMA) {
        result <- c(result, measure_gama())
      }

      if (tolower(package[i]) == CONST_ALGORITHM_PVCLUST) {
        result <- c(result, measure_pvclust())
      }
    }
  }

  return(result)

}


#' Method in charge of verifying the implemented metrics
#'
#' @param metrics array with the metrics used in the execution of the package
#'
#' @return list of metrics
#'
#' @keywords internal
#'

metrics_calculate <- function(metrics) {
  result <- vector()

  if (is.null(metrics)) {
    # All metrics
    result <-
      c(
        CONST_TIME_EXTERNAL,
        CONST_ENTROPY_METRIC,
        CONST_VARIATION_INFORMATION_METRIC,
        CONST_PRECISION_METRIC,
        CONST_RECALL_METRIC,
        CONST_F_MEASURE_METRIC,
        CONST_FOWLKES_MALLOWS_INDEX_METRIC,
        CONST_CONNECTIVITY_METRIC,
        CONST_DUNN_METRIC,
        CONST_SILHOUETTE_METRIC,
        CONST_TIME_INTERNAL
      )
  } else {
    result <- c(result, CONST_TIME_EXTERNAL)

    for (i in 1:length(metrics)) {
      if (tolower(metrics[i]) == CONST_ENTROPY_METRIC) {
        result <- c(result, CONST_ENTROPY_METRIC)
      }

      if (tolower(metrics[i]) == CONST_VARIATION_INFORMATION_METRIC) {
        result <- c(result, CONST_VARIATION_INFORMATION_METRIC)
      }

      if (tolower(metrics[i]) == CONST_PRECISION_METRIC) {
        result <- c(result, CONST_PRECISION_METRIC)
      }

      if (tolower(metrics[i]) == CONST_RECALL_METRIC) {
        result <- c(result, CONST_RECALL_METRIC)
      }

      if (tolower(metrics[i]) == CONST_F_MEASURE_METRIC) {
        result <- c(result, CONST_F_MEASURE_METRIC)
      }

      if (tolower(metrics[i]) == CONST_FOWLKES_MALLOWS_INDEX_METRIC) {
        result <- c(result, CONST_FOWLKES_MALLOWS_INDEX_METRIC)
      }

      if (tolower(metrics[i]) == CONST_CONNECTIVITY_METRIC) {
        result <- c(result, CONST_CONNECTIVITY_METRIC)
      }

      if (tolower(metrics[i]) == CONST_DUNN_METRIC) {
        result <- c(result, CONST_DUNN_METRIC)
      }

      if (tolower(metrics[i]) == CONST_SILHOUETTE_METRIC) {
        result <- c(result, CONST_SILHOUETTE_METRIC)
      }
    }

    result <- c(result, CONST_TIME_INTERNAL)

  }

  return (result)

}

#' Metrics of the advclust algorithm
#'
#' @return list with the metrics
#'
#' @keywords internal
#'

measure_advclust <- function() {
  return(c(CONST_FUZZY_CM,
           CONST_FUZZY_GG,
           CONST_FUZZY_GK))

}

#' Metrics of the amap algorithm
#'
#' @return list with the metrics
#'
#' @keywords internal
#'

measure_amap <- function() {
  return(c(CONST_HCLUST_EUCLIDEAN))

}

#' Metrics of the apcluster algorithm
#'
#' @return list with the metrics
#'
#' @keywords internal
#'

measure_apcluster <- function() {
  return(c(
    CONST_APCLUSTERK_EUCLIDEAN,
    CONST_APCLUSTERK_MANHATTAN,
    CONST_APCLUSTERK_MINKOWSKI
  ))

}

#' Metrics of the cluster algorithm
#'
#' @return list with the metrics
#'
#' @keywords internal
#'

measure_cluster <- function() {
  return(
    c(
      CONST_AGNES_EUCLIDEAN,
      CONST_AGNES_MANHATTAN,
      CONST_CLARA_EUCLIDEAN,
      CONST_CLARA_MANHATTAN,
      CONST_DAISY_MANHATTAN,
      CONST_DAISY_GOWER,
      CONST_DAISY_EUCLIDEAN,
      CONST_DIANA_EUCLIDEAN,
      CONST_FANNY_EUCLIDEAN,
      CONST_FANNY_MANHATTAN,
      CONST_PAM_EUCLIDEAN,
      CONST_PAM_MANHATTAN,
      CONST_MONA
    )
  )

}

#' Metrics of the ClusterR algorithm
#'
#' @return list with the metrics
#'
#' @keywords internal
#'

measure_clusterr <- function() {
  return(c(
    CONST_GMM_EUCLIDEAN,
    CONST_GMM_MANHATTAN,
    CONST_KMEANS_ARMA,
    CONST_KMEANS_RCPP,
    CONST_MINI_KMEANS
  ))

}

#' Metrics of the gama algorithm
#'
#' @return list with the metrics
#'
#' @keywords internal
#'

measure_gama <- function() {
  return(c(CONST_GAMA_EUCLIDEAN))

}

#' Metrics of the pvclust algorithm
#'
#' @return list with the metrics
#'
#' @keywords internal
#'

measure_pvclust <- function() {
  return(c(CONST_PVCLUST_EUCLIDEAN,
           CONST_PVLCUST_CORRELATION))

}

#' Advclust package algorithms
#'
#' @return list with the algorithms
#'
#' @keywords internal
#'

algorithm_advclust <- function() {
  return(c(CONST_FUZZY_CM,
           CONST_FUZZY_GG,
           CONST_FUZZY_GK))

}

#' amap package algorithms
#'
#' @return list with the algorithms
#'
#' @keywords internal
#'

algorithm_amap <- function() {
  return(c(CONST_HCLUST))

}

#' apcluster package algorithms
#'
#' @return list with the algorithms
#'
#' @keywords internal
#'

algorithm_apcluster <- function() {
  return(c(CONST_APCLUSTERK))

}

#' cluster package algorithms
#'
#' @return list with the algorithms
#'
#' @keywords internal
#'

algorithm_cluster <- function() {
  return(c(CONST_AGNES,
           CONST_CLARA,
           CONST_DAISY,
           CONST_DIANA,
           CONST_FANNY,
           CONST_MONA,
           CONST_PAM))

}

#' ClusterR package algorithms
#'
#' @return list with the algorithms
#'
#' @keywords internal
#'

algorithm_clusterr <- function() {
  return(c(CONST_GMM,
           CONST_KMEANS_ARMA,
           CONST_KMEANS_RCPP,
           CONST_MINI_KMEANS))

}

#' gama package algorithms
#'
#' @return list with the algorithms
#'
#' @keywords internal
#'

algorithm_gama <- function() {
  return(c(CONST_ALGORITHM_GAMA))
}

#' pvclust package algorithms
#'
#' @return list with the algorithms
#'
#' @keywords internal
#'

algorithm_pvclust <- function() {
  return(c(CONST_ALGORITHM_PVCLUST))

}