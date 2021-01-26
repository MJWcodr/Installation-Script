add-apt-repository ppa:phoerious/keepassxc -y
add-apt-repository ppa:unit193/encryption -y

apt update
apt install keepassxc rclone git veracrypt snap gpg -y

snap install --classic code # or code-insider
snap install spotify

apt autoremove
