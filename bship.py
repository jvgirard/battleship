# Socket server in Python using select function
 
import socket, select
  
if __name__ == "__main__":
      
    CONNECTION_LIST = []    # list of socket clients
    ADDR_LIST = []
    NUM_LIST=1
    RECV_BUFFER = 4096 # Advisable to keep it as an exponent of 2
    PORT = 8000
         
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    # this has no effect, why ?
    server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server_socket.bind(("127.0.0.1", PORT))
    server_socket.listen(10)
 
    # Add server socket to the list of readable connections
    CONNECTION_LIST.append(server_socket)
 
    print "Chat server started on port " + str(PORT)
 
    while 1:
        # Get the list sockets which are ready to be read through select
        read_sockets,write_sockets,error_sockets = select.select(CONNECTION_LIST,[],[])
 
        for sock in read_sockets:
             
            #New connection
            if sock == server_socket:
                # Handle the case in which there is a new connection received through server_socket
                sockfd, addr = server_socket.accept()
                CONNECTION_LIST.append(sockfd)
                print "%s" %addr[1]
                ADDR_LIST.append(addr[1])
                print "%d" %ADDR_LIST[0]            
                print "Client (%s, %s) connected" % addr
                 
            #Some incoming message from a client
            else:
                # Data received from client, process it
                try:
                    #In Windows, sometimes when a TCP program closes abruptly,
                    # a "Connection reset by peer" exception will be thrown
                    data = sock.recv(RECV_BUFFER)
                    # echo back the client message
                    if data.startswith  ("bye"):
                        print "Client (%s, %s) is offline" % addr
                        sock.close()
                        CONNECTION_LIST.remove(sock)
                    else:
                        sock.sendto('OK ... ' + data,("127.0.0.1",ADDR_LIST[0]))
                           
                 
                # client disconnected, so remove from socket list
                except:
                    #broadcast_data(sock, "Client (%s, %s) is offline" % addr)
                    print "Client (%s, %s) is offline" % addr
                    sock.close()
                    CONNECTION_LIST.remove(sock)
                    continue
         
    server_socket.close()