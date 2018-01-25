#!/bin/bash

cd ~/seniordesign/labassist-mailer;

# Run the mailer to dispatch pending messages
mvn compile exec:java -Dexec.mainClass='wvutech.mailer.Mailer';

# Run the session closer
mvn compile exec:java -Dexec.mainClass='wvutech.mailer.SessionCloser';
