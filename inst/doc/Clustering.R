## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library("tidyverse")

## ----echo=TRUE, warning=FALSE-------------------------------------------------

df <- Clustering::clustering(df = Clustering::basketball,  
                             packages = c("clusterr"), min = 4, max = 6)


## ----echo=FALSE, warning=FALSE------------------------------------------------
  knitr::kable(df$result, "html") %>%  
  kableExtra::kable_styling()  %>%
  kableExtra::scroll_box(height = "400px", width = "100%")


## ----echo=FALSE, warning=FALSE------------------------------------------------
  df$hasInternalMetrics 

## ----echo=FALSE, warning=FALSE------------------------------------------------
  df$hasExternalMetrics 

## ----echo=FALSE, warning=FALSE------------------------------------------------
df$algorithms_execute

## ----echo=FALSE, warning=FALSE------------------------------------------------
df$measures_execute

## ----echo=TRUE, warning=FALSE-------------------------------------------------

df_variable <- Clustering::clustering(df = Clustering::basketball,  
                             packages = c("clusterr"), min = 4, max = 6, variables = TRUE)


## ----echo=FALSE, warning=FALSE------------------------------------------------
  knitr::kable(df_variable$result, "html") %>%  
  kableExtra::kable_styling()  %>%
  kableExtra::scroll_box(height = "400px", width = "100%")


## ----echo=TRUE, warning=FALSE-------------------------------------------------

df_best_ranked_external <- Clustering::best_ranked_external_metrics(df$result)


## ----echo=FALSE, warning=FALSE------------------------------------------------
  knitr::kable(df_best_ranked_external, "html") %>%  
  kableExtra::kable_styling()  %>%
  kableExtra::scroll_box(height = "400px", width = "100%")


## ----echo=TRUE, warning=FALSE-------------------------------------------------

df_best_ranked_internal <- Clustering::best_ranked_internal_metrics(df$result)


## ----echo=FALSE, warning=FALSE, results='asis'--------------------------------
  knitr::kable(df_best_ranked_internal, "html") %>%  
  kableExtra::kable_styling() %>%
  kableExtra::scroll_box(height = "400px", width = "100%")


## ----echo=TRUE, warning=FALSE-------------------------------------------------

df_best_validation_external <- Clustering::evaluate_best_validation_external_by_metrics(df$result)


## ----echo=FALSE, warning=FALSE------------------------------------------------
  knitr::kable(df_best_validation_external$result,"html") %>%  
  kableExtra::kable_styling() %>% kableExtra::row_spec(1:2, bold = TRUE, italic = TRUE, color = "white", background = "#006d38") %>% kableExtra::scroll_box(width = "100%")


## ----echo=TRUE, warning=FALSE-------------------------------------------------

df_result_external <- Clustering::result_external_algorithm_by_metric(df$result,"gmm")


## ----echo=FALSE, warning=FALSE------------------------------------------------
  knitr::kable(df_result_external$result,"html") %>%  
  kableExtra::kable_styling() %>% kableExtra::row_spec(1, bold = TRUE, italic = TRUE, color = "white", background = "#006d38") %>% kableExtra::scroll_box(width = "100%")


## ----echo=TRUE, warning=FALSE-------------------------------------------------

df_best_validation_internal <-   
  Clustering::evaluate_best_validation_internal_by_metrics(df$result)


## ----echo=FALSE, warning=FALSE------------------------------------------------
  knitr::kable(df_best_validation_internal$result,"html") %>%  
  kableExtra::kable_styling() %>% kableExtra::row_spec(3:5, bold = TRUE, italic = TRUE, color = "white", background = "#006d38") %>% kableExtra::scroll_box(width = "100%")


## ----fig.show='hold', fig.width=7, fig.align ='center', warning=FALSE---------

Clustering::plot_external_validation(df,"variation_information")


