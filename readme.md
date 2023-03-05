> Article Data：2023-03-05 10:54

# CPU 使用率监控  {docsify-ignore-all}

因一朋友需要，特写此脚本，予以帮助，顺写此文作为记录。


![image-20230305105137371](http://file.artisancode.cn/img/image-20230305105137371.png)

## 代码

cpu_check.sh

```bash
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
```

cpu_test.sh

```bash
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
```



## 测试结果

![image-20230305105328117](http://file.artisancode.cn/img/image-20230305105328117.png)