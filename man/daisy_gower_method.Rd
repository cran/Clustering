% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/daisy.R
\name{daisy_gower_method}
\alias{daisy_gower_method}
\title{Method that runs the daisy algorithm using the gower metric to make an
external or internal validation of the cluster.}
\usage{
daisy_gower_method(dt, clusters, columnClass, metric)
}
\arguments{
\item{dt}{matrix or data frame with the set of values to be applied to the
algorithm.}

\item{clusters}{is an integer that indexes the number of clusters we want to
create.}

\item{columnClass}{is an integer with the number of columns, for example if a
dataset has five column, we can select column four to calculate validation.}

\item{metric}{is a characters vector with the metrics avalaible in the
package. The metrics implemented are: entropy, variation_information,
precision,recall,f_measure,fowlkes_mallows_index,connectivity,dunn,
silhouette.}
}
\value{
returns a list with both the internal and external evaluation of the
grouping.
}
\description{
Method that runs the daisy algorithm using the gower metric to make an
external or internal validation of the cluster.
}
\keyword{internal}
