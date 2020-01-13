import sys

sys.path.append('1aCreateFullArticleData')
sys.path.append('1bCreateFullArticleData_APS')
sys.path.append('2CreateNetwork')

from create_full_article_data import create_full_data_arxiv
from create_full_article_data_APS import create_full_data_APS
from create_network import create_network

full_data_arxiv=create_full_data_arxiv()
full_data_APS=create_full_data_APS()
all_papers=full_data_arxiv+full_data_APS

create_network(all_papers)