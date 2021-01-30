add-apt-repository -qq  ppa:phoerious/keepassxc -y
add-apt-repository -qq ppa:unit193/encryption -y

apt -qq update
apt -qq install keepassxc rclone git veracrypt snap gpg -y

snap install --classic code # or code-insider
snap install spotify

apt autoremove
