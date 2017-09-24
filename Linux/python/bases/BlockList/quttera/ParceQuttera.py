import os
import requests
from bs4 import BeautifulSoup
from datetime import datetime

RESULT = []
baseUrl = 'https://quttera.com'

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
    mlwr = soup.find_all('div', class_='alert alert-m')
    for ml in mlwr:
        table_body = ml.find('tbody')
        rows = ml.find_all('td')
        domain = rows[1].text
        type = rows[3].text
        time = rows[5].text
        reportlink = baseUrl + rows[7].find('a').get('href')
        RESULT.append([domain, type, time, reportlink])

def savetofile():
    name = datetime.now().strftime("%Y-%m-%d_%H_%M") + '.csv'
    f = open(name, 'w')
    for line in RESULT:
        f.write(line[0] +', '+ line[1] +', '+ line[2] +', '+ line[3] + '\n')
    f.close()

def main():    
    url = 'https://quttera.com/lists/malicious?'
    page_part = 'page='
    page = 0
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


