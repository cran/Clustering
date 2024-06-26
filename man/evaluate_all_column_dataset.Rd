% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/evaluate_column_dataset.R
\name{evaluate_all_column_dataset}
\alias{evaluate_all_column_dataset}
\title{Method in charge of calculating the average for all datasets using all the
algorithms defined in the application.}
\usage{
evaluate_all_column_dataset(datas, method, cluster, nameDataset, metrics)
}
\arguments{
\item{datas}{It's a data frame or matrix.}

\item{method}{Described the metrics used by each of the algorithms.}

\item{cluster}{Number of clusters.}

\item{nameDataset}{Specify the name of dataset like information.}

\item{metrics}{Array with internal or external metrics.}
}
\value{
A list with result of external and internal validation applying on
algorithms.
}
\description{
Method in charge of calculating the average for all datasets using all the
algorithms defined in the application.
}
\keyword{internal}
