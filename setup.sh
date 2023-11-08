#!/bin/bash

# Atualiza o sistema e instala as atualizações
sudo apt-get update && sudo apt-get upgrade -y

# Remove o Docker Desktop (se estiver instalado)
sudo apt remove docker-desktop
rm -r $HOME/.docker/desktop
sudo rm /usr/local/bin/com.docker.cli
sudo apt purge docker-desktop

# Instala algumas ferramentas básicas
sudo apt-get install -y git neofetch ca-certificates curl gnupg lsb-release

# Atualiza o sistema novamente
sudo apt-get update && sudo apt-get upgrade -y

# Configura o repositório do Docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Exibe o conteúdo do arquivo de configuração do Docker
cat /etc/apt/sources.list.d/docker.list

# Exibe as versões disponíveis do Docker
apt-cache madison docker-ce | awk '{ print $3 }'

# Atualiza o sistema novamente
sudo apt-get update && sudo apt-get upgrade -y

# Instala o Docker e ferramentas relacionadas
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Adiciona o usuário ao grupo Docker
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# Exibe a versão do Docker
docker --version
docker compose version

# Exibe o status do serviço Docker
sudo systemctl status docker.service

# Reinicia o sistema
sudo reboot

# Exibe informações do sistema após a reinicialização (opcional)
neofetch
