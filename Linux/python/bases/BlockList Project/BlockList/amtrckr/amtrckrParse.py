import json
import requests
import os
from datetime import datetime

def main(url):
    name = datetime.now().strftime("%Y-%m-%d_%H_%M") + '.csv'
    file = open(name, 'w')
    try:
        req = requests.get(url)
        js = json.loads(req.text)
        for item in js:
            if item['status']:
                file.write(item['ip'] + '\n')
    except:
        pass
    file.close()

if(__name__ == '__main__'):
    url = 'https://amtrckr.info/json/live'
    main(url)
