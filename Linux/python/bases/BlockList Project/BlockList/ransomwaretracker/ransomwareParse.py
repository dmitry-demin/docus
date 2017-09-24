import requests
import os
from datetime import datetime

def main(url):
    name = datetime.now().strftime("%Y-%m-%d_%H_%M") + '.csv'
    file = open(name, 'w')
    try:
        req = requests.get(url)
        lines = req.text.split('\n')
        for line in lines:
            if len(line) > 15: continue
            row = line.split('.')
            if(len(row) == 4):
                file.write(line + '\n')
    except:
        pass
    file.close()

if(__name__ == '__main__'):
    url = 'http://ransomwaretracker.abuse.ch/downloads/RW_IPBL.txt'
    main(url)
