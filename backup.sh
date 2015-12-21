#!/bin/bash

# This file is under GPL V3 license
# Created by Marcos Zuriaga Miguel on march 2014
# This script will backup a running minecraft server that is lanuched into an screen session

SCREEN_NAME="minecraft"
BACKUP_DIR="/raid/minecraft/backups/"
MINECRAFT_DIR="/raid/minecraft/"
WORLD_DIR=$MINECRAFT_DIR"world/"
LOG_FILE=$BACKUP_DIR"backup.log"

if [ ! -d $BACKUP_DIR ]
then
	screen -x $SCREEN_NAME -X stuff "`printf "say Creating backup directory...\r"`"
	echo "Creating bakcup directory on $BACKUP_DIR" >> $LOG_FILE
        mkdir -p $BACKUP_DIR
fi


screen -x $SCREEN_NAME -X stuff "`printf "say Disabling auto-save\r"`"
echo "Disabling auto-save" >> $LOG_FILE
screen -x $SCREEN_NAME -X stuff "`printf "save-off\r"`"

screen -x $SCREEN_NAME -X stuff "`printf "say Saving world...\r"`"
echo "Saving remaining wold changes" >> $LOG_FILE
screen -x $SCREEN_NAME -X stuff "`printf "save-all\r"`"

screen -x $SCREEN_NAME -X stuff "`printf "say Backing up world... \'$WORLD\'\r"`"
DT=$(date +"%G-%m-%d-%H-%M-%S")
BACKUP_NAME=$BACKUP_DIR"world-"$DT".tar.gz"
echo "Creating backup ($BACKUP_NAME)" >> $LOG_FILE
tar -czvf $BACKUP_NAME $WORLD_DIR >> $LOG_FILE 2>&1

screen -x $SCREEN_NAME -X stuff "`printf "say Backup completed\r"`"
screen -x $SCREEN_NAME -X stuff "`printf "say Enabling auto-save\r"`"
echo "Enabling auto-save" >> $LOG_FILE
screen -x $SCREEN_NAME -X stuff "`printf "save-on\r"`"

screen -x $SCREEN_NAME -X stuff "`printf "say All done. Backup for $DT saved.\r"`"

