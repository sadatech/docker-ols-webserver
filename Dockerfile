FROM sadaindonesia/ubuntu-baseline:focal

# Update package list
RUN apt -y update && \
    apt -y upgrade

# Configure Command
ADD /sources/config /tmp
ADD /sources/commands /tmp
RUN dos2unix /tmp/configure-* && \
    chmod +x /tmp/configure-* && \
    sh -c /tmp/configure-app-openlitespeed && \
    sh -c /tmp/configure-config-openlitespeed && \
    sh -c /tmp/configure-vhost-openlitespeed && \
    sh -c /tmp/configure-composer && \
    sh -c /tmp/configure-supervisor && \
    sh -c /tmp/configure-nodejs && \
    sh -c /tmp/configure-openssh && \
    sh -c /tmp/configure-vsftpd && \
    sh -c /tmp/configure-vnstat && \
    sh -c /tmp/configure-healthcheck && \
    sh -c /tmp/configure-container 
ADD /sources/healthcheck /opt/healthcheck

# Clear Temp
RUN rm /etc/timezone && \
    echo "Asia/Jakarta" | sudo tee /etc/timezone && \
    rm -rf /tmp/* && \
    apt -y autoclean && \
    apt -yqq autoremove && \
    apt -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/log/*.log

# Container Environment
EXPOSE 20 21 22 80 443 7080
WORKDIR /home/vhosts
HEALTHCHECK CMD node /opt/healthcheck/monitor.js
LABEL maintainer="Andika Muhammad Cahya <andkmc99@gmail.com>"
LABEL container="Web Server Application (OLS)"