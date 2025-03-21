#!/bin/bash

source ./common.sh

check_root

echo "please enter DB Password:"
read -s mysql_root_password

dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "Installing MySQL Server"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "Enabling MySQL Server"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "Starting MySQL Server"


mysql -h db.dwas78s.online -uroot -p${mysql_root_password} -e 'show database;' &>>$LOGFILE
if  [ $? -ne 0 ]
then
    mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE
    VALIDATE $?  # Mysql root password setup
else
    echo -e "Mysql root password is already setup...$Y SKIPPING$N"
fi
