FROM centos
LABEL author="guo"
LABEL email="<guolejian@126.com>"

# 将c.txt copy到/usr/local目录下并改名字
COPY c.txt /usr/local/cincontainer.txt
# 将jdk和tomcat copy到/usr/local 并解压
ADD jdk-8u241-linux-x64.tar.gz /usr/local
ADD apache-tomcat-8.5.51.tar.gz /usr/local

RUN mv /usr/local/jdk1.8.0_241 /usr/local/jdk
RUN mv /usr/local/apache-tomcat-8.5.51 /usr/local/tomcat

# 列出信息
RUN ls -l /usr/local

# 安装一些工具
RUN yum -y install vim
RUN yum -y install net-tools

# 安装vim
#RUN yum -y install vim
# 设置登录目录
ENV MYPATH /usr/local
WORKDIR ${MYPATH}
# 配置Java与tomcat环境变量
ENV JAVA_HOME ${MYPATH}/jdk
ENV CATALINA_HOME ${MYPATH}/tomcat
ENV CATALINA_BASE ${MYPATH}/tomcat
ENV PATH $PATH:${JAVA_HOME}/bin:${CATALINA_HOME}/lib:${CATALINA_HOME}/bin

# 容器运行时坚挺的端口
EXPOSE 8080

# 启动时运行tomcat
CMD /usr/local/tomcat/bin/startup.sh && tail -F /usr/local/tomcat/bin/logs/catalina.out


