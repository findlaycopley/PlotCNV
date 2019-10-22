# PlotCNV
An R package to create a pretty Copy Number Variant plot from a segments file

### Disclaimer 
This is early development so let me know if anyone finds this, likes it, or wants changes let me know!

## Installation

PlotCNV was written on R 3.6.1 and I've no idea if it works on older versions.

### Dependancies

It'll load/install ggplot2 and magrittr

### Get the package

As we're on github you'll need "install_github" from devtools.

```R
## If you don't already have devtools installed
BiocManager::install("devtools")
library(devtools)
install_github("findlaycopley/PlotCNV")
```

This will give you access to the wonderful world of PlotCNV ver 0.1.

## Examples

You can generate a series of segments for hg19 like this:

```R
CNV <- generateTestData()
```
You can then run the following steps to get the plot
```R
## Makes sure all the columns are labelled in a way that the package understands
CNV <- prepareCNV(CNV, chr="chr", sampleID="sampleID", start.pos="start.pos", end.pos="end.pos", calls="calls")
## Orders the samples so they will plot in descending order of % variant bp
CNV <- orderCNV(CNV)
## Sets up the data values for the plot
CNV <- setPositionsCNV(CNV, genome="hg19")
## Prints out the plot
CNV <- plotCopynumber(CNV)
## You can access the plot object in the Plots slot like this:
CNV@Plot$plot
```
![example of plot](https://github.com/findlaycopley/PlotCNV/blob/master/TestPlot.png)
