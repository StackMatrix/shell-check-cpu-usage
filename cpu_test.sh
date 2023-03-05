#!/bin/bash

# 循环
for i in {1..850};
do
  # 获取 CPU 使用率
  cpu_usage=$(top -bn1 | awk 'NR>7{s+=$9} END {print s}')
  
  # 当前 CPU 使用率
  echo "now cpu usage: $cpu_usage%"

  # md5sum 命令是一个计算文件哈希值的工具，
  # 将 /dev/null 作为输入参数时，实际上是在对一个不存在的文件进行哈希计算，
  # 因此这个计算过程不会有实际的磁盘 I/O 操作，只会占用 CPU 运算资源。
  # 使用 & 符号可以将命令放入后台执行，
  # 这样可以同时启动多个 md5sum /dev/null 进程来占用 CPU。
  md5sum /dev/null &
done