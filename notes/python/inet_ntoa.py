import socket
import struct


def inet_ntoa(n):
    """
    complicated in using inet_ntoa in python for some consideration
    like this: ip = socket.inet_ntoa(struct.pack(">L", n))
    make it easy
    """
    res = []
    mask = 2**8 - 1
    while len(res) < 4:
        res.append(n & mask)
        n >>= 8

    return ".".join(map(str, reversed(res)))


if __name__ == "__main__":
    n = 3449552015
    print socket.inet_ntoa(struct.pack(">L", n))
    print inet_ntoa(n)
