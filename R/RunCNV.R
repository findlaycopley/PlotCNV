#' Run the whole pipeline start to finish
#' This function will take a dataframe with sample, chr, start.pos, end.pos and call.
#' It will create an instance of the CNVvault class
#' Then it will order this class based on the total amount of the geneome editted.
#' Then it will generate the positions for each sample on the y-axis
#' Then it will plot the output
#' @name RunCNV
#' @title RunCNV
#' @param Copynumber Dataframe of your segments. REQUIRED
#' @param genome The genome to use for plotting. Currently only works on hg19. Default: "hg19"
#' @param chr string: name of the column for the chromosome. Default: "chr"
#' @param start.pos string: name of the column for the start positions of the segments. Default: "start.pos"
#' @param end.pos string: name of the column for the end positions of the segments. Default: "end.pos"
#' @param calls string: name of the column for the SV type of the segments. Default: "calls"
#' @keywords Copynumber CNV
#' @export
#' @examples
#' CNV <- read.delim("your_segments_file.tsv")
#' RunCNV(CNV)
#' ## If you have differnet column names specify them when calling the function
#' RunCNV(CNV, chr="CHROM","start.pos" = "Start")
#'
#'
if (! require(tidyverse)) {print("requirement tidyverse is not met")
        install <- readline(prompt="Install the tidyverse package [Y/n]?")
        ifelse(install == "y" | install == "Y", BiocManager::install("tidyverse"),
               "package not installing")
        }

RunCNV <- function(Copynumber, genome="hg19", chr="chr",start.pos="start.pos",end.pos="end.pos", calls="calls") {
        ReturnClass <- prepareCNV(x, chr=chr, start.pos=start.pos, end.pos=end.pos, calls=calls)
        ReturnClass <- orderCNV(ReturnClass)
        ReturnClass <- setPositionsCNV(ReturnClass, genome)
        ReturnClass <- plotCopynumber(ReturnClass)
        ReturnClass
}
