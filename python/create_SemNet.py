import sys

sys.path.append('1aCreateFullArticleData')
sys.path.append('1bCreateFullArticleData_APS')
sys.path.append('2CreateNetwork')
sys.path.append('3CollapsNetwork')
sys.path.append('4CalculateAncientNetworks')
sys.path.append('5PrepareNNData')

from create_full_article_data import create_full_data_arxiv
from create_full_article_data_APS import create_full_data_APS
from create_network import create_network
from analyse_network import collaps_network
from prepare_ancient_semnets import create_ancient_networks
from calc_properties import calculate_all_network_properties
from prepare_training_data import prepare_training_data

full_data_arxiv=create_full_data_arxiv()
full_data_APS=create_full_data_APS()
all_papers=full_data_arxiv+full_data_APS

network_T_full,nn_full,all_KW_full=create_network(all_papers)

network_T,nn,all_KW=collaps_network(network_T_full,nn_full,all_KW_full)

start_year=2000
end_year=2017
all_KW,evolving_nets,evolving_nums=create_ancient_networks(network_T,nn,all_KW,start_year,end_year)

all_properties=calculate_all_network_properties(evolving_nets,evolving_nums)

prediction_distance=5 # how many years into the future are we predicting
all_data_0, all_data_1=prepare_training_data(evolving_nets,all_properties,prediction_distance,start_year)

# 6TrainNN) Train network, we will use PyTorch

# 7bCalcROC) Evaluate the Quality of the predictions using ROC and AUC
