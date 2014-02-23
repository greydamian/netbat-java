#! /usr/bin/env bash

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

# create execution script
echo '#! /usr/bin/env bash

java -jar ./netbat.jar $@;' > ../bin/netbat-java.sh;
chmod +x ../bin/netbat-java.sh;

ln -s ./netbat-java.sh ../bin/netbat-java;

