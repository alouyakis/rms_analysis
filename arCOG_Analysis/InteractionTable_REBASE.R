library(igraph)
library(Matrix)


edge_list <- as.matrix(read.table(file = "Prot_orfs/arCOGs_analyzed/CompRMS/InteractionTable/InteractionTable_REBASE.txt",header = FALSE))
HG_network <- graph_from_edgelist(edge_list,directed = FALSE)
HG_components <- components(HG_network)
write.table(HG_components$membership, file = "Prot_orfs/arCOGs_analyzed/CompRMS/InteractionTable/REBASE_Componenets.components",quote=FALSE,sep = "\t",col.names = FALSE)
