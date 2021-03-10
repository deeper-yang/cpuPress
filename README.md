# cpuPress
（A simple Linux CPU pressure test tools which can assign time lasts and  CPU Utilization based on core numbers) 一个简单的、可指定压力值和时长的 Linux CPU 压力工具

## 简介
cpuPress 对cpu使用率的限制是基于cpulimit实现的，需要安装cpulimit工具，CentOS系统下cpuPress默认会帮你安装，脚本已在CentOS7.2测试通过，可以在脚本开头修改指定的压力值和时长

```
//默认压力值30%，时长30秒
DEST_LIMIT=30 //cpu使用率压力值
DEST_TIME=30  //脚本执行时长
```

## 使用方法
```
chmod +x cpuPress.sh
./cpuPress.sh
```
