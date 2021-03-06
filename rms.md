**title: "Rms_analysis"**  
**author: "Artemis Louyakis and Matthew Fullmer"**  
**date: "11/28/2018"**  
**output: html_notebook**

##### R packages used 
```{r}
library(ape)
library(ggtree)
library(phangorn)
library(phytools)
library(plotly)
library(heatmaply)
library(dendextend)
library(vegan)
library(corrgram)
library(Hmisc)
library(corrplot)
```

##### Input files for all analyses (individual chunks relist input files for that plot)
```{r}
tree_rooted <- read.newick("input_files/ConcatAlnRooted.tre")
matrix_file <- read.table(file = "input_files/PresAbsSummary.txt", 
                          header = TRUE, row.names = 1, stringsAsFactors = FALSE, sep = "\t")
order_mat <- read.table(file = "input_files/reorder.txt", header = TRUE, row.names = 1, 
                        stringsAsFactors = FALSE, sep = "\t")
counts <- read.delim("input_files/cHGperGenome.txt")
pan_matrix <- read.table(file = "input_files/PresAbsMatrixAnnot.txt", 
                         stringsAsFactors = TRUE, header = TRUE, row.names = 1, sep = "\t")

### uniprot_arcog.txt mined from www.uniprot.org and includes various annotations
arcog_plus <- read.delim("input_files/uniprot_arcog.txt", header=TRUE, row.names = NULL, com='', check.names=F)
```

##### Build heatmap with phylogenetic tree attached
```{r}
tree_rooted <- read.newick("input_files/ConcatAlnRooted.tre")
matrix_file <- read.table(file = "input_files/PresAbsSummary.txt", 
                          header = TRUE, row.names = 1, stringsAsFactors = FALSE, sep = "\t")
order_mat <- read.table(file = "input_files/reorder.txt", header = TRUE, row.names = 1, 
                        stringsAsFactors = FALSE, sep = "\t")

intermediate_tree <- ggtree(tree_rooted, branch.length = T, ladderize = TRUE) + 
  geom_tiplab(size = 2.5, linetype = "dashed", linesize = 0.1, align = TRUE) + 
  geom_point2(aes(subset = as.numeric(label)>79 & !isTip), color = "firebrick", size = 1) + 
  geom_treescale(x = -0.01, y = -5, offset = 2.5) +
  theme(legend.position="none")
alpha <- gheatmap(intermediate_tree, matrix_file, offset = 0.7, width = 2.5, colnames = F) + 
  scale_fill_manual(values = c("lightgrey","black")) +
  theme(legend.position="none") +
  theme(text = element_text(size=20))
bet <- get_heatmap_column_position(alpha, by = "bottom")
top <- get_heatmap_column_position(alpha, by = "top")

alpha + 
  geom_text(data = bet, aes(x, y, label = label), nudge_y = -0.5, size = 2.5, color = "red", angle = 90)
ggsave("out_files/heattree.pdf", height = 20, width = 10, dpi = 300)

## optional interactive heatmap
x <- as.phylo(intermediate_tree)
x <- force.ultrametric(x, method = 'nnls')
row_dend  <- x %>% as.dendrogram 

heatmaply(order_mat, file = "out_files/heatmaply_plot.html", height = 1200, width = 400, fontsize_row = 4, 
          hide_colorbar = TRUE, dendrogram = 'row', Rowv = row_dend, margins = c(100,90))
```

##### Plot genomes per homologous group
```{r}
### genome counts in bar plot
counts <- read.delim("input_files/cHGperGenome.txt")
ggplot(data = counts, aes(x = reorder(alpha_hg, -No..of.Genomes), y = No..of.Genomes)) +
  geom_bar(stat = "identity", color="black", fill="steelblue") +
  theme_bw() +
  xlab("cHG") +
  ylab("No. of genomes") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  scale_y_continuous(expand = c(0,0), limits = c(0,180), breaks = seq(0,180, by = 30)) +
  theme(axis.text.x = element_text(angle = 90))
ggsave("out_files/cHGperGenome.pdf", width = 6, height = 6, dpi = 500)
```

##### Plot rarefaction curve
```{r}
pan_matrix <- read.table(file = "input_files/PresAbsMatrixAnnot.txt", 
                         stringsAsFactors = TRUE, header = TRUE, row.names = 1, sep = "\t")

t_pan_matrix <- t(pan_matrix)
t_sp <- specaccum(t_pan_matrix,method="random",permutations=100)

#pdf('out_files/rarefaction_plot.pdf', width = 7, height = 7)	
par(las = 1)
plot(t_sp, ci.type = "poly", col = "blue",lwd = 2, ci.lty = 0, 
     ci.col = "lightblue", xlab = "Gene families", ylab= "No. of taxa")
boxplot(t_sp,col = "yellow", add = TRUE)
```

##### Plot spearman correlations
```{r}
pan_matrix <- read.table(file = "input_files/PresAbsMatrixAnnot.txt", 
                         stringsAsFactors = TRUE, header = TRUE, row.names = 1, sep = "\t")

in_matrix <- as.matrix(pan_matrix)
spearman_rcorr <- rcorr(in_matrix, type = "spearman")
#write.table(spearman_rcorr$P, file = "out_files/spearman_p.txt", sep = "\t", row.names = TRUE, col.names = TRUE)
#write.table(spearman_rcorr$r, file = "out_files/spearman_r.txt", sep = "\t", row.names = TRUE, col.names = TRUE)

#### apply bonferroni correction for 48x48 pairwise comparisons
bonf_corr_p <- spearman_rcorr$P
spear_r <- spearman_rcorr$r
bonf_corr_p[is.na(bonf_corr_p)] <- 0
y <- function(x) ifelse(x*1128<1, x*1128, 1)
bonf_corr_p[] <- vapply(bonf_corr_p, y, numeric(1))
bonfer_matrix <- ifelse(bonf_corr_p<1, spear_r, 0)

#### output plot
#pdf("out_files/corrplot.pdf", height = 6, width = 6)
corrplot(bonfer_matrix, type = "lower", order = "FPC", tl.cex = 0.5, tl.srt = 30, tl.col = "black")
```
