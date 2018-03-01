# apt-get install python-mysqldb
import MySQLdb
conn = MySQLdb.connect(host='localhost', user='test', passwd='abcd1234', db='test', port=3306)
cur = conn.cursor()
cur.execute("show tables")
res = cur.fetchall()
print res
