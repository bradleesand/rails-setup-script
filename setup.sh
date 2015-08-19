echo "Starting installation process..."
echo "Install packages? (y/N)"
read installPackages
echo "Download & Install Qt 4.7.4? (y/N)"
read installQt
echo "Download & Install Ruby? (y/N)"
read installRuby
if [[ "$installRuby" == "y" ]]; then
    DEFAULT_RUBY_VERSION=2.1.5
    echo "Ruby Version? (${DEFAULT_RUBY_VERSION})"
    read rubyVersion
    rubyVersion=${rubyVersion:-${DEFAULT_RUBY_VERSION}}
fi
echo "Setup Git? (y/N)"
read installGit

if [[ "$installPackages" == "y" ]]; then
    echo "Updating..."
    sudo apt-get -y update
    echo "Installing necessary packages..."
    sudo apt-get -y install curl git-core python-software-properties build-essential openssl libssl-dev python g++ make checkinstall
    sudo apt-get -y install postgresql libpq-dev xclip libxslt-dev libxml2-dev nodejs nginx imagemagick libmagickcore-dev libmagickwand-dev libreadline-dev
    sudo mkdir ~/src && cd $_
    sudo wget -N http://nodejs.org/dist/node-latest.tar.gz
    sudo tar xzvf node-latest.tar.gz && cd node-v*
    sudo ./configure
    sudo checkinstall
    sudo dpkg -i node_*
    wget http://download.redis.io/redis-stable.tar.gz
    tar xvzf redis-stable.tar.gz
    cd redis-stable
    make
    sudo make install
fi


if [[ "$installQt" == "y" ]]; then
    cd /tmp
    sudo wget -N http://download.qt-project.org/archive/qt/4.7/qt-everywhere-opensource-src-4.7.4.tar.gz
    sudo tar xzvf qt-everywhere-opensource-src-4.7.4.tar.gz
    cd qt-everywhere-opensource-src-4.7.4
    sudo ./configure
    echo "How many CPU cores does this computer have? (Choose: 1,2,4)"
    sudo ln -s /usr/lib/libXrender.so.1.3.0 /usr/lib/libXrender.so
    read cores
    if [[ "$cores" == "1" ]]; then
        make
    elif [[ "$cores" == "2" ]]; then
        make -j4
    elif [[ "$cores" == "4" ]]; then 
        make -j8
    else
        make
    fi
    sudo make install
    echo "PATH=/usr/local/Trolltech/Qt-4.7.4/bin:$PATH" >> ~/.bashrc
    echo "export PATH" >> ~/.bashrc    
fi

if [[ "$installRuby" == "y" ]]; then
    echo "Downloading and Installing Ruby $rubyVersion via Rbenv..."
    curl -L https://raw.github.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash
    echo "Copy & Paste the lines above as stated into the bashrc file, then press enter"
    read enter
    . ~/.bashrc
    rbenv install $rubyVersion
    rbenv global $rubyVersion
    ruby -v
    gem install bundler --no-ri --no-rdoc
    gem install rake
    rbenv rehash
    bundle -v
    echo "Please make a postgres user and db. Use the following commands:"
    echo "create user rt password 'password123';"
    echo "create database rt_production owner rt;"
    echo "\quit"
    sudo -u postgres psql
fi


if [[ "$installGit" == "y" ]]; then
    echo "Type your email address, followed by [ENTER]:"
    read address
    ssh-keygen -t rsa -C "$address"
    ssh-add
    xclip -sel clip < ~/.ssh/id_rsa.pub
    echo "What is your name?"
    read username
    git config --global user.email "$address"
    git config --global user.name "$username"
    echo "You're all set."
    echo "Copied ssh key to clipboard, please paste into your github account on github.com, then press enter."
    read enter
fi

echo "ALL DONE!"
