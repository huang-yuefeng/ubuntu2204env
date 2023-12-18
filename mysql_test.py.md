from pymysql import Connection
db = Connection(host='localhost',
				port=3306,
				user='root',
				passwd='huangyf')

print (db.get_server_info())

cursor = db.cursor()

cursor.execute("CREATE DATABASE IF NOT EXISTS testDB")
cursor.execute("USE testDB")
cursor.execute("show tables;")
print  ("existing tables:", cursor.fetchall())

cursor.execute("""create table if not exists PERSON(
				 `id` int unsigned auto_increment primary key,
				 `name` varchar(40) not null,
				 `birthday` date);""")
print  ("existing tables:", cursor.fetchall())


sql = """INSERT INTO PERSON(name,birthday)
         VALUES ('huang', '1981-6-15')"""
cursor.execute(sql)
db.commit()

cursor.execute("select * from PERSON")

print  ("existing tables:", cursor.fetchall())
db.close()
