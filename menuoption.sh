#!/bin/bash
source dataopdb.sh
source checkerdb.sh

function displayMenu {

 choice='Please enter your choice: '
 options=("Install Apache"  "Remove Apache" "list all virtual hosts" "add virtual host" "delete virtual host" "disable virtual host" "enable virtual host" "enableAuthVirtualHost" "disable auth virtual host" "Quit")	 
 select opt in "${options[@]}"
 do
     case $opt in
         "Install Apache")
				echo '1';
				#install apache web server
				installapache
             ;;
          "Remove Apache")
			echo '2';
			#remove apache web server"
			removeapache
			;;
 	"list all virtual hosts")
        #list all virtual hosts
			echo '3'
			listallvirtualhosts	
	     	;;
 	"add virtual host")
 		echo '4';
            #add virtual host
			addvirtualhost
      	;;
     	"delete virtual host")
         echo '5';
			#delete virtual host
			deletevirtualhost
             ;;
         "disable virtual host")
             echo '6';
		 disablevirtualhost
             ;;
       "enable virtual host")
             echo '7';
		 #enable virtual host 
		 enablevirtualhost
              ;;
        "enableAuthVirtualHost")
           echo '8';
		 enableauthvirtualhost
		#enable  auth virtual host
             ;;
 			"disable auth virtual host")
 			 echo '9';
		 disableauthvirtualhost
		#disable  auth virtual host
             ;;
         "Quit")
             break
             ;;
         *) echo "invalid option $REPLY";;
     esac
 done
 }

