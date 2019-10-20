setwd("/home/cnemri/Documents/JHU Data Science/Getting and Cleaning Data")

if (!requireNamespace("BiocManager", quietly = TRUE))
{install.packages("BiocManager");BiocManager::install("rhdf5")}

library("rhdf5")
created = h5createFile("example.h5")
created

created = h5createGroup("example.h5", "foo")
created = h5createGroup("example.h5", "baa")
created = h5createGroup("example.h5", "foo/foobaa")
h5ls("example.h5")

A = matrix(1:10, nr=5, nc= 2)
h5write(A, "example.h5", "foo/A")
B = array(seq(0.1, 2.0, by = 0.1), dim = c(5, 2, 2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5", "foo/foobaa/B")
h5ls("example.h5")

h5read("example.h5", "foo/foobaa/B")
h5write(c(1,2,3), "example.h5", "foo/foobaa/B", index = list(1:3,2,2))

h5read("example.h5", "foo/foobaa/B")