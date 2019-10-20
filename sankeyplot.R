install.packages("networkD3")
library(networkD3)
library(dplyr)

links <- data.frame(
  source=c("group_A","group_A", "group_B", "group_C", "group_C", "group_E"), 
  target=c("group_C","group_D", "group_E", "group_F", "group_G", "group_H"), 
  value=c(2,3, 2, 3, 1, 3)
)

nodes <- data.frame(
  name=c(as.character(links$source), 
         as.character(links$target)) %>% unique()
)

links$IDsource <- match(links$source, nodes$name)-1 
links$IDtarget <- match(links$target, nodes$name)-1

p <- sankeyNetwork(Links = links, Nodes = nodes,
                   Source = "IDsource", Target = "IDtarget",
                   Value = "value", NodeID = "name", 
                   sinksRight=FALSE)

links <- data.frame(
  source = c("LeftoversSpring", "Coins", "Fees", "Fees", "Fees", "Fees", "Fees"),
  target = c("GEZ", "GEZ", "GEZ", "Cleaning", "Beverages","Pancakes", "LeftoversAutumn"),
  value = c(10, 38, 57, 230, 30, 15, 80)
)

nodes <- data.frame(
  name = c(as.character(links$source),
           as.character(links$target)) %>% unique()
)

links$IDsource <- match(links$source, nodes$name) - 1
links$IDtarget <- match(links$target, nodes$name) - 1

p <- sankeyNetwork(Links = links, Nodes = nodes,
                   Source = "IDsource", Target = "IDtarget",
                   Value = "value", NodeID = "name", 
                   sinksRight=FALSE, fontSize = 24)
p
