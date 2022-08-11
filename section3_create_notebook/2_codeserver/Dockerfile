FROM public.ecr.aws/j1r0q0g6/notebooks/notebook-servers/codeserver-python:v1.4

USER root 
RUN apt-get update && apt-get install -y sudo
RUN usermod -aG sudo ${NB_USER}
RUN echo ${NB_USER}:${NB_USER} | chpasswd
RUN echo "${NB_USER} ALL=(root) NOPASSWD:SETENV: /init" >> /etc/sudoers

USER jovyan