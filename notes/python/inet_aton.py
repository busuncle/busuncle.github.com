import struct
import socket
import sys


def inet_aton(a):
    """
    using inet_aton in python is so complicated,
    I only want a single-input-single-output function
    """
    nums = map(int, a.split("."))
    res = 0
    for n in nums:
        res <<= 8
        res += n

    return res


if __name__ == "__main__":
    #addr = "123.125.48.34"
    #print struct.unpack(">L", socket.inet_pton(socket.AF_INET, addr))[0]
    addr = sys.argv[1]
    print inet_aton(addr)
