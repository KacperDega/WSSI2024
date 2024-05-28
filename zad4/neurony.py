import numpy as np
import networkx as nx
import matplotlib.pyplot as plt

class Neuron:  
    def __init__(self, n_inputs, bias = 0., weights = None):  
        self.b = bias
        if weights: self.ws = np.array(weights)
        else: self.ws = np.random.rand(n_inputs)

    def _f(self, x): #activation function (here: leaky_relu)
        return max(x*.1, x)   

    def __call__(self, xs): #calculate the neuron's output: multiply the inputs with the weights and sum the values together, add the bias value,
                            # then transform the value via an activation function
        return self._f(xs @ self.ws + self.b) 
  

class Network:
    def __init__(self):
        self.hidden1_neurons = [Neuron(3) for _ in range(4)]
        self.hidden2_neurons = [Neuron(4) for _ in range(4)]
        self.output_neuron = Neuron(4)

    def __call__(self, xs):
        hidden1_outputs = [neuron(xs) for neuron in self.hidden1_neurons]
        hidden2_outputs = [neuron(hidden1_outputs) for neuron in self.hidden2_neurons]
        return self.output_neuron(hidden2_outputs)

    def draw_graph(self):
        
        input_size = 3 
        hidden_size_1 = 4 
        hidden_size_2 = 4 
        output_size = 1 

        G = nx.DiGraph()

        for i in range(input_size):
            G.add_node(f'x{i}', label=f'x{i}', pos=(0, -0.5-i+input_size/2))

        for i in range(hidden_size_1):
            G.add_node(f'h1_{i}', label=f'h1_{i}', pos=(1, -0.5-i+hidden_size_1/2))

        for i in range(hidden_size_2):
            G.add_node(f'h2_{i}', label=f'h2_{i}', pos=(2, -0.5-i+hidden_size_2/2))

        for i in range(output_size):
            G.add_node(f'y{i}', label=f'y{i}', pos=(3, -0.5-i+output_size/2))


        for i in range(input_size):
            for j in range(hidden_size_1):
                G.add_edge(f'x{i}', f'h1_{j}')

        for i in range(hidden_size_1):
            for j in range(hidden_size_2):
                G.add_edge(f'h1_{i}', f'h2_{j}')

        for i in range(hidden_size_2):
            for j in range(output_size):
                G.add_edge(f'h2_{i}', f'y{j}')


        pos = nx.get_node_attributes(G, 'pos') 
        labels = nx.get_node_attributes(G, 'label')
        weights = nx.get_edge_attributes(G, 'weight') 

        nx.draw(G, pos, node_size=1000, node_color='skyblue', edge_color='black', with_labels=False, labels=labels)
        nx.draw_networkx_edge_labels(G, pos, edge_labels=weights)

        plt.axis('off')
        plt.show()
        
network = Network()
network.draw_graph()
