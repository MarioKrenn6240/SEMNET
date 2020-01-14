import random
import numpy as np

def create_network(all_papers):    
    keyword_list = '2CreateNetwork\\keyword_list.lst'
    all_KW=[]
    with open(keyword_list) as fp:
       line = fp.readline()
       while line:
           all_KW.append(line[0:-1])
           line = fp.readline()

    all_KW=all_KW[0:2000] # this helps reducing the process for debugging...

    padding_str=''
    for ii in range(1000):
        padding_str=padding_str+' '

    line=[ [] for _ in range(5)]
    print('Creating Network Template')
    network_T=np.frompyfunc(list, 0, 1)(np.empty((len(all_KW),len(all_KW)), dtype=object))
    nn=np.zeros((len(all_KW),len(all_KW)))
    cc_papers=0
    for article in all_papers:
        # quasi-unique paper identifier:
        # this number between (0,1) will be added to the year in SemNet
        # such that one number carries both the year-info and the paper id
        paper_id=random.random()
        
        if cc_papers%10==0:
            print('Paper ',cc_papers,'/',len(all_papers))    
            print('Title: ',article[1])
       
        cc_papers+=1

        full_text=article[1]+' '+article[2]
        full_text=full_text.replace("'","")
        full_text=full_text.replace("--","-")
        full_text=full_text.replace("ö","oe")
        full_text=full_text.replace("ä","ae")
        full_text=full_text.replace("ü","ue")
        full_text=full_text.replace('{\"o}','oe')
        full_text=full_text.replace('\\','')
        full_text=full_text.lower()

        # ToDo: one can also remove brackets
        # such as "Greenberger-Horne-Zeilinger (GHZ) state", GHZ
        # Thus have two abstracts that can be disaminated

        found_KW=[]
        kw_idx=0
        for kw in all_KW:
            if full_text.find(kw)>=0:
                found_KW.append(kw_idx)            
                #   ToDo: padd this part of the text. in that way, other KWs dont use part of this KW anymore (idea is: this KW is more specific than smaller ones)   
                #   full_text.replace(kw,padding_str[0:len(kw)]) 
                #   However for this the KWs should be sorted by size
            kw_idx+=1

        found_KW=list(set(found_KW))

        for ii in range(len(found_KW)-1):
            for jj in range(ii+1,len(found_KW)):
                network_T[found_KW[ii],found_KW[jj]].append(int(article[0][0:4])+paper_id)
                network_T[found_KW[jj],found_KW[ii]].append(int(article[0][0:4])+paper_id)
                
                nn[found_KW[ii],found_KW[jj]]+=1
                nn[found_KW[jj],found_KW[ii]]+=1

    return network_T, nn, all_KW