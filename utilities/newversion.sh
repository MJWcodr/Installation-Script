ysn="$(pwd)"
cd ./utilities || echo "..." 
tar -zcf "../../$(date +%y-%m-%d-%H-%M-)"Installation-Script".tar.gz" "$(find "../../" -maxdepth 1 -type d -name *"Installation Script"* -print -quit)" 
cd "$ysn"
