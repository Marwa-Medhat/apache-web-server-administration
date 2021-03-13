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
				displayMenu
             ;;
          "Remove Apache")
			echo '2';
			#remove apache web server"
			removeapache
			displayMenu
			;;
 	"list all virtual hosts")
        #list all virtual hosts
			echo '3'
			# listallvirtualhosts
			checkApache
	        ApacheEXIST=${?} ##already installed
            if [ ${ApacheEXIST} == 1 ]
            then
			listallvirtualhosts	
			else
				displayMenu									
            fi
	     	;;
 	"add virtual host")
 		echo '4'
        #  check_if_virtualhost_exist_or_not
		#  check_if_virtualhost_exist_or_not 
		#   check_if_virtualhost_exist_or_not
            #add virtual host
			# addvirtualhost

		#4 --> add -->checker exist or not-->lw msh mwgod --> call add --> lw  mwgod yktb exist y3rd Menu tani 
			check_if_virtualhost_exist_or_not  
            EXISTLOCALHOST=${?}
			 if [ ${EXISTLOCALHOST} == 0 ]
             then
				addvirtualhost
			else
				displayMenu									
            fi

      	;;
     	"delete virtual host")
         echo '5';
			#delete virtual host
			deletevirtualhost
			displayMenu
             ;;
         "disable virtual host")
             echo '6';
		 disablevirtualhost
		 displayMenu
             ;;
       "enable virtual host")
             echo '7';
		 #enable virtual host 
		 enablevirtualhost
		 displayMenu
              ;;
        "enableAuthVirtualHost")
           echo '8';
		 enableauthvirtualhost
		 displayMenu
		#enable  auth virtual host
             ;;
 			"disable auth virtual host")
 			 echo '9';
		 disableauthvirtualhost
		 displayMenu
		#disable  auth virtual host
             ;;
         "Quit")
             break
             ;;
         *) echo "invalid option $REPLY";;
     esac
 done
 }

