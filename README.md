# PlotCNV
An R package to create a pretty Copy Number Variant plot from a segments file

### Disclaimer 
This is early development so let me know if anyone finds this, likes it, or wants changes let me know!

## Installation

PlotCNV was written on R 3.6.1 and I've no idea if it works on older versions, but I've no reason to assume it won't.

### Dependancies

It'll load/install ggplot2, GenomicFeatures and magrittr

### Get the package

As we're on github you'll need "install_github" from devtools.

```R
## If you don't already have devtools installed
BiocManager::install("devtools")
```
To install the package just use this:

```R
library(devtools)
install_github("findlaycopley/PlotCNV")
```

This will give you access to the wonderful world of PlotCNV ver 0.1.0

## Input

The package takes a dataframe of segments in long format.

It needs the following 5 columns:

chr
*(string/numeric value) Chromosome the segment is on. Doesn't need the chr prefix for all you cool ensembl cats (if it doesn't detect chr it'll add it with gsub). These do need to match the chromosomes as downloaded from UCSC i.e. chrOne won't work (and is horrific, please don't do this)  
sampleID
*(string) the sample the segment corresponds to
start.pos
*(numeric value) the first position of the structural variant
end.pos
*(numeric value) the last position of the structural variant
calls
*Gain, Loss, CN-LOH (This feature will be overhauled in a future version to accept anything, but is fixed currently to maintain the colours)

You can name the columns whatever you want, but if they're different to the above you need to pass this with the call to the following functions:

```R
prepareCNV(CNV, chr="chr", sampleID="sampleID", start.pos="start.pos", end.pos="end.pos", calls="calls")
RunCNV(CNV, chr="chr", sampleID="sampleID", start.pos="start.pos", end.pos="end.pos", calls="calls")
```

Currently the package will only use genomes on UCSC and will download the chromosome sizes. It will also automatically stop at chrX, but this can be extended (or reduced!) using the "FinalChrom" option. You can set the genome/version to use as follows:

```R
setPositionsCNV(CNV, genome="hg19", FinalChrom="X")
RunCNV(CNV, genome="hg19", FinalChrom="X")
```
I plan to add the option to set your own chromosome sizes in a future version for all you comrades who might want to use your own genome assemblies or have more control over the plot.

## Examples

You can generate a series of segments for hg19 like this:

```R
CNV <- generateTestData()
```

Or now, other genomes like this:

```R
CNV <- generateTestData(genome="mm10")
```

You can use any genome from UCSC

This will generate a dataframe to use in the package. This can be used as a guide to formatting your own data for use in this package.

chr | sampleID | start.pos | end.pos | calls
---|---|---|---|---
chr7 |	Sample1	| 100998668 |	110396599 |	Loss
chr16 |	Sample2	| 43859840 | 80317946 |	Gain
chr12	| Sample3 |	32271933 | 99088557 | CN-LOH
chr16 |	Sample4	| 58412150 | 88854473 | CN-LOH

You can then run the following steps to get the plot:

```R
## Makes sure all the columns are labelled in a way that the package understands
CNV <- prepareCNV(CNV, chr="chr", sampleID="sampleID", start.pos="start.pos", end.pos="end.pos", calls="calls")
## Orders the samples so they will plot in descending order of % variant bp
CNV <- orderCNV(CNV)
## Sets up the data values for the plot
CNV <- setPositionsCNV(CNV, genome="hg19", FinalChrom="X")
## Prints out the plot
CNV <- plotCopynumber(CNV)
## You can access the plot object in the Plots slot like this:
CNV@Plot$plot
ggsave("TestPlot.png", width=10, height=3)
```
Here is the plot generated by the example data (I set the seed for the test data generator so yours should look identical).

![example of plot](https://github.com/findlaycopley/PlotCNV/blob/master/TestPlot.png)

You can run the whole thing with just one line too:

```R
CNV <- RunCNV(CNV)
```

### Other Genomes?

Using other genomes is now easy thanks to GenomicFeatures.

We download the chromosome lengths directly from UCSC.

We can also now select the chromosome to end our plot on. Take a look:

```R
CNV <- generateTestData(genome="mm10")
RunCNV(CNV, genome="mm10", FinalChrom="Y")
ggsave("mm10_Test_plot.png", width=10, height=3)
```

This leads to a graph like this:
![example mouse of plot](https://github.com/findlaycopley/PlotCNV/blob/master/mm10_Test_plot.png)
