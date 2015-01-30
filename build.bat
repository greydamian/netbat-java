@echo off

rem Copyright (c) 2015 Damian Jason Lapidge
rem 
rem The contents of this file are subject to the terms and conditions defined 
rem within the file LICENSE.txt, located within this project's root directory.

set SRC=.\src\org\greydamian\netbatjava\Netbat.java
set OUT=.\bin\netbat.jar

rem create output directory
mkdir .\bin\classes

rem compile java source code
javac -d .\bin\classes %SRC%

rem create executable jar file
jar cfm %OUT% .\src\Manifest.txt -C .\bin\classes\ .

rem remove compiled class files
rmdir /q /s .\bin\classes

rem create execution script
echo @echo off >.\bin\netbat-java.bat
echo. >>.\bin\netbat-java.bat
echo java -jar .\netbat.jar %%* >>.\bin\netbat-java.bat