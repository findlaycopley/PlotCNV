#' Generate some basic test data
#'
#' This script will generate some very basic test data to check thr script is running correctly
#' @name generateTestData
#' @title generateTestData
#' @param genome string. The geneome to download from UCSC. Default: hg19
#' @param FinalChrom string. The final chromosome to include in the plot. Default: chrX
#' @keywords Copynumber CNV
#' @export
#' @examples
#' generateTestData()
#'

generateTestData <- function(genome="hg19", FinalChrom="chrX", ...){
        set.seed(19011990)
        ## These are my basic chr sizes for hg19
        Chr_Sizes <- getGenomeLengths(genome=genome, FinalChrom=FinalChrom)
        ## Make some sample IDs
        sampleID <- c("Sample1","Sample2","Sample3","Sample4")
        ## Loop through the samples and generate some segments
        GeneratedData <- lapply(sampleID, function(x){
                ## Only grab 10 chromosomes. this is pretty basic and doesn't stop overlapping fragments
                ## This is because I am lazy
                ## The package can deal with this though
                chr <- names(Chr_Sizes[sample(1:length(Chr_Sizes), 10, replace=TRUE)])
                ## For each chromosome selected generate:
                ## start position,
                ## end position,
                ## call type
                sapply(chr, function(y) {
                        start.pos <- sample(1:Chr_Sizes[y], 1)
                        end.pos <- sample(start.pos:Chr_Sizes[y],1)
                        calls <- sample(c("Gain","Loss","CN-LOH"),1)
                        cbind(start.pos,end.pos, calls)
                        }) %>%
                        t() %>%
                        cbind(chr,rep(x,10),.) %>%
                        'colnames<-'(c("chr","sampleID","start.pos","end.pos","calls"))
                }) %>% do.call("rbind",.) %>% as.data.frame() }
