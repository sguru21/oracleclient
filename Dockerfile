FROM centos

RUN yum -y update && yum install -y libXrender && yum install -y libXext && yum install -y fontconfig && yum install -y freetype && yum install -y libaio && yum install -y zip && yum install -y unzip  && yum install -y tigervnc-server && yum install -y xterm

#Oracle instant client include files copying into docker image
ADD /usr/include /usr/include

# oracle instant client libs copying into docker image
ADD /usr/lib /usr/lib

# Copy VNC configuration files
RUN mkdir /root/.vnc
ADD /VNC_Files /root/.vnc
RUN chmod 700 /root/.vnc/passwd
RUN chmod 700 /root/.vnc/xstartup

#creating symbolic link for sqlplus instant tool
RUN ln -s /usr/lib/oracle/11.2/client64/bin/sqlplus /usr/bin/sqlplus

#creating symbolic link for sqlplus instant tool
RUN ln -s /usr/lib/oracle/11.2/client64/lib/libclntsh.so /usr/lib/oracle/11.2/client64/lib/libclntsh.so.11.1
RUN ln -s /usr/lib/oracle/11.2/client64/lib/libclntsh.so /usr/lib/oracle/11.2/client64/lib/libclntsh.so.12.1
RUN ln -s /usr/include /usr/lib/oracle/11.2/client64/include

# setting library paths of oracle instant client
env LD_LIBRARY_PATH=/usr/lib/oracle/11.2/client64/lib

#setting executable paths of oracle instant client
env PATH=$PATH:/usr/lib/oracle/11.2/client64/bin


# setting environment variables for oracle instant client
env ORACLE_HOME=/usr/lib/oracle/11.2/client64 
env TNS_ADMIN=/usr/lib/oracle/11.2/client64/network/admin

#QT X11 rendering
env QT_X11_NO_MITSHM=1

RUN chmod 0777 /usr/lib/oracle/11.2/client64/bin/sqlplus