#' Set the start and coords for the geom_rect
#'
#' This function will take a dataframe with sample, chr, start.pos, end.pos and call.
#' It will output a full plot of all the segments
#' @title setPositionsCNV
#' @param Copynumber Dataframe of your segments. REQUIRED
#' @param genome string. The geneome to download from UCSC. Default: hg19
#' @param FinalChrom string. The final chromosome to include in the plot. Default: chrX
#' @keywords Copynumber CNV
#' @export
#' @examples
#' setPositionsCNV(CNVvault_class)

getGenomeLengths <- function(ReturnClass, genome="hg19", FinalChrom="chrX") {
        ## This function will download the chromosome sizes from UCSC
        Chr_Sizes <- getChromInfoFromUCSC(genome)

        CutOff <- Chr_Sizes$chrom %>% grepl(paste(FinalChrom,"$", sep=""), .) %>% which()
        Chr_Sizes <- Chr_Sizes[1:CutOff,]
        if( "size" %in% colnames(Chr_Sizes)) {
                Chr_Sizes <- c(Chr_Sizes$size) %>% setNames(Chr_Sizes$chrom)
        } else if ( "length" %in% colnames(Chr_Sizes)) {
                Chr_Sizes <- c(Chr_Sizes$length) %>% setNames(Chr_Sizes$chrom)
        } else {
                Chr_Sizes <- c(Chr_Sizes[,2] %>% unlist()) %>% setNames(Chr_Sizes$chrom)
        }
        Chr_Sizes
}
