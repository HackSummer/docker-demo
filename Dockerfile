FROM centos
MAINTAINER Summer <1015941081@qq.com>
ADD ./jdk-8u162-linux-x64.tar.gz /usr/java/jdk/
ADD ./apache-tomcat-8.5.28.tar.gz /usr/java/tomcat/
ADD ./server.xml /usr/java/tomcat/apache-tomcat-8.5.28/conf/
#启动tomcat与初始化mysql脚本
ADD ./run.sh /root/run.sh
#打包项目并拷贝到tomcat webapps目录 
COPY ./Student.war /usr/java/tomcat/apache-tomcat-8.5.28/webapps/
#复制mysql初始化脚本到容器里
COPY ./0-init_table.sql /root/0-init_table.sql
#安装mysql方便后续执行脚本
RUN yum update -y && \
    yum install wget rpm -y && \
    wget http://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm && \
    yum localinstall mysql57-community-release-el7-8.noarch.rpm -y && \
    rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
    yum install mysql-community-server -y
#设定环境变量
ENV JAVA_HOME /usr/java/jdk/jdk1.8.0_162
ENV JRE_HOME /usr/java/jdk/jdk1.8.0_162/jre
ENV CLASSPATH .:$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH
ENV PATH $JAVA_HOME/bin:$JRE_HOME/bin:$JAVA_HOME:$PATH
#打开端口
EXPOSE 5223
#给脚本增加执行权限
RUN chmod a+x /root/0-init_table.sql
RUN chmod a+x /root/run.sh
#ENTRYPOINT ["/root/run.sh","run"]
