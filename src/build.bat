@echo off

set SOURCE=.\org\greydamian\netbatjava\Netbat.java
set OUTPUT=..\bin\netbat.jar

rem create output directory
mkdir ..\bin\classes

rem compile java source code
javac -d ..\bin\classes %SOURCE%

rem create executable jar file
jar cfm %OUTPUT% .\Manifest.txt -C ..\bin\classes\ .

rem remove compiled class files
rmdir /q /s ..\bin\classes

rem create execution script
echo @echo off >..\bin\netbat-java.bat
echo. >>..\bin\netbat-java.bat
echo java -jar .\netbat.jar %%* >>..\bin\netbat-java.bat
