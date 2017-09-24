import json
import requests
import sys
from glob import glob
import os

def deleteRequestData(delList):
    l = []
    for host in delList:
        d = {'Host': host}
        l.append(d)
    data = json.dumps({'Records': l})
    return data

def postRequestData(postList, details):
    l = []
    for host in postList:
        d = {'Host': host, 'Mask': '0.0.0.0', 'Details': details}
        l.append(d)
    data = json.dumps({'Records': l})
    return data

def findUpCsv(dir):
    return glob(dir + '\Update.csv')

def getDirs():
    dirs = []
    list = os.listdir('.')
    for dir in list:
        if os.path.isdir(dir):
            dirs.append(dir)
    return dirs

def sendRestRequest(act, data):
    url = 'https://ath-00003.avsw.ru/api/v1/dictionaries/ip'
    headers = {'X-Auth-Token': 'a8cab1ea-ccfd-4602-b11f-97e9bdba779c',
               'Content-Type': 'application/json'}
    if act == 'Insert':
        req = requests.post(url, headers=headers, data=data)
        if req.status_code == 200:
            return req.content
    if act == 'Delete':
        req = requests.delete(url, headers=headers, data=data)
        if req.status_code == 200:
            return req.content
    return

def process(csvFile, dir):
    delList = []
    postList = []
    maxBytes = 1000
    file = open(csvFile)
    for line in file:
        row = line.split(';')
        if len(row) < 2:
            continue
        action = row[1].strip()
        host = row[0]
        if action == 'Insert':
            postList.append(host)
            if sys.getsizeof(postList) > maxBytes:
                data = postRequestData(postList, dir)
                print sys.getsizeof(data)
                r = sendRestRequest(action, data)
                if r: print (r +' sending rows '+ str(len(postList)))
                else: print 'error'
                del postList[:]
        if action == 'Delete':
            delList.append(host)
            if sys.getsizeof(delList) > maxBytes:
                data = deleteRequestData(delList)
                r = sendRestRequest(action, data)
                if r: print (r +' sending rows '+ str(len(delList)))
                else: print 'error'
                del delList[:]
    if postList:
        data = postRequestData(postList, dir)
        r = sendRestRequest('Insert', data)
        if r: print (r +' sending rows '+ str(len(postList)))
        else: print 'error'
    if delList:
        data = deleteRequestData(delList)
        r = sendRestRequest('Delete', data)
        if r: print (r +' sending rows '+ str(len(delList)))
        else: print 'error'


def main():
    dirs = getDirs()
    for dir in dirs:
        print(dir + ':')
        upCsv = findUpCsv(dir) 
        if upCsv:
            process(upCsv[0], dir)


if __name__ == '__main__':
    main()
