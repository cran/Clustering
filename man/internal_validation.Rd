% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/internal_validation.R
\name{internal_validation}
\alias{internal_validation}
\title{Method that applicate differents internal metrics about a data frame or
matrix, for example dunn, connectivity etc.}
\usage{
internal_validation(
  distance = NULL,
  clusters_vector,
  dataf = NULL,
  method = CONST_EUCLIDEAN,
  metric = NULL
)
}
\arguments{
\item{distance}{Dissimilarity matrix.}

\item{clusters_vector}{Array that containe tha data grouped in cluster.}

\item{dataf}{Dataframe with original data.}

\item{method}{Indicates the method for calculating distance between points.}

\item{metric}{Array with external metric types.}
}
\value{
Return a list of the internal results initialized to zero.
}
\description{
Method that applicate differents internal metrics about a data frame or
matrix, for example dunn, connectivity etc.
}
\keyword{internal}
