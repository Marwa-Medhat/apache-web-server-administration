#!/bin/bash
source dataopdb.sh
source checkerdb.sh

function displayMenu {

 choice='Please enter your choice: '
 options=("Install Apache"  "Remove Apache" "list all virtual hosts" "add virtual host" "delete virtual host" "disable virtual host" "enable virtual host" "enableAuthVirtualHost" "disable auth virtual host" "start apache" "stop Apache" "Quit")	 
 select opt in "${options[@]}"
 do
     case $opt in
         "Install Apache")
				echo '1';
				#install apache web server
				checkApache
	        ApacheEXIST=${?} 
            if [ ${ApacheEXIST} == 0] ##not installed so install it 
            then
				installapache
				displayMenu
			else
				displayMenu									
            fi	
             ;;
          "Remove Apache")
			echo '2';
			#remove apache web server"
			# listallvirtualhosts
			checkApache
	        ApacheEXIST=${?} ##already installed
            if [ ${ApacheEXIST} == 1 ]
            then
			removeapache
			displayMenu
			else
				displayMenu									
            fi
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
			displayMenu									
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

			checkApache
	        ApacheEXIST=${?} ##already installed
            if [ ${ApacheEXIST} == 1 ]
            then
						check_if_virtualhost_exist_or_not  
						EXISTLOCALHOST=${?}
						if [ ${EXISTLOCALHOST} == 0 ]
						then
							addvirtualhost
							displayMenu									
						else
				        displayMenu									
                        fi
			else
				displayMenu									
            fi

      	;;
     	"delete virtual host")
         echo '5';
			#delete virtual host
			checkApache
	        ApacheEXIST=${?} ##already installed
            if [ ${ApacheEXIST} == 1 ]
            then
			deletevirtualhost
			displayMenu									
			else
				displayMenu									
            fi
             ;;
         "disable virtual host")
             echo '6';
			checkApache
	        ApacheEXIST=${?} ##already installed
            if [ ${ApacheEXIST} == 1 ]
            then
			disablevirtualhost
		    displayMenu									
			else
					displayMenu									
			fi
             ;;
       "enable virtual host")
             echo '7';
		 #enable virtual host 
		    checkApache
	        ApacheEXIST=${?} ##already installed
            if [ ${ApacheEXIST} == 1 ]
            then
		    enablevirtualhost
			displayMenu									
		    else
				displayMenu									
			fi
              ;;
        "enableAuthVirtualHost")
           echo '8';
		   #   checkApache
	        # ApacheEXIST=${?} ##already installed
            # if [ ${ApacheEXIST} == 1 ]
            # then
			# enableauthvirtualhost
			# else
			# 			displayMenu									
			# fi
			###Check first if Apache exist or not 
			### then check if make enbleauthantication to website before or not 
		   checkApache
	        ApacheEXIST=${?} ##already installed
            if [ ${ApacheEXIST} == 1 ]
            then
						check_if_authorized_or_not
						EXISTAuthantication=${?}
						if [ ${EXISTAuthantication} == 1 ]  ##not authorized so make auth by call enable fn 
						then
							enableauthvirtualhost
							displayMenu									
						else
				        displayMenu									
                        fi
			else
					displayMenu									
			fi
		    #enable  auth virtual host
             ;;
 			"disable auth virtual host")
 			 echo '9';
			#   checkApache
	        # ApacheEXIST=${?} ##already installed
            # if [ ${ApacheEXIST} == 1 ]
            # then
			# disableauthvirtualhost
			# else
			# 			displayMenu									
			# fi
			checkApache
	        ApacheEXIST=${?} ##already installed
            if [ ${ApacheEXIST} == 1 ]
            then
						check_if_enable_authorized_or_not
						EXISTAuthantication=${?}
						if [ ${EXISTAuthantication} == 1 ]  ##authorized so can make Nonauth by call disableauth fn 
						then
						disableauthvirtualhost
						displayMenu									
						else
				        displayMenu									
                        fi
			else
					   displayMenu									
			fi

		#disable  auth virtual host
             ;;
			 "start apache")
				startApache
				displayMenu
			 ;;
			 "stop Apache")
				stopApache
				displayMenu
			 ;;
         "Quit")
             break
             ;;
         *) echo "invalid option $REPLY";;
     esac
 done
 }

