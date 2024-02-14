## using list instead of rbind ->
# much much faster!


flist <- function(n) {
  res <- list()
  for (i in 1:n) {
    res[[length(res) + 1]] <- c(1, 2)
  }
  do.call(rbind, res)
}

a<- flist(9)
class(a)

b<- as.data.frame(a)
