### save medici network data (from network package) as .txt file 

bucket = "/Users/meltemodabas/github/meltemod/workshops/SNA/01-data-structure"
library(network)
flo = data(flo)
write.table(flo,file=file.path(bucket,"data","flo.txt"))

#to open the file, run:

# flo = read.table("/Users/meltemodabas/github/meltemod/workshops/SNA/01-data-structure/data/flo.txt",
#            header=TRUE,row.names=1)

