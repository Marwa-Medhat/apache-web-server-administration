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

### at first Require all granted
### in autharized So AllowOver All
#### in  remove autharized so  AllowOver None 
function check_if_authorized_or_not
{

   read -p "Enter name of virtualhost you want to make auth for it : " authVirtualHost
    Flag_authorized=1
    while read -r line;do
    if [ "$line" == "Require all granted" ] || [ "$line" == "AllowOverride None" ]; then ###need to make authantication
          echo "not authorized"  
           Flag_authorized=1    ##call enableauth 
           break
    else                               
             echo "authorized"    ####authorized exist
              Flag_authorized=0
    fi
    done <"/etc/apache2/sites-available/${authVirtualHost}.conf"

    return $[Flag_authorized]
   
}

function check_if_enable_authorized_or_not
{

   read -p "Enter name of virtualhost you want to make disautharized for it : " authVirtualHost
    Flag_authorized=1
    while read -r line;do
    if [ "$line" == "AllowOverride All" ]; then ####we make fn enbleAuth so we can make fn NonAuth
          echo "authorized"  
           Flag_authorized=1
           break
    else
             echo " not authorized"       
              Flag_authorized=0
    fi
    done <"/etc/apache2/sites-available/${authVirtualHost}.conf"

    return $[Flag_authorized]
   
}

function check_if_directory_Exist_or_not
{
    read -p "Enter name of virtualhost (website): " websitename
    flagAdd_virtualHost=0
    if [ -d "/var/www/html/${websitename}" ]
    then
            echo "directory already Exist"
                flagAdd_virtualHost=0
    else
              flagAdd_virtualHost=1 ##7y3ml call l fn al addvirtualhost
    fi
       return $[flagAdd_virtualHost]
}

function check_if_passwd_already_exist
{
      read -p "Enter name of virtualhost you want to make auth for it : " authVirtualHost
      flagUserExistBefore=0
      if [ -f "/var/www/html/${authVirtualHost}/public_html/.htpasswd" ]
     then
            echo "there is user exist for website "
	      flagUserExistBefore=1
     else
     	    flagUserExistBefore=0  
	      
     fi
      return $[flagUserExistBefore]

}





