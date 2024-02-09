if (!require(tidyverse, quietly = TRUE)) {
  install.packages("tidyverse")}

library(tidyverse)



source("contig_length_function.R")


readFastaAndGetLengths("megahit_out/final.contigs.fa")


contig_len_df <- readFastaAndGetLengths("megahit_out/final.contigs.fa")


# Sort data frame by decreasing length, using order() function
contig_len_df_decreasing <- contig_len_df[order(-contig_len_df$Length), ]

# Plot using ggplot2
my_plot <- contig_len_df_decreasing %>% 
    filter(Length>10000) %>% 
  ggplot(aes(x = reorder(Contig, Length), y = Length)) +
  geom_col() +
  labs(x = "Contig", y = "Length (bp)", title = "Contig Length Distribution") +
  theme_minimal() +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) # Hide x-axis labels for clarity


ggsave("contig_len_10k.png", plot=my_plot, width = 6, height = 4, dpi = 300)

