#' Process data for copynumber plot
#'
#' This class will hold your segments and sample information
#' @title CNVvault Class
#' @param Segments Dataframe of your segments.
#' @param SampleInfo Information on your clusters
#' @param Plot the plot of everything
#' @keywords Copynumber CNV
#' @export CNVvault
#' @examples
#' CNVvault()

CNVvault <- setClass("CNVvault", slots = c(Segments="data.frame",
                                           SampleInfo="list",
                                           Plot="list",
                                           NumberOfSamples="numeric",
                                           Chr_Starts="numeric",
                                           Chr_Sizes="numeric"))
