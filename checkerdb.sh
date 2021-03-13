 #!/bin/bash

##############################################3
function checkApache {
    
     service apache2 status > status.txt 2>&1 
     status=$(grep 'unrecognized' status.txt)
     echo ${status}
     FLAG_EXIST=0 ##if not insalled
     if [ -z "$status" ]
     then
      FLAG_EXIST=1 ##already installed
     fi
     echo $FLAG
     return $[FLAG_EXIST]
}
################################################
function check_if_virtualhost_exist_or_not
{

    # read -p "Enter name of virtualhost (website): " websitename
    # apache2ctl -S | grep 'port'| cut -d' ' -f13 > allLocalHost
		# if grep -Fxq "${websitename}" allLocalHost; then
		# echo "Already exist" ##true	
    # addvirtualhost
    # else
		# displayMenu
		# fi

    read -p "Enter name of virtualhost (website): " websitename	
     FlagExistVirtualHost=1
		apache2ctl -S | grep 'port'| cut -d' ' -f13 > allLocalHost
		if grep -Fxq "${websitename}" allLocalHost; then
		echo "Already exist" ##true
    FlagExistVirtualHost=1
		else
      FlagExistVirtualHost=0
			# addvirtualhost
		fi
    return $[FlagExistVirtualHost]
		# displayMenu
}

