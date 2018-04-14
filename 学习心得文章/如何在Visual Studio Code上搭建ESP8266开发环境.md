## 前言
> 在物联网这个圈子里,一提到**ESP8266**我想不会没有人不知道这货吧?**(如果不知道的小伙伴,我建议你还是早点回家养猪吧,不要问为什么)**,在当时WIFI价格还在20元以上时,这货横空出世把价格拉到了12元甚至更低,一下子把其他WIFI厂商啪啪啪打得措手不及,纷纷推出跟ESP8266竞标的用于物联网的WIFI.当然啦,这是一个好事,有竞争才会进步嘛.本想继续BB下去,把所知道的统统说出来的,但是这样有违本篇的标题,So直接进入主题吧

## ESP8266开发环境现状
目前,ESP8266主流的开发环境有以下几个:
- **[1]** 官方推荐的直接在Linux下进行开发

- **[2]** 官方推荐的linux虚拟机在windows上开发

- **[3]** 安信可推出的eclipse+cygwin+安信可的配置工具在windows上开发

现在大家用搜索引擎搜索到的开发环境搭建的教程或者论坛贴均是基于上面的 **[1]**&**[2]**&**[3]** 来展开的,但是上面的这几种开发环境在我看来均是不完美的,原因如下:
- **[A]** 一般的嵌入式开发者,大多开发软件均是基于Windows的,如果直接在Linux下开发,要么就安装Linux虚拟机,要么双系统,要么两台电脑,要么......等等,这些在我看来是让人很蛋疼的,起码我个人是绝不会这样做的,因为我们仅仅是需要一个linux环境而已,你却要我安装这么多还这么大的东西,所以我对这种方式直接"Say No!"**(如果是一直都是基于linux环境开发的大佬可以忽悠,直接右上角)**

- **[B]** 官方推出的第二种方式在我看来,会比官方推荐的第一种方式稍微好一点,但是还是太麻烦了,因为编译和编写代码要在**windows**和**linux**环境下不断切换,仍然**PASS**掉:grin:

- **[C]** 安信可的这种方式本身没什么毛病,现在用的最多的可能就是这种开发模式了,但是在我看来还是不理想.
     1. 首先,**C/C++ for eclipse**对代码补全的功能相对于java来说太鸡肋了,只对结构体才会有效,其他的每次我要<code>Ctrl + /</code>才会有代码补全,对于用惯**Visual Studio**的人来说这简直不能忍
     2. **C/C++ for eclipse**在我看来还是太大了,而且这货你安装了平时也很少用
     
以上就是目前市场上比较主流的情况,可能你会说**Arduino IDE**也可以啊,这种就是给小学生玩的,这里不予讨论.

## 开始进入主题
上面说了这么多废话,其实就是想表达有没有更简单,更轻量级的方法来实现在windows上开发ESP8266甚至是ESP32,经过两天的摸索终于找到了.在开始前先看看要实现这样的目的需要哪些工具
![](https://raw.githubusercontent.com/xiaolongba/picture/master/ESP8266%20%E5%BC%80%E5%8F%91%E6%89%80%E9%9C%80%E8%A6%81%E7%9A%84%E5%B7%A5%E5%85%B7.png)

### 支持Make命令的Linux环境
**Cygwin**、**MinGw**以及乐鑫官方提供的**msys2**等等均可以,选一个你最喜欢的.这里我选用安信可提供的Cygwin **(里面已经包含了ESP8266&ESP32的编译工具链)** [下载地址](https://pan.baidu.com/s/1skRvR1j#list/path=%2F)

### ESP的toolchain
因为乐鑫芯片的内核不是我们大家所比较熟悉的**Cortex-M**内核,所以需要用乐鑫提供的工具链,ESP8266用的是**xtensa-lx106-elf**,ESP32用的是**xtensa-esp32-elf**,已经包含在上面的 **[下载地址]**

### 代码编辑器
**Visual Studio Code**、**clion**、**sublime**、**source insight**等等均可以,但是我个人还是推荐用神器**Visual Studio Code**,理由你懂得:smile:


其实,**ESP8266开发环境现状**中所说的 **[1]**&**[2]**&**[3]** 就是基于上面所说的方法展开的,以下是我摸索出来的方法
![](https://raw.githubusercontent.com/xiaolongba/picture/master/ESP8266%20%E5%BC%80%E5%8F%91%E6%89%80%E9%9C%80%E8%A6%81%E7%9A%84%E5%B7%A5%E5%85%B7%2B%E8%AF%A6%E7%BB%86%E5%86%85%E5%AE%B9.png)

之所以是这样的组合,理由如下:
1. **Visual Studio Code**硬邦邦的代码补全功能
2. **Visual Studio Code**可以直接调用bash
3. **Visual Studio Code**大小只有40多MB,轻量级软件
4. 安信可的**Cygwin**包含有现成的编译工具链

## 配置
要实现这样以上所说的功能,只需进行以下几个简单的配置即可.
- 安装**Visual Studio Code**,这个自行解决**(如果不知道的小伙伴,没错!赶紧回家养猪吧,不要问为什么:joy:)**
- 解压**Cygwin**至任意盘符 **(!路径最好不要有中文)**
- 将**Cygwin**和**编译工具链**添加至环境变量 **(右击我的电脑->高级系统设置->环境变量)**中即可**(用户及系统变量任意一个均可)**,笔者添加至环境变量的内容如下,<font color=#ff0000 size=3>一定要添加至环境变量否则无法调用bash和使用乐鑫的编译工具链:</font>
```
E:\Software Application\Cygwin\cygwin\bin;
E:\Software Application\Cygwin\cygwin\opt\xtensa-lx106-elf\bin;
```

只要这三个步骤就完成了,简单地一逼,现在就可以用**Visual Studio Code**编写以及编译ESP8266了

## 如何使用
打开**Visual Studio Code**安装一些辅助插件,主要是用于代码高亮和提示,详细的方法自行网上搜索解决,这里不再概述,接下来讲如何使用**Visual Studio Code**编写以及编译ESP8266
- 在**Visual Studio Code**打开ESP8266的SDK包,如下图所示:
![](https://raw.githubusercontent.com/xiaolongba/picture/master/ESP8266%20RTOS%20SDK%E5%8C%85.png)

- 在**Visual Studio Code**按下<code>Ctrl + `</code>组合键,打开终端,如下图所示:
![](https://raw.githubusercontent.com/xiaolongba/picture/master/powershell.png)

- 在终端中从powershell切换至bash,如下图所示:
![](https://raw.githubusercontent.com/xiaolongba/picture/master/bash.png)

- 开始编译 **(在编译前需要修改gen_misc.sh中的SDK以及BIN路径,具体的修改方法参考[ESP8266 SDK⼊门指南](https://www.espressif.com/zh-hans/support/explore/get-started/esp8266/getting-started-guide))**,如下图所示
![](https://raw.githubusercontent.com/xiaolongba/picture/master/complier.png)


```
Administrator@Helon /cygdrive/d/VM/Share/ESP8266_RTOS_SDK
$ cd project_template/

Administrator@Helon /cygdrive/d/VM/Share/ESP8266_RTOS_SDK/project_template
$ ls
gen_misc.bat  gen_misc.sh  include  Makefile  readme.txt  sample_lib  user

Administrator@Helon /cygdrive/d/VM/Share/ESP8266_RTOS_SDK/project_template
$ ./gen_misc.sh
gen_misc.sh version 20150911

SDK_PATH:
D:/VM/Share/ESP8266_RTOS_SDK

BIN_PATH:
D:/VM/Share/ESP8266_RTOS_SDK/bin

Please check SDK_PATH & BIN_PATH, enter (Y/y) to continue:
Y

Please follow below steps(1-5) to generate specific bin(s):
STEP 1: use boot_v1.2+ by default
boot mode: new

STEP 2: choose bin generate(0=eagle.flash.bin+eagle.irom0text.bin, 1=user1.bin, 2=user2.bin)
enter (0/1/2, default 0):
1
generate bin: user1.bin

STEP 3: choose spi speed(0=20MHz, 1=26.7MHz, 2=40MHz, 3=80MHz)
enter (0/1/2/3, default 2):

spi speed: 40 MHz

STEP 4: choose spi mode(0=QIO, 1=QOUT, 2=DIO, 3=DOUT)
enter (0/1/2/3, default 0):

spi mode: QIO

STEP 5: choose spi size and map
    0= 512KB( 256KB+ 256KB)
    2=1024KB( 512KB+ 512KB)
    3=2048KB( 512KB+ 512KB)
    4=4096KB( 512KB+ 512KB)
    5=2048KB(1024KB+1024KB)
    6=4096KB(1024KB+1024KB)
    7=4096KB(2048KB+2048KB) not support ,just for compatible with nodeMCU board
    8=8192KB(1024KB+1024KB)
    9=16384KB(1024KB+1024KB)
enter (0/2/3/4/5/6/7/8/9, default 0):
6
spi size: 4096KB
spi ota map:  1024KB + 1024KB

start...

make -C user clean;  make -C sample_lib clean;
make[1]: Entering directory '/cygdrive/d/VM/Share/ESP8266_RTOS_SDK/project_template/user'
rm -f -r .output/eagle/debug
make[1]: Leaving directory '/cygdrive/d/VM/Share/ESP8266_RTOS_SDK/project_template/user'
make[1]: Entering directory '/cygdrive/d/VM/Share/ESP8266_RTOS_SDK/project_template/sample_lib'
make -C folder1 clean;  make -C folder2 clean;
make[2]: Entering directory '/cygdrive/d/VM/Share/ESP8266_RTOS_SDK/project_template/sample_lib/folder1'
rm -f -r .output/eagle/debug
make[2]: Leaving directory '/cygdrive/d/VM/Share/ESP8266_RTOS_SDK/project_template/sample_lib/folder1'
make[2]: Entering directory '/cygdrive/d/VM/Share/ESP8266_RTOS_SDK/project_template/sample_lib/folder2'
rm -f -r .output/eagle/debug
make[2]: Leaving directory '/cygdrive/d/VM/Share/ESP8266_RTOS_SDK/project_template/sample_lib/folder2'
rm -f -r .output/eagle/debug
make[1]: Leaving directory '/cygdrive/d/VM/Share/ESP8266_RTOS_SDK/project_template/sample_lib'
rm -f -r .output/eagle/debug
make[1]: Entering directory '/cygdrive/d/VM/Share/ESP8266_RTOS_SDK/project_template/user'
DEPEND: xtensa-lx106-elf-gcc -M -Os -g -Wpointer-arith -Wundef -Werror -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -ffunction-sections -fdata-sections -fno-builtin-printf -fno-jump-tables -DICACHE_FLASH -I include -I ./ -I ../include -I D:/VM/Share/ESP8266_RTOS_SDK/include -I D:/VM/Share/ESP8266_RTOS_SDK/extra_include -I D:/VM/Share/ESP8266_RTOS_SDK/driver_lib/include -I D:/VM/Share/ESP8266_RTOS_SDK/include/espressif -I D:/VM/Share/ESP8266_RTOS_SDK/include/lwip -I D:/VM/Share/ESP8266_RTOS_SDK/include/lwip/ipv4 -I D:/VM/Share/ESP8266_RTOS_SDK/include/lwip/ipv6 -I D:/VM/Share/ESP8266_RTOS_SDK/include/nopoll -I D:/VM/Share/ESP8266_RTOS_SDK/include/spiffs -I D:/VM/Share/ESP8266_RTOS_SDK/include/ssl -I D:/VM/Share/ESP8266_RTOS_SDK/include/json -I D:/VM/Share/ESP8266_RTOS_SDK/include/openssl -I D:/VM/Share/ESP8266_RTOS_SDK/include/mqtt user_main.c
xtensa-lx106-elf-gcc -Os -g -Wpointer-arith -Wundef -Werror -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -ffunction-sections -fdata-sections -fno-builtin-printf -fno-jump-tables  -DICACHE_FLASH   -I include -I ./ -I ../include -I D:/VM/Share/ESP8266_RTOS_SDK/include -I D:/VM/Share/ESP8266_RTOS_SDK/extra_include -I D:/VM/Share/ESP8266_RTOS_SDK/driver_lib/include -I D:/VM/Share/ESP8266_RTOS_SDK/include/espressif -I D:/VM/Share/ESP8266_RTOS_SDK/include/lwip -I D:/VM/Share/ESP8266_RTOS_SDK/include/lwip/ipv4 -I D:/VM/Share/ESP8266_RTOS_SDK/include/lwip/ipv6 -I D:/VM/Share/ESP8266_RTOS_SDK/include/nopoll -I D:/VM/Share/ESP8266_RTOS_SDK/include/spiffs -I D:/VM/Share/ESP8266_RTOS_SDK/include/ssl -I D:/VM/Share/ESP8266_RTOS_SDK/include/json -I D:/VM/Share/ESP8266_RTOS_SDK/include/openssl -I D:/VM/Share/ESP8266_RTOS_SDK/include/mqtt  -o .output/eagle/debug/obj/user_main.o -c user_main.c
xtensa-lx106-elf-ar ru .output/eagle/debug/lib/libuser.a .output/eagle/debug/obj/user_main.o
xtensa-lx106-elf-ar: creating .output/eagle/debug/lib/libuser.a
make[1]: Leaving directory '/cygdrive/d/VM/Share/ESP8266_RTOS_SDK/project_template/user'
make[1]: Entering directory '/cygdrive/d/VM/Share/ESP8266_RTOS_SDK/project_template/sample_lib'
make[2]: Entering directory '/cygdrive/d/VM/Share/ESP8266_RTOS_SDK/project_template/sample_lib/folder1'
DEPEND: xtensa-lx106-elf-gcc -M -Os -g -Wpointer-arith -Wundef -Werror -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -ffunction-sections -fdata-sections -fno-builtin-printf -fno-jump-tables -DICACHE_FLASH -I include -I ./ -I ../include -I ./ -I ../../include -I
D:/VM/Share/ESP8266_RTOS_SDK/include -I D:/VM/Share/ESP8266_RTOS_SDK/extra_include -I D:/VM/Share/ESP8266_RTOS_SDK/driver_lib/include -I D:/VM/Share/ESP8266_RTOS_SDK/include/espressif -I D:/VM/Share/ESP8266_RTOS_SDK/include/lwip -I D:/VM/Share/ESP8266_RTOS_SDK/include/lwip/ipv4 -I D:/VM/Share/ESP8266_RTOS_SDK/include/lwip/ipv6 -I D:/VM/Share/ESP8266_RTOS_SDK/include/nopoll -I D:/VM/Share/ESP8266_RTOS_SDK/include/spiffs -I D:/VM/Share/ESP8266_RTOS_SDK/include/ssl -I D:/VM/Share/ESP8266_RTOS_SDK/include/json -I D:/VM/Share/ESP8266_RTOS_SDK/include/openssl -I D:/VM/Share/ESP8266_RTOS_SDK/include/mqtt file1.c
xtensa-lx106-elf-gcc -Os -g -Wpointer-arith -Wundef -Werror -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -ffunction-sections -fdata-sections -fno-builtin-printf -fno-jump-tables  -DICACHE_FLASH   -I include -I ./ -I ../include -I ./ -I ../../include -I D:/VM/Share/ESP8266_RTOS_SDK/include -I D:/VM/Share/ESP8266_RTOS_SDK/extra_include -I D:/VM/Share/ESP8266_RTOS_SDK/driver_lib/include -I D:/VM/Share/ESP8266_RTOS_SDK/include/espressif -I D:/VM/Share/ESP8266_RTOS_SDK/include/lwip -I D:/VM/Share/ESP8266_RTOS_SDK/include/lwip/ipv4 -I D:/VM/Share/ESP8266_RTOS_SDK/include/lwip/ipv6 -I D:/VM/Share/ESP8266_RTOS_SDK/include/nopoll -I D:/VM/Share/ESP8266_RTOS_SDK/include/spiffs -I D:/VM/Share/ESP8266_RTOS_SDK/include/ssl -I D:/VM/Share/ESP8266_RTOS_SDK/include/json -I D:/VM/Share/ESP8266_RTOS_SDK/include/openssl -I D:/VM/Share/ESP8266_RTOS_SDK/include/mqtt  -o .output/eagle/debug/obj/file1.o -c file1.c
xtensa-lx106-elf-ar ru .output/eagle/debug/lib/libfolder1.a .output/eagle/debug/obj/file1.o
xtensa-lx106-elf-ar: creating .output/eagle/debug/lib/libfolder1.a
make[2]: Leaving directory '/cygdrive/d/VM/Share/ESP8266_RTOS_SDK/project_template/sample_lib/folder1'
make[2]: Entering directory '/cygdrive/d/VM/Share/ESP8266_RTOS_SDK/project_template/sample_lib/folder2'
DEPEND: xtensa-lx106-elf-gcc -M -Os -g -Wpointer-arith -Wundef -Werror -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -ffunction-sections -fdata-sections -fno-builtin-printf -fno-jump-tables -DICACHE_FLASH -I include -I ./ -I ../include -I ./ -I ../../include -I
D:/VM/Share/ESP8266_RTOS_SDK/include -I D:/VM/Share/ESP8266_RTOS_SDK/extra_include -I D:/VM/Share/ESP8266_RTOS_SDK/driver_lib/include -I D:/VM/Share/ESP8266_RTOS_SDK/include/espressif -I D:/VM/Share/ESP8266_RTOS_SDK/include/lwip -I D:/VM/Share/ESP8266_RTOS_SDK/include/lwip/ipv4 -I D:/VM/Share/ESP8266_RTOS_SDK/include/lwip/ipv6 -I D:/VM/Share/ESP8266_RTOS_SDK/include/nopoll -I D:/VM/Share/ESP8266_RTOS_SDK/include/spiffs -I D:/VM/Share/ESP8266_RTOS_SDK/include/ssl -I D:/VM/Share/ESP8266_RTOS_SDK/include/json -I D:/VM/Share/ESP8266_RTOS_SDK/include/openssl -I D:/VM/Share/ESP8266_RTOS_SDK/include/mqtt file2.c
xtensa-lx106-elf-gcc -Os -g -Wpointer-arith -Wundef -Werror -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -ffunction-sections -fdata-sections -fno-builtin-printf -fno-jump-tables  -DICACHE_FLASH   -I include -I ./ -I ../include -I ./ -I ../../include -I D:/VM/Share/ESP8266_RTOS_SDK/include -I D:/VM/Share/ESP8266_RTOS_SDK/extra_include -I D:/VM/Share/ESP8266_RTOS_SDK/driver_lib/include -I D:/VM/Share/ESP8266_RTOS_SDK/include/espressif -I D:/VM/Share/ESP8266_RTOS_SDK/include/lwip -I D:/VM/Share/ESP8266_RTOS_SDK/include/lwip/ipv4 -I D:/VM/Share/ESP8266_RTOS_SDK/include/lwip/ipv6 -I D:/VM/Share/ESP8266_RTOS_SDK/include/nopoll -I D:/VM/Share/ESP8266_RTOS_SDK/include/spiffs -I D:/VM/Share/ESP8266_RTOS_SDK/include/ssl -I D:/VM/Share/ESP8266_RTOS_SDK/include/json -I D:/VM/Share/ESP8266_RTOS_SDK/include/openssl -I D:/VM/Share/ESP8266_RTOS_SDK/include/mqtt  -o .output/eagle/debug/obj/file2.o -c file2.c
xtensa-lx106-elf-ar ru .output/eagle/debug/lib/libfolder2.a .output/eagle/debug/obj/file2.o
xtensa-lx106-elf-ar: creating .output/eagle/debug/lib/libfolder2.a
make[2]: Leaving directory '/cygdrive/d/VM/Share/ESP8266_RTOS_SDK/project_template/sample_lib/folder2'
mkdir -p _libsample
cd _libsample; xtensa-lx106-elf-ar xo ../folder1/.output/eagle/debug/lib/libfolder1.a; xtensa-lx106-elf-ar xo ../folder2/.output/eagle/debug/lib/libfolder2.a;
xtensa-lx106-elf-ar ru .output/eagle/debug/lib/libsample.a  _libsample/*.o
xtensa-lx106-elf-ar: creating .output/eagle/debug/lib/libsample.a
rm -f -r _libsample
make[1]: Leaving directory '/cygdrive/d/VM/Share/ESP8266_RTOS_SDK/project_template/sample_lib'
xtensa-lx106-elf-gcc  -LD:/VM/Share/ESP8266_RTOS_SDK/lib -Wl,--gc-sections -nostdlib -TD:/VM/Share/ESP8266_RTOS_SDK/ld/eagle.app.v6.new.2048.ld -Wl,--no-check-sections -u call_user_start -Wl,-static -Wl,--start-group -lcirom -lcrypto -lespconn -lespnow -lfreertos -lgcc -lhal -ljson -llwip -lmain -lmirom -lnet80211 -lnopoll -lphy -lpp -lpwm -lsmartconfig -lspiffs -lssl -lwpa -lwps user/.output/eagle/debug/lib/libuser.a sample_lib/.output/eagle/debug/lib/libsample.a -Wl,--end-group -o .output/eagle/debug/image/eagle.app.v6.out

!!!
SDK_PATH: D:/VM/Share/ESP8266_RTOS_SDK
BIN_PATH: D:/VM/Share/ESP8266_RTOS_SDK/bin/upgrade

bin crc: 44d22a1c
Support boot_v1.4 and +
Generate user1.4096.new.6.bin successully in BIN_PATH
boot.bin------------>0x00000
user1.4096.new.6.bin--->0x01000
!!!

Administrator@Helon /cygdrive/d/VM/Share/ESP8266_RTOS_SDK/project_template
$
```

至此,整个使用流程就结束了.

## 总结
以上所描述的方法,是不是较于主流的方法简单很多,而且非常适合常使用windows开发环境的嵌入式开发者,估计这个应该是全网首创的方法了,嘿嘿:sweat_smile:

## 注意事项
如果在执行**gen_misc.sh**时出现以下错误:
```
$ ./gen_misc.sh
./gen_misc.sh: line 2: $'\r': command not found
./gen_misc.sh: line 10: $'\r': command not found
./gen_misc.sh: line 13: $'\r': command not found
gen_misc.sh version 20150911
```
**[原因]**
win下的换行是回车符+换行符，也就是\r\n,而unix下是换行符\n,linux下不识别\r为回车符,所以导致每行的配置都多了个\r.

**[解决方法]**
只需要在**Visual Studio Code**中打开**gen_misc.sh**,并在当前页面将右下角的那一框中将**CRLF**切换成**LF**即可解决.

## 扩展
后面可以再写一个脚本,直接调用esptool来烧录生成的固件,这样就已经算完美了.哈哈,等有时间我再写一个,如果有读者已经有现成,欢迎留言.





