#!/bin/sh -e
# This will be run in the guest machine as the vagrant user,
# to prepare the build environment.

sudo apt-get update
# Dependencies
sudo apt-get install -y python3 python3-pip python3-pyqt5 python3-pyqt5.qtopengl python3-pyqt5.qtquick python3-pyqt5.qtsvg python3-numpy python3-serial qml-module-qtquick2 qml-module-qtquick-window2 qml-module-qtquick-layouts qml-module-qtquick-dialogs qml-module-qtquick-controls
sudo pip3 install google-apputils 'protobuf>=3.0.0a3'
# Graphic environment
sudo apt-get install -y task-xfce-desktop
#sudo VBoxClient-all
