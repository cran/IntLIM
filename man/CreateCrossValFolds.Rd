% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/crossvalfunctions.R
\name{CreateCrossValFolds}
\alias{CreateCrossValFolds}
\title{Creates multiple cross-validation folds from the data. Format is a list of
IntLIMData training and testing pairs. The "training" slot contains all data
except that in the given fold, and the "testing" contains all data in the fold.}
\usage{
CreateCrossValFolds(inputData, folds)
}
\arguments{
\item{inputData}{IntLimData object (output of ReadData()) with analylte levels and
associated meta-data}

\item{folds}{number of folds to create}
}
\value{
A set of IntLimData training and testing sets, of the following format:
list(list("train" = IntLimData, "test" = IntLimData), ... list("train" = IntLimData,
"test" = IntLimData))

List of IntLimModel objects with model results
}
\description{
Creates multiple cross-validation folds from the data. Format is a list of
IntLIMData training and testing pairs. The "training" slot contains all data
except that in the given fold, and the "testing" contains all data in the fold.
}
