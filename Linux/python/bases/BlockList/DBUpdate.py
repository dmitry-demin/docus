import pyodbc
from glob import glob
import os

def sqlconnect():
    try:
        return pyodbc.connect(
            'DRIVER={ODBC Driver 11 for SQL Server};'
            'SERVER=localhost;'
            'DATABASE=sandBox;'
            'UID=devUser;'
            'PWD=devPassword')
    except:
        return ''

def findUpCsv(dir):
    return glob(dir + '/Update.csv')

def getDirs():
    dirs = []
    list = os.listdir('.')
    for dir in list:
        if os.path.isdir(dir):
            dirs.append(dir)
    return dirs

def getQueryString(line,dir):
    row = line.split(';')
    if len(row) < 2:
        return
    action = row[1].strip()
    host = row[0]
    if action == 'Insert':
        return 'insert into DirectoryIps values(1,\''+host+'\',\'0.0.0.0\',\''+dir+'\',GETDATE(), GETDATE())'
    if action == 'Delete':
        return 'delete from DirectoryIps where Host=\''+host+'\' and Details=\''+dir+'\''
    return 
 
def logger(badQuery):
    f = open('log.txt', 'a')
    f.write('bad query: ' + badQuery)
    f.close()

def process(connection, csvFile, dir):
    cursor = connection.cursor()
    file = open(csvFile)
    for line in file:
        query = getQueryString(line, dir)
        if query:
            try:
                cursor.execute(query)
            except:
                logger(query)
    cursor.commit()

def main():
    con = sqlconnect()
    if not con:
        print('error db connection')
        return

    dirs = getDirs()
    for dir in dirs:
        print(dir)
        upCsv = findUpCsv(dir)
        if upCsv:
            process(con, upCsv[0], dir)
    con.close()

if(__name__ == '__main__'):
    main()
