% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/app.R
\name{result_internal_algorithm_by_metric}
\alias{result_internal_algorithm_by_metric}
\title{Internal results by algorithm}
\usage{
result_internal_algorithm_by_metric(df, algorithm)
}
\arguments{
\item{df}{data matrix or data frame with the result of running the clustering
algorithm.}

\item{algorithm}{It's a string with the algorithm we want to evaluate your
results}
}
\value{
a data.frame with the results of the algorithm indicated as parameter.
}
\description{
Method that returns a data.frame with the algorithm and the
metric indicated as parameters.
}
\details{
The functionality of this method is to return as a result a
data.frame with the algorithm indicated as a parameter along with the rest of
the dissimilarity measurements and the internal evaluation metrics.
}
\examples{

result = clustering(
               df = cluster::agriculture,
               min = 4,
               max = 5,
               algorithm='gmm',
               metrics=c("silhouette"),
               attributes = FALSE
         )

result_internal_algorithm_by_metric(result,'gmm')

}
