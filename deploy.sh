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
  apt install git -y
}
# authenticate git 
git config --global user.email "oranbusiness@gmail.com"
git config --global user.name "wisehackermonkey"

command -v docker >/dev/null 2>&1 ||
{ echo >&2 "docker is not installed. Installing..";
# install docker
sudo apt update -y
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update -y
apt-cache policy docker-ce
sudo apt install docker-ce  -y
# sudo systemctl status docker
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
[ ! -d "${HOME}//github" ] && mkdir ~/github
cd ~/github

# download all my repos
# [Check if a directory exists in Linux or Unix shell - nixCraft](https://www.cyberciti.biz/faq/check-if-a-directory-exists-in-linux-or-unix-shell/)
[ ! -d "${HOME}/github/website" ] && git clone https://github.com/wisehackermonkey/website.git && printf "website\n\n\n"
[ ! -d "${HOME}/github/website-router" ] && git clone https://github.com/wisehackermonkey/website-router.git && printf "website-router\n\n\n"
[ ! -d "${HOME}/github/chirpweb" ] && git clone https://github.com/wisehackermonkey/chirpweb.git && printf "chirpweb\n\n\n"
[ ! -d "${HOME}/github/remash" ] && git clone https://github.com/wisehackermonkey/remash.git && printf "remash\n\n\n"
[ ! -d "${HOME}/github/shitty-90s-website" ] && git clone https://github.com/wisehackermonkey/shitty-90s-website.git && printf "shitty-90s-website\n\n\n"
[ ! -d "${HOME}/github/blank-black-website" ] && git clone https://github.com/wisehackermonkey/blank-black-website.git && printf "blank-black-website\n\n\n"
[ ! -d "${HOME}/github/webtorrent-demo" ] && git clone https://github.com/wisehackermonkey/webtorrent-demo.git && printf "webtorrent-demo\n\n\n"
[ ! -d "${HOME}/github/pixel-artist" ] && git clone https://github.com/wisehackermonkey/pixel-artist.git && printf "pixel-artist\n\n\n"
[ ! -d "${HOME}/github/business_card_puzzle" ] && git clone https://github.com/wisehackermonkey/business_card_puzzle.git && printf "business_card_puzzle\n\n\n"






######  ####
printf "start all the services run\n\n\n"

# printf "XXXXXXXXX [Starting]\n\n\n"
# docker-compose -f ./XXXXXXXXX/docker-compose.yml up -d && printf "XXXXXXXXX [Done]\n"

# printf "webtorrent-demo [Starting]\n\n\n" &&      cd ~/github/webtorrent-demo && docker-compose build && docker-compose up -d && printf "webtorrent-demo [Done]\n\n\n"
printf "website-router [Starting]\n\n\n" &&             cd ~/github/website-router && docker-compose up -d && printf "website-router [Done]\n\n"

printf "chirpweb [Starting]\n\n\n" &&             cd ~/github/chirpweb && docker-compose up -d && printf "chirpweb [Done]\n\n"
printf "shitty-90s-website [Starting]\n\n\n" &&   cd ~/github/shitty-90s-website && docker-compose up -d && printf "shitty-90s-website [Done]\n\n\n"
printf "blank-black-website [Starting]\n\n\n" &&  cd ~/github/blank-black-website && docker-compose up -d && printf "blank-black-website [Done]\n\n\n"
## Special snowflake ones
printf "website [Starting]\n\n\n" &&             cd ~/github/website && docker-compose -f ./docker-compose.deploy.yml up -d && printf "website [Done]\n\n"
printf "remash [Starting]\n\n\n" &&               cd ~/github/remash && docker-compose -f ./docker-compose.deploy.yml up -d && printf "remash [Done]\n\n\n"
printf "pixel-artist [Starting]\n\n\n" &&         cd ~/github/pixel-artist && docker-compose -f ./docker-compose.deploy.yml up -d && printf "pixel-artist [Done]\n\n\n"
printf "blog [Starting]\n\n\n" &&         cd ~/github/blog-backup && docker-compose -f ./docker-compose.deploy.yml up -d && printf "blog [Done]\n\n\n"

printf "business_card_puzzle [Starting]\n\n\n" && cd ~/github/business_card_puzzle 
echo "FLAG1=123456789
FLAG2=999999999
FLAG3=111111111
PORT=3000">>.env
docker-compose up -d && printf "business_card_puzzle [Done]\n\n\n"

printf "manual process\n\n\n"
docker login

printf "download private ghost blog backup data\n\n\n"
[ ! -d "${HOME}/github/blog-backup" ] && git clone https://github.com/wisehackermonkey/blog-backup.git


printf "-----------------------------------------"

printf "\n\n\nServer is now fully setup! Enjoy :)\n\n\n"
