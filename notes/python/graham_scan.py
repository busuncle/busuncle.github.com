# -*- coding: utf-8 -*-


class Point(object):
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __eq__(self, p):
        return self.x == p.x and self.y == p.y

    def __str__(self):
        return "Point(%s, %s)" % (self.x, self.y)


class Vec2(object):
    def __init__(self, start_point, end_point):
        self.x = end_point.x - start_point.x
        self.y = end_point.y - start_point.y

    def __str__(self):
        return "Vec2(%s, %s)" % (self.x, self.y)


def cross(v1, v2):
    return v1.x * v2.y - v2.x * v1.y


def dot(v1, v2):
    return v1.x * v2.x + v1.y * v2.y


def graham_scan(point_list):
    p0_i = 0
    min_x, min_y = point_list[p0_i].x, point_list[p0_i].y 
    for i, p in enumerate(point_list):
        if p.y < min_y or (p.y == min_y and p.x < min_x):
            min_x, min_y = p.x, p.y
            p0_i = i

    p0 = point_list.pop(p0_i)
    def cmp(p1, p2):
        v1, v2 = Vec2(p0, p1), Vec2(p0, p2)
        if cross(v1, v2) > 0:
            # v1在v2右边
            return -1
        else:
            return 1

    point_list.sort(cmp)

    res = []
    res.append(p0)
    res.append(point_list[0])
    res.append(point_list[1])
    point_list = point_list[2:]
    while len(point_list) > 0:
        pi = point_list.pop(0)
        while cross(Vec2(res[-1], pi), Vec2(res[-1], res[-2])) < 0:
            res.pop(-1)
        res.append(pi)

    return res
            

#test_list = [Point(0.5, 1), Point(1, 0.5), Point(0, 0), Point(-1, 1), Point(0, 1), Point(1, 1)]
test_list = [Point(0, 0), Point(1, 0.2), Point(1.2, 0.5), Point(0.5, 0.5), Point(1, 1), Point(0.5, 2), Point(0, 1), Point(-1, 1), Point(-0.75, 0.25),]
ch = graham_scan(test_list)
for p in ch:
    print p

if Point(0.5, 0.5) in ch:
    print "yes"
else:
    print "no"
