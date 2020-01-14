import numpy as np
from numpy import dot
from numpy.linalg import norm
import networkx as nx

def distance_between_nodes(mat):
    G=nx.from_numpy_matrix(np.matrix(mat))
    dist=np.zeros(mat.shape)
    
    for ii in range(len(mat)-1):
        for jj in range(ii+1,len(mat)):
            try:
                curr_dist=nx.shortest_path_length(G, ii, jj) 
            except:
                curr_dist=10 # if not connected: some large number, in paper it was 2*max(dist)
                    
            dist[ii][jj]=curr_dist
            dist[jj][ii]=curr_dist
            
    return dist


def cos_similarity(mtx):    
    single_net=np.heaviside(mtx, 0.0)
    cos_sim=dot(single_net, single_net)/(norm(single_net)*norm(single_net))
    return cos_sim


def path_N(mtx,N):
    mult_mat=mtx
    for ii in range(1,N):
        mult_mat=dot(mult_mat, mtx)
    
    path_N_mtx=mult_mat/(norm(mtx)*norm(mtx))
    return path_N_mtx


def calculate_all_network_properties_per_year(single_net,single_netYM1,single_netYM2,evolving_nums):
    # we create 15 matrices of properties
    # numsA, numsB, degA, degB (those vectors need to be stored only once)
    # cosS, 
    # path2Y,path2YM1,path2YM2,path3Y,path3YM1,path3YM2,path4Y,path4YM1,path4YM2
    # distance (TODO: use two alternative distances)
    # Those properties have been used based on heuristic tests, probably there is a lot of room for improvements
    
    all_properties=[evolving_nums]
    
    degrees=np.count_nonzero(single_net,axis=0)
    all_properties.append(degrees)
    
    cos_sim = cos_similarity(single_net)
    all_properties.append(cos_sim)

    for curr_mat in [single_net,single_netYM1,single_netYM2]:
        for ii in range(2,5):
            all_properties.append(path_N(curr_mat,ii))
        
    dist_mtx=distance_between_nodes(single_net)
    all_properties.append(dist_mtx)
    
    return all_properties


def calculate_all_network_properties(evolving_nets,evolving_nums):
    all_properties_years=[]
    for ii in range(2,len(evolving_nets)):        
        current_all_properties=calculate_all_network_properties_per_year(evolving_nets[ii],evolving_nets[ii-1],evolving_nets[ii-2],evolving_nums)
        all_properties_years.append(current_all_properties)
    
    return all_properties_years
