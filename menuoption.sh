#!/bin/bash
source dataopdb.sh
source checkerdb.sh

function displayMenu {
    echo "1-to install apache web server"
	echo "2-to remove apache web server"
	echo "3- list all virtual hosts"
	echo "4-add virtual host "
	echo "5-delete virtual host "
	echo "6-disable virtual host "
	echo "7-enable virtual host "
	echo "8-enable  auth virtual host" 
	echo "9-disable auth virtual host "
    echo "10-start apache"		
	echo "11-stop Apache"
	echo "12- Quit"
	# runMenu

}	



function runMenu {
	local CH
	echo "Enter your choice"
	local FLAG=1
	while [ ${FLAG} -eq 1 ]
	do
	read CH
	case ${CH} in
		"1")
			echo '1'
		checkApache
	        ApacheEXIST=${?} 
            if [ ${ApacheEXIST} == 0] ##not installed so install it 
            then
				installapache
				displayMenu
			else
				echo "already installed"
				displayMenu	
		    fi	
			
			;;
		"2")
			echo '2'
			#remove apache web server"
			# listallvirtualhosts
			checkApache
			ApacheEXIST=${?} ##already installed
		    if [ ${ApacheEXIST} == 1 ]
		    then
				removeapache
				displayMenu
				else
					echo "already removed"
		  		  displayMenu									
            fi
			;;
		"3")
			 #list all virtual hosts
			echo '3'
			# listallvirtualhosts
			checkApache
	        ApacheEXIST=${?} ##already installed
            if [ ${ApacheEXIST} == 1 ]
            then
			listallvirtualhosts	
			echo "-----------------------------"										
			else
			echo "Apache not exist you need to install it first"											
		    fi

					 
			;;
		
		"4")
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
						else
						 echo "Already exist"	
				
                        fi
			else
				echo "Apache not exist you need to install it first"										
            fi

			;;
		"5")
			echo '5'
			#delete virtual host
			checkApache
	        ApacheEXIST=${?} ##already installed
            if [ ${ApacheEXIST} == 1 ]
            then
			deletevirtualhost
			else
				echo "Apache not exist you need to install it first"
            fi
		;;
		"6")
		 echo '6'
			checkApache
	        ApacheEXIST=${?} ##already installed
            if [ ${ApacheEXIST} == 1 ]
            then
                  disablevirtualhost
			else
					echo "Apache not exist you need to install it first"
			fi
		
		;;
		"7")
		echo '7'
		 #enable virtual host 
		    checkApache
	        ApacheEXIST=${?} ##already installed
            if [ ${ApacheEXIST} == 1 ]
            then
		    enablevirtualhost
		    else
				echo "Apache not exist you need to install it first"
			fi
		;;
		"8")
		           echo '8'
		    
		   checkApache
	        ApacheEXIST=${?} ##already installed
            if [ ${ApacheEXIST} == 1 ]
            then
						check_if_authorized_or_not
						EXISTAuthantication=${?}
						if [ ${EXISTAuthantication} == 1 ]  ##not authorized so make auth by call enable fn 
						then
							enableauthvirtualhost
						
                        fi
			else
				echo "Apache not exist you need to install it first"

			fi
		    #enable  auth virtual host
		;;
		"9")
		 echo '9'
			checkApache
	        ApacheEXIST=${?} ##already installed
            if [ ${ApacheEXIST} == 1 ]
            then
						check_if_enable_authorized_or_not
						EXISTAuthantication=${?}
						if [ ${EXISTAuthantication} == 1 ]  ##authorized so can make Nonauth by call disableauth fn 
						then
						disableauthvirtualhost			
                        fi
			else
					echo "Apache not exist you need to install it first"
			fi
		#disable  auth virtual host
		;;
		
		"10")
			   checkApache
	        ApacheEXIST=${?} ##already installed
            if [ ${ApacheEXIST} == 1 ]
            then
			startApache
			else
				echo "Apache not exist you need to install it first"
			fi
				
		;;
		"11")
		echo '11'
			   checkApache
	        ApacheEXIST=${?} ##already installed
            if [ ${ApacheEXIST} == 1 ]
            then

			stopApache
			else
				echo "Apache not exist you need to install it first"
			fi
				# stopApache
				# displayMenu
		;;
		
		"12")
		echo '12'
		##exit
			FLAG=0
		;;
		
		*)
			echo "Invalid choice, please try again"
			;;
	esac
	if [ ${FLAG} -eq 1 ]   
	then
		displayMenu
	fi
	done
}
