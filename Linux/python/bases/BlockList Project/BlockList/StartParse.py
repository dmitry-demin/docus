import os
from glob import glob
from datetime import datetime
from subprocess import Popen, PIPE

def getDirs():
    dirs = []
    list = os.listdir('.')
    for dir in list:
        if os.path.isdir(dir):
            dirs.append(dir)
    return dirs

def findScript():
    return glob('*.py')

def doWork(path):
    startTime = datetime.now()
    proc = Popen("python " + path, shell=True, stdout=PIPE, stderr=PIPE)
    proc.wait()
    endTime = datetime.now()
    procTime = endTime - startTime
    print (path + ' was processing '+ str(procTime))

def process():
    script = findScript()
    if script:
        doWork(script[0])

def main():
    root = os.getcwd()
    dirs= getDirs()
    for dir in dirs:
        os.chdir(root + '\\' + dir)
        process()

if(__name__ == '__main__'):
    main()
