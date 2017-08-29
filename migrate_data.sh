#!/bin/bash

function clone() {
    local src=$1
    shift
    local  dst=$1
    shift

    log_name=$(echo $src | perl -ne 's/\//_/g;print')
    
    (set -v
     touch logs/$log_name.running
     echo STARTING RSYNC
     date
     cmd="rsync -avHAER --delete $src $dst"
     echo $cmd >/dev/tty
     if $cmd; then
	 mv logs/$log_name.running logs/$log_name.done
     else
	 mv logs/$log_name.running logs/$log_name.crashed
     fi
     date
    ) 2>&1 >> ./logs/$log_name.log
    
}

cat $1 | (
    read root dst;
    #echo root=$root
    #echo dst=$dst
    
    while read x; do
        src=$root./${x#$root}
	clone $src /sdsc/ 
    done
)
