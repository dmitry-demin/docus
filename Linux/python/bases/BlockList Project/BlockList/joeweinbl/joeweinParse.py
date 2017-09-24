import requests
import os
from datetime import datetime

def main(url):
    name = datetime.now().strftime("%Y-%m-%d_%H_%M") + '.csv'
    try:
        with open(name, 'wb') as file:
            req = requests.get(url, stream=True)
            for chunk in req.iter_content(1024):
                file.write(chunk)
    except:
        pass

if(__name__ == '__main__'):
    url = 'http://www.joewein.net/dl/bl/dom-bl.txt'
    main(url)

