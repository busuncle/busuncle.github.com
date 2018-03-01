cache = {}
def fib(n):
    if n == 0:
        return 0
    if n == 1:
        return 1
    if n in cache:
        return cache[n]
    res = fib(n-1) + fib(n-2)
    cache[n] = res
    return res

print fib(40)
