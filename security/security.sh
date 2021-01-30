cd ./security
# ufw firwall
command ufw || apt -qq install ufw
  apt install ufw
  echo "ufw already installed"

ufw enable

# lynis audit

command apt-transport-https | apt install -qq apt-transport-https
echo 'Acquire::Languages "none";' | sudo tee /etc/apt/apt.conf.d/99disable-translations
lynis audit --quiet system
echo "lynis log created"
echo "log can be found at /var/log/lynis.log"

cd ..
