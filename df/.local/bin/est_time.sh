#!/bin/sh

[ $# -ne 2 ] && \
	echo "Usage:\n  est_time.sh [percent done] [time taken]\n\n  arguments can be any valid arithmetic expression in python\n  percent should be in range of (0; 100)" && exit

#echo $(( 100 * $2 / $1 ))
python -c "print(round( 100 * ($2) / ($1) , 2))"

