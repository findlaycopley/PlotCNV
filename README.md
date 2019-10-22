# PlotCNV
An R package to create a pretty Copy Number Variant plot from a segments file

### Disclaimer 
This is early development so let me know if anyone finds this, likes it, or wants changes let me know!

## Installation

PlotCNV was written on R 3.6.1 and I've no idea if it works on older versions.

### Dependancies

You'll need to have tidyverse installed which you should have already, come on it's ace. Who doesn't love piping in R?

If you don't have it, it should install when you load the package and it see you have poor taste.

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

Watch this space as I generate some data to include as an example.

Basically you pass the function RunCNV your segments and information about the columnheadings and it'll print out a genome wide copynumber plot for you.
