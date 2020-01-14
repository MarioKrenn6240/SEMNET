import numpy as np

def collaps_network(network_T_full,nn_full,all_KW_full):
    # ToDo: collaps_synonyms.py - combining synonyms

    degree=sum(np.heaviside(nn_full,0))

    orig_size=len(network_T_full)

    # Remove keywords that have never been used
    ii=0
    network_T_s1=network_T_full[0,:]
    nn_s1=nn_full[0,:]
    while ii<orig_size:
        if ii%500==0:
            print('collaps_network: Progress (vertical): ',ii, '/', orig_size,'(', len(network_T_s1),')')
        if degree[ii]>0:
            network_T_s1=np.vstack([network_T_s1, network_T_full[ii,:]])
            nn_s1=np.vstack([nn_s1, nn_full[ii,:]])
        ii+=1
    network_T_s1=network_T_s1[1:,:]
    nn_s1=nn_s1[1:,:]
    
    network_T_s1=network_T_s1.transpose()
    nn_s1=nn_s1.transpose()
    
    ii=0
    network_T_s2=network_T_s1[0,:]
    nn_s2=nn_s1[0,:]
    all_KW_s2=[]
    while ii<orig_size:
        if ii%500==0:
            print('collaps_network: Progress (horizontal): ',ii, '/', orig_size,'(', len(network_T_s2),')')
        if degree[ii]>0:
            network_T_s2=np.vstack([network_T_s2, network_T_s1[ii,:]])
            nn_s2=np.vstack([nn_s2, nn_s1[ii,:]])
            all_KW_s2.append(all_KW_full[ii])
        ii+=1
    network_T_s2=network_T_s2[1:,:]
    nn_s2=nn_s2[1:,:]
    
    return network_T_s2, nn_s2, all_KW_s2
    