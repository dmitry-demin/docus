import os
import requests
from bs4 import BeautifulSoup
from datetime import datetime

base_url = 'https://quttera.com/lists/malicious'
RESULT = []

def process(url):
    r = requests.get(url)
    if(r.url == base_url):
        return False
    get_mlwrurl(r.text)
    return True

def get_mlwrurl(html):
    soup = BeautifulSoup(html, 'html.parser')
    mlwr = soup.find_all('div', class_='alert alert-m')
    for ml in mlwr:
        ch = ml.text.split('\n')[1]
        RESULT.append(ch)

def savetofile():
    name = datetime.now().strftime("%Y-%m-%d_%H_%M") + '.csv'
    f = open(name, 'w')
    for line in RESULT:
        f.write(line + '\n')
    f.close()

def main():    
    url = 'https://quttera.com/lists/malicious?'
    page_part = 'page='
    page = 1
    isWorking = True
    while(isWorking):
        url_gen = url + page_part + str(page)
        isWorking = process(url_gen)
        os.system('cls')
        print('page_' + str(page) + '\n')
        print('load ' + str(len(RESULT)) +' items')
        page += 1
    savetofile()

if(__name__ == '__main__'):
    main()


