#' Process data for copynumber plot
#'
#' This function will take a dataframe with sample, chr, start.pos, end.pos and call.
#' It will create an instance of the CNVvault class
#' @title prepareCNV
#' @param Copynumber Dataframe of your segments. REQUIRED
#' @param genome string. The geneome to download from UCSC. Default: hg19
#' @param FinalChrom string. The final chromosome to include in the plot. Default: chrX
#' @param chr string: name of the column for the chromosome. Default: "chr"
#' @param sampleID string: name of the column for the sample IDs. Default: "sampleID"
#' @param start.pos string: name of the column for the start positions of the segments. Default: "start.pos"
#' @param end.pos string: name of the column for the end positions of the segments. Default: "end.pos"
#' @param calls string: name of the column for the SV type of the segments. Default: "calls"
#' @keywords Copynumber CNV
#' @export
#' @examples
#' prepareCNV()
#'
#'
prepareCNV <-
        function(Copynumber,
                 sampleID = "sampleID",
                 genome = "hg19",
                 chr = "chr",
                 start.pos = "start.pos",
                 end.pos = "end.pos",
                 calls = "calls",
                 ...) {
                Copynumber <- Copynumber[!duplicated(Copynumber), ]
                ## Create the instance with all the data from Copynumber
                ReturnClass <- CNVvault(Segments = Copynumber)
                ## Make sure the chromosome info is stored in a column called chr
                ReturnClass@Segments["chr"] <- Copynumber[chr]
                ## Make sure the call type info is stored in a column called calls
                ReturnClass@Segments["calls"] <- Copynumber[calls]
                ## Make sure the call type info is stored in a column called calls
                ReturnClass@Segments["sampleID"] <- Copynumber[sampleID]
                ## Make sure the start position info is stored in a column called start.pos
                ReturnClass@Segments["start.pos"] <- Copynumber[start.pos]
                ## Make sure the start position info is numeric
                ReturnClass@Segments["start.pos"] <-
                        ReturnClass@Segments$start.pos %>% unlist() %>% as.character() %>% as.numeric()
                ## Make sure the end position info is stored in a column called end.pos
                ReturnClass@Segments["end.pos"] <- Copynumber[end.pos]
                ## Make sure the end position info is numeric
                ReturnClass@Segments["end.pos"] <-
                        ReturnClass@Segments$end.pos %>% unlist() %>% as.character() %>% as.numeric()
                ## Return the class
                ReturnClass
        }
