# Enable exit-on-error mode
#set -e

create_user(){
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

create_user
base_dev_packages
additional_dev_packages
export -f setup_git_repo
su msfdev -c 'bash -c setup_git_repo'

