% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/app.R
\name{export_file_internal}
\alias{export_file_internal}
\title{Export result of internal metrics in latex.}
\usage{
export_file_internal(df, path = NULL)
}
\arguments{
\item{df}{is a dataframe that contains as a parameter a table in latex format
with the results of the external validations.}

\item{path}{it's a string with the path to a directory where a file is to be
stored in latex format.}
}
\description{
Method that exports the results of external measurements in
latex format to a file.
}
\details{
When we work in latex format and we need to create a table to export
the results, with this method we can export the results of the clustering
algorithm to latex.
}
\examples{
result = clustering(
               df = cluster::agriculture,
               min = 4,
               max = 5,
               algorithm='gmm',
               metrics=c("dunn"),
               attributes = TRUE
         )

export_file_internal(result)
file.remove("internal_data.tex")

}
