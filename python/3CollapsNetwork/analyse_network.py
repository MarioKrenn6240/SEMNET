import numpy as np

def collaps_synonyms(network_T_full,nn_full,all_KW_full):
    synonym_list = '3CollapsNetwork\\SynonymList.lst'
    all_syn=[[]]
    syn_count=0
    with open(synonym_list) as fp:
        line = fp.readline()
        while line:
            if line[0:-1]=='---':
                all_syn.append([])
                syn_count+=1
            else:
                all_syn[syn_count].append(line[0:-1])
            line = fp.readline()
    
    
    synonym_indices=[]
    for ii in range(len(all_syn)): # all classes of synonyms (e.g., ['bb84','bb84 protocol'])
        KW_idx=[]
        for jj in range(len(all_KW_full)): # all KWs
            for kk in range(len(all_syn[ii])): # over all synonym members, 'bb84','bb84 protocol' 
                if all_syn[ii][kk]==all_KW_full[jj]: # is any of the synonym members the KW?
                    KW_idx.append(jj)
        KW_idx.sort()
        synonym_indices.append(KW_idx)
    
    
    all_removed_kws=[]
    for ii in range(len(synonym_indices)):
        if len(synonym_indices[ii])>1:
            curr_syn_idx=synonym_indices[ii]
            prime_idx=curr_syn_idx[0]
            for jj in range(1,len(curr_syn_idx)):            
                all_removed_kws.append(curr_syn_idx[jj])
                for kk in range(len(network_T_full)):
                    network_T_full[prime_idx,kk]+=network_T_full[curr_syn_idx[jj],kk]
                    network_T_full[kk,prime_idx]+=network_T_full[curr_syn_idx[jj],kk]
    
                    nn_full[prime_idx,kk]+=nn_full[curr_syn_idx[jj],kk]
                    nn_full[kk,prime_idx]+=nn_full[kk,curr_syn_idx[jj]]
                    
    all_removed_kws.sort(reverse=True)
    
    # all_removed_kws are KWs that we will delete, because they are
    # synonyms with other words, and we store their information
    network_T_full=np.delete(network_T_full,all_removed_kws,axis=0)
    network_T_full=np.delete(network_T_full,all_removed_kws,axis=1)
    nn_full=np.delete(nn_full,all_removed_kws,axis=0)
    nn_full=np.delete(nn_full,all_removed_kws,axis=1)
    
    for ii in all_removed_kws:
        del all_KW_full[ii]
        
        
    return network_T_full,nn_full,all_KW_full
            

def collaps_network(network_T_full,nn_full,all_KW_full):
    # Remove keywords that are synonyms, but keep their information
    network_T_full,nn_full,all_KW_full=collaps_synonyms(network_T_full,nn_full,all_KW_full)
    print('collaps_network - Finished collapsing synonyms')

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