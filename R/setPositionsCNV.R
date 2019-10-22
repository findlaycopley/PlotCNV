#' Set the start and coords for the geom_rect
#'
#' This function will take a dataframe with sample, chr, start.pos, end.pos and call.
#' It will output a full plot of all the segments
#' @title setPositionsCNV
#' @param Copynumber Dataframe of your segments. REQUIRED
#' @param genome The genome to use for plotting. Currently only works on hg19. Default: "hg19"
#' @keywords Copynumber CNV
#' @export
#' @examples
#' setPositionsCNV(CNVvault_class)

setPositionsCNV <- function(ReturnClass, genome="hg19") {
        ## These are for hg19
        ## Add hg38 as well as a way to automate downloading
        Chr_Sizes <- c(chr1=249250621,chr2=243199373,chr3=198022430,chr4=191154276,chr5=180915260,chr6=171115067,
                       chr7=159138663,chr8=146364022,chr9=141213431,chr10=135534747,chr11=135006516,chr12=133851895,
                       chr13=115169878,chr14=107349540,chr15=102531392,chr16=90354753,chr17=81195210,chr18=78077248,
                       chr19=59128983,chr20=63025520,chr21=48129895,chr22=51304566,chrX=155270560)
        Chr_Starts <- lapply(1:length(Chr_Sizes), function(x) {
                sum(Chr_Sizes[1:x])
        }) %>% unlist() %>% c(0,.) %>% setNames(c(names(Chr_Sizes),"end"))
        ## Set start of the regions
        ReturnClass@Segments$start <- ReturnClass@Segments$start.pos
        ReturnClass@Segments$end <- ReturnClass@Segments$end.pos
        ## Setup x coords by adding the cumulative chromosome length to each start and end position.
        ## If not using the chr prefix add it to look over the chromosomes
        ## TODO make this better
        ifelse (! grep("chr", ReturnClass@Segments$chr[1]), {
                print("not using chr")
                ReturnClass@Segments$start <- Chr_Starts[paste("chr",ReturnClass@Segments$chr,sep="")] + ReturnClass@Segments$start
                ReturnClass@Segments$end <- Chr_Starts[paste("chr",ReturnClass@Segments$chr,sep="")] + ReturnClass@Segments$end
        },{
                ReturnClass@Segments$start <- Chr_Starts[ReturnClass@Segments$chr] + ReturnClass@Segments$start
                ReturnClass@Segments$end <- Chr_Starts[ReturnClass@Segments$chr] + ReturnClass@Segments$end
                })
        ## Set sample heights
        ReturnClass@Segments$Ystart <- ReturnClass@SampleInfo[ReturnClass@Segments$sampleID,]$Ystart
        ReturnClass@Segments$Yend <- ReturnClass@SampleInfo[ReturnClass@Segments$sampleID,]$Yend
        ## Store Genome Coords
        ReturnClass@Chr_Starts <- Chr_Starts
        ReturnClass@Chr_Sizes <- Chr_Sizes
        ReturnClass
}
