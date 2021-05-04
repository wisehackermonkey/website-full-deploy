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
# [Check if a directory exists in Linux or Unix shell - nixCraft](https://www.cyberciti.biz/faq/check-if-a-directory-exists-in-linux-or-unix-shell/)
[ ! -d "${HOME}/github/website" ] && git clone https://github.com/wisehackermonkey/website.git && echo "website\n\n\n"
[ ! -d "${HOME}/github/website-router" ] && git clone https://github.com/wisehackermonkey/website-router.git && echo "website-router\n\n\n"
[ ! -d "${HOME}/github/chirpweb" ] && git clone https://github.com/wisehackermonkey/chirpweb.git && echo "chirpweb\n\n\n"
[ ! -d "${HOME}/github/remash" ] && git clone https://github.com/wisehackermonkey/remash.git && echo "remash\n\n\n"
[ ! -d "${HOME}/github/shitty-90s-website" ] && git clone https://github.com/wisehackermonkey/shitty-90s-website.git && echo "shitty-90s-website\n\n\n"
[ ! -d "${HOME}/github/blank-black-website" ] && git clone https://github.com/wisehackermonkey/blank-black-website.git && echo "blank-black-website\n\n\n"
[ ! -d "${HOME}/github/webtorrent-demo" ] && git clone https://github.com/wisehackermonkey/webtorrent-demo.git && echo "webtorrent-demo\n\n\n"
[ ! -d "${HOME}/github/pixel-artist" ] && git clone https://github.com/wisehackermonkey/pixel-artist.git && echo "pixel-artist\n\n\n"
[ ! -d "${HOME}/github/business_card_puzzle" ] && git clone https://github.com/wisehackermonkey/business_card_puzzle.git && echo "business_card_puzzle\n\n\n"



echo "manual process\n\n\n"
docker login

echo "download private ghost blog backup data\n\n\n"
[ ! -d "${HOME}/github/blog-backup" ] && git clone https://github.com/wisehackermonkey/blog-backup.git

# echo "website-router  [Starting]\n\n\n"
# cd ./website && docker-compose up

##########
echo "start all the services run\n\n\n"

# echo "XXXXXXXXX [Starting]\n\n\n"
# docker-compose -f ./XXXXXXXXX/docker-compose.yml up -d && echo "XXXXXXXXX [Done]\n"


echo "chirpweb [Starting]\n\n\n" &&             cd ~/github/chirpweb && docker-compose up -d && echo "chirpweb [Done]\n\n"
echo "remash [Starting]\n\n\n" &&               cd ~/github/remash && docker-compose -f ./docker-compose.deploy.yml up -d && echo "remash [Done]\n\n\n"
echo "shitty-90s-website [Starting]\n\n\n" &&   cd ~/github/shitty-90s-website && docker-compose up -d && echo "shitty-90s-website [Done]\n\n\n"
echo "blank-black-website [Starting]\n\n\n" &&  cd ~/github/blank-black-website && docker-compose up -d && echo "blank-black-website [Done]\n\n\n" 
# echo "webtorrent-demo [Starting]\n\n\n" &&      cd ~/github/webtorrent-demo && docker-compose build && docker-compose up -d && echo "webtorrent-demo [Done]\n\n\n"
echo "pixel-artist [Starting]\n\n\n" &&         cd ~/github/pixel-artist && docker-compose up -d && echo "pixel-artist [Done]\n\n\n"
echo "business_card_puzzle [Starting]\n\n\n" && cd ~/github/business_card_puzzle && docker-compose up -d && echo "business_card_puzzle [Done]\n\n\n"
