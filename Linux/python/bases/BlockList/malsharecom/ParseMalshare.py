import urllib2
import argparse
import csv
from datetime import datetime, date

def main():
    mal_digest = urllib2.urlopen(url='http://www.malshare.com/daily/malshare.current.txt')
    mal_digest = list(mal_digest)
    pull_time = [str(date.today())] * len(mal_digest) 
    strip_list = [x.strip('\n') for x in mal_digest]
    dictionary = dict(zip(strip_list, pull_time))
    outfile_name = datetime.now().strftime("%Y-%m-%d_%H_%M") + '.csv'
    writer = csv.writer(open( outfile_name , 'a'))
    for key, value in dictionary.items():
        if (key):
            writer.writerow([key, value])

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print(" [X] Shutting Down")