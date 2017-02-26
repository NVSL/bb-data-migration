#!/usr/bin/env bash

function die () {
    echo "Fatal Error: $1"
    exit 1
}

if [ ".$1" = "." ]; then
    die "usage: setup.sh <directory to install gdrive executableb>"
fi

dst=$1

if [ -e $dst/gdrive ] ; then
    echo "Already installed"
    exit 0
fi

if [ `uname` = 'Darwin' ]; then
    GDRIVE_URL='https://docs.google.com/uc?id=0B3X9GlR6Embnb010SnpUV0s2ZkU&export=download'
elif [ `uname` = 'Linux' ]; then 
    GDRIVE_URL='https://docs.google.com/uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA&export=download'
else
    die  "Unknown system: $(uname)"
fi

mkdir -p $dst
wget -O $dst/gdrive $GDRIVE_URL
chmod u+x $dst/gdrive
    
