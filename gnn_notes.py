# CGNNs from scratch in numpy
# nodes in a graph send messages to eachother
# this simplifies to just one more matrix multiplication

# Data: Zachary's Karate Club
# Members of the Club and Social interactions between members 

# message passing between nodes is a fundamental concept:
# get the sum of each nodes neighbourhood features by multiplying the feature matrix
# by the adjacency matrix, which encodes all the connections in the graph
# "Graph Neighbourhood Mask" 
# original paper presents a normalized version of this matrix
# also adds identity matrix to add self connections 
# normalize connections by neighbourhood sizes 
# final equation scales each 1 in the adjacency matrix by the amount of connections per node

# if we do not have node features we can simply use the identity matrix as features
# which ultimately maps each node in the graph to a column of learnable parameters in the 
# first layer => fully learnable node embeddings

# GCN layer: 
# to instantiate a GCN layer we need only need to specify the desired number of input 
# and output features that construct our learnable parameter matrix w
# aswell as placeholders for an initialization scheme and activation function 

# Equation from the original paper: 
# A_hat * H_0 (input features) does the message passing 
# then we multiply by the learnable matrix w and apply a nonlinearity 

# self._X => message passing step with normalized adjacency matrix and input features X

# The GCNNetwork: 
# just chain multiple GCN layers for the amount of message passing steps required

# Limitation of GCN => each node has an equal contribution 
# Introduce additional weight params to scale contributions (GATs)

# Link prediction: p(A_ij) = sigmoid(scalar_prod(embedding_i, embedding_j))
# => we can then optimize for this via node embedding

# for our usecase specifically: 
# we may use BERT embeddings as feature vector for each word
# and then train a binary classifier: Connection yes/no.

# Can also do direct triplet classification with negative sampling at the cost of 
# enormous dataset sizes 
# in general sampling small subgraphs is enough for training
# with the small and sparse graphs available to us we 
# can train very quickly and perform inference even faster
# we can obtain multiple graphs per document as entire document is very sparse
# also very useful for other downstream tasks => knowledge graph completion, 
# graph embedding, node classification and clustering

# neighbourhood overlap and heuristics 
# for relex 
# https://proceedings.neurips.cc/paper/2021/file/71ddb91e8fa0541e426a54e538075a5a-Paper.pdf

# link prediction in sparse networks 
# https://arxiv.org/pdf/2011.07788.pdf

# further work:
