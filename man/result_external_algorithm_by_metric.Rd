% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/app.R
\name{result_external_algorithm_by_metric}
\alias{result_external_algorithm_by_metric}
\title{External results by algorithm.}
\usage{
result_external_algorithm_by_metric(df, metric)
}
\arguments{
\item{df}{data matrix or data frame with the result of running the clustering
algorithm.}

\item{metric}{It's a string with the metric to evaluate.}
}
\value{
A data.frame with the results of the algorithm indicated as parameter.
}
\description{
It is used for obtaining the results of an algorithm indicated
as a parameter grouped by number of clusters.
}
\examples{

result = Clustering::clustering(
               df = cluster::agriculture,
               min = 4,
               max = 5,
               algorithm='gmm',
               metrics=c("Precision")
         )

Clustering::result_external_algorithm_by_metric(result,'Precision')

}
