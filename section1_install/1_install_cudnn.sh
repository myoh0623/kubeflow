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
CUDNN_TAR_FILE="cudnn-10.1-linux-x64-v7.6.5.32.tgz"
wget https://developer.download.nvidia.com/compute/redist/cudnn/v7.6.5/${CUDNN_TAR_FILE}
tar -xzvf ${CUDNN_TAR_FILE}

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
