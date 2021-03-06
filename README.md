netbat-java
===========

Overview
--------

Simple TCP client/server utility program. Java translation of 
[netbat](https://github.com/greydamian/netbat).

Netbat-java can act as either a TCP client or TCP server. Data is concurrently 
read from standard input (stdin) then written to the TCP stream and read from 
the TCP stream and written to standard output (stdout).

Netbat-java terminates execution normally when it receives end-of-transmission 
from the TCP stream.

My motivation for writing netbat-java was to produce a platform independant 
version on netbat. As with netbat, netbat-java was heavily influenced by 
attempting to emulate some behaviours of the 
[Netcat](http://nc110.sourceforge.net/) program, which was originally developed 
by \*Hobbit\*, and is a much more fully-featured utility.

Compatibility
-------------

* Linux (with dependencies from sublist)
  * JRE (Java Runtime Environment) >= 7
* Unix (with dependencies from sublist)
  * JRE (Java Runtime Environment) >= 7
* Apple OS X (with dependencies from sublist)
  * JRE (Java Runtime Environment) >= 7
* Microsoft Windows (with dependencies from sublist)
  * JRE (Java Runtime Environment) >= 7

Installation
------------

### Linux/Unix/Apple OS X

Full installation of netbat-java is a 2 step process. However, the second step 
is optional.

Firstly, navigate into the root directory of the project and run the following 
command:

    $ bash build.sh

Once this has completed, you can run netbat-java by navigating into the bin 
directory and running the following command:

    $ ./netbat-java

Secondly, and optionally, you can install netbat-java system-wide by copying 
the contents of the bin directory into your path. For example, you could 
execute a command such as:

    # cp bin/* /usr/local/bin/

### Microsoft Windows

Full installation of netbat-java on MS Windows is a 2 step process. However, 
the second step is optional.

Firstly, navigate into the root directory of the project and run the 
following command:

    > build

Once this has completed, you can run netbat-java by navigating into the bin 
directory and running the following command:

    > netbat-java

Secondly, and optionally, you can install netbat-java system-wide by adding the 
contents of the bin directory to your command path.

Examples
--------

There are many purposes for which netbat-java can be used. However, here I will 
focus on 3 specific usage examples: file transfer, HTTP request, instant 
messaging.

Netbat-java can be used to transfer a file (e.g. myfile) by executing the 
following commands on their respective hosts:

    host-a$ netbat-java 4444 < myfile
    host-b$ netbat-java 192.168.0.2 4444 > myfile

N.B. The previous example presumes that host-a has the IP address 192.168.0.2.

Netbat-java can be used as a simple instant messaging client by executing the 
following commands on their respective hosts:

    host-a$ netbat-java 4444
    host-b$ netbat-java 192.168.0.2 4444

After executing the previous commands, anything typed as input to one of the 
commands will be displayed as output from the other and vice-versa. Supplying 
EOF (End Of File) to one of the programs will terminate the session, this can 
usually be done by typing [Ctrl] + [D] \(on Unix-like systems\) or [Ctrl] + [Z] 
\(on MS Windows\).

N.B. The previous example presumes that host-a has the IP address 192.168.0.2.

Netbat-java can be used to send a HTTP request to a web server, and display the
response, by executing the following command:

    $ echo -ne 'GET / HTTP/1.1\r\nHost: 192.168.0.1\r\n'\
    > 'Connection: close\r\n\r\n' | netbat-java 192.168.0.1 80

N.B. The previous example utilises a Unix-like echo command, and thus will not
work on MS Windows. The previous example also presumes the web server is 
running on port 80 of the host with IP address 192.168.0.1.

License
-------

Copyright (c) 2015 Damian Jason Lapidge

Licensing terms and conditions can be found within the file LICENSE.txt.

