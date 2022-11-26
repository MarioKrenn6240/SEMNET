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


def distance_between_nodes_weighted(mat):
    G=nx.from_numpy_matrix(np.matrix(mat))
    dist=np.zeros(mat.shape)
    
    for ii in range(len(mat)-1):
        for jj in range(ii+1,len(mat)):
            try:
                curr_dist=nx.dijkstra_path_length(G, ii, jj) 
            except:
                curr_dist=10 # some large number, in paper it was 2*max(dist)
                    
            dist[ii][jj]=curr_dist
            dist[jj][ii]=curr_dist
            
    return dist


def cos_similarity(mtx):    
    single_net=np.heaviside(mtx, 0.0)
    cos_sim=dot(single_net, single_net)/(
            norm(single_net, axis=1)@norm(single_net, axis=0)  # (n, n)
    )
    return cos_sim


def path_N(mtx,N):
    mult_mat=mtx
    for ii in range(1,N):
        mult_mat=dot(mult_mat, mtx)
    
    path_N_mtx=mult_mat/(norm(mtx)*norm(mtx))
    return path_N_mtx


def calculate_all_network_properties_per_year(single_net,single_netYM1,single_netYM2,evolving_nums):
    # we create 17 matrices of properties
    # numsA, numsB, degA, degB (those vectors need to be stored only once)
    # cosS, 
    # path2Y,path2YM1,path2YM2,path3Y,path3YM1,path3YM2,path4Y,path4YM1,path4YM2
    # distance, weighted_distance_1, weighted_distance_2
    # Those properties have been used based on heuristic tests, probably there is a lot of room for improvements
    
    all_properties=[]
    all_properties.append(np.array(evolving_nums))
    
    degrees=np.count_nonzero(single_net,axis=0)
    all_properties.append(degrees/max(degrees))
    
    cos_sim = cos_similarity(single_net)
    all_properties.append(cos_sim)

    for curr_mat in [single_net,single_netYM1,single_netYM2]:
        for ii in range(2,5):
            all_properties.append(path_N(curr_mat,ii))
        
    dist_mtx=distance_between_nodes(single_net)
    all_properties.append(dist_mtx)
    
    
    epsilon=10**(-4) # simple way to avoid runtime warning, div by zero (which has no consequence for result)
    w_mtx1=np.zeros(single_net.shape)
    w_mtx2=np.zeros(single_net.shape)
    for ii in range(len(single_net)):
        for jj in range(len(single_net)):
            w_mtx1[ii,jj]=degrees[ii]*degrees[jj]/(single_net[ii,jj]+epsilon)
            w_mtx2[ii,jj]=np.sqrt(degrees[ii]*degrees[jj])/(single_net[ii,jj]+epsilon)
    
    
    print('calculate_all_network_properties_per_year - calculating the weighted distances takes very long (deactivated for the moment)')
    if False:
        dist_mtx1=distance_between_nodes_weighted(w_mtx1)
        dist_mtx2=distance_between_nodes_weighted(w_mtx2)
    else:
        dist_mtx1=np.zeros(w_mtx1.shape)
        dist_mtx2=np.zeros(w_mtx1.shape)
        
    all_properties.append(dist_mtx1)    
    all_properties.append(dist_mtx2)   
    
    return all_properties



def calculate_all_network_properties(evolving_nets,evolving_nums):
    all_properties_years=[]
    for ii in range(2,len(evolving_nets)):  
        print('calculate_all_network_properties - ',ii,'/',len(evolving_nets))
        current_all_properties=calculate_all_network_properties_per_year(evolving_nets[ii],evolving_nets[ii-1],evolving_nets[ii-2],evolving_nums[ii])
        all_properties_years.append(current_all_properties)
    
    return all_properties_years
