#!/bin/bash
#create:2021-03-10
#author: deeper-yang

set -u 

DEST_LIMIT=30
DEST_TIME=30
CPU_NUM=`cat /proc/cpuinfo | grep processor | wc -l`
echo "CPU Destination: ${DEST_LIMIT}%"
echo "Time Lasts: ${DEST_TIME}s"
echo "CPU Core Numbers: ${CPU_NUM}"
REAL_LIMIT=`expr ${DEST_LIMIT} \* ${CPU_NUM}`


#check cpulimit is installed or not
if [[ $(rpm -qa |grep -w cpulimit | wc -l) -gt 0 ]];then
  #echo "cpulimit has installed"
  echo ''
else
  echo "There is no cpulimit, need to install" 
  yum install cpulimit -y 
fi


#muti process:overload cpu base on cpu core nums
cat > /tmp/axxpie.sh<<EOF
for ((i=0;i<${CPU_NUM};i++));do
{
time echo "scale=5000000; 4*a(1)" | bc -l -q
} &
done
wait
echo "yyyyyyyyyyyyyyyyy"
EOF

chmod +x /tmp/axxpie.sh
nohup cpulimit -l ${REAL_LIMIT} -i  /tmp/axxpie.sh >/dev/null 2>&1 &

echo "-------start CPU overload-------"
TIME_COUNT=1
while [ ${TIME_COUNT} -le ${DEST_TIME} ]
do 
        sleep 1
        #echo ${TIME_COUNT}
	let TIME_COUNT++
done

pid=`ps -lef |grep "bc -l -q" |grep -v grep |awk '{print $4}'`
kill -9 ${pid}
sleep 2
count=`ps -lef |grep axxpie | grep -v grep | wc -l`
if [ $count -eq 0 ];then
  echo "------stop CPU overload-------"
  find /tmp/ -type f -name "axxpie.sh" |xargs rm -f 
else
  echo "process not end, please check 'ps -lef |grep axxpie' " 
fi

