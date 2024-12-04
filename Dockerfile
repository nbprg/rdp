# Dockerfile
FROM ubuntu:20.04

# XFCE এবং VNC সার্ভার ইনস্টল করুন
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    xfce4 \
    xfce4-goodies \
    tightvncserver \
    novnc \
    websockify \
    xterm \
    curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# একটি ব্যবহারকারী তৈরি করুন
RUN useradd -m -s /bin/bash rdpuser && \
    echo 'rdpuser:password' | chpasswd

# VNC সার্ভার সেটআপ করুন
RUN mkdir -p /home/rdpuser/.vnc && \
    echo "password" | vncpasswd -f > /home/rdpuser/.vnc/passwd && \
    chown -R rdpuser:rdpuser /home/rdpuser/.vnc && \
    chmod 600 /home/rdpuser/.vnc/passwd

# পোর্ট উন্মুক্ত করুন
EXPOSE 5901 6080

# স্টার্টআপ স্ক্রিপ্ট
COPY startup.sh /opt/startup.sh
RUN chmod +x /opt/startup.sh

CMD ["/opt/startup.sh"]
