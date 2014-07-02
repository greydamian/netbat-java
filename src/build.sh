#! /usr/bin/env bash

# Copyright (c) 2014 Damian Jason Lapidge
#
# The contents of this file are subject to the terms and conditions defined 
# within the file LICENSE.txt, located within this project's root directory.

SOURCE="./org/greydamian/netbatjava/Netbat.java";
OUTPUT="../bin/netbat.jar";

# create output directory
mkdir -p ../bin/classes;

# compile java source code
javac -d ../bin/classes $SOURCE;

# create executable jar file
jar cfm $OUTPUT ./Manifest.txt -C ../bin/classes/ .;

# remove compiled class files
rm -r ../bin/classes;

# create execution script (here document)
cat <<EOF >../bin/netbat-java.sh;
#! /usr/bin/env bash

java -jar ./netbat.jar \$@;

EOF
chmod +x ../bin/netbat-java.sh;

ln -s ./netbat-java.sh ../bin/netbat-java;

