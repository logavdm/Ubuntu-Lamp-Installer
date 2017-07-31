#!/bin/bash

#Add the PPA

sudo add-apt-repository ppa:webupd8team/java

#Update and install the installer script

sudo apt update; sudo apt install oracle-java8-installer

#checking the java version

javac -version
