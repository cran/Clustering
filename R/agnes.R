#'
#' Method that runs the agnes algorithm using the Euclidean metric to
#' make an external or internal validation of the cluster.
#'
#' @param dt Matrix or data frame with the set of values to be applied to the
#' algorithm.
#'
#' @param clusters It's an integer that indexes the number of clusters we want to
#' create.
#'
#' @param metric It's a characters vector with the metrics avalaible in the
#' package. The metrics implemented are: Entropy, Variation_information,
#' Precision,Recall,F_measure,Fowlkes_mallows_index,Connectivity,Dunn,
#' Silhouette.
#'
#' @return Return a list with both the internal and external evaluation of the
#' grouping.
#'
#' @keywords internal


agnes_euclidean_method = function(dt, clusters, metric) {

  start.time <- Sys.time()

  if ('data.frame' %in% class(dt))
    dt = as.matrix(dt)

  numeric_cluster <- ifelse(!is.numeric(clusters),1,0)

  if (sum(numeric_cluster)>0)
    stop('The field clusters must be a numeric')

  agnes_euclidean <- tryCatch({
    agnes(
      x = dt,
      metric = CONST_EUCLIDEAN,
      stand = FALSE,
      trace.lev = CONST_ZERO
    )
  },

  error = function(cond) {
    return(CONST_NULL)
  })

  if (!is.null(agnes_euclidean)) {
    ev_agnes_euclidean <-
      tryCatch({
        external_validation(agnes_euclidean$order,
                            cutree(agnes_euclidean, k = clusters),metric)

      },

      error = function(cond) {
        ev_agnes_euclidean = initializeExternalValidation()
      })

    iv_agnes_euclidean  <- tryCatch({
      internal_validation(
        distance = agnes_euclidean$diss,
        clusters_vector = cutree(agnes_euclidean, k = clusters),
        dataf = dt,
        method = CONST_EUCLIDEAN,
        metric
      )

    },

    error = function(cond) {
      iv_agnes_euclidean = initializeInternalValidation()
    })

  } else {
    ev_agnes_euclidean = initializeExternalValidation()
    iv_agnes_euclidean = initializeInternalValidation()
  }

  end.time <- Sys.time()
  time <- end.time - start.time

  ev_agnes_euclidean$time = time - iv_agnes_euclidean$time
  iv_agnes_euclidean$time = time - ev_agnes_euclidean$time

  result = list("external" = ev_agnes_euclidean,
                "internal" = iv_agnes_euclidean)

  return (result)
}

#' Method that runs the agnes algorithm using the manhattan metric to make an
#' external or internal validation of the cluster
#'
#' @param dt matrix or data frame with the set of values to be applied to the
#' algorithm.
#' @param clusters is an integer that indexes the number of clusters we want to
#' create.
#' @param metric is a characters vector with the metrics avalaible in the
#' package. The metrics implemented are: entropy, variation_information,
#' precision,recall,f_measure,fowlkes_mallows_index,connectivity,dunn,
#' silhouette.
#'
#' @return returns a list with both the internal and external evaluation of the
#' grouping.
#'
#' @keywords internal
#'

agnes_manhattan_method = function(dt, clusters, metric) {

  start.time <- Sys.time()

  if ('data.frame' %in% class(dt))
    dt = as.matrix(dt)

  numeric_cluster <- ifelse(!is.numeric(clusters),1,0)

  if (sum(numeric_cluster)>0)
    stop('The field clusters must be a numeric')

  agnes_manhattan <- tryCatch({
    agnes(
      x = dt,
      metric = CONST_MANHATTAN,
      stand = FALSE,
      trace.lev = CONST_ZERO
    )
  },

  error = function(cond) {
    return(CONST_NULL)
  })

  if (!is.null(agnes_manhattan)) {
    ev_agnes_manhattan <-
      tryCatch({
        external_validation(agnes_manhattan$order,
                            cutree(agnes_manhattan, k = clusters),metric)

      },

      error = function(cond) {
        ev_agnes_manhattan = initializeExternalValidation()
      })

    iv_agnes_manhattan <- tryCatch({
      internal_validation(
        distance = agnes_manhattan$diss,
        clusters_vector = cutree(agnes_manhattan, k = clusters),
        dataf = dt,
        method = CONST_MANHATTAN,
        metric
      )
    },

    error = function(cond) {
      iv_agnes_manhattan = initializeInternalValidation()
    })
  } else {
    ev_agnes_manhattan = initializeExternalValidation()
    iv_agnes_manhattan = initializeInternalValidation()
  }

  end.time <- Sys.time()
  time <- end.time - start.time

  ev_agnes_manhattan$time = time - iv_agnes_manhattan$time
  iv_agnes_manhattan$time = time - ev_agnes_manhattan$time

  result = list("external" = ev_agnes_manhattan,
                "internal" = iv_agnes_manhattan)

  return (result)
}
