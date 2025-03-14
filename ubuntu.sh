sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update

sudo apt install -y ca-certificates curl gnupg gnupg2
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt update

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
sudo apt install gnupg2 ca-certificates -y
wget -O- https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor > pgsql.gpg
sudo mv pgsql.gpg /etc/apt/trusted.gpg.d/pgsql.gpg
sudo apt update

wget https://github.com/limanmys/core/releases/download/release.master.1010/liman-2.1.1-1010.deb

sudo apt install ./liman-2.1.1-1010.deb -y
