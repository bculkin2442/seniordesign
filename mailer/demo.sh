#!/bin/bash

mvn clean compile install exec:java -Dexec.mainClass="wvutech.mailer.DemoMailer"
