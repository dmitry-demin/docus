import os
from glob import glob
from datetime import datetime

def findCsvFiles(dir):
    oldCsv = ''
    newCsv = ''
    listcsv = glob(dir + '/????-??-??_??_??.csv')
    if(len(listcsv) > 1):
        newCsv = listcsv[-1]
        oldCsv = listcsv[-2]
    if(len(listcsv) == 1):
        newCsv = listcsv[0]

    csvToDel = listcsv[:-2]
    for file in csvToDel:
        deleteFile(file)

    csvs = {'oldCsv': oldCsv, 'newCsv': newCsv}
    return csvs

def logger(dir, insCount, delCount):
    log = open(dir + '/log.txt', 'a')   
    log.write('---' + datetime.now().strftime("%Y-%m-%d %H:%M") + '---\n')
    log.write('insert:' + str(insCount) + ' records\n')
    log.write('delete: ' + str(delCount) + ' records\n\n')
    log.close()

def loggerError(dir):
    log = open(dir + '/log.txt', 'a')   
    log.write('---' + datetime.now().strftime("%Y-%m-%d %H:%M") + '---\n')
    log.write('Csv upload error. Maybe url is not available\n\n')
    log.close()

def saveUpdates(delList, insList, dir):
    update = open(dir + '/Update.csv', 'w')
    for delhost in delList:
        s = delhost.strip() + '; Delete\n'
        update.write(s)
    for insHost in insList:
        s = insHost.strip() + '; Insert\n'
        update.write(s)
    update.close()

def isSorted(list):
    if not list:
        return
    old = list[0]
    for item in list:
        if old > item:
            return False
        old = item
    return True


def findUpdates(oldLines, newLines, dir):
    oldCount = len(oldLines) -1
    newCount = len(newLines) -1
    o = 0
    n = 0
    delLines = []
    insLines = []
    while 1:
        if newLines[n] == oldLines[o]:
            n+=1
            o+=1
        elif oldLines[o] > newLines[n]:
            insLines.append(newLines[n])
            n+=1
        elif newLines[n] > oldLines[o]:
            delLines.append(oldLines[o])
            o+=1
        if o == oldCount:
            insLines += newLines[n+1:]
            break
        if n == newCount:
            delLines += oldLines[o+1:]  
            break
    saveUpdates(delLines, insLines, dir)
    logger(dir, len(insLines), len(delLines))

def process(csvs, dir):
    oldFile = open(csvs['oldCsv'])
    oldLines = oldFile.readlines()
    if not isSorted(oldLines):
        oldLines.sort()
    oldFile.close()
    newFile = open(csvs['newCsv'])
    newLines = newFile.readlines()
    if not isSorted(newLines):
        newLines.sort()
    newFile.close()
    findUpdates(oldLines, newLines, dir)

def insertNewCsv(file, dir):
    csvFile = open(file)
    lines = csvFile.readlines()
    csvFile.close()
    update = open(dir + '/Update.csv', 'w')
    for line in lines:
        s = line.strip() + '; Insert\n'
        update.write(s)
    update.close()
    logger(dir, len(lines), 0)

def getDirs():
    dirs = []
    list = os.listdir('.')
    for dir in list:
        if os.path.isdir(dir):
            dirs.append(dir)
    return dirs

def deleteFile(file):
    if not os.path.isfile(file):
        return
    os.remove(file)

def isFileEmpty(file):
    if not os.path.isfile(file):
        return False
    if os.path.getsize(file) == 0:
        deleteFile(file)
        return False
    return True

def main():
    dirs = getDirs()
    for dir in dirs:
        print(dir)
        deleteFile(dir + '/Update.csv')
        csvs = findCsvFiles(dir)
        if not isFileEmpty(csvs['newCsv']):
            loggerError(dir)
            continue
        if not isFileEmpty(csvs['oldCsv']):
            insertNewCsv(csvs['newCsv'], dir)
            continue
        process(csvs, dir)
        deleteFile(csvs['oldCsv'])

if(__name__ == '__main__'):
    main()