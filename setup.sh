#!/bin/bash


pushd ./fedora-41/automated-setup

# run bootstrap script

bash ./bootstrap.sh


# run github setup script 

bash ./github-setup.sh


# install needed collections

make setup


# create password file

make password

# Let the user know to add password to the file and then run the playbook via make run command
echo "Please add your password to the password file and then run the playbook via make run command"
echo "The password file is located at: $(pwd)/.ansible_sudo_password"
echo "This is not optional, so do not skip this step."


echo "To run the playbook, please execute the following commands:"
echo "cd fedora-41/automated-setup"
echo "make run"