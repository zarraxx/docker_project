#!/bin/sh
set -v

export DCM4CHEE_VERSION=2.18.3
export DCM4CHEE_ARCHIVE=dcm4chee-$DCM4CHEE_VERSION-mysql.zip

export ARR_VERSION=3.0.11
export ARR_ARCHIVE=dcm4chee-arr-$ARR_VERSION-mysql.zip

export JBOSS_URL=http://downloads.sourceforge.net/project/jboss/JBoss/JBoss-4.2.3.GA/jboss-4.2.3.GA-jdk6.zip
export DCM4CHEE_URL=http://downloads.sourceforge.net/project/dcm4che/dcm4chee/$DCM4CHEE_VERSION/$DCM4CHEE_ARCHIVE
export ARR_URL=http://downloads.sourceforge.net/project/dcm4che/dcm4chee-arr/$ARR_VERSION/$ARR_ARCHIVE

apt-get update
apt-get upgrade -y

# Install dependencies
apt-get install -y curl zip mysql-client  openjdk-8-jdk

# Make the dcm4chee home dir
DCM4CHEE_HOME=/var/local/dcm4chee
mkdir -p $DCM4CHEE_HOME
cd $DCM4CHEE_HOME

# Download the binary package for DCM4CHEE
echo $DCM4CHEE_URL
echo $DCM4CHEE_ARCHIVE

curl -LG $DCM4CHEE_URL  > /stage/$DCM4CHEE_ARCHIVE
unzip -q /stage/$DCM4CHEE_ARCHIVE
DCM_DIR=$DCM4CHEE_HOME/dcm4chee-$DCM4CHEE_VERSION-mysql

# Download the binary package for JBoss
echo $JBOSS_URL
curl -LG $JBOSS_URL  > /stage/jboss-4.2.3.GA-jdk6.zip
unzip -q /stage/jboss-4.2.3.GA-jdk6.zip
JBOSS_DIR=$DCM4CHEE_HOME/jboss-4.2.3.GA

# Download the Audit Record Repository (ARR) package
curl -LG $ARR_URL  > /stage/$ARR_ARCHIVE
unzip -q /stage/$ARR_ARCHIVE
ARR_DIR=$DCM4CHEE_HOME/dcm4chee-arr-$ARR_VERSION-mysql

# Copy files from JBoss to dcm4chee
$DCM_DIR/bin/install_jboss.sh jboss-4.2.3.GA > /dev/null

# Copy files from the Audit Record Repository (ARR) to dcm4chee
$DCM_DIR/bin/install_arr.sh dcm4chee-arr-$DCM4CHEE_VERSION-mysql > /dev/null

# Install and set up MySQL
#mysql_install_db
#/usr/bin/mysqld_safe &
#sleep 5s
# Create the 'pacsdb' and 'arrdb' databases, and 'pacs' and 'arr' DB users.
#mysql -uroot < /stage/create_dcm4chee_databases.sql
# Load the 'pacsdb' database schema
#mysql -upacs -ppacs pacsdb < $DCM_DIR/sql/create.mysql
# The ARR setup script needs to be patched
#sed "s/type=/engine=/g" $ARR_DIR/sql/dcm4chee-arr-mysql.ddl > fixed.ddl
#mv fixed.ddl $ARR_DIR/sql/dcm4chee-arr-mysql.ddl
# Load the 'arrdb' database schema
#mysql -uarr -parr arrdb < $ARR_DIR/sql/dcm4chee-arr-mysql.ddl
#killall mysqld
#sleep 5s

# Patch the JPEGImageEncoder issue for the WADO service
#sed -e "s/value=\"com.sun.media.imageioimpl.plugins.jpeg.CLibJPEGImageWriter\"/value=\"com.sun.image.codec.jpeg.JPEGImageEncoder\"/g" < $DCM_DIR/server/default/conf/xmdesc/dcm4chee-wado-xmbean.xml > dcm4chee-wado-xmbean.xml
#mv dcm4chee-wado-xmbean.xml $DCM_DIR/server/default/conf/xmdesc/dcm4chee-wado-xmbean.xml

# Update environment variables
echo "\
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64\n\
PATH=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin\"\n\
" > /etc/environment
