import pymongo

conn = pymongo.MongoClient("localhost", 27017)

print "collection names:"
print conn.test.collection_names(include_system_collections=False)
print

print "total count:"
print conn.test.user.count()
print

cur = conn.test.user.find()
print "iter collection:"
for v in cur:
    print v
print

print "access by index:"
cur.rewind()
print cur[1]
print

print "access by slice:"
cur.rewind()
for v in cur[1:3]:
    print v
print


""" output

collection names:
[u'user', u'team']

total count:
5

iter collection:
{u'age': 28.0, u'_id': ObjectId('565ede9e54d13a69b5b735df'), u'id': 1.0, u'name': u'busuncle'}
{u'age': 27.0, u'_id': ObjectId('565fed0254d13a69b5b735e0'), u'name': u'haha', u'id': 2.0}
{u'age': 26.0, u'_id': ObjectId('565fed6154d13a69b5b735e1'), u'name': u'aaa', u'id': 3.0}
{u'age': 26.0, u'_id': ObjectId('565fed6c54d13a69b5b735e2'), u'name': u'bbb', u'id': 4.0}
{u'age': 26.0, u'_id': ObjectId('565fed7454d13a69b5b735e3'), u'name': u'ccc', u'id': 5.0}

access by index:
{u'age': 27.0, u'_id': ObjectId('565fed0254d13a69b5b735e0'), u'name': u'haha', u'id': 2.0}

access by slice:
{u'age': 27.0, u'_id': ObjectId('565fed0254d13a69b5b735e0'), u'name': u'haha', u'id': 2.0}
{u'age': 26.0, u'_id': ObjectId('565fed6154d13a69b5b735e1'), u'name': u'aaa', u'id': 3.0}

"""
