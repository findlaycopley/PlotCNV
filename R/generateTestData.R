#' Generate some basic test data
#'
#' This script will generate some very basic test data to check thr script is running correctly
#' @name generateTestData
#' @title generateTestData
#' @keywords Copynumber CNV
#' @export
#' @examples
#' generateTestData()
#'
library(magrittr)
generateTestData <- function(){
        set.seed(19011990)
        ## These are my basic chr sizes for hg19
        Chr_Sizes <- c(chr1=249250621,chr2=243199373,chr3=198022430,chr4=191154276,chr5=180915260,chr6=171115067,
               chr7=159138663,chr8=146364022,chr9=141213431,chr10=135534747,chr11=135006516,chr12=133851895,
               chr13=115169878,chr14=107349540,chr15=102531392,chr16=90354753,chr17=81195210,chr18=78077248,
               chr19=59128983,chr20=63025520,chr21=48129895,chr22=51304566,chrX=155270560)
        ## Make some sample IDs
        sampleID <- c("Sample1","Sample2","Sample3","Sample4")
        ## Loop through the samples and generate some segments
        GeneratedData <- lapply(sampleID, function(x){
                ## Only grab 10 chromosomes. this is pretty basic and doesn't stop overlapping fragments
                ## This is because I am lazy
                ## The package can deal with this though
                chr <- names(Chr_Sizes[sample(1:23, 10, replace=TRUE)])
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
