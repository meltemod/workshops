### save Joe Galaskiewicz's CEO network data (from network package) as .txt file 
# downloaded datasert from https://networkdata.ics.uci.edu/netdata/html/ceos.html
# on Oct 24 2021

bucket = "/Users/meltemodabas/github/meltemod/workshops/SNA/01-data-structure"
load(file.path(bucket,"data/galaskie_ceos.rdata"))

library(network)

#Get sociommatrix and save
M = as.sociomatrix(CEOs)
write.table(M,file=file.path(bucket,"data","galaskie_ceos_sociomatrix.txt"))

#to open the file, run:
# M = read.table("/Users/meltemodabas/github/meltemod/workshops/SNA/01-data-structure/data/galaskie_ceos_sociomatrix.txt",
#            header=TRUE,row.names=1)


# list.network.attributes(CEOs)
# list.vertex.attributes(CEOs)
# list.edge.attributes(CEOs)


#get vertex attr data and save
vcount = get.network.attribute(CEOs, "n")
vnames = c(1:vcount)
vlabels = get.vertex.attribute(CEOs, "vertex.names")
type = rep("ceo", length(vnames))
type[grepl("Club", vlabels)] = "club"

df_vattr = tibble(labels = vlabels, type = type)
write_csv(df_vattr, file = file.path(bucket,"data","galaskie_ceos_vertex_attributes.csv"))

#get edgelist and save
tmp = tibble(names = vnames, labels = vlabels)
df_edgelist = as.edgelist(CEOs,output = "tibble")
df_edgelist = merge(df_edgelist, tmp, by.x = ".tail", by.y = "names", all = FALSE)
df_edgelist = df_edgelist %>% rename(from = labels)
df_edgelist = merge(df_edgelist, tmp, by.x = ".head", by.y = "names", all = FALSE)
df_edgelist = df_edgelist %>% rename(to = labels)
df_edgelist = df_edgelist %>% select(from,to)



write_csv(df_edgelist, file = file.path(bucket,"data","galaskie_ceos_edgelist.csv"))



