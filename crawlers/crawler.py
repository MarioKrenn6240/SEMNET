import os, glob, pickle
import matplotlib.pyplot as plt

os.chdir('arxivAbstractsXML')


str_title_start='<dc:title>'
str_title_end='</dc:title>'

str_abstract_start='<dc:description>'
str_abstract_end='</dc:description>'

str_date_start='<dc:date>'
str_date_end='</dc:date>'

str_creator_start='<dc:creator>'
str_creator_end='</dc:creator>'

str_id_start='<identifier>'
str_id_end='</identifier>'

str_cat_start='<dc:subject>'
str_cat_end='</dc:subject>'

all_titles=[]
all_abstracts=[]
all_dates=[]
all_creator=[]
all_cat=[]
all_id=[]

all_dirs_tmp=glob.glob("*")
start_idx=all_dirs_tmp.index('9401')
all_dirs=all_dirs_tmp[start_idx:]+all_dirs_tmp[0:start_idx]

paper_list=[]
for arxivdir in all_dirs:
    os.chdir(arxivdir)
    print(arxivdir,': ',len(glob.glob("*.xml")))

    yymm_titles=[]
    yymm_abstracts=[]
    yymm_dates=[]
    yymm_creator=[]
    yymm_cat=[]
    yymm_id=[]
    
    paper_list.append(len(glob.glob("*.xml")))

    for xmlfile in glob.glob("*.xml"):
        

        # Open a file: file
        file = open(xmlfile,mode='r')
        all_content = file.read()
        file.close()

        paper_title=all_content[all_content.find(str_title_start)+len(str_title_start):all_content.find(str_title_end)]
        paper_abstract=all_content[all_content.find(str_abstract_start)+len(str_abstract_start):all_content.find(str_abstract_end)]
        paper_date=all_content[all_content.find(str_date_start)+len(str_date_start):all_content.find(str_date_end)]
        paper_creator=all_content[all_content.find(str_creator_start)+len(str_creator_start):all_content.find(str_creator_end)]        
        paper_cat=all_content[all_content.find(str_cat_start)+len(str_cat_start):all_content.find(str_cat_end)]        
        paper_id=all_content[all_content.find(str_id_start)+len(str_id_start):all_content.find(str_id_end)]

        yymm_titles.append(paper_title)
        yymm_abstracts.append(paper_abstract)
        yymm_dates.append(paper_date)
        yymm_creator.append(paper_creator)
        yymm_cat.append(paper_cat)
        yymm_id.append(paper_id)

        #print(paper_title)
    
    all_titles=all_titles+yymm_titles
    all_abstracts=all_abstracts+yymm_abstracts
    all_dates=all_dates+yymm_dates
    all_creator=all_creator+yymm_creator
    all_cat=all_cat+yymm_cat
    all_id=all_id+yymm_id
    
    os.chdir('..')

os.chdir('..')
with open('arxiv_data_new.pkl', 'wb') as f:  
    pickle.dump([all_titles, all_abstracts, all_dates, all_creator, all_cat, all_id], f)

plt.plot(paper_list[0:-4])
plt.ylabel('#(papers)')
plt.xlabel('months since 1994')
plt.title('arXiv papers per month in ML+AI, since 1994')
plt.show()