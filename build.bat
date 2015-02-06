@echo off

rem Copyright (c) 2015 Damian Jason Lapidge
rem 
rem The contents of this file are subject to the terms and conditions defined 
rem within the file LICENSE.txt, located within this project's root directory.

rem compiler, archiver, and runtime commands (could specify absolute paths)
set JAVAC=javac
set JAR=jar
set JAVA=java

rem output directory for class files
set CLASSDIR=.\bin\classes

rem application entry point
set MAINCLASS=org.greydamian.netbatjava.Netbat

set SRC=.\src\org\greydamian\netbatjava\Netbat.java
set OUT=.\bin\netbat.jar

rem extract bin directory from output path (dirname %OUT%)
for %%f in (%OUT%) do set BINDIR=%%~dpf

rem create output directories
mkdir %BINDIR%
mkdir %CLASSDIR%

rem compile java source code
%JAVAC% -d %CLASSDIR% %SRC%

rem create executable jar file
%JAR% cfe %OUT% %MAINCLASS% -C %CLASSDIR% .

rem remove compiled class files
rmdir /q /s %CLASSDIR%

rem create execution script
echo @echo off >.\bin\netbat-java.bat
echo. >>.\bin\netbat-java.bat
echo %JAVA% -jar %%~dp0.\netbat.jar %%* >>.\bin\netbat-java.bat
