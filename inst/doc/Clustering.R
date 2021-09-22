## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, fig.cap = "", fig.path = "Plot")
library("Clustering")

## ---- fig.align='center', echo=TRUE, eval=FALSE-------------------------------
#  
#  result <- Clustering::clustering(df = basketball, min = 3, max = 5, algorithm = c('gmm',
#                          'fanny'), metrics = c('entropy','dunn'), attributes = T)
#  

## ---- fig.align='center', echo=TRUE, eval=FALSE-------------------------------
#  Clustering::best_ranked_external_metrics(result)
#  

## ---- fig.align='center', echo=TRUE, eval=FALSE-------------------------------
#  Clustering::best_ranked_internal_metrics(result)
#  

## ---- fig.align='center', echo=TRUE, eval=FALSE-------------------------------
#  Clustering::evaluate_best_validation_external_by_metrics(result)
#  

## ---- fig.align='center', echo=TRUE, eval=FALSE-------------------------------
#  Clustering::evaluate_validation_external_by_metrics(result)

## ---- fig.align='center', echo=TRUE, eval=FALSE-------------------------------
#  Clustering::result_external_algorithm_by_metric(result,'gmm')

## ---- fig.align='center', echo=TRUE, eval=FALSE-------------------------------
#  result <- Clustering::clustering(df = Clustering::basketball, min = 3, max=3,
#            algorithm = c('gmm'), metrics = c('entropy','dunn'), attributes = T);
#  
#  sort(result,T,'entropy')

## ---- fig.align='center', echo=TRUE, eval=FALSE-------------------------------
#  result[entropy > 0.11 & dunn > 0.11 & entropyAttr == 2]

## ---- fig.align='center', echo=TRUE, eval=FALSE-------------------------------
#  Clustering::appClustering()

