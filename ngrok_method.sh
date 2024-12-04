sudo apt update
sudo apt upgrade -y
sudo apt install -y xrdp
sudo apt install -y xfce4 xfce4-goodies
sudo apt install -y tightvncserver
sudo apt install -y dbus-x11 x11-xserver-utils
echo "xfce4-session" > ~/.xsession
sudo systemctl enable xrdp
sudo systemctl start xrdp
wget https://bin.equinox.io/c/4VmDzA7iaJ6/ngrok-stable-linux-amd64.zip
unzip ngrok-stable-linux-amd64.zip
sudo mv ngrok /usr/local/bin

ngrok authtoken 2plhEpD09JQm81jobgoKfKOO3aY_5TupH8pFEUCVWVXib75k4

ngrok tcp 3389
