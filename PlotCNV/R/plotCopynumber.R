#' Print Genome wide copynumber plot
#'
#' This function will take a dataframe with sample, chr, start.pos, end.pos and call.
#' It will output a full plot of all the segments
#' @title plotCopynumber
#' @param ReturnClass Class of type CNV. REQUIRED
#' @keywords Copynumber CNV
#' @export
#' @examples
#' Plot_Copynumber(CNVvault_Object)

plotCopynumber <- function(ReturnClass, genome="hg19") {

        ReturnClass@Plot$plot <- ggplot(ReturnClass@Segments, aes(xmin=start, xmax=end, ymin=Ystart, ymax=Yend, fill=calls)) +
                geom_rect() +
                ## Draw lines between the chromosomes
                geom_vline(xintercept = ReturnClass@Chr_Starts,
                           colour="grey",
                           alpha=0.25) +
                ## draw lines between the samples
                geom_hline(yintercept = 0:ReturnClass@NumberOfSamples,
                           colour="grey",
                           alpha=0.25) +
                ## Start x at 0. break halfway through each chromosome (this means the label is centered)
                 scale_x_continuous(expand = c(0, 0),
                                    breaks = ReturnClass@Chr_Starts[-length(ReturnClass@Chr_Starts)] +
                                            (ReturnClass@Chr_Sizes/2),
                                    ## set the labels to the chr names
                                    labels = gsub("chr","",
                                                  names(ReturnClass@Chr_Starts[-length(ReturnClass@Chr_Starts)]))) +
                ## Break y between each sample
                scale_y_continuous(expand=c(0,0),
                                   breaks = 0.5:(ReturnClass@NumberOfSamples-0.5), labels=levels(ReturnClass@Segments$sampleID)) +
                ## set the colours for the calls and remove the name
                scale_fill_manual(name="",
                                  values=c("Gain"="#F8766D", "Loss"="#619CFF","CN-LOH"="#00BA38")) +
                ## Set axis labels
                labs(x="Chromosome", y="Sample") +
                theme_classic() +
                theme(axis.text.x = element_text(size=8,
                                                 face="bold"),
                      axis.text.y = element_text(size=10,
                                                 face="bold"),
                      axis.ticks = element_blank(),
                      legend.position = "top")
        print(ReturnClass@Plot$plot)
        ReturnClass
}
