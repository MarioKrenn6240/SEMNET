import numpy as np

def create_ancient_networks(network_T,nn,all_KW,y_start,y_end):
    ancient_nns=[]
    ancient_nums=[]
    
    # probably quite inefficient method
    for year in range(y_start,y_end+1):
        curr_nn=np.zeros(network_T.shape)
        all_id_coll=[]
        for ccx in range(len(network_T)):
            all_ids=[]
            for ccy in range(len(network_T)):
                curr_entry=network_T[ccx,ccy]
                count=0
                for ccn in range(len(curr_entry)):
                    # curr_entry[ccn] is a number in the form: YYYY.paper_id, see create_network()
                    if curr_entry[ccn]<year+1: 
                        count+=1
                        all_ids.append(curr_entry[ccn])
                curr_nn[ccx,ccy]=count
            all_id_coll.append(len(set(all_ids)))
        ancient_nns.append(curr_nn)
        ancient_nums.append(all_id_coll)
        
        print('create_ancient_networks: Finished year ', year)
        
    return(all_KW,ancient_nns,ancient_nums)
