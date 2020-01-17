#########
# Predicting Research Trends with Semantic and Neural Networks with an application in Quantum Physics
# Mario Krenn, Anton Zeilinger
# https://arxiv.org/abs/1906.06843 (in PNAS)
#
# This file is the navigator for creating a semantic network from data,
# and using it for predicting future research trends using artificial
# neural networks.
# 
# The code is far from clean, but should give the principle idea.
# If you have any questions, dont hasitate to contact me:
# mario.krenn@univie.ac.at / mariokrenn.wordpress.com
#
#
#
# Mario Krenn, Toronto, Canada, 14.01.2020
#
#########

import sys

print('Start building semantic network for Quantum Physics')
sys.path.append('1aCreateFullArticleData')
sys.path.append('1bCreateFullArticleData_APS')
sys.path.append('2CreateNetwork')
sys.path.append('3CollapsNetwork')
sys.path.append('4CalculateAncientNetworks')
sys.path.append('5PrepareNNData')
sys.path.append('6TrainNN')

from create_full_article_data import create_full_data_arxiv
from create_full_article_data_APS import create_full_data_APS
from create_network import create_network
from analyse_network import collaps_network
from prepare_ancient_semnets import create_ancient_networks
from calc_properties import calculate_all_network_properties
from prepare_training_data import prepare_training_data
from train_nn import train_nn
print('Environment OK, start reading arXiv data.')
full_data_arxiv=create_full_data_arxiv()
print('Finished reading files from arXiv. Start reading APS data.')

full_data_APS=create_full_data_APS()
all_papers=full_data_arxiv+full_data_APS
print('Finished reading files from APS. Start creating initial semantic network')

network_T_full,nn_full,all_KW_full=create_network(all_papers)
print('Finished creating first instance of semantic network')

network_T,nn,all_KW=collaps_network(network_T_full,nn_full,all_KW_full)

print('Finished collapsing network (synonyms, empty KWs, ...). Start creating ancient networks.')

start_year=2005
end_year=2018
all_KW,evolving_nets,evolving_nums=create_ancient_networks(network_T,nn,all_KW,start_year,end_year)
print('Finished creating ancient networks')

all_properties=calculate_all_network_properties(evolving_nets,evolving_nums)
print('Finished calculating network properties for all ancient networks')

prediction_distance=5 # how many years into the future are we predicting
all_data_0, all_data_1=prepare_training_data(evolving_nets,all_properties,prediction_distance,start_year)
print('Finished preparing training data for neural network')

train_nn(all_data_0, all_data_1, prediction_distance, start_year) # Here we train the neural network, and calculate the ROC & AUC
print('Finished training neural networks')

