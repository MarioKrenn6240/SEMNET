import random
import numpy as np
import time
from pathlib import Path

def create_network(all_papers):    
    keyword_list = Path('2CreateNetwork/keyword_list.lst')
    all_KW=[]
    KW_length=[]
    print('create_network - For debugging reasons, only 1500 KWs are used')
    time.sleep(3)
    with open(keyword_list) as fp:
        line = fp.readline()
        while line:
            if len(all_KW)<1500: # this helps reducing the time for debugging...
                all_KW.append(line[0:-1])
                KW_length.append(len(line[0:-1]))
            line = fp.readline()

    sorted_KW_idx=np.argsort(KW_length)[::-1] # indices of KWs from largest to smallest

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
        # such that one number carries both the year-info and the paper id in the for YYYY.IDIDID
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

        if full_text.find('(')>=0: # Remove brakets, for example: Clauser-Horne (CH) inequality, in a separate string. Thus have two abstracts that can be disaminated
            idx=full_text.find('(')+1
            new_full_text=full_text[0:idx-1]    
            bracket_count=1
            while idx<len(full_text):
                if bracket_count==0:
                    new_full_text+=full_text[idx]
                    
                if full_text[idx]=='(':
                    bracket_count+=1
                if full_text[idx]==')':
                    bracket_count-=1            
        
                idx+=1
                
            full_text=full_text+" "+new_full_text.replace('  ',' ')
        
        found_KW=[]
        kw_idx=0
        for kw_idx in sorted_KW_idx:
            if full_text.find(all_KW[kw_idx])>=0:
                found_KW.append(kw_idx)
                pos_of_kw=full_text.find(all_KW[kw_idx])
                full_text=full_text[0:pos_of_kw]+full_text[pos_of_kw+len(all_KW[kw_idx]):]
            kw_idx+=1

        found_KW=list(set(found_KW))

        for ii in range(len(found_KW)-1):
            for jj in range(ii+1,len(found_KW)):
                network_T[found_KW[ii],found_KW[jj]].append(int(article[0][0:4])+paper_id)
                network_T[found_KW[jj],found_KW[ii]].append(int(article[0][0:4])+paper_id)
                
                nn[found_KW[ii],found_KW[jj]]+=1
                nn[found_KW[jj],found_KW[ii]]+=1

    return network_T, nn, all_KW