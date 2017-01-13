#!/usr/bin/env bash

PROJECT_NAME="mysite"

# Install Python 3
echo 'Installing pip3'
sudo apt-get -y update
sudo apt-get -y install python3-pip
sudo apt-get -y install python3-setuptools
sudo apt-get -y install apache2
sudo apt-get -y install libapache2-mod-wsgi-py3

#echo 'Installing postgresql'

#sudo apt-get -y install postgresql libpq-dev postgresql-client postgresql-client-common

echo 'install django'

sudo pip3 install django

cd /var/www

# Django project test and init

if [ ! -f mysite/manage.py ];

then
  echo "The project $PROJECT_NAME don\'t exist, a new project will be init"
  sudo django-admin.py startproject $PROJECT_NAME
  #cd $PROJECT_NAME && pip3 freeze > requirements.txt)
  echo 'Done.'
else
  echo "The project $PROJECT_NAME exist"
#  echo "Checking existing dependencies ..."
#    if [ ! -f $PROJECTS_DIR/$PROJECT_NAME/requirements.txt ];
#      then
#      echo "exiting requirements"
#      echo "requirements installation ..."
#      pip install -r $PROJECTS_DIR/$PROJECT_NAME/requirements.txt
#      echo "requirements updating ..."
#      pip freeze -r $PROJECTS_DIR/$PROJECT_NAME/requirements.txt > $PROJECTS_DIR/$PROJECT_NAME/requirements.txt
#    fi
#  echo 'Done.'
fi

cd mysite

echo "applying migrations"
yes | sudo python3 manage.py migrate

echo "complete"



#add to end of apache2.conf file.  if using python 2 add (:/usr/local/lib/python3.4/dist-packages) after mysite
cd /etc/apache2
grep -q -F "WSGIPythonPath /var/www/$PROJECT_NAME" apache2.conf || echo "WSGIPythonPath /var/www/$PROJECT_NAME" >> apache2.conf

Pattern="www\/html"
Replace="www\/$PROJECT_NAME \n WSGIScriptAlias \/ \/var\/www\/mysite\/mysite\/wsgi.py"
File="000-default.conf"
cd /etc/apache2/sites-available

sudo sed -i "s/$Pattern/$Replace/"g $File

#Working full command
#sudo sed -i 's/www\/html/www\/mysite \n WSGIScriptAlias \/ \/var\/www\/mysite\/mysite\/wsgi.py/'g 000-default.conf


#enable firewall and allow apache and django port

yes | sudo ufw enable
sudo ufw allow 80
sudo ufw allow 8000
sudo service apache2 restart