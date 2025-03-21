#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%f-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cute -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 $R FAILURE $N"
    else
        echo -e "$2 $G SUCCESS $N"
    fi
}

check_root(){
    if [ $USERID -ne 0 ]
    then
        echo "Please run this script with the root access."
        exit 1 #Manually exit if error comes.
    else 
        echo "You are super user."
    fi
}