#!/bin/bash
# startup.sh

# VNC সার্ভার শুরু করুন
su rdpuser -c 'vncserver :1 -geometry 1280x800 -depth 24'

# noVNC শুরু করু
/opt/novnc/utils/novnc_proxy --vnc localhost:5901 --listen 6080
