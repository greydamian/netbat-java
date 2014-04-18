/*
 * Copyright (c) 2014 Damian Jason Lapidge
 *
 * The contents of this file are subject to the terms and conditions defined
 * within the file LICENSE.txt, located within this project's root directory.
 */

package org.greydamian.netbatjava;

import java.lang.Exception;
import java.lang.Runnable;

import java.io.InputStream;
import java.io.OutputStream;

import java.net.ServerSocket;
import java.net.Socket;

/**
 * Represents the <code>netbat-java</code> program.
 *
 * @author  Damian Jason Lapidge <grey@greydamian.org>
 * @version 1.0.0
 */
public class Netbat {
    /**
     * Represents a receiver thread. Which, when run, reads data from a socket 
     * and then writes that data to some output.
     *
     * @author  Damian Jason Lapidge <grey@greydamian.org>
     * @version 1.0.0
     * @since   1.0.0
     */
    private static class Receiver implements Runnable {
        private static final int BUFSIZE = 1024;

        private Socket       sock = null;
        private OutputStream oput = null;

        /**
         * Initialises a new <code>Receiver</code> thread.
         *
         * @param sock socket from which data will be read
         * @param out  output to which data will be written
         */
        public Receiver(Socket sock, OutputStream out) {
            this.sock = sock;
            this.oput = out;
        }

        /**
         * Reads data from the socket and then writes that data to the output. 
         * Execution terminates when EOF is reached on the socket.
         */
        public void run() {
            byte[] buf = new byte[this.BUFSIZE];
            int rbytes = 0;

            try {
                InputStream iput = this.sock.getInputStream();

                rbytes = iput.read(buf);
                while (rbytes > -1) {
                    this.oput.write(buf, 0, rbytes);
                    rbytes = iput.read(buf);
                } 

                this.sock.shutdownInput();
            }
            catch (Exception e) {
                System.err.println("error: failure receiving data");
            }
        }
    }

    /**
     * Represents a sender thread. Which, when run, reads data from some input 
     * and then writes that data to a socket.
     *
     * @author  Damian Jason Lapidge <grey@greydamian.org>
     * @version 1.0.0
     * @since   1.0.0
     */
    private static class Sender implements Runnable {
        private static final int BUFSIZE = 1024;

        private Socket      sock = null;
        private InputStream iput = null;

        /**
         * Initialises a new <code>Sender</code> thread.
         *
         * @param sock socket to which data will be written
         * @param in   input from which data will be read
         */
        public Sender(Socket sock, InputStream in) {
            this.sock = sock;
            this.iput = in;
        }

        /**
         * Reads data from the input and then writes that data to the socket. 
         * Execution terminates when EOF is reached on the input.
         */
        public void run() {
            byte[] buf = new byte[this.BUFSIZE];
            int rbytes = 0;

            try {
                OutputStream oput = this.sock.getOutputStream();

                rbytes = this.iput.read(buf);
                while (rbytes > -1) {
                    oput.write(buf, 0, rbytes);
                    rbytes = this.iput.read(buf);
                }

                this.sock.shutdownOutput();
            }
            catch (Exception e) {
                System.err.println("error: failure sending data");
            }
        }
    }

    /**
     * Represents parsed command-line arguments.
     *
     * @author  Damian Jason Lapidge <grey@greydamian.org>
     * @version 1.0.0
     * @since   1.0.0
     */
    private static class Options {
        public String host = null;
        public int    port = -1;

        /**
         * Initialises a fresh <code>Options</code> object.
         */
        public Options() {
            /* do nothing */
        }
    }

    /**
     * Outputs usage information to stderr.
     */
    private static void printUsage() {
        System.err.println("usage: netbat-java [host] <port>");
    }

    /**
     * Parses command-line arguments into their corresponding command options. 
     * The parsed options are stored in the <code>Options</code> object.
     *
     * @param opts the <code>Options</code> object
     * @param args the command-line arguments
     *
     * @throws Exception If command-line arguments could not be parsed 
     *                   correctly.
     */
    private static void parseArgs(Options opts, String[] args)
            throws Exception {
        if (args.length < 1)
            throw new Exception("error: too few arguments");

        if (args.length > 1)
            opts.host = args[args.length - 2];

        opts.port = Integer.parseInt(args[args.length - 1]);
        if (opts.port < 1)
            throw new Exception("error: invalid port number");
    }

    public static void main(String[] args) {
        Options opts = new Options();
        try {
            parseArgs(opts, args);
        }
        catch (Exception e) {
            printUsage();
            System.exit(1); /* exit failure */
        }

        Socket sock = null;
        if (opts.host == null) {
            /* server action */
            try {
                ServerSocket servSock = new ServerSocket(opts.port);
                sock = servSock.accept();
                servSock.close();
            }
            catch (Exception e) {
                System.err.println("error: failure accepting connections on " + 
                                   "port " + opts.port);
                System.exit(1); /* exit failure */
            }
        }
        else {
            /* client action */
            try {
                sock = new Socket(opts.host, opts.port);
            }
            catch (Exception e) {
                System.err.println("error: failure connecting to " + 
                                   opts.host + ":" + opts.port);
                System.exit(1); /* exit failure */
            }
        }

        Thread rxThread = new Thread(new Receiver(sock, System.out));
        Thread txThread = new Thread(new Sender(sock, System.in));

        /* start sender/receiver threads */
        try {
            rxThread.start();
            txThread.start();
        }
        catch (Exception e) {
            System.err.println("error: failure starting receiver/sender " + 
                               "thread");
            System.exit(1); /* exit failure */
        }

        /* join receiver thread */
        try {
            rxThread.join();
        }
        catch (Exception e) {
            System.err.println("error: failure joining receiver thread");
        }

        System.exit(0); /* exit success */
    }
}

