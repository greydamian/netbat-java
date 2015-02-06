#! /usr/bin/env bash

# Copyright (c) 2015 Damian Jason Lapidge
#
# The contents of this file are subject to the terms and conditions defined 
# within the file LICENSE.txt, located within this project's root directory.

# compiler, archiver, and runtime commands (could specify absolute paths)
JAVAC="javac";
JAR="jar";
JAVA="java";

# output directory for class files
CLASSDIR="./bin/classes";

# application entry point
MAINCLASS="org.greydamian.netbatjava.Netbat";

SRC="./src/org/greydamian/netbatjava/Netbat.java";
OUT="./bin/netbat.jar";

# create output directory
mkdir -p $(dirname $OUT);
mkdir -p $CLASSDIR;

# compile java source code
$JAVAC -d $CLASSDIR $SRC;

# create executable jar file
$JAR cfe $OUT $MAINCLASS -C $CLASSDIR .;

# remove compiled class files
rm -r $CLASSDIR;

# create execution script (here document)
cat <<EOF >./bin/netbat-java.sh;
#! /usr/bin/env bash

$JAVA -jar \$(dirname \$0)/netbat.jar \$@;

EOF
chmod +x ./bin/netbat-java.sh;

# create symlink to execution script
ln -s ./netbat-java.sh ./bin/netbat-java;

