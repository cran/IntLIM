% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plottingfunctions.R
\name{MarginalEffectsGraphDataframe}
\alias{MarginalEffectsGraphDataframe}
\title{Creates a dataframe of the marginal effect of phenotype}
\usage{
MarginalEffectsGraphDataframe(
  inputResults,
  inputData,
  independentAnalyteOfInterest,
  outcomeAnalyteOfInterest,
  continuous,
  outcome,
  independentVariable
)
}
\arguments{
\item{inputResults}{IntLimResults object with model results (output of RunIntLim())}

\item{inputData}{Named list (output of 
FilterData()) with analyte levels 
and associated meta-data}

\item{independentAnalyteOfInterest}{independent analyte in pair}

\item{outcomeAnalyteOfInterest}{outcome analyte in pair}

\item{continuous}{whether or not the outcome is continuous (TRUE or FALSE)}

\item{outcome}{'1' or '2' must be set as outcome/independent variable}

\item{independentVariable}{'1' or '2' must be set as outcome/independent variable}
}
\value{
dataframe for further analysis
}
\description{
Creates a dataframe of the marginal effect of phenotype
}
