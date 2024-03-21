library(igraph)
g <- graph.full(nrow(dist.au))
V(g)$label <- city.names
layout <- layout_with_mds(g, dist = as.matrix(dist.au))
plot(g, layout = layout, vertex.size = 3)

