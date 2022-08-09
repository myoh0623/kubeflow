#!/bin/bash
sudo apt-get -y update
sudo apt-get -y remove --purge '^nvidia-.*'
sudo apt-get -y remove --purge 'cuda-.*'
sudo apt-get -y install nvidia-cuda-tookit
sudo apt-get -y install nvidia-cuda-toolkit
nvcc -V
whereis cuda
mkdir ~/nvidia
cd ~/nvidia
wget http://people.cs.uchicago.edu/~kauffman/nvidia/cudnn/cudnn-10.1-linux-x64-v7.6.5.32.tgz
tar -xvfz cudnn-10.1-linux-x64-v7.6.5.32.tgz
tar -xvzf cudnn-10.1-linux-x64-v7.6.5.32.tgz
ls
sudo cp cuda/include/cudnn.h /usr/lib/cuda/include/
sudo cp cuda/lib64/libcudnn* /usr/lib/cuda/lib64/
sudo chmod a+r /usr/lib/cuda/lib64/libcudnn*
sudo chmod a+r /usr/lib/cuda/include/cudnn.h
echo "export LD_LIBRARY_PATH=/usr/lib/cuda/lib64:$LD_LIBRARY_PATH" >> ~/.bashrc
export "LD_LIBRARY_PATH=/usr/lib/cuda/include:$LD_LIBRARY_PATH" >> ~/.bashrc
source ~/.bashrc
ubuntu-drivers devices
sudo apt install -y nvidia-driver-470
echo "reboot....."