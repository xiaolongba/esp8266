# 前言
该脚本是我在使用VSCode开发ESP8266时,方便在Bash终端中编译完成之后,直接在Bash下载生成的固件,如果在大家在使用的过程有任何问题或者想法都可以跟我沟通(直接在**Issues**交流)

# 准备工作
该脚本主要是调用官网的**esptool**来实现下载烧录,脚本只用到下载和擦除功能,更多的功能请参考[乐鑫官网的esptool的使用详情](https://github.com/espressif/esptool)
至于如何在安装**esptool**,大家可以参考[如何安装esptool](https://github.com/espressif/esptool),在这里就不在详述,感兴趣的朋友可以参考我的公众号(**会不定期地更新自己学习Wifi&BLE&Zibgee的心得体会**),如下图所示:

![公众号](https://raw.githubusercontent.com/xiaolongba/picture/master/QRcode.png)

# 如何使用
在bash下直接调用以下脚本即可,但是你还是要先设置下对应的路径,具体你可以看脚本里面的内容,那里有中文的注释
```
./download.sh
```

# 运行的结果

```
$ ./download.sh
Download shell by Helon Chan 2018/04/01

D:/Project/Smart_Plug/tools/esptool/esptool.py

COM10

Do u wanna check the flash size?enter (Y/y or N/n) to continue(default is N/n):



Do u want to erase all flash? enter (Y/y or N/n) to continue(default is N/n):


Is this new esp8266? enter (Y/y or N/n) to continue(default is N/n):


D:/Project/Smart_Plug/bin/upgrade/user1.2048.new.5.bin

what is the esp8266 flash size(MB)
    0=0.5MB
    1=1MB
    2=2MB
    3=4MB
    4=8MB
    5=16MB
enter (0/1/2/3/4/5, default 0):
2
Download is starting ^_^!!

0x01000
esptool.py v2.3.2-dev
Connecting........__
Detecting chip type... ESP8266
Chip is ESP8266EX
Features: WiFi
Uploading stub...
Running stub...
Stub running...
Configuring flash size...
Auto-detected Flash size: 2MB
Compressed 277204 bytes to 198647...
Wrote 277204 bytes (198647 compressed) at 0x00001000 in 17.5 seconds (effective 126.5 kbit/s)...
Hash of data verified.

Leaving...
Hard resetting via RTS pin...
```
# 最后
欢迎大家提出任何意见,谢谢!当然,你不提也没关系,反正我也不会鸟你:joy:
