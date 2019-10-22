# PlotCNV
An R package to create a pretty Copy Number Variant plot from a segments file

## Installation

PlotCNV was written on R 3.6.1 and I've no idea if it works on older versions.

### Dependancies

You'll need to have tidyverse installed which you should have already, come on it's ace. Who doesn't love piping in R?

If you don't have it, it should install when you load the package and it see you have poor taste.

```R
## If you don't already have devtools installed
BiocManager::install("devtools")
library(devtools)
install_github("findlaycopley/PlotCNV")
```
