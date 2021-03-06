% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/internal_validation.R
\name{connectivity_metric}
\alias{connectivity_metric}
\title{Method to calculate the connectivity}
\usage{
connectivity_metric(distance, clusters_vector, dt, method)
}
\arguments{
\item{distance}{dissimilarity matrix}

\item{clusters_vector}{array that containe tha data grouped in cluster}

\item{dt}{dataframe with original data}

\item{method}{indicates the method for calculating distance between points}
}
\value{
returns a double with the result of the connectivity calculation
}
\description{
Method to calculate the connectivity
}
\keyword{internal}
