import os
import requests
from bs4 import BeautifulSoup
from datetime import datetime

RESULT = []

def process(url):
    try:
        r = requests.get(url)
    except Exception:
        return False
    else:
        get_mlwrurl(r.text)
        return True

def get_mlwrurl(html):
    soup = BeautifulSoup(html, 'html.parser')
    mlwr = soup.find_all('tr')
    for ml in mlwr:
        rows = ml.find_all('td')
        if(len(rows) > 7):
            uuid = rows[0].text
            md5 = rows[2].text
            time = rows[7].text
            RESULT.append([uuid, md5, time])

def savetofile():
    name = datetime.now().strftime("%Y-%m-%d_%H_%M") + '.csv'
    f = open(name, 'w')
    for line in RESULT:
        f.write(line[0] +', '+ line[1] +', '+ line[2] + '\n')
    f.close()

def main():    
    url1 = 'http://panda.gtisc.gatech.edu/malrec/'
    url2 = 'http://giantpanda.gtisc.gatech.edu/malrec/'
    process(url1)     
    process(url2)
    savetofile()

if(__name__ == '__main__'):
    main()