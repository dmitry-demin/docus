import requests
import os
from datetime import datetime

def main(url):
    name = datetime.now().strftime("%Y-%m-%d_%H_%M") + '.csv'
    try:
        with open(name, 'w') as file:
            req = requests.get(url)
            lines = req.text.split('\n')
            for line in lines:    
                if line[0] == '#': continue
                file.write(line + '\n')
    except:
        pass

if(__name__ == '__main__'):
    url = 'https://ransomwaretracker.abuse.ch/downloads/RW_URLBL.txt'
    main(url)

