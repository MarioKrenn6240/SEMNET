import os, json

def create_full_data_APS():
    full_article_data_APS=[]
    for newdir in os.listdir('1bCreateFullArticleData_APS\\APS-data'):
        for dir_id in os.listdir('1bCreateFullArticleData_APS\\APS-data\\'+newdir):
            for file in os.listdir('1bCreateFullArticleData_APS\\APS-data\\'+newdir+'\\'+dir_id):
                file_name='1bCreateFullArticleData_APS\\APS-data\\'+newdir+'\\'+dir_id+'\\'+file
                
                with open(file_name,encoding="utf8") as json_file:                
                    data = json.load(json_file)
                
                date=data['date']
                title=data['title']['value']
                abstract=''
                if 'abstract' in data.keys():
                    abstract=data['abstract']['value']
                
                full_article_data_APS.append([date, title, abstract])
                  
    return full_article_data_APS
