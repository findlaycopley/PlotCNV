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

setPositionsCNV <- function(ReturnClass, genome="hg19", FinalChrom="chrX") {
        ## This function will download the chromosome sizes from UCSC
        Chr_Sizes <- getGenomeLengths(genome=genome, FinalChrom=FinalChrom)
        ## This works out the chromosome starts to correctly position them on the x axis.
        Chr_Starts <- lapply(1:length(Chr_Sizes), function(x) {
                sum(Chr_Sizes[1:x])
        }) %>% unlist() %>% c(0,.) %>% setNames(c(names(Chr_Sizes),"end"))
        ## Set start of the regions
        ReturnClass@Segments$start <- ReturnClass@Segments$start.pos
        ReturnClass@Segments$end <- ReturnClass@Segments$end.pos
        ## Setup x coords by adding the cumulative chromosome length to each start and end position.
        ## If not using the chr prefix add it to look over the chromosomes
        ## TODO make this better
        ifelse (! grepl("chr", ReturnClass@Segments$chr[1]), {
                print("not using chr")
                ReturnClass@Segments$start <- Chr_Starts[paste("chr",ReturnClass@Segments$chr,sep="")] + ReturnClass@Segments$start
                ReturnClass@Segments$end <- Chr_Starts[paste("chr",ReturnClass@Segments$chr,sep="")] + ReturnClass@Segments$end
        },{print("using chr")
                ReturnClass@Segments$start <- Chr_Starts[ReturnClass@Segments$chr %>% as.character()] + ReturnClass@Segments$start
                ReturnClass@Segments$end <- Chr_Starts[ReturnClass@Segments$chr %>% as.character()] + ReturnClass@Segments$end
                })
        ## Set sample heights
        ReturnClass@Segments$Ystart <- ReturnClass@SampleInfo[ReturnClass@Segments$sampleID,]$Ystart
        ReturnClass@Segments$Yend <- ReturnClass@SampleInfo[ReturnClass@Segments$sampleID,]$Yend
        ## Store Genome Coords
        ReturnClass@Chr_Starts <- Chr_Starts
        ReturnClass@Chr_Sizes <- Chr_Sizes
        ReturnClass
}
