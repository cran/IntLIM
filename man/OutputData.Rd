% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/writingfunctions.R
\name{OutputData}
\alias{OutputData}
\title{Output data into individual CSV files.  All data will be zipped into one file with all data.}
\usage{
OutputData(inputData, filename = "")
}
\arguments{
\item{inputData}{data output from ReadData() or FilterData() function}

\item{filename}{name of file to be output (default: 'tempdir/output.zip')}
}
\value{
the filename of the CSV file with results named with cohort
}
\description{
Output data into individual CSV files.  All data will be zipped into one file with all data.
}
