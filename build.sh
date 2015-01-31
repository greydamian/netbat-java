#! /usr/bin/env bash

# Copyright (c) 2015 Damian Jason Lapidge
#
# The contents of this file are subject to the terms and conditions defined 
# within the file LICENSE.txt, located within this project's root directory.

SRC="./src/org/greydamian/netbatjava/Netbat.java";
OUT="./bin/netbat.jar";

MAINCLASS="org.greydamian.netbatjava.Netbat";

# create output directory
mkdir -p ./bin/classes;

# compile java source code
javac -d ./bin/classes $SRC;

# create executable jar file
jar cfe $OUT $MAINCLASS -C ./bin/classes/ .;

# remove compiled class files
rm -r ./bin/classes;

# create execution script (here document)
cat <<EOF >./bin/netbat-java.sh;
#! /usr/bin/env bash

java -jar ./netbat.jar \$@;

EOF
chmod +x ./bin/netbat-java.sh;

ln -s ./netbat-java.sh ./bin/netbat-java;

