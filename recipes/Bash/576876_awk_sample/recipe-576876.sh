#!/usr/bin/env bash

FILE=${1:?"FILE?"}

echo $*
#get the fields
#delete the non-ditital data, user, system, elapsed
#convert the real time 's min:sec
#print the fields

#awk 'BEGIN { FS = "\n"; RS = "" }\
#{print $2}' $FILE \
$(which sed) -n '/.*user.*system.*/p' ${FILE} \
|$(which sed) -e 's/user//' -e 's/system//' -e 's/elapsed//' |\
$(which awk) 'BEGIN { FS = " "; RS = "\n" }\
{split($3, real, ":"); $3=real[1]*60 + real[2]} \
#{printf $1 "\t"$2 "\t" $3"\n"} \
{ user_sum += $1;  sys_sum += $2; real_sum += $3; count++} \
END {printf "user_sum: " user_sum/count "\nsys_sum: " sys_sum/count  "\nreal_sum: " real_sum/count "\n"}'

echo ""
