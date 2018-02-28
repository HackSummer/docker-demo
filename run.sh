#!/bin/bash
mysql -u root -pAZod123@#$ -h 192.168.199.128 --port=33306 < /root/0-init_table.sql && sh /usr/java/tomcat/apache-tomcat-8.5.28/bin/catalina.sh run;



