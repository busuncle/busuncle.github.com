import socket, select
from datetime import datetime



READ_MAX = 1024
EPOLL_TIMEOUT = 5
SOCKET_LISTEN = 10

server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server_socket.bind(('127.0.0.1', 1234))
server_socket.listen(SOCKET_LISTEN)
server_socket.setblocking(0)

epoll = select.epoll()
epoll.register(server_socket.fileno(), select.EPOLLIN)
try:
    connections, requests, responses = {}, {}, {}
    while True:
        events = epoll.poll(EPOLL_TIMEOUT)
        print "epolling"
        for fileno, event in events:
            if fileno == server_socket.fileno():
                connection, address = server_socket.accept()
                connection.setblocking(0)
                epoll.register(connection.fileno(), select.EPOLLIN)
                connections[connection.fileno()] = connection
                requests[connection.fileno()] = address
                responses[connection.fileno()] = ""
                print "%s connected at %s" % (address, datetime.now())

            elif event & select.EPOLLIN:
                buf = connections[fileno].recv(READ_MAX)
                responses[fileno] += buf
                if len(buf) < READ_MAX:
                    responses[fileno] = "hello, you say: " + responses[fileno]
                    epoll.modify(fileno, select.EPOLLOUT)

            elif event & select.EPOLLOUT:
                sended = connections[fileno].send(responses[fileno])
                responses[fileno] = responses[fileno][sended:]
                if len(responses[fileno]) == 0:
                    #epoll.modify(fileno, 0)
                    #connections[fileno].shutdown(socket.SHUT_RDWR)
                    epoll.modify(fileno, select.EPOLLIN)

            elif event & select.EPOLLHUP:
                print "epollhup, disconnect by %s" % (requests[fileno], )
                epoll.unregister(fileno)
                connections[fileno].close()
                del connections[fileno]
                del requests[fileno]
                del responses[fileno]

finally:
    epoll.unregister(server_socket.fileno())
    epoll.close()
    server_socket.close()
