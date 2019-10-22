#' Process data for copynumber plot
#'
#' This function will take a dataframe with sample, chr, start.pos, end.pos and call.
#' It will create the sample info dataframe and set ordering for the samples
#' @title orderCNV
#' @param ReturnClass Class of type CNVvault created using prepareCNV. REQUIRED
#' @param descending sets the direction of the ordering. Default: TRUE
#' @keywords Copynumber CNV
#' @export
#' @examples
#' orderCNV(CNVvault_object)

orderCNV <- function(ReturnClass, descending=TRUE) {
        ## Order Samples by total bp altered.
        ## Get bp size of variant
        ReturnClass@Segments$CNV_size <- ReturnClass@Segments$end.pos - ReturnClass@Segments$start.pos
        ## Sum the bp for each sample
        ReturnClass@SampleInfo <- aggregate(ReturnClass@Segments$CNV_size, by=list(ReturnClass@Segments$sampleID), sum)
        ## Order the CNV_Order data by this sum.
        ReturnClass@SampleInfo <- ReturnClass@SampleInfo[order(ReturnClass@SampleInfo$x),]
        ## Set the heights for each sample on the y axis.
        ## As the samples are ordered this just numerically assigns the y axis position from 0-the number of samples
        ReturnClass@SampleInfo$Ystart <- 0:(length(ReturnClass@SampleInfo$x)-1)
        ReturnClass@SampleInfo$Yend <- 1:length(ReturnClass@SampleInfo$x)

        rownames(ReturnClass@SampleInfo) <-  ReturnClass@SampleInfo$Group.1
        ## Changes the factor levels to fit with the order
        ReturnClass@Segments$sampleID <- factor(ReturnClass@Segments$sampleID,
                                                levels=ReturnClass@SampleInfo$Group.1)
        ## Set the number of samples
        ReturnClass@NumberOfSamples <- length(ReturnClass@SampleInfo$Group.1)
        ## Return the class
        ReturnClass
}
