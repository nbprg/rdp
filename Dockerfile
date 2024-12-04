# Use the official Ubuntu base image
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    xfce4 \
    xfce4-goodies \
    xrdp \
    supervisor \
    sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a user and set a password
RUN useradd -m -s /bin/bash rdpuser && \
    echo 'rdpuser:password' | chpasswd && \
    adduser rdpuser sudo

# Set up xrdp
RUN echo "rdpuser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
COPY xrdp.ini /etc/xrdp/xrdp.ini

# Expose the RDP port
EXPOSE 3389

# Start xrdp and supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]
