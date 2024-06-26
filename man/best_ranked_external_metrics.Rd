% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/app.R
\name{best_ranked_external_metrics}
\alias{best_ranked_external_metrics}
\title{Best rated external metrics.}
\usage{
best_ranked_external_metrics(df)
}
\arguments{
\item{df}{Matrix or data frame with the result of running the clustering
algorithm.}
}
\value{
Returns a data.frame with the best classified external attribute.
}
\description{
Method in charge of searching for each algorithm those that have
the best external classification.

Method that looks for those external attribute that are better
classified, making use of the var column. In this way of discard attribute and
only work with those that give the best response to the algorithm in question.
}
\examples{

result = Clustering::clustering(
               df = cluster::agriculture,
               min = 4,
               max = 4,
               algorithm='clara',
               metrics=c("Recall")
         )

Clustering::best_ranked_external_metrics(df = result)

}
