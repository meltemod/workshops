### save Hollywood film music as .txt file 
# downloaded dataset from https://sites.google.com/site/ucinetsoftware/datasets/hollywood-film-music
# on Oct 24 2021


library(network)


bucket = "/Users/meltemodabas/github/meltemod/workshops/SNA/01-data-structure"
paj = read.paj(file.path(bucket,"data/Hi-tech.paj"))

paj_network = paj$networks$`Hi-tech.net`

#Get sociommatrix and save
M = as.sociomatrix(paj_network)
dim(M)

write.table(M,file=file.path(bucket,"data","Hi-tech_sociomatrix.txt"))


# list.network.attributes(paj_network)
# list.vertex.attributes(paj_network)
# list.edge.attributes(paj_network)

#get vertex attr data and save
vcount = get.network.attribute(paj_network, "n")
vnames = c(1:vcount)
vlabels = get.vertex.attribute(paj_network, "vertex.names")
union_support = paj$partitions[,1]
union_support_text = rep("no support", length(union_support))
union_support_text[union_support==1] = "support"
union_support_text[union_support==2] = "oppose"
union_support_text[union_support==3] = "oppose + top manager"

df_vattr = tibble(labels = vlabels, 
                  union_support = union_support, union_support_text = union_support_text)
write_csv(df_vattr, file = file.path(bucket,"data","Hi-tech_vertex_attributes.csv"))

#get edgelist and save
tmp = tibble(names = vnames, labels = vlabels)
df_edgelist = as.edgelist(paj_network,output = "tibble")
df_edgelist = merge(df_edgelist, tmp, by.x = ".tail", by.y = "names", all = FALSE)
df_edgelist = df_edgelist %>% rename(from = labels)
df_edgelist = merge(df_edgelist, tmp, by.x = ".head", by.y = "names", all = FALSE)
df_edgelist = df_edgelist %>% rename(to = labels)
df_edgelist = df_edgelist %>% select(from,to)

write_csv(df_edgelist, file = file.path(bucket,"data","Hi-tech_edgelist.csv"))


