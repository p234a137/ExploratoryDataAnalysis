#!/bin/bash

# http://www.r-bloggers.com/bashr-howto-pass-parameters-from-bash-script-to-r/

data=`date --date=-1day +%Y%m%d`
fileshort=test_$data.csv

Rscript R_from_shell.R $fileshort --save