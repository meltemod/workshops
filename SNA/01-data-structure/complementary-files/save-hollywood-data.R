### save Hollywood film music as .txt file 
# downloaded dataset from https://sites.google.com/site/ucinetsoftware/datasets/hollywood-film-music
# on Oct 24 2021


library(network)


bucket = "/Users/meltemodabas/github/meltemod/workshops/SNA/01-data-structure"
paj = read.paj(file.path(bucket,"data/Movies.paj"))

paj_network = paj$networks$`Movies.net [2-Mode]`

#Get sociommatrix and save
M = as.sociomatrix(paj_network)
dim(M)

M[M == 1] = get.edge.attribute(paj_network, "Movies.net [2-Mode]")
write.table(M,file=file.path(bucket,"data","hollywood_sociomatrix.txt"))


# list.network.attributes(paj_network)
# list.vertex.attributes(paj_network)
# list.edge.attributes(paj_network)

#get edgelist and save
df_edgelist = as.edgelist(paj_network,output = "tibble")
names(df_edgelist) = c("from","to")

df_edgelist$weight = get.edge.attribute(paj_network, "Movies.net [2-Mode]")
write_csv(df_edgelist, file = file.path(bucket,"data","hollywood_edgelist.csv"))


#get vertex attr data and save
vcount = get.network.attribute(paj_network, "n")
vnames = c(1:vcount)
vlabels = get.vertex.attribute(paj_network, "vertex.names")
top_composer = paj$partitions$Movies_top_composers.clu

df_vattr = tibble(names = vnames, labels = vlabels, top_composer = top_composer)
write_csv(df_vattr, file = file.path(bucket,"data","hollywood_vertex_attributes.csv"))

