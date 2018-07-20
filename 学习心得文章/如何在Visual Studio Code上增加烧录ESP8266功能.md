# 前言
> 根据上次分享的[**如何在Visual Studio Code上搭建ESP8266开发环境**](https://github.com/xiaolongba/esp8266/blob/master/%E5%AD%A6%E4%B9%A0%E5%BF%83%E5%BE%97%E6%96%87%E7%AB%A0/%E5%A6%82%E4%BD%95%E5%9C%A8Visual%20Studio%20Code%E4%B8%8A%E6%90%AD%E5%BB%BAESP8266%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83.md)之后,我相信大家现在都可以很熟悉地在**Visual Studio Code**搭建乐鑫序列的开发环境了吧 **(如果仍然还是有不明白或者更好建议的大佬,欢迎留言)**,既然开发环境搭建完成了,那么理所当然接下来就要将编译出来的固件下载至芯片中去,接下来我就介绍如何在**Visual Studio Code**上增加烧录的功能.

# 下载工具
据我了解,现在乐鑫的下载工具目前有两个:
- flash_download_tools
- esptool

前者是一个上位机软件,只能在Windows系统环境下使用.而后者则可以在Windows/Linux/Mac系统下使用.

## flash_download_tools
- 优点:
可以很直观地选择以及配置参数,同时还可以设置射频相关的参数.

- 缺点
每次都要打开才能使用,而且只能在Windows系统下使用,编译与烧录要来回切换,对于经常调试的人来说,这样子切换来切换去让人很烦.

## esptool
- 优点
最大的优点就是可以跨平台使用,这个得益于python语言的强大,可以很方便地移植到不同的地方使用.同时,还有读取Flash大小、读取Flash内容等功能.[更多的功能](https://github.com/espressif/esptool)可以迁步至github中的**esptool**的**README.md**,那里有详细地介绍

- 缺点
相对于**flash_download_tools**在下载时选择参数没有那么直观,而且不能设置射频参数,最烦的是你还要安装python,而且python的版本不要太高级,否则无法使用,相当蛋疼.

## 如何选择
鉴于各有优缺点,那么接下来就要结合目前的情况了,因为我们现在使用的**Visual Studio Code**来编译&编辑,其实两种工具都是可以的,**Visual Studio Code**都可以很方便地去调度它们:

- 通过任务的方式调用外部程序**flash_download_tools**(很遗憾,我现在还不会,不知道怎么搞,有知道的麻烦请告之,非常感谢)

- 通过在**Visual Studio Code**终端中,使用脚本来调用**esptool**

综上所述,我们这里选择使用**esptool**,由于在上一篇[**如何在Visual Studio Code上搭建ESP8266开发环境**](https://github.com/xiaolongba/esp8266/blob/master/%E5%AD%A6%E4%B9%A0%E5%BF%83%E5%BE%97%E6%96%87%E7%AB%A0/%E5%A6%82%E4%BD%95%E5%9C%A8Visual%20Studio%20Code%E4%B8%8A%E6%90%AD%E5%BB%BAESP8266%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83.md)中我们使用的是安信可现成的cygwin,里面已经有python了.因此,我们此时就不需要再去安装额外的python了.

# 脚本
**esptool**的各种功能地实现均是通过调用**esptool.py**来实现的,因为python本来就是脚本语言,所以这里可以很方便很灵活地编写自己的脚本,从而来调用**esptool.py**.

## 获取esptool
**esptool**放在了乐鑫的github代码仓库上,大家可以在github下载到**esptool**.在写这篇文章时,**esptool**最新版本是**2.3.1**([下载页面](https://github.com/espressif/esptool))

## 安装esptool
其实在github中的**esptool**的**README.md**,里面有很详细的介绍,在这里我们选择手动安装即可,笔者是将**esptool**放在了工程目录下的**tools**子目录中,所以进到**esptool**的根目录下直接执行
```
python setup.py install
```
即可完成**esptool**地安装.具体地操作如下所示:
```
Administrator@Helon /cygdrive/d/Project/Smart_Plug/tools/esptool-2.3.1
$ ls
build            dist   espefuse.py   esptool.egg-info  flasher_stub  MANIFEST.in  README.md  setup.py
CONTRIBUTING.md  ecdsa  espsecure.py  esptool.py        LICENSE       pyaes        setup.cfg  test

Administrator@Helon /cygdrive/d/Project/Smart_Plug/tools/esptool-2.3.1
$ python setup.py install
```
## 编写脚本
在这里就不一一演示脚本怎么写了,我已经写好了,大家可以直接下载使用([脚本下载地址](https://github.com/xiaolongba/esp8266/tree/master/%E7%BC%96%E8%AF%91%E5%8F%8A%E7%83%A7%E5%BD%95%E8%84%9A%E6%9C%AC),如果写得不好,欢迎打脸.

## 使用脚本
在终端下直接调用以下脚本即可,但是你还是要先设置下相关参数对应的路径,具体你可以看脚本里面的内容,那里有中文的注释
```
./download.sh
```
## 运行的结果
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
至此,大家应该知道如何在**Visual Studio Code**上使用脚本调用**esptool**下载固件至ESP8266.还是那句话 **"如果写得不好,欢迎打脸."**

