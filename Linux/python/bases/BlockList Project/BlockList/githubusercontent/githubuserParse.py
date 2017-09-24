import requests
import os
from datetime import datetime

def main(url):
    name = datetime.now().strftime("%Y-%m-%d_%H_%M") + '.csv'
    try:
        with open(name, 'w') as file:
            req = requests.get(url, stream=True)
            file.write(req.text)
    except:
        pass

if(__name__ == '__main__'):
    url = 'https://raw.githubusercontent.com/oleksiig/Squid-BlackList/master/denied_ext.conf'
    main(url)

