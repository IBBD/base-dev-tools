#
# Base Dev Tools Dockerfile
#
# https://github.com/ibbd/dockerfile-base-dev-tools
#
# sudo docker build -t ibbd/base-dev-tools ./
#

# Pull base image.
FROM buildpack-deps:jessie

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 解决时区问题
ENV TZ "Asia/Shanghai"

# sources.list
# git clone git@github.com:IBBD/docker-compose.git
# 如果导致apt-get Install不成功，可以先注释这句
ADD ext/sources.list   /etc/apt/sources.list

# 安装公共开发工具的工具
RUN \
    apt-get update \
    && apt-get install -y \
        apt-transport-https \
        git \
        git-flow \
        vim \
        tmux \
        python-pip python-dev build-essential \
    && pip install --upgrade pip \
    && pip install --upgrade virtualenv \
    && pip install mycli \
    && rm -r /var/lib/apt/lists/*

# 配置git
RUN git config --global push.default simple

# 安装vim插件
# 解决vim中文显示的问题
# 解决安装spf13之后，终端输入不了中文的问题
ADD ext/spf13-vim.sh /spf13-vim.sh 
RUN sh spf13-vim.sh \
    && echo "set fileencodings=utf-8" >> /etc/vim/vimrc \
    && echo "set fileencoding=utf-8" >> /etc/vim/vimrc \
    && echo "set encoding=utf-8" >> /etc/vim/vimrc 

# 代码目录
RUN mkdir -p /var/www 
VOLUME /var/www

