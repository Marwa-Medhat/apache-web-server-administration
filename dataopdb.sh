 #!/bin/bash
##this script to have fns  
	# "1-to install apache web server"
	# "2-to remove apache web server"
	# "3- list all virtual hosts"
	# "4-add virtual host "
	# "5-delete virtual host "
	# "6-disable virtual host "
	# "7-enable virtual host "
	# "8-enable  auth virtual host" 
	# "9-disable auth virtual host "
 #################################################33   
function installapache
{
    #Update & Upgrade then install Apache
    sudo apt-get update -y && sudo apt-get upgrade -y
    sudo apt-get install apache2 -y
    #start Apache
    sudo systemctl start apache2.service
    sudo systemctl status apache2.service
    echo " apache installed"
}
function removeapache
{
#  Remove with all config :
    sudo apt purge apache2
#   Remove without config:
    sudo apt remove apache2
    echo " Apache Removed"
}
function listallvirtualhosts
{ 
#take all lines start with port from command apache2ctl -S in file allLocalHost but here > we override
#loop on file and read line line and take 4th coloum  (field 4 ) using delimeter " " 
#by2ra mn al file < name of file 
 apache2ctl -S | grep 'port'>allLocalHost
    while read -r line;do
    echo ${line} | cut -d " " -f 4
    done <"allLocalHost"
}
function addvirtualhost
{
    # enter name of website then store it in /var/www/html/(name of website)/public_html
    #So everytime directory change from website to another
    #write html of website page in index.html which exist in  /var/www/html/(name of website)/public_html/index.html
    #create config file for website in /etc/apache2/sites-available/(name of website).conf
    #  <VirtualHost *:80>
    #     ServerAdmin webmaster@${websitename}
    #     ServerName ${websitename}
    #     ServerAlias www.${websitename}
    #     DocumentRoot /var/www/html/${websitename}/public_html
    # </VirtualHost>
    # <Directory "/var/www/html/${websitename}/public_html">
    #     Require all granted
    # </Directory>
    #then enable website config 
    #add 127.0.0.1	websitename in /etc/hosts
    #then restart Apache to apply changes
    read -p "Enter name of virtualhost (website): " websitename
        sudo mkdir /var/www/html/${websitename}
        sudo mkdir /var/www/html/${websitename}/public_html
        read -p "Enter username: " username
        sudo chown -R $USER:${username} /var/www/html/${websitename}/public_html
        sudo touch /var/www/html/${websitename}/public_html/index.html
        echo "<html>
        <head>
        <title>www.${websitename}</title>
        </head>
        <body>
        <h1>Hello, This is a test page for ${websitename}  website</h1>
        </body>
        </html>" >> /var/www/html/${websitename}/public_html/index.html
        cat /var/www/html/${websitename}/public_html/index.html;
        sudo touch /etc/apache2/sites-available/${websitename}.conf
      echo "
    <VirtualHost *:80>
        ServerAdmin webmaster@${websitename}
        ServerName ${websitename}
        ServerAlias www.${websitename}
        DocumentRoot /var/www/html/${websitename}/public_html
    </VirtualHost>
    <Directory "/var/www/html/${websitename}/public_html">
        Require all granted
    </Directory>" >> /etc/apache2/sites-available/${websitename}.conf
    cat  /etc/apache2/sites-available/${websitename}.conf
    echo a2ensite ${websitename}.conf
    sudo a2ensite ${websitename}.conf
    systemctl reload apache2
    sudo systemctl restart apache2
    echo "127.0.0.1	${websitename}"
    echo "127.0.0.1	${websitename}"  >> /etc/hosts
    sudo systemctl restart apache2
    #echo "Open up your web browser and point it to http://Websitename";
}

function deletevirtualhost
{
    # First, disable the virtual host and restart Apache:
    # At this point, the site is disabled and will no longer be accessible.
    # Now just remove the config file and cleanup the /var/www/ directory to permanently remove the site and all of its files:
    #loop line line utill find specific line which i want tp delete then 
    #take number of line and remove it 
    #expr to make arthimatic operation and increase 
    read -p "Enter name of virtualhost you want to delete : " deleteVirtualHost
    NUM_LINE=1
    while read -r line;do
    if [ "$line" == "127.0.0.1	${deleteVirtualHost}" ]; then
    REQ_LINE=${NUM_LINE}
    fi
    NUM_LINE=$(expr ${NUM_LINE} + 1)
    done <"/etc/hosts"
    sudo sed -i "${REQ_LINE}d" /etc/hosts
    sudo rm /etc/apache2/sites-available/${deleteVirtualHost}.conf
    sudo rm -Rf /var/www/${deleteVirtualHost}
}
function disablevirtualhost
{
        #Example on disable virtual host:
		# sudo a2dissite 000-default.conf
        #sudo a2dissite ostechnix1.lan.conf        
         read -p "Enter File You want to disable: " configfiledis
         sudo a2dissite ${configfiledis} 
         # Restart apache web server to take effect the changes.
         sudo systemctl restart apache2
         #sudo systemctl reload apache2
        #  Site 000-default disabled.
		
}
function enablevirtualhost
{
    
    # Example on enable virtual host:
    #sudo a2ensite $1
    #sudo a2ensite 000-default.conf
    #sudo a2ensite ostechnix1.lan.conf
     read -p "Enter File You want to enable: " configfile
     sudo a2ensite ${configfile} 
    # Site 000-default already enabled
    # Enabling site 000-default.
     # Restart apache web server to take effect the changes.
     sudo systemctl restart apache2
}
function  enableauthvirtualhost
{
    #replace  Require all granted with AllowOverride All in config file of website
    read -p "Enter name of virtualhost you want to make auth for it : " authVirtualHost
    NUM_LINE=1
    while read -r line;do
    if [ "$line" == "Require all granted" ]; then
    REQ_LINE=${NUM_LINE}
    echo ${REQ_LINE}
    fi
    NUM_LINE=$(expr ${NUM_LINE} + 1)
    done <"/etc/apache2/sites-available/${authVirtualHost}.conf"
    sudo sed -i "${REQ_LINE}d" /etc/apache2/sites-available/${authVirtualHost}.conf
    sudo sed -i "${REQ_LINE} i AllowOverride All" /etc/apache2/sites-available/${authVirtualHost}.conf
    ##############################################
    read -p "Enter name of user : " username
    sudo adduser ${username}
    sudo htpasswd -c /var/www/html/${authVirtualHost}/public_html/.htpasswd ${username}
    #to make sure that username and password are created
    sudo cat  /var/www/html/${authVirtualHost}/public_html/.htpasswd 
    ###########################################################3
    #.htaccess for every website to make authentication
    sudo touch /var/www/html/${authVirtualHost}/public_html/.htaccess
    echo "
     AuthType Basic
     AuthName 'Restricted Content'
     AuthUserFile /var/www/html/${authVirtualHost}/public_html/.htpasswd 
     Require valid-user
    " > /var/www/html/${authVirtualHost}/public_html/.htaccess
    ######################################
    #restart llapache to apply configuration
    sudo systemctl restart apache2
    ######################################    
}
function  disableauthvirtualhost
{
    # replace allowOverride All with AllowOverride None and remove .htaccess
    read -p "Enter name of virtualhost you want to make remove auth from it : " disauthVirtualHost
    NUM_LINE=1
    while read -r line;do
    if [ "$line" == "AllowOverride All" ]; then
    REQ_LINE=${NUM_LINE}
    fi
    NUM_LINE=$(expr ${NUM_LINE} + 1)
    done <"/etc/apache2/sites-available/${disauthVirtualHost}.conf"
    sudo sed -i "${REQ_LINE}d" /etc/apache2/sites-available/${disauthVirtualHost}.conf
    sudo sed -i "${REQ_LINE} i  AllowOverride None" /etc/apache2/sites-available/${disauthVirtualHost}.conf
    rm  /var/www/html/${disauthVirtualHost}/public_html/.htaccess
}

