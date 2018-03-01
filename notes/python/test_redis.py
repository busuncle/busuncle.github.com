# apt-get install python-redis
import redis 

HOST = "127.0.0.1" 
PORT = 6480 
DB = 2 


red = redis.StrictRedis(host=HOST, port=PORT, db=DB) 
print red.get("some_key")
