library(tidyverse)
library(DT)
library(shinydashboard)
library(shinyFiles)
library(shinyjs)
library(shinymanager)
library(reactR)
library(listviewer)
library(rjson)
library(shinythemes)

INDEX_COL <- "Sample Name"
EXP_COL <- "Experiment Name"
THEIA_CONFIG <- read_csv("metadata-config.csv")
QC_METRICS_TABLE <- read_csv("metadata-config-qc_metrics.csv")

QC_TABLE_LIST <-  c(
  INDEX_COL,
  EXP_COL,
  "pipeline",
  "STAR.star.version",
  "STAR.species (genome)",
  "STAR.readLength",
  QC_METRICS_TABLE$Field
)
