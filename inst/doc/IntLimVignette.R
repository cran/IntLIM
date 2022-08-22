## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
result_dir <- paste0(tempdir(), "\\IntLIM_vignette_results")
dir.create(result_dir)

## ----eval = FALSE-------------------------------------------------------------
#  if(!require("devtools")){
#    install.packages("devtools")
#  }
#  library("devtools")
#  install_github("ncats/IntLIM")

## -----------------------------------------------------------------------------
library(IntLIM)

## -----------------------------------------------------------------------------
dir <- system.file("extdata", package="IntLIM", mustWork=TRUE)
csvfile <- file.path(dir, "NCItestinput.csv")
csvfile

## -----------------------------------------------------------------------------
inputData <- IntLIM::ReadData(inputFile = csvfile,analyteType1id='id',analyteType2id='id',
                              class.feat = list(PBO_vs_Leukemia = "factor",
                                                drugscore = "numeric"))

## -----------------------------------------------------------------------------
IntLIM::ShowStats(IntLimObject = inputData)

## -----------------------------------------------------------------------------
inputDatafilt <- IntLIM::FilterData(inputData,
                                    analyteType1perc = 0.10, analyteType2perc = 0.10,
                                    analyteMiss = 0.80)

## -----------------------------------------------------------------------------
IntLIM::PlotDistributions(inputData = inputDatafilt)

## -----------------------------------------------------------------------------
IntLIM::PlotPCA(inputData = inputDatafilt,stype = "drugscore")
IntLIM::PlotPCA(inputData = inputDatafilt,stype = "PBO_vs_Leukemia")

## -----------------------------------------------------------------------------
myres.drugscore <- IntLIM::RunIntLim(inputData = inputDatafilt,stype="drugscore",
                              outcome = 1,
                              independent.var.type = 2,
                              save.covar.pvals = TRUE, continuous = TRUE)
myres.cancertype <- IntLIM::RunIntLim(inputData = inputDatafilt,stype="PBO_vs_Leukemia",
                              outcome = 1,
                              independent.var.type = 2,
                              save.covar.pvals = TRUE)

## -----------------------------------------------------------------------------
IntLIM::DistPvalues(IntLimResults = myres.drugscore, adjusted = FALSE)
IntLIM::DistPvalues(IntLimResults = myres.cancertype, adjusted = FALSE)

## -----------------------------------------------------------------------------
IntLIM::DistRSquared(IntLimResults = myres.drugscore)
IntLIM::DistRSquared(IntLimResults = myres.cancertype)

## -----------------------------------------------------------------------------
IntLIM::PValueBoxPlots(IntLimResults = myres.drugscore)
IntLIM::PValueBoxPlots(IntLimResults = myres.cancertype)

## -----------------------------------------------------------------------------
IntLIM::InteractionCoefficientGraph(inputResults = myres.drugscore,
                                    interactionCoeffPercentile = 0.9)
IntLIM::InteractionCoefficientGraph(inputResults = myres.cancertype,
                                    interactionCoeffPercentile = 0.9)

## -----------------------------------------------------------------------------
IntLIM::pvalCoefVolcano(inputResults = myres.drugscore, inputData = inputDatafilt,
                        pvalcutoff = 0.05)
IntLIM::pvalCoefVolcano(inputResults = myres.cancertype, inputData = inputDatafilt,
                        pvalcutoff = 0.05)

## -----------------------------------------------------------------------------
myres.sig.drugscore <- IntLIM::ProcessResults(inputResults = myres.drugscore,
                                       inputData = inputDatafilt,
                                       pvalcutoff = 0.10,
                                       rsquaredCutoff = 0.2,
                                       interactionCoeffPercentile = 0.5)
myres.sig.cancertype <- IntLIM::ProcessResults(inputResults = myres.cancertype,
                                       inputData = inputDatafilt,
                                       pvalcutoff = 0.10,
                                       rsquaredCutoff = 0.2,
                                       interactionCoeffPercentile = 0.5)

## -----------------------------------------------------------------------------
IntLIM::PlotPair(inputData = inputDatafilt,
                 inputResults = myres.drugscore,
                 outcome = 1,
                 independentVariable = 2,
                 outcomeAnalyteOfInterest = "(p-Hydroxyphenyl)lactic acid",
                 independentAnalyteOfInterest = "DLG4")

## -----------------------------------------------------------------------------
IntLIM::PlotPair(inputData = inputDatafilt,
                 inputResults = myres.cancertype,
                 outcome = 1,
                 independentVariable = 2,
                 outcomeAnalyteOfInterest = "(p-Hydroxyphenyl)lactic acid",
                 independentAnalyteOfInterest = "DLG4")

## -----------------------------------------------------------------------------
IntLIM::HistogramPairs(myres.sig.drugscore, type = "outcome")
IntLIM::HistogramPairs(myres.sig.drugscore, type = "independent")
IntLIM::HistogramPairs(myres.sig.cancertype, type = "outcome")
IntLIM::HistogramPairs(myres.sig.cancertype, type = "independent")

## ----eval = FALSE-------------------------------------------------------------
#  IntLIM::OutputData(inputData=inputDatafilt,filename=paste(result_dir,
#                                                           "FilteredData.zip", sep = "\\"))
#  IntLIM::OutputResults(inputResults=myres.sig.drugscore,filename=paste(result_dir,
#                                                                "MyResultsDrugscore.csv", sep = "\\"))
#  IntLIM::OutputResults(inputResults=myres.sig.cancertype,filename=paste(result_dir,
#                                                                "MyResultsCancertype.csv", sep = "\\"))

## -----------------------------------------------------------------------------
unlink(result_dir, recursive = TRUE)

## ----eval = FALSE-------------------------------------------------------------
#  crossValResults <- RunCrossValidation(inputData = inputData, analyteType1perc = 0.10,
#                     analyteType2perc = 0.10, analyteMiss = 0.80,
#                     stype="drugscore", outcome = c(1),
#                     independent.var.type = c(2), save.covar.pvals = TRUE,
#                     pvalcutoff = 0.10, rsquaredCutoff = 0.2,
#                     folds = 4, continuous = TRUE,
#                     interactionCoeffPercentile = 0.5)
#  IntLIM::PlotFoldOverlapUpSet(crossValResults$processed)

## ----eval = FALSE-------------------------------------------------------------
#  crossValResults <- RunCrossValidation(inputData = inputData, analyteType1perc = 0.10,
#                     analyteType2perc = 0.10, analyteMiss = 0.80,
#                     stype="PBO_vs_Leukemia", outcome = c(1),
#                     independent.var.type = c(2), save.covar.pvals = TRUE,
#                     pvalcutoff = 0.10, rsquaredCutoff = 0.2,
#                     folds = 4, interactionCoeffPercentile = 0.5)
#  IntLIM::PlotFoldOverlapUpSet(crossValResults$processed)

## ----eval = FALSE-------------------------------------------------------------
#  perm.res <- IntLIM::PermuteIntLIM(data = inputDatafilt, stype = "drugscore", outcome = 1,
#                        independent.var.type = 2, pvalcutoff = 0.10, interactionCoeffPercentile = 0.5,
#                     rsquaredCutoff = 0.2,
#                     num.permutations = 5, continuous = TRUE)
#  countSummary <- IntLIM::PermutationCountSummary(permResults = perm.res, inputResults = myres.sig.drugscore,
#                                plot = TRUE)
#  pairSummary <- IntLIM::PermutationPairSummary(permResults = perm.res, inputResults = myres.sig.drugscore,
#                                plot = TRUE)

## ----eval = FALSE-------------------------------------------------------------
#  perm.res <- IntLIM::PermuteIntLIM(data = inputDatafilt, stype = "PBO_vs_Leukemia", outcome = 1,
#                        independent.var.type = 2, pvalcutoff = 0.10, interactionCoeffPercentile = 0.5,
#                     rsquaredCutoff = 0.2,  num.permutations = 5)
#  countSummary <- IntLIM::PermutationCountSummary(permResults = perm.res, inputResults = myres.sig.cancertype,
#                                plot = TRUE)
#  pairSummary <- IntLIM::PermutationPairSummary(permResults = perm.res, inputResults = myres.sig.cancertype,
#                                plot = TRUE)

