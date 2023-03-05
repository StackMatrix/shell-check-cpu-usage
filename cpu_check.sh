#!/bin/bash

# 设置日志文件路径
logfile="cpu_alert.log"

# 无限循环
while :
do
  # 获取 CPU 使用率
  cpu_usage=$(top -bn1 | awk 'NR>7{s+=$9} END {print s}')
  
  #判断 CPU 使用率是否超过 75%
  if [[ $(echo "$cpu_usage > 75" | bc -l) -eq 1 ]]
  then
    # 记录警告信息到日志文件
    echo "CPU 使用率超过 75%。当前使用率为 $cpu_usage%。" >> $logfile
    
    # 退出脚本
    exit 1
  fi

  # 等待 5 秒
  sleep 5
done