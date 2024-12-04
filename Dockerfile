# বেস ইমেজ হিসেবে Ubuntu 20.04 ব্যবহার করছি
FROM ubuntu:20.04

# প্রয়োজনীয় প্যাকেজগুলি ইনস্টল করছি
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    xfce4 \
    xfce4-goodies \
    xrdp \
    supervisor \
    sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# একটি নতুন ব্যবহারকারী তৈরি করছি এবং পাসওয়ার্ড সেট করছি
RUN useradd -m -s /bin/bash nbpgytrdp && \
    echo 'nbpgytrdp:subscribe' | chpasswd && \
    adduser nbpgytrdp sudo

# xrdp সার্ভার কনফিগার করছি
RUN echo "nbpgytrdp ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
COPY xrdp.ini /etc/xrdp/xrdp.ini

# RDP পোর্ট উন্মুক্ত করছি
EXPOSE 3389

# xrdp এবং supervisor চালু করছি
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]
