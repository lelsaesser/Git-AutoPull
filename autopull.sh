#!/bin/bash

pull() {
    d_user=$USER  
    log_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

    {
        cd /Users/$d_user/git
    } || {
        echo "Expected git repository path not found. Please adjust the path in the script"
        return -1
    }

    date | tee $log_dir/autopull_log.txt

    for d in */ ; do
        cd $d
        git pull 2>&1 | tee -a $log_dir/autopull_log.txt
        cd ..
    done
}

pull