#!/bin/Rscript
args = commandArgs(trailingOnly=TRUE)

library(ggplot2)
library(cowplot)

# get output dir and rank from input arguments
output_dir <- args[1]
rank <- args[2]

# vector to fecth full rank
possible_ranks <- c("S" = "species", "G" = "genera", "F" = "family")

# fetch full rank
full_rank <- unname(possible_ranks["S"])

# create output dir if not present
if(!dir.exists(paste0(output_dir, "/accumulation_curves"))) {
  dir.create(paste0(output_dir, "/accumulation_curves"))
}

# list files 
files <- list.files(paste0(output_dir, "/plot_data/"), pattern = "*.txt")

# read files as a list
list_files <- lapply(files, function(x) read.table(paste0(output_dir, "/plot_data/", x) , col.names = c("i","read","kmer", "kraken")))

# set names
names(list_files) <- gsub(".txt","", files)

# add column for sample
list_files <- lapply(names(list_files), function(x) cbind(list_files[[x]], sample=x)  )

# rbind list
dat <- do.call(rbind, list_files)

# colour palette
pal <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

# create plot
if(length(list_files) <= 8){
 
  p1 <- ggplot(dat, aes(x=read, y=kmer, colour=sample)) + 
    geom_point() + 
    geom_smooth(method = "loess", formula = y~x, se = F) + 
    labs(x = "N reads", 
         y = "N kmers", 
         colour = "Sample",
         title = "Kmer accumulation curve") + 
    theme_classic() + 
    scale_color_manual(values = pal)
 
  p2 <- ggplot(dat, aes(x=read, y=kraken, colour=sample)) +
    geom_point() +
    geom_smooth(method = "loess", formula = y~x, se = F) +
    labs(x = "N reads",
         y = paste("N", full_rank),
         colour = "Sample",
         title = paste0("Kraken accumulation curve (", full_rank, ")")) +
    theme_classic() +
    scale_color_manual(values = pal)

} else { 

  p1 <- ggplot(dat, aes(x=read, y=kmer, colour=sample)) +
    geom_point() +
    geom_smooth(method = "loess", formula = y~x, se = F) +
    labs(x = "N reads",
         y = "N kmers",
         colour = "Sample",
         title = "Kmer accumulation curve") +
    theme_classic() 

  p2 <- ggplot(dat, aes(x=read, y=kraken, colour=sample)) +
    geom_point() +
    geom_smooth(method = "loess", formula = y~x, se = F) +
    labs(x = "N reads",
         y = paste("N", full_rank),
         colour = "Sample",
         title = paste0("Kraken accumulation curve (", full_rank, ")")) +
    theme_classic() 

}

# plot_grid
p <- plot_grid(plotlist = list(p1,p2), nrow=1, align='hv', axis='tblr') 

# create png
png(paste0(output_dir, "/accumulation_curves/plot.png"), height = 5, width = 12, units = "in", res = 600)
print(p)
dev.off()

