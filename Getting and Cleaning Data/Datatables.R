library(data.table)

# Defining the classical Data Frame
t0 <- Sys.time()

DF = data.frame(x=rnorm(9), y = rep(c('a','b','c'),each=3),z=rnorm(9))

t1 <- Sys.time()

# Defining Data Table
DT = data.table(x=rnorm(9), y = rep(c('a','b','c'),each=3),z=rnorm(9))

t2 <- Sys.time()

t1 - t0
t2 - t1

tables()