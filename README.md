# MinecraftBackup
Backup script for minecraft server using screen

This script will make a backup of your minecraft world, for it to be running you need to be executing your minecraft server inside a named screen terminal session.
How do you do this? easy:
screen -U -S minecraft java -Xms512M -Xmx1G -XX:PermSize=128m -jar ftbserver.jar

Let's explain this: 
screen -U makes sure it's handling utf-8  output
screen -S minecraft opens a session named "minecraft" that will execute the command right after it

so screen -U -S minecraft will create a minecraft screen that uses utf8

After this two parameters you specify your command, the one that runs the minecraft server (java -Xms512M -Xmx1G -XX:PermSize=128m -jar ftbserver.jar), or the launch script. I personally eddited my launch script so it contains the screen session creation.

If you are not familiar with screen, you can detach your session from the current terminal, and keep the server running in the background with "CTRL+A CTRL+D" and recover the background running session with screen -r minecraft

If you are interested in screen, check it's manual.


Once you have your running minecraft server, you have to change a few values inside the script, like where you want your backups, what's your screen session name, the directory that contains the minecraft world, where on your system is the minecraft server root and that stuff.

Also you can setup a cron job to keep your world periodically backed up.
