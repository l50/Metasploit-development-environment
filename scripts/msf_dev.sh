# Enable exit-on-error mode
#set -e

create_msfdev_user(){
    adduser --disabled-password --gecos "" msfdev
    mkdir -p /etc/sudoers.d/
    touch /etc/sudoers.d/10_msfdev
    echo 'msfdev ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/10_msfdev
}

base_dev_packages(){
    apt install -y \
        autoconf \
        bison \
        build-essential \
        curl \
        git-core \
        libapr1 \
        libaprutil1 \
        libcurl4-openssl-dev \
        libgmp3-dev \
        libpcap-dev \
        libpq-dev \
        libreadline6-dev \
        libsqlite3-dev \
        libssl-dev \
        libsvn1 \
        libtool \
        libxml2 \
        libxml2-dev \
        libxslt-dev \
        libyaml-dev \
        locate \
        ncurses-dev \
        openssl \
        postgresql \
        postgresql-contrib \
        wget \
        xsel \
        zlib1g \
        zlib1g-dev
}

additional_dev_packages(){
    apt install -y \
        sudo \
        vim
}

setup_git_repo(){
    forked_repo="git://github.com/l50/metasploit-framework.git"
    pushd /home/msfdev
    git clone $forked_repo
    cd metasploit-framework
    git remote add upstream git://github.com/rapid7/metasploit-framework.git
    git fetch upstream
    git checkout -b upstream-master --track upstream/master
    popd
}

install_rvm(){
    curl -sSL https://rvm.io/mpapis.asc | gpg --import -
    curl -L https://get.rvm.io | bash -s stable
}

install_and_configure_ruby(){
    source ~/.rvm/scripts/rvm
    cd ~/metasploit-framework
    rvm --install $(cat .ruby-version)
    gem install bundler
    echo 'source ~/.rvm/scripts/rvm' >> ~/.bashrc
    echo 'rvm use $(cat ~/metasploit-framework/.ruby-version)' >> ~/.bashrc
}

create_msfdev_user
base_dev_packages
additional_dev_packages
export -f setup_git_repo
su msfdev -c 'bash -c setup_git_repo'
export -f install_rvm
su msfdev -c 'bash -c install_rvm'
export -f install_and_configure_ruby
su msfdev -c 'bash -c install_and_configure_ruby'
