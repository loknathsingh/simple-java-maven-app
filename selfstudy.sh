#!/bin/bash

error: RPC failed; HTTP 403 curl 22 The requested URL returned error: 403 Forbidden

####################################################################################################
#########################################LINUX######################################################
####################################################################################################

##alias
cybage@master:~$ alias
alias a='devapp'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias devapp='kubectl -n dev-pldev-app'
alias devpl='kubectl -n dev-pldev-pl'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias intapp='kubectl -n dev-devint-app'
alias intpl='kubectl -n dev-devint-pl'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias p='devpl'
alias pletl='kubectl -n dev-pletl-pl'
alias uiapp='kubectl -n dev-plui-app'
alias uipl='kubectl -n dev-plui-pl'

##sample etc host file
cybage@master:~$ cat /etc/hosts
127.0.0.1 localhost localhost.localdomain
127.0.1.1	master.cybage.com	master

# The following lines are desirable for IPv6 capable hosts
::1 ip6-localhost ip6-loopback localhost6 localhost6.localdomain
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
# Ansible inventory hosts BEGIN
172.27.15.68 master master.cluster.local app-pldev.cybage.com pl-pldev.cybage.com app-devint.cybage.com pl-devint.cybage.com app-plui.cybage.com pl-plui.cybage.com pl-pletl.cybage.com
172.27.15.86 node1 node1.cluster.local
172.27.15.137 node2 node2.cluster.local
172.27.15.129 node3 node3.cluster.local
172.27.15.61 node4 node4.cluster.local
10.233.37.106 pl-dre-servicegateway

# Ansible inventory hosts END


#https://www.eduncle.com/net-achiever-computer-science-2018/515
#https://www.quora.com/What-are-the-best-ways-to-prepare-for-UGC-NET-computer-science
#https://www.upkar.in/books.php?word=net&cat=All
#Linux sources package list urls
ls /etc/apt/sources.list.d/

temp

#connect mariadb
mysql --user=root --password=cybage@dm -h 172.27.15.159  -P 3306
#https://mariadb.com/kb/en/library/mysql-command-line-client/

##containers
#mariadb container
docker run -d \
-p 3307:3306 \
-v /home/ubuntu/dm-poc/mariadb-data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=password \
-v /etc/localtime:/etc/localtime:ro \
-v /etc/timezone:/etc/timezone:ro \
--restart=unless-stopped \
--name dmpoc-mariadb \
mariadb/server:10.3
#https://hub.docker.com/_/mariadb

#myssql container
docker run -d \
-p 3306:3306 \
-v /home/ubuntu/dm-poc/mysql-data:/var/lib/mysql \
-v /home/ubuntu/dm-poc/mysql-conf:/etc/mysql/conf.d \
-e MYSQL_ROOT_PASSWORD=password \
-v /etc/localtime:/etc/localtime:ro \
-v /etc/timezone:/etc/timezone:ro \
--restart=unless-stopped \
--name dmpoc-mysql \
mysql:5.7

#MSSQL container without network
# MSSQL without network
docker run -d \
-p 1433:1433 \
-v $HOME/decisionmines/db-scripts:/decisionmines/db-scripts \
-v /etc/localtime:/etc/localtime:ro \
-v /etc/timezone:/etc/timezone:ro \
-v $HOME/decisionmines/db_data:/var/opt/mssql \
-e 'ACCEPT_EULA=Y' \
-e 'SA_PASSWORD=cybage@123' \
-h sql1 \
--restart=unless-stopped \
--name sql1  \
microsoft/mssql-server-linux:2017-latest

# MSSQL with network
docker run -d \
-p 1433:1433 \
-v $HOME/decisionmines/db-scripts:/decisionmines/db-scripts \
-v /etc/localtime:/etc/localtime:ro \
-v /etc/timezone:/etc/timezone:ro \
-v $HOME/decisionmines/db_data:/var/opt/mssql \
-e 'ACCEPT_EULA=Y' \
-e 'SA_PASSWORD=cybage@123' \
--network="decisionmines_dm-network" \
-h sql1 \
--restart=unless-stopped \
--name sql1  \
microsoft/mssql-server-linux:2017-latest

#console log redirection
nohup <service command> &
tail -f nohup.out
tail 1000 nohup.out
<ctrl+c>

#watch command
watch <command name>

#sed replace $ variable
sed -i "s&\$HOME/decisionmines&/decisionmines&g" *.yaml

#Install mysqladm from mysql client
sudo apt install mysql-client-5.7
#Caused by: java.sql.SQLException: Host '172.27.15.72' is blocked because of many connection errors; unblock with 'mysqladmin flush-hosts'

#flush ip
mysqladmin -h 172.27.15.115 -P 3301 -u root -p flush-hosts

#to zip a file
zip -r filename.zip foldername1/ foldername2/
unzip filename.zip

#earlier github username prakashsinhab to be vivahnimantran

#give permissions like in Dockerfile
RUN chmod +x /pl-status-api/start.sh

#List db users in MSSQL mssql  db
SELECT * FROM sys.database_principals where (type='S' or type = 'U')

#Linux ram information
cat /proc/meminfo

#Linux cpu information
cat /proc/cpuinfo

#Harddisk information
cat /sys/block/sda/queue/rotational
#if 0 then SSD else HDD
#or, dig through proc file system for model information and research it online for its type
cat /proc/scsi/scsi


#python update version with soft link
mv /usr/bin/python /usr/bin/python-old
ln -s /usr/bin/python3.5 /usr/bin/python
# pip install PyMySQL flask_cors sklearn numpy sqlalchemy pandas xlrd configparser requests

#set system hostname
sudo hostnamectl set-hostname NEW_HOSTNAME
#exit the console and relogin to a new shell prompt

#find in subdirectories with wildcards
find /location/sublocation -name "*sometext*"

#orchestration with multiple toolsets
https://github.com/microservices-demo/microservices-demo/tree/master/deploy/kubernetes


#To know package for sudo apt-get package-name
apt-cache pkgnames | grep packagename
#or follow below example steps
#https://www.howtogeek.com/229682/how-to-find-out-exact-package-names-for-applications-in-linux/
ls /etc/apt/sources.list.d/
cat /etc/apt/sources.list.d/skype-stable.list
sudo apt-get upgrade skype-stable
https://repo.skype.com/deb/dists/stable/main/binary-amd64/Packages
sudo apt-get upgrade skypeforlinux

#To disable firewall rules in ubuntu linux
#https://www.cyberciti.biz/faq/turn-on-turn-off-firewall-in-linux/
#Log in as root
iptables-save > /root/firewall.rules
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

#To restore or turn on firewall
iptables-restore < /root/firewall.rules

#Apply permissions recursively to folder and its subfolders
sudo chown -R username:groupname foldername

#List ubuntu pre-installed certificates
ls /etc/ssl/certs/ssl-cert-snakeoil.pem
sudo ls /etc/ssl/private/ssl-cert-snakeoil.key

#import ca certificate .cer
sudo keytool -import -trustcacerts -keystore /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/cacerts -storepass changeit -file $HOME/decisionmines/certs/db-ca-cert.cer -alias decisionmines-db
keytool -import -trustcacerts -keystore /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/cacerts -storepass changeit -file ./certs/db-ca-cert.cer -alias decisionmines-db

#max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]
grep vm.max_map_count /etc/sysctl.conf
sudo sysctl -w vm.max_map_count=262144

#Remote access to windows machine
#Remmina with xrdp plugin

#to remove earlier paired machine
#Host key verification failed.
#Add correct host key in /home/prakashsinha/.ssh/known_hosts to get rid of this message.
ssh-keygen -f "/home/prakashsinha/.ssh/known_hosts" -R "172.27.15.8"

#list all local users
#https://askubuntu.com/questions/410244/a-command-to-list-all-users-and-how-to-add-delete-modify-users
cut -d: -f1 /etc/passwd

#create user
adduser username
#add to sudo group
usermod -aG sudo username

#to grant sudo privileges
visudo
#Search for the line that looks like this:
root    ALL=(ALL:ALL) ALL
#copy paste to newline as below
newuser ALL=(ALL:ALL) ALL

#add user to a group say docker
su username
sudo usermod -aG docker $USER

#set permission of user in dockerhub
#Permission denied to Docker daemon socket at unix:///var/run/docker.sock
sudo setfacl -m user:<your username>:rw /var/run/docker.sock
#https://stackoverflow.com/questions/53126950/permission-denied-to-docker-daemon-socket-at-unix-var-run-docker-sock

#to delete user
deluser newuser
sudo deluser --remove-home newuser

#smart goals
Service mesh in Decisionmines
Assist in hybrid cloud implementation
Develop skillset in aws, k8s, ansible, rancheros stack
Groom new TMs
Spread the word about Decisionmines, its importance and applicability


#elk
http://decisionmines-qa-int.cybage.com:9200/
http://decisionmines-qa-int.cybage.com:5601/app/kibana#/home?_g=()
https://hub.docker.com/r/elastic/elasticsearch/
https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html
#giving correct permissions to filebeat and elastic
chmod 644 elastic/config/filebeat.yml
mkdir -p elastic/logs/elasticsearch elastic/data/elasticsearch
chmod 777 elastic/logs/elasticsearch elastic/data/elasticsearch

#k8s
https://www.gcppodcast.com/post/episode-36-kubernetes-1-3-with-carter-morgan/
https://blog.openshift.com/tag/podctl/
https://kubernetespodcast.com/

#tree command to include date and level 2
tree -D -L 2

#creating self signed certificate
https://fabianlee.org/2018/02/17/ubuntu-creating-a-self-signed-san-certificate-using-openssl/

#Installing a root/CA Certificate
sudo mkdir /usr/share/ca-certificates/extra
sudo cp foo.crt /usr/share/ca-certificates/extra/foo.crt

#Let Ubuntu add the .crt file's path relative to /usr/share/ca-certificates to /etc/ca-certificates.conf:
sudo dpkg-reconfigure ca-certificates

#In case of a .pem file on Ubuntu, it must first be converted to a .crt file:
openssl x509 -in foo.pem -inform PEM -out foo.crt


# cat file without comments and empty line
cat elastic/config/kibana.yml | egrep -v "(^#.*|^$)"

#To insert a line at 3rd line in a file temp.txt
sed -i '3iTo insert a task in line 3' temp.txt

#Find process id from port
sudo lsof -i :portnumber
sudo netstat -tlnpa | grep portnumber

#Find process location from process id
ps -ef | grep <pid>

#For BSD or GNU grep you can use -B num to set how many lines before the match and -A num for the number of lines after the match.
grep -B 3 -A 2 printer temp.txt


#If you want the same number of lines before and after you can use -C num.
grep -C 3 foo README.txt

#In order to assign execution permissions only to directories
chmod -R a-rwx,u=rwX,g=rX .

#Linux shell script sleep

sleep NUMBER[SUFFIX]
s for seconds (the default)
m for minutes.
h for hours.
d for days.
sleep 2m

#To apply read, write and execute permissions to files within subfolders from a folder
sudo chmod 777 ./*/logs/*.txt

#To remove logs from subfolders within a folder
rm <folder name>/*/logs/*.log

#Set rw r r permissions
chmod 0644 filename

#remove all the containers
docker rm -f $(docker ps -a -q)

#docker ps to list only images
docker ps --format ‘{{.Image}}’

#docker ps to list only names
docker ps --format '{{.Names}}'


# sonarqube jacoco
# Import JaCoCo code coverage report.
# Set the property to the path of the JaCoCo .exec report.
sonar.jacoco.reportPath=target/jacoco.exec

#Extra build and publish in CI jobs-in-jenkins
#cleanup PR
#second docker build and publish

#the amendment in Section 17 under Shops and Establishment Act 2017

#docker build return image id example
IMAGE_ID=$(docker build -t foo . 2>/dev/null | awk '/Successfully built/{print $NF}')
#SHA - updated command instead of awk command
IMAGE_ID=$(docker build -q -t foo . 2>/dev/null | awk '/Successfully built/{print $NF}')

#docker image tag and push
Done: docker image tag and push
https://docs.docker.com/docker-cloud/builds/push-images/
 docker tag <image id> author/repo:version
 docker push author/repo:version

 ##Empty repository. -- from dockerhub
 ##You may push a new image to this repository using the CLI:

 docker tag local-image:tagname reponame:tagname
 docker push reponame:tagname
 #Make sure to change tagname with your desired image repository tag.


#git diff for a file

git rm --cached .idea
#Reset git login
git config --global --unset credential.helper

#Git set username
git config --global user.name 'some name'

#Git reset --hard
#Remove unneccessary git commits
http://christoph.ruegg.name/blog/git-howto-revert-a-commit-already-pushed-to-a-remote-reposit.html

#Find out commits for particular file
git log --follow <filename>

#git checkout tag as branch
git checkout -b newbranch v1.0

#error: RPC failed; HTTP 403 curl 22 The requested URL returned error: 403 Forbidden
git config --local http.postBuffer 157286400

 #Store git user name and password
git config credential.helper store
git pull
 #Next git pull works out from store
git pull

#to unset credential store
git config --global --unset credential.helper
git config --system --unset credential.helper

#Add instance in mssql server
https://4sysops.com/archives/how-to-create-a-new-sql-server-2012-instance/

#fetch specific file from remote IP with username and password
wget --user user --password pass http://example.com/.

#liquibase maven dependency
https://docs.microsoft.com/en-us/sql/connect/jdbc/download-microsoft-jdbc-driver-for-sql-server?view=sql-server-2017
https://docs.microsoft.com/en-us/sql/connect/jdbc/using-the-jdbc-driver?view=sql-server-2017

#git checkout specific file from remote origin branch
 git checkout origin/kotak-beta -- db-scripts/kotak-schema.sql

#how to set specific java version to maven
https://stackoverflow.com/questions/19654557/how-to-set-specific-java-version-to-maven

#Liquibase dtd document type defintion for changelog xml files
http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-3.1.xsd

#Update pom.xml from snapshot to release from all sub and parent modules - Example below
grep -nr "SNAPSHOT"
grep -r -l '1.1.5-SNAPSHOT' . | sort | uniq | xargs perl -e "s/1.1.5-SNAPSHOT/1.1.5/" -pi
find . -name "*.bak" -type f -not -path "./.git/*" -delete
grep -nr "1.1.5" --exclude-dir=.git


#mvn commands with only parent pom
 mvn liquibase:status --non-recursive

#Craet jenkins job through REST api
https://stackoverflow.com/questions/8424228/export-import-jobs-in-jenkins

#DM Jira Board
https://decisionmines.atlassian.net/secure/RapidBoard.jspa?rapidView=8

#Reverse search in linux-command-line
In active terminal, ctrl+i key combination results to reverse-i-search

#IP Access
ping <IP>
#IP with specific port Access
telnet <IP> <PORT>
#URL Access
curl <URL>

#List git configuration
#Show git configuration
git config --list
git config --global -l

#Grep in selective files
grep -nr "dm-solutionapi" --include \*.yml

#Grep with exclude dir and exact word #also -c -w like -w
grep -nrw "context.xml" --exclude-dir="target"

https://opensource.com/article/16/12/web-browsers-linux-command-line

#printer
echo -en "\rHello world\r\f" | smbclient "smb://172.27.172.100/CT2-3rdFloor" \
"cybage@123" -c "print -" -N -U "prakashsinhaba" -W "cybage"


se
git rev-list -n 1 --grep 'DM' origin script
git rev-list -n 1 --grep '^DM' origin script

"[DM-561] pre-rebase git hook for develop"
 cp devops/githooks/pre-rebase .git/hooks/

#Copy to and from container (say with name dummy) and host machine
docker cp c:\myfolder\myfile.txt dummy:/root/myfile.txt
docker cp dummy:/root/myfile.txt c:\myfolder\myfile.txt

https://confluence.atlassian.com/bitbucketserver/using-repository-hooks-776639836.html
https://www.eandbsoftware.org/liquibase-use-case-example/

sql server management studio
sql server configuration manager to enable TCP/IP port 1433 IPAll
sql server express
sqlcmd -S PRAKASHSINHABA\SQLEXPRESS -E

localhost ms sql server connection string
Server=localhost\SQLEXPRESS;Database=master;Trusted_Connection=True;

In a hibernate project, hbm2ddl is not required if we make use of liquibase -
https://stackoverflow.com/questions/3525048/is-there-any-liquibase-issue-with-hibernate-hbm2ddl-create

We configure Liquibase for synonyms -
https://stackoverflow.com/questions/22865568/liquibase-issue-when-using-synonyms

Liquibase might have issue with changeset and context -
https://stackoverflow.com/questions/37855189/liquibase-issues-with-labels-and-context

Liquibase rollback might have issues with include command -
https://stackoverflow.com/questions/41810911/rollback-issue-liquibase

Issue with tagDatabase operation in Liquibase for empty database -
https://stackoverflow.com/questions/41810911/rollback-issue-liquibase

Other similar technical issues with solutions - locking, column data type,
upgrades failing updates, speed, primary key lengths across databases,
https://stackoverflow.com/questions/41810911/rollback-issue-liquibase

docker run --name artifactory-host-mysql -d -p 8083:8083 -p 3306:3306 artifactory-hostmysql -v /home/cybage/prakash/artifactory:/opt/jfrog/artifactory

#mysql bind address to 0.0.0.0 and restart the service
/etc/mysql/mysql.conf.d
sudo /etc/init.d/mysql start
#Grant permission for global ips %
#https://stackoverflow.com/questions/5016505/mysql-grant-all-privileges-on-database
GRANT ALL ON *.* TO 'root'@'192.168.1.%' identified by 'MY_PASSWORD';
GRANT ALL PRIVILEGES ON mydb.* TO 'myuser'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON artdb.* TO 'artifactory'@'*' IDENTIFIED BY 'cybage#123';
GRANT ALL PRIVILEGES ON artdb.* TO 'artifactory'@'%' IDENTIFIED BY 'cybage#123';


docker run --name artifactory-host-mysql -e DB_TYPE=mysql -e DB_HOST=172.27.56.230 -e DB_URL='jdbc:mysql://172.27.56.230:3306/artdb?characterEncoding=UTF-8&elideSetAutoCommits=true' -e DB_PORT=3306  -e DB_USER=artifactory -e DB_PASSWORD=cybage#123 -d -p 8083:8083 --net=host -v /home/cybage/prakash/artifactory/mysql-connector-java-5.1.46.jar:/opt/jfrog/artifactory/tomcat/lib/mysql-connector-java-5.1.46.jar artifactory-hostmysql
https://www.jfrog.com/confluence/display/RTF/Installing+with+Docker
https://www.jfrog.com/jira/browse/RTFACT-14877 - similar issue oof db fail to start
mysql username password root cybage#123 for all dbs and artifactory cybage#123 for artdb


#with oss latest
docker run --name artifactory-host-mysql -e DB_TYPE=mysql -e DB_HOST=172.27.56.230 -e DB_URL='jdbc:mysql://172.27.56.230:3306/artdb?characterEncoding=UTF-8&useSSL=false' -e DB_PORT=3306  -e DB_USER=artifactory -e DB_PASSWORD=cybage#123 -d -p 8083:8081 -v /home/cybage/prakash/artifactory/mysql-connector-java-5.1.46.jar:/opt/jfrog/artifactory/tomcat/lib/mysql-connector-java-5.1.46.jar docker.bintray.io/jfrog/artifactory-oss:latest



copy .bak and restore sql to location after setup demo shell execution and before 01 script execution

-bash: ./03compose_up.sh: /bin/bash^M: bad interpreter: No such file or directory


export PATH=$PATH:"c:/Program Files/Microsoft SQL Server/Client SDK/ODBC/130/Tools/Binn/sqlcmd"
"c:/Program Files/Microsoft SQL Server/Client SDK/ODBC/130/Tools/Binn/sqlcmd"


liquibase  --defaultsFile=src/main/resources/liquibase/liquibase.properties --classpath="C:/Users/prakashsinhaba/Downloads/mysql-connector-java-5.1.46.tar/mysql-connector-java-5.1.46.jar" --changeLogFile=d:\output.xml generateChangeLog


# tree command in git bash
 cmd //c tree

# ttfb time to first byte

# run command with mssqld container for backup restore with same mount point
docker exec -it sql1 /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "cybage@123" -i /home/cybage/DataBackup/kotak_4_22May.bak

#to run mssql container
docker run -p 3306:3306 --name mariadbtest -e MYSQL_ROOT_PASSWORD=mypass -d mariadb/server:10.3


#force db refresh in mssql
USE master;
ALTER DATABASE [databasename] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE [databasename] ;

#list users in mssql
select * from master.sys.server_principals

#remove lines with comments from a file
grep -o '^[^#]*' file

#nginx reverse proxy upstream
upstream testservers {
       server 172.27.15.47:30137;
       server 172.27.15.83:30137;
}server {
   listen       80;
   server_name  dmsar.dm.com; location / {
       #rewrite ^/amp^/ /$1 break;
       proxy_pass http://testservers;
   }

#run ifconfig in container
#install net tools
apt-get update && apt-get install net-tools

#install ping utils
apt-get update && apt-get install iputils-ping

#https://github.com/pubaayaam/docker_ssh_key_pair
#install scp
apt-get install openssh-client
apt-get install ssh

#scp via private key file
scp -i ~/.ssh/id_rsa.pub USER@SERVER:/home/USER/FILENAME /home/USER/FILENAME


#or
sudo apt-get install sshpass
sshpass -p your_password ssh user@hostname
#ssh-keygen -t rsa -f $HOME/.ssh/id_rsa -q -P ""
#cat $HOME/.ssh/id_rsa.pub ssh prakashsinha@172.27.15.88 "cat - >> $HOME/.ssh/authorized_keys"
#ssh prakashsinha@172.27.15.88
#RUN ssh-keygen -t rsa
#RUN  apt-get install ssh


#install ps
apt-get update && apt-get install procps
#install telnet
apt-get install telnet
#install lsof
apt-get install lsof
#install curl
apt-get install curl
#install wget
echo 'install in progress'
sudo apt-get update;
sudo apt-get install procps -y;
sudo apt-get install telnet -y;
sudo apt-get install lsof -y;
sudo apt-get install curl -y;
echo "install completed successfully"


#create a mount
#edit /etc/exports after installing nfs server
#/dm-nfs 192.168.99.1 (rw,nohide,insecure,no_subtree_check,async,no_root_squash)
showmount -e localhost
#mount
mkdir $HOME/tempMount
sudo mount -t nfs -o nfsvers=3,udp 192.168.99.1:/tmp  $HOME/tempMount
#

#atom editor shortcut
#https://blog.bugsnag.com/atom-editor-cheat-sheet/


#security certificate creation

keytool -genkey -alias <domain name ie machine hostname> -keystore <domain name>.pfx -storepass cybage@123 -validity 365 -keyalg RSA -keysize 2048 -storetype pkcs12 -ext san=dns:<domain name>
openssl pkcs12 -in <domain name>.pfx -nocerts -out <domain name>.key
openssl rsa -in <domain name>.key -outform PEM -out <domain name>-PEM.key
openssl pkcs12 -in <domain name>.pfx -clcerts -nokeys -out <domain name>.crt
openssl pkcs12 -in <domain name>.pfx -clcerts -nokeys -out <domain name>.cer

keytool -genkey -alias prakashsinha-mint  -keystore prakashsinha-mint.pfx -storepass   -validity 365 -keyalg RSA -keysize 2048 -storetype pkcs12 -ext san=dns:prakashsinha-mint
openssl pkcs12 -in prakashsinha-mint.pfx -nocerts -out prakashsinha-mint.key
openssl rsa -in prakashsinha-mint.key -outform PEM -out prakashsinha-mint-PEM.key
openssl pkcs12 -in prakashsinha-mint.pfx -clcerts -nokeys -out prakashsinha-mint.crt
openssl pkcs12 -in prakashsinha-mint.pfx -clcerts -nokeys -out prakashsinha-mint.cer
#pub_hostname prakashsinha-mint  simple ip  or  dns record?

#security certificate creation from wildcard
#Rename certificate from wildcard.pfx to <domain name>.pfx
cp wildcard.pfx domain-a1.company.com.pfx
# Extract Certificate
openssl pkcs12 -in domain-a1.company.com.pfx -clcerts -nokeys -out domain-a1.cer

# Extract key with passphrase
openssl pkcs12 -in domain-a1.company.com.pfx -nocerts -out domain-a1.key

# Extract key without passphrase
openssl rsa -in domain-a1.key -outform PEM -out domain-a1-PEM.key


#tree command with size
tree -L 1 -hf /home/prakashsinha/Documents/k.8.s/ssl//home/prakashsinha/Documents/k.8.s/ssl
tree -L 3 --du -h  ./certs/
#tree command with date and size
tree -D -L 3 --du -h  ./certs/

#linux mint terminal zoom in zoom out tool
sudo apt-get install xdotool
#command
xdotool key Ctrl+plus
xdotool key Ctrl+minus

#
sudo dpkg-reconfigure ca-certificates


#To list directories with total and depth as 1
du -h --max-depth=1 /home | sort -n -r
#https://stackoverflow.com/questions/1019116/using-ls-to-list-directories-and-their-total-sizes


#redis error
#redis.conf
stop-writes-on-bgsave-error no
#https://stackoverflow.com/questions/19581059/misconf-redis-is-configured-to-save-rdb-snapshots

#encrypt text with openssl
# generate a 2048-bit RSA key and store it in key.txt
openssl genrsa -out key.txt 2048

# encrypt "hello world" using the RSA key in key.txt
echo "hello world" | openssl rsautl -inkey key.txt -encrypt >output.bin

# decrypt the message and output to stdout
openssl rsautl -inkey key.txt -decrypt <output.bin

# dmjenkins.dm.com token for prakashsinhaba
11c2ec0362ef573867cc8137f5d220aef1

#cat with line number
cat -n temp.txt

#cybage intranet
#http://cybintranet/sites/Home/default.aspx


####################################################################################################
#########################################KUBERNETES#################################################
####################################################################################################

##Command to apply configurations to pods
kubectl delete po update-demo-<pod name>
kubectl scale deployment/update-demo --replicas=0; kubectl scale deployment/update-demo --replicas=1


##Command to get component status
kubectl get cs

##Command to taint the node for spark scheduling
kubectl taint nodes <node> thisnode=HatesPods:NoSchedule

##minikube k8s setup
minikube start
minikube stop
#host path /home/cybage/decisionmines:/home/docker/decisionmines
minikube start
minikube dashboard
#create secret
#kubectl create -f depl svc file names

#Install k8s
https://linuxhint.com/minikube_tutorial_made_easy/

#https://kubernetes.io/docs/tasks/tools/install-kubectl/
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

kubectl client v1.12.2
kubectl server v1.10.0

#Install VirtualBox from package manager

#https://github.com/kubernetes/minikube/releases
sudo dpkg -i Downloads/minikube_0.30-0.deb
minikube 0.30.0
#minikube login credentials ?

#k8s commands
minikube start
kubectl cluster-info
kubectl cluster-info dump

#kompose commands
#binary installation
curl -L https://github.com/kubernetes/kompose/releases/download/v1.1.0/kompose-linux-amd64 -o kompose
chmod +x kompose
sudo mv ./kompose /usr/local/bin/kompose
#sample example https://kompose.io/getting-started/

#docker login effects
cat ~/.docker/config.json
#either Auth or credStore

#to pull images from private docker registry, create a secret in k8s
kubectl create secret docker-registry regcred --docker-server=https://index.docker.io/v1/ --docker-username=prakashsinhab --docker-password=pu00170@ --docker-email=prakash.uday.bayas@gmail.com

#view secret in yaml
kubectl get secret regcred --output=yaml

#decoding dockerconfigjson from base64
kubectl get secret regcred --output="jsonpath={.data.\.dockerconfigjson}" | base64 --decode

#decoding auth from base64
echo "" | base64 --decode


#either
kompose convert
kubectl create -f <comma seperated output file name(s)> .

##locale timezone
volumeMounts:
      - name: tz-config
        mountPath: /etc/localtime
    volumes:
      - name: tz-config
        hostPath:
           path: /usr/share/zoneinfo/Asia/Kolkata

#update deployment file with secret parallel to 'containers' key
#imagePullSecrets:
#  - name: regcred
kubectl delete pods --all
kubectl create -f <comma seperated list of all the deployment files after kompose up> .

#or #
kompose up


#update k8s service type to nodeport in spec section
#spec:
#  type: NodePort
kubectl apply -f <comma seperated yaml filenames>


#also resource specific name
kubectl get deployment <deployment name like dm-scheduler> --output=yaml
#to describe a resource
kubectl describe deployment.extensions/dm-scheduler


#kubectl list all the pods from all namespaces
kubectl get pods --all-namespaces
#specific namespace, say default
kubectl get pods --namespace=default

#simple volume mounts with host path mappings example alternative to persistent volumes and config map
#https://stackoverflow.com/questions/37302776/kubectl-get-pods-kubectl-get-pods-status-imagepullbackoff
#host path example https://kubernetes.io/docs/concepts/storage/volumes/#hostpath
#vm mappings are like key value so if key is hosthome, after ssh to vm, it will be at ls /hosthome and likewise
#update deployment file mappings likewise before kubectl create -f . --validate=false


#describe service svc to get its NodePort
kubectl describe svc dm-scheduler
#get cluster info to know node's public ip
kubectl cluster-info
#in browser, ip:port to access the application service URL

#minikube lifecycle
minikube delete
minikube start
minikube stop

#minikube vm mount host path
#comment out type from hostpaths of deployments
/home/prakashsinha/decisionimes:/home/docker/decisionmines

#minikube lifecycle
minikube start

#up service and deployment pair say of scheduler
ls *scheduler*.yaml
kubectl create -f dm-scheduler-deployment.yaml,dm-scheduler-service.yaml


#http://pwittrock.github.io/docs/user-guide/configmap/
#https://kubernetes.io/docs/tasks/administer-cluster/namespaces-walkthrough/
#https://kubernetes.io/docs/reference/kubectl/overview/

#certificates view
kubectl config view

#current context
kubectl config current-context

#set context
kubectl config set-context efk-example --namespace=efk-example \
  --cluster=minikube \
  --user=minikube

#configmap,deployment and service
kubectl create configmap e-config-map --from-file=elastic/config/elasticsearch.yml --from-file=elastic/data/elasticsearch --from-file=elastic/logs/elasticsearch --namespace=efk-example

#
# Create the service account in the current namespace
# (we assume default)
kubectl create serviceaccount my-dashboard-sa
# Give that service account root on the cluster
kubectl create clusterrolebinding my-dashboard-sa \
--clusterrole=cluster-admin \
--serviceaccount=default:my-dashboard-sa
# Find the secret that was created to hold the token for the SA
kubectl get secrets
# Show the contents of the secret to extract the token
kubectl describe secret my-dashboard-sa-token-xxxxx

#
kubectl get svc --all-namespaces
#change the dashboard service type to NodePort instead of Cluster IP

#token in one line command - deployment-controller-token
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | awk '/^deployment-controller-token-/{print $1}') | awk '$1=="token:"{print $2}'

#proxy dashboard
kubectl proxy --address='0.0.0.0' --accept-hosts='^*$'

#efk-example

#create namespace
kubectl create -f namespace-efk_example.json

#create secret for docker login in this namespace
kubectl create secret docker-registry regcred --docker-server=https://index.docker.io/v1/ --docker-username=<docker username> --docker-password=<docker password> --docker-email=<docker email address> --namespace=efk-example


#create config maps and volume claims
kubectl create -f e-config-map.yaml,e-data-claim-pvc.yaml,e-logs-claim-pvc.yaml,f-config-map.yaml,captcha-api-f-claim-pvc.yaml, k-config-map.yaml

#set vm max limit
sudo sysctl -w vm.max_map_count=262144

#variable to be updated in file
cat /etc/sysctl.conf

#create elasticsearch
kubectl create -f dm-elasticsearch-deployment.yaml,dm-elasticsearch-service.yaml

#create filebeat
kubectl create -f dm-filebeat-deployment.yaml,dm-filebeat-service.yaml


#create kibana
kubectl create -f dm-kibana-deployment.yaml,dm-kibana-service.yaml

#kibana service url with NodePort
minikube service dm-kibana --url=true --namespace=efk-example


#upgrade minikube
#https://github.com/kubernetes/minikube/releases

#delete all ur pods,deployment, services
kubectl delete --all -n <your-namespace>

# swap off and restart docker; restart kubelete
#When node is in NotReady state then
switch to root
swapoff -a
systemctl restart docker
systemctl restart kubelet

#kubectl not working after restart of k8s master
sudo -i
swapoff -a
exit
strace -eopenat kubectl version

#install helm from script
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh
#validate if tiller pod is running
kubectl -n kube-system get po

#install specific chart from project's root directory, say ef-stack-helm,
helm install .
export POD_NAME=$(kubectl get pods --namespace default -l "app=kibana,release=goodly-bear" -o jsonpath="{.items[0].metadata.name}")
sudo kubectl port-forward $POD_NAME 8080:5601

##Write update to running container into new image id with same tag
docker commit <container id>
#docker --help

#docker private registry over HTTP
#https://stackoverflow.com/questions/42564058/how-to-use-local-docker-images-with-minikube
docker run -d -p 5000:5000 --restart=always --name registry registry:2
docker tag ubuntu prakashsinha-mint.cybage.com:5000/fenginx:latest
docker push prakashsinha-mint.cybage.com:5000/fenginx:latest
docker pull prakashsinha-mint.cybage.com:5000/fenginx:latest
#http://prakashsinha-mint.cybage.com:5000/v2/

#https://github.com/docker/distribution/issues/1874 daemon.json
#Create or modify /etc/docker/daemon.json
{ "insecure-registries":["myregistry.example.com:5000"] }
#Restart docker daemon
sudo service docker restart

#minikube start with insecure registry
minikube start --vm-driver="xhyve" --insecure-registry="http://prakashsinha-mint.cybage.com:5000/v2/"

#local private registry image in k8s deployment
#- image: prakashsinha-mint.cybage.com:5000/fenginx:latest
        #imagePUllPolicy: ifNotPresent

#Mount minikube over nfs
minikube ssh "sudo mkdir -p /host-sources && sudo mount -t nfs -o nfsvers=3,tcp 192.168.99.1:${sources_dir} /host-sources"
mount.nfs: access denied by server while mounting 192.168.99.1:

#Forcefully delete a pod example
kubectl delete pod configfrontend-68978c8697-qz2xv -n microservice --grace-period=0 --force

#command in k8s deployment file
spec:
  containers:
  - args:
    - -c
    - sysctl -w vm.max_map_count=262144
    command:
    - /bin/sh
    image: cybagesoftware/elasticsearch-oss:6.3.2

#Vulcans Commands to find the Module Name and Image Name on docker-compose and kubernetes environment are
#K8s Command  :
paste <(app get pod -o go-template --template="{{range .items}}{{range .spec.containers}}{{.name}} {{end}}{{end}}" | sed 's/ /\n/g' ) <(app get pod -o go-template --template="{{range .items}}{{range .spec.containers}}{{.image}} {{end}}{{end}}" | sed 's/ /\n/g') | column -s $'\t' -t
#Docker-Compose command :
paste <(echo `docker ps --format {{.Names}}` | sed 's/ /\n/g') <(echo `docker ps --format {{.Image}}` | sed 's/ /\n/g') | column -s $'\t' -t
paste <(intpl get pod -o go-template --template="{{range .items}}{{range .spec.containers}}{{.name}} {{end}}{{end}}" | sed 's/ /\n/g' ) <(intpl get pod -o go-template --template="{{range .items}}{{range .spec.containers}}{{.image}} {{end}}{{end}}" | sed 's/ /\n/g') | column -s $'\t' -t


####################################################################################################
#########################################AWS########################################################
####################################################################################################

#list creds
cat ~/.aws/credentials

#list buckets
aws s3 ls --profile aws-cli-user

#configure user profile
aws configure --profile aws-cli-user

#copy file to aws ec2 instance example
scp -i "DM-Demo-POC-us-east-1-key.pem" conversionIQ_salesforce.py  ubuntu@ec2-34-225-83-89.compute-1.amazonaws.com:/home/ubuntu/
ssh -i dev-ohio/devops-key.pem ubuntu@18.222.114.45
scp -i "devops-key.pem" -r dm50etllib/*  ubuntu@18.222.114.45:/home/ubuntu/dm50etllib/
ssh -i key/devops-key.pem ubuntu@10.0.102.4
scp -i "devops-key.pem" -r dm50etllib/*  ubuntu@10.0.102.4:/app/decisionmines/tools/pentaho/data-integration/lib/



####################################################################################################
#########################################JENKINS PIPELINE###########################################
####################################################################################################

        //sh "#!/bin/bash \n" +
        //"set -o allexport \n" +
        //"source /tmp/pl-action-batch-dev-image-id.txt \n" +
       //"echo \"Hello from SHELL\" \n" +
       //"echo \"Hello from \$IMAGE_ID\" \n"


java.lang.NoSuchMethodError: No such DSL method 'steps' found among steps [ArtifactoryGradleBuild, MavenDescriptorStep, acceptGitLabMR, addGitLabMRComment, addInteractivePromotion, archive, artifactoryDistributeBuild, artifactoryDownload, artifactoryMavenBuild, artifactoryPromoteBuild, artifactoryUpload, bat, bitbucketStatusNotify, build, catchError, checkout, collectEnv, conanAddRemote, conanAddUser, container, containerLog, deleteDir, deployArtifacts, dir, dockerFingerprintFrom, dockerFingerprintRun, dockerNode, dockerPullStep, dockerPushStep, dockerPushWithProxyStep, echo, emailext, emailextrecipients, envVarsForTool, error, fileExists, getArtifactoryServer, getContext, git, gitlabBuilds, gitlabCommitStatus, initConanClient, input, isUnix, jiraComment, jiraIssueSelector, jiraSearch, junit, kubernetesDeploy, library, libraryResource, load, lock, mail, milestone, newArtifactoryServer, newBuildInfo, newGradleBuild, newMavenBuild, node, parallel, podTemplate, powershell, properties, publishBuildInfo, publishHTML, pwd, readFile, readTrusted, resolveScm, retry, rtp, runConanCommand, script, sh, slackSend, sleep, sshagent, stage, stash, step, svn, timeout, timestamps, tm, tool, unarchive, unstash, updateGitlabCommitStatus, validateDeclarativePipeline, waitForQualityGate, waitUntil, withContext, withCredentials, withDockerContainer, withDockerRegistry, withDockerServer, withEnv, withKubeConfig, wrap, writeFile, ws, xrayScanBuild] or symbols [all, allOf, always, ant, antFromApache, antOutcome, antTarget, any, anyOf, apiToken, architecture, archiveArtifacts, artifactManager, attach, authorizationMatrix, batchFile, bitbucketpr, booleanParam, branch, brokenBuildSuspects, brokenTestsSuspects, buildButton, buildDiscarder, buildParameter, buildingTag, caseInsensitive, caseSensitive, certificate, changeRequest, changelog, changeset, checkoutToSubdirectory, choice, choiceParam, cifsPublisher, cleanWs, clock, cloud, command, configFile, configFileProvider, configMapVolume, containerEnvVar, containerLivenessProbe, containerTemplate, copyArtifactPermission, copyArtifacts, credentials, cron, crumb, culprits, default, defaultView, demand, developers, disableConcurrentBuilds, disableResume, docker, dockerCert, dockerfile, downloadSettings, downstream, dumb, durabilityHint, emptyDirVolume, emptyDirWorkspaceVolume, envVar, envVars, environment, equals, expression, file, fileParam, filePath, fingerprint, frameOptions, freeStyle, freeStyleJob, fromScm, fromSource, git, gitLabConnection, github, githubPush, gitlab, globalConfigFiles, gradle, headRegexFilter, headWildcardFilter, hostPathVolume, hostPathWorkspaceVolume, hyperlink, hyperlinkToModels, inheriting, inheritingGlobal, installSource, isRestartedRun, jdk, jdkInstaller, jgit, jgitapache, jnlp, jobName, kubeconfigContent, kubernetes, label, lastCompleted, lastDuration, lastFailure, lastGrantedAuthorities, lastStable, lastSuccess, lastSuccessful, latestSavedBuild, legacy, legacySCM, list, local, location, logRotator, loggedInUsersCanDoAnything, masterBuild, maven, maven3Mojos, mavenErrors, mavenMojos, mavenWarnings, modernSCM, myView, never, newContainerPerStage, nfsVolume, nfsWorkspaceVolume, node, nodeProperties, nodejs, nodejsci, nonInheriting, nonStoredPasswordParam, none, not, onFailure, overrideIndexTriggers, paneStatus, parameters, password, pattern, permalink, permanent, persistentVolumeClaim, persistentVolumeClaimWorkspaceVolume, pipeline-model, pipelineTriggers, plainText, plugin, podAnnotation, podEnvVar, pollSCM, portMapping, preserveStashes, projectNamingStrategy, proxy, queueItemAuthenticator, quietPeriod, recipients, remotingCLI, requestor, run, runParam, schedule, scmRetryCount, scriptApprovalLink, search, secretEnvVar, secretVolume, security, shell, skipDefaultCheckout, skipStagesAfterUnstable, slave, sourceRegexFilter, sourceWildcardFilter, specific, ssh, sshPublisher, sshPublisherDesc, sshTransfer, sshUserPrivateKey, stackTrace, standard, status, string, stringParam, swapSpace, tag, text, textParam, tmpSpace, toolLocation, unsecured, upstream, upstreamDevelopers, usernameColonPassword, usernamePassword, viewsTabBar, weather, withAnt, withSonarQubeEnv, workspace, zfs, zip] or globals [Artifactory, currentBuild, docker, env, params, pipeline, scm]

####################################################################################################
#########################################JENKINS PIPELINE###########################################
####################################################################################################





#team contacts temp
https://decisionmines.atlassian.net/wiki/spaces/DM/pages/30085490/Team+Definition

#printer configuration IP
\\172.27.172.100

#ct-share configuration IP
#172.27.172.203 and domain cybage.com as workgroup


#cyb temp
http://cybintranet/sites/Home/default.aspx

#
#DecisionMines
alias dmissue="xdg-open https://decisionmines.atlassian.net"
alias dmchat="xdg-open http://teams.microsoft.com/"
alias dmmail="xdg-open http://outlook.office365.com/"
alias dmwiki="xdg-open https://decisionmines.atlassian.net/wiki/spacedirectory/view.action"
alias dmcode="xdg-open https://decisionmines.bitbucket.org/dashboard/overview"
alias dmcicd="xdg-open http://172.27.15.8:8081/"
alias dmenvdtls="xdg-open https://decisionmines.atlassian.net/wiki/spaces/DM/pages/898826266/Kubernetes+Environment+Wise+Details"
alias dmssh68="ssh cybage@172.27.15.68"
alias dmssh166="ssh cybage@172.27.15.166"


####################################################################################################
#########################################SCHEDULER AZKABAN###########################################
####################################################################################################

sessionid="$(curl -s -X POST --data "action=login&username=dm-azkaban&password=cybage@123" http://pl-pldev.cybage.com:31588 | grep "session.id" | cut -c 19-54)"
curl -s -X POST --data "session.id=$sessionid&action=create&name=dmines-daily&description=kapilsa" http://pl-pldev.cybage.com:31588/manager
curl -s -X POST -H "Content-Type: multipart/form-data" -F "session.id=${sessionid}" -F "project=dminesdaily" -F "ajax=upload" -F "file=@dmines-daily.zip;type=application/zip" http://pl-pldev.cybage.com:31588/manager


##############################################################################################
#########################################ANCHOR-CLI###########################################
##############################################################################################

##
git clone https://github.com/anchore/anchore-cli
  cd anchore-cli
  pip install --user --upgrade .
  sudo apt install python-pip
  echo $ANCHORE_CLI_URL
  pip install --user --upgrade .
  anchore-cli
  anchore-cli --version
  echo $ANCHORE_CLI_URL
  ANCHORE_CLI_URL=http://localhost:8228/v1
  ANCHORE_CLI_USER=admin
  ANCHORE_CLI_PASS=foobar
  echo $ANCHORE_CLI_URL
  anchore-cli image add docker.io/librar
  cd ../l
  mkdir ~/aevolume
  mkdir aevolume
  cd ~/aevolume
  cd /home/prakash/aevolume
  docker pull docker.io/anchore/anchore-engine:latest
  docker create --name ae docker.io/anchore/anchore-engine:latest
  docker cp ae:/docker-compose.yaml ~/aevolume/docker-compose.yaml
  docker rm ae
  docker-compose pull
  docker-compose up -d
  ANCHORE_CLI_URL=http://localhost:8228/v1
  ANCHORE_CLI_USER=admin
  ANCHORE_CLI_PASS=foobar
  curl http://localhost:8228/v1
  anchore-cli image add docker.io/library/debian:latest
  export ANCHORE_CLI_USER
  export ANCHORE_CLI_URL
  export ANCHORE_CLI_PASS
  anchore-cli image add openjdk:10-jdk
  anchore-cli image add docker.io/library/debian:latest
  docker login
  anchore-cli image add openjdk:10-jdk
  anchore-cli image add docker.io/library/debian:latest
  anchore-cli image add cybagesoftware/pl-scheduler-dev:latest
  anchore-cli image add docker.io/library/cybagesoftware/pl-scheduler-dev:latest
  anchore-cli image add docker.io/cybagesoftware/pl-scheduler-dev:latest
  anchore-cli --help
  anchore-cli registry --help
  anchore-cli registry add --help
  anchore-cli registry add REGISTRY docker.io REGISTRY_USER prakashsinhab  REGISTRY_PASS pu00170@
  anchore-cli registry add docker.io prakashsinhab  pu00170@
  anchore-cli image add docker.io/cybagesoftware/pl-scheduler-dev:latest
  anchore-cli image add docker.io/cybagesoftware/pl-redis-dev:latest
  anchore-cli image add docker.io/cybagesoftware/grafana:6.2.4
  sudo anchore-cli image add docker.io/cybagesoftware/grafana:6.2.4
  anchore-cli image add docker.io/cybagesoftware/app-dashboard-web-rel:latest
  anchore-cli image add openjdk:10-jdk
  history
  pwd
  ls -la
  cd //
  cd /home/prakash/
  ls -la
  ls -la .docker/
  cat .docker/config.json
  anchore-cli image add https://index.docker.io/cybagesoftware/app-dashboard-web-rel:latest
  anchore-cli image add index.docker.io/cybagesoftware/app-dashboard-web-rel:latest
  anchore-cli image add docker.io/cybagesoftware/app-dashboard-web-rel:latest
  anchore-cli image add --debug docker.io/cybagesoftware/app-dashboard-web-rel:latest
  anchore-cli image add docker.io/cybagesoftware/app-dashboard-web-rel:latest --debug
  anchore-cli --debug image vuln docker.io/library/debian:latest os
  anchore-cli --debug image vuln docker.io/cybagesoftware/app-dashboard-web-rel:latest
  anchore-cli --debug image add docker.io/cybagesoftware/app-dashboard-web-rel:latest
  ps -ef | grep analy
  anchore-cli --debug image add docker.io/cybagesoftware/app-dashboard-web-rel:latest
  anchore-cli --debug image add docker.io/cybagesoftware/pl-dre-service-config-dev:1.6.0-SNAPSHOT-3fcdcaf-build5
  anchore-cli image add docker.io/cybagesoftware/pl-dre-service-config-dev:0.0.1-SNAPSHOT-1bd9baf-build3
  ##
