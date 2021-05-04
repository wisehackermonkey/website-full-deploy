# this script recreates my full website server
# by oran collins
# github.com/wisehackermonkey
# oranbusiness@gmail.com
# 20210504

# docker compose latest version
# https://stackoverflow.com/a/49839172
VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*\d')

command -v git >/dev/null 2>&1 ||
{ echo >&2 "Git is not installed. Installing..";
  apt install git
}
# authenticate git 
git config --global user.email "oranbusiness@gmail.com"
git config --global user.name "wisehackermonkey"

command -v docker >/dev/null 2>&1 ||
{ echo >&2 "docker is not installed. Installing..";
# install docker
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce
sudo systemctl status docker
sudo usermod -aG docker ${USER}
su - ${USER}
id -nG
docker version
}

# install docker compose
# [How To Install and Use Docker Compose on Ubuntu 20.04 | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04)

command -v docker-compose >/dev/null 2>&1 ||
{ echo >&2 "docker-compose is not installed. Installing..";
    cd ~
    sudo curl -L "https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    docker-compose --version
}

# make default download location for my github repos
cd ~
mkdir ~/github
cd ~/github

# download all my repos
git clone https://github.com/wisehackermonkey/website.git
git clone https://github.com/wisehackermonkey/website-router.git
git clone https://github.com/wisehackermonkey/chirpweb.git
git clone https://github.com/wisehackermonkey/remash.git
git clone https://github.com/wisehackermonkey/shitty-90s-website.git
git clone https://github.com/wisehackermonkey/blank-black-website.git
git clone https://github.com/wisehackermonkey/webtorrent-demo.git
git clone https://github.com/wisehackermonkey/pixel-artist.git
git clone https://github.com/wisehackermonkey/business_card_puzzle.git



# manual process
docker login

# download private ghost blog backup data 
git clone https://github.com/wisehackermonkey/blog-backup.git


##########
# start all the services run
docker-compose -f ./website/docker-compose.yml up