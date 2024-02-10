#!/bin/bash
# https://docs.docker.com/engine/install/ubuntu/

command_exists() {
  command -v "$@" > /dev/null 2>&1
}

if ! command_exists curl; then
  sudo apt-get update && sudo apt-get install -y -q curl
fi

sudo apt-get install qemu binfmt-support qemu-user-static

echo "[INFO] Remove previous versions"
sudo apt-get remove -y docker docker-engine docker.io containerd runc >/dev/null
echo ""

echo "[INFO] Install the latest version"
wget -qO- https://get.docker.com | bash -s docker --mirror Aliyun
# curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
echo ""

echo "[INFO] Adding ${USER} to the docker group"
sudo usermod -aG docker "$USER"
echo ""

echo "[INFO] Configure the Docker daemon"
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
    "registry-mirrors": ["https://registry.docker-cn.com"]
}
EOF
echo ""

echo "[INFO] Flush changes and restart Docker"
sudo systemctl daemon-reload
sudo systemctl restart docker
echo ""

reboot () { echo 'Reboot? (y/n)' && read x && [[ "$x" == "y" ]] && /sbin/reboot; }

reboot
