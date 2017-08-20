#!/bin/bash


mkdir -p logs

for i in $*; do
    echo rsync -avHAX --delete /homes/$i /sdsc/homes/
    (
	(set -v
	 touch logs/$i.running
	 echo STARTING RSYNC
	 date
	 if rsync -avHAX --delete /homes/$i /sdsc/homes/ ; then
	     mv logs/$i.running logs/$i.done
	 else
	     mv logs/$i.running logs/$i.crashed
	 fi
	 date
	) 2>&1 >> ./logs/$i.log
    ) &
done
