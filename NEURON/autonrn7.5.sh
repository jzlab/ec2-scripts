#!/usr/bin/env bash

# Source: https://neurojustas.com/2018/03/27/tutorial-installing-neuron-simulator-with-python-on-ubuntu-linux/

# Assuming Ubuntu based linux image 16.04+

# Install the relevant system requirements
sudo apt-get update
# sudo apt-get install -y build-essential

# Install NEURON dependencies
sudo apt-get install -y libx11-dev
sudo apt-get install -y libxext-dev
sudo apt-get install -y mpich
sudo apt-get install -y libncurses-dev
sudo apt-get install -y xfonts-100dpi

# Install python 2.7 and pip
sudo apt-get install -y python
sudo apt-get install -y python-dev
sudo apt-get install -y python-pip
pip install --upgrade pip

# Install needed python packages
pip install mpi4py
pip install neo
pip install numpy
pip install lazyarray

# DEPRECATED - Old way of installing python libraries without pip
#sudo apt-get install -y python-numpy
#sudo apt-get install -y python-lazyarray
#sudo apt-get install -y python-neo

# Make neuron directory
mkdir ~/neuron
cd ~/neuron/

# Pull Source files for installing NEURON and IV
wget http://www.neuron.yale.edu/ftp/neuron/versions/v7.5/nrn-7.5.tar.gz
wget http://www.neuron.yale.edu/ftp/neuron/versions/v7.5/iv-19.tar.gz

# Unzip neuron install packages
tar xzf ./iv-19.tar.gz
tar xzf ./nrn-7.5.tar.gz

# Rename folders for ease of use
mv iv-19 iv
mv nrn-7.5 nrn

# Configure, make and install InverViews
cd ./iv
./configure --prefix=`pwd`
make
make install

# Configure, make and install Neuron
cd ../nrn
./configure --prefix=`pwd` --with-nrnpython --with-paranrn --with-iv
make
make install

# Allow importing of neuron into python
cd src/nrnpython
sudo python setup.py install

# Add IV and NEURON to PATH
sudo echo "# Add Neuron and IV to path variable" >> ~/.bashrc
sudo echo 'export PATH="$HOME/neuron/nrn/x86_64/bin:$PATH"' >> ~/.bashrc
sudo echo 'export PATH="$HOME/neuron/iv/x86_64/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
