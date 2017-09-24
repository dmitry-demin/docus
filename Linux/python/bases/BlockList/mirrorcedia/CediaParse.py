import requests
import os
from datetime import datetime

def main(url, url2):
    name = datetime.now().strftime("%Y-%m-%d_%H_%M") + '.csv'
    try:
        with open(name, 'wb') as file:
            req = requests.get(url, stream=True)
            for chunk in req.iter_content(1024):
                file.write(chunk)
            req = requests.get(url2)
            lines = req.text.split('\n')
            for line in lines:
                if line[0] == '#': continue
                file.write(line + '\n')
    except:
        pass

if(__name__ == '__main__'):
    url = 'https://mirror.cedia.org.ec/malwaredomains/justdomains'
    url2 = 'https://mirror.cedia.org.ec/malwaredomains/immortal_domains.txt'
    main(url, url2)
