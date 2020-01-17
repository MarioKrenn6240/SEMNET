import os, json
from pathlib import Path

def create_full_data_APS():
    # Reads publication data from APS json files
    full_article_data_APS=[]
    aps_dir = Path('1bCreateFullArticleData_APS/APS-data')
    for newdir in aps_dir.iterdir():
        if newdir.is_dir():
            for dir_id in newdir.iterdir():
                if dir_id.is_dir():
                    for file_name in dir_id.iterdir():
                        if file_name.suffix == ".json":
                            with open(file_name, encoding="utf8") as json_file:
                                data = json.load(json_file)

                            date=data['date']
                            title=data['title']['value']
                            abstract=''
                            if 'abstract' in data.keys():
                                abstract=data['abstract']['value']

                            full_article_data_APS.append([date, title, abstract])
                  
    return full_article_data_APS
