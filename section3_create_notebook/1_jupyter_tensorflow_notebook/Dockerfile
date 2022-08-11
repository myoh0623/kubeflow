FROM public.ecr.aws/j1r0q0g6/notebooks/notebook-servers/jupyter-tensorflow-cuda-full:v1.4

# install - requirements.txt

USER root 
# Nvidia GPG Public Key 교체
RUN rm /etc/apt/sources.list.d/cuda.list
RUN rm /etc/apt/sources.list.d/nvidia-ml.list

RUN apt-get update && apt-get install -y sudo
RUN usermod -aG sudo ${NB_USER}
RUN echo ${NB_USER}:${NB_USER} | chpasswd
RUN echo "${NB_USER} ALL=(root) NOPASSWD:SETENV: /init" >> /etc/sudoers

USER jovyan