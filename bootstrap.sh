#!/usr/bin/env bash

PROJECT_NAME="mysite"

# Install Python 3
echo 'Installing pip3'

sudo apt-get -y install python3-pip

echo 'install django'

sudo pip3 install django

cd /vagrant/src

# Django project test and init

if [ ! -f mysite/manage.py ];

then
  echo "The project $PROJECT_NAME don\'t exist, a new project will be init"
  django-admin startproject $PROJECT_NAME
  #cd $PROJECT_NAME && pip3 freeze > requirements.txt)
  echo 'Done.'
else
  echo "The project $PROJECT_NAME exist"
  echo "Checking existing dependencies ..."
#    if [ ! -f $PROJECTS_DIR/$PROJECT_NAME/requirements.txt ];
#      then
#      echo "exiting requirements"
#      echo "requirements installation ..."
#      pip install -r $PROJECTS_DIR/$PROJECT_NAME/requirements.txt
#      echo "requirements updating ..."
#      pip freeze -r $PROJECTS_DIR/$PROJECT_NAME/requirements.txt > $PROJECTS_DIR/$PROJECT_NAME/requirements.txt
#    fi
  echo 'Done.'
fi

cd mysite

echo "applying migrations"
#python3 manage.py migrate
