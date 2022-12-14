% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/internalfunctions.R
\name{getStatsAllLM}
\alias{getStatsAllLM}
\title{Function that runs Linear Models for all analytes}
\usage{
getStatsAllLM(
  outcome,
  independentVariable,
  type1,
  type2,
  type,
  covar,
  covarMatrix,
  continuous,
  save.covar.pvals,
  remove.tri = FALSE,
  suppressWarnings = FALSE
)
}
\arguments{
\item{outcome}{'1' or '2' must be set as outcome/independent variable}

\item{independentVariable}{'1' or '2' must be set as outcome/independent variable}

\item{type1}{Analyte type 1 dataset}

\item{type2}{Analyte type 2 dataset}

\item{type}{vector of sample type (by default, it will be used in the interaction term).
Only 2 categories are currently supported.}

\item{covar}{vector of additional vectors to consider}

\item{covarMatrix}{covariate matrix}

\item{continuous}{indicate whether data is discrete (FALSE) or continuous (TRUE)}

\item{save.covar.pvals}{boolean to indicate whether or not to save the p-values of all covariates,
which can be analyzed later but will also lengthen computation time.}

\item{remove.tri}{boolean to indicate whether or not to remove the 1-1
or 2-2 pair with the highest p-value across two duplicate models (e.g. m1~m2 and m2~m1)}

\item{suppressWarnings}{whether or not to suppress warnings}
}
\value{
list of matrices (interaction.pvalues, interaction.adj.pvalues, interaction.coefficients)
}
\description{
Function that runs Linear Models for all analytes
}
