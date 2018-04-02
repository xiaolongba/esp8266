:<<!
********************请注意***************
在使用之前,必须先填充以下变量的路径或者内容
1/ESPTOOL_PATH表示esptool.py的绝对路径
2/COM表示当前连接ESP8266的是串口几
3/BOOT_PATH表示如果是Non-FOTA则是eagle_flash.bin的绝对路径,否则是boot.bin的绝对路径
3/USER_BIN_PATH表示如果是Non-FOTA则是eagle_irom0text.bin的绝对路径,否则就是user1.bin的绝对路径,
4/USER_BIN_PATH表示blank.bin的绝对路径
5/ESP_INIT_DATA_DEFAULT_BIN_PATH表示esp_init_data_default.bin的绝对路径

example:
    export ESPTOOL_PATH=D:/Project/Smart_Plug/tools/esptool/esptool.py
    export COM=COM10
    export BOOT_PATH=D:/Project/Smart_Plug/bin/boot_v1.7.bin
    export USER_BIN_PATH=D:/Project/Smart_Plug/bin/upgrade/user1.2048.new.bin
    export BLANK_BIN_PATH=D:/Project/Smart_Plug/bin/blank.bin
    export ESP_INIT_DATA_DEFAULT_BIN_PATH=D:/Project/Smart_Plug/bin/esp_init_data_default.bin
!
export ESPTOOL_PATH=D:/Project/Smart_Plug/tools/esptool/esptool.py
export COM=COM10
export BOOT_PATH=D:/Project/Smart_Plug/bin/boot_v1.7.bin
export USER_BIN_PATH=D:/Project/Smart_Plug/bin/upgrade/user1.2048.new.5.bin
export BLANK_BIN_PATH=D:/Project/Smart_Plug/bin/blank.bin
export ESP_INIT_DATA_DEFAULT_BIN_PATH=D:/Project/Smart_Plug/bin/esp_init_data_default.bin

echo "Download shell by Helon Chan 2018/04/01"
echo ""

if [ $ESPTOOL_PATH ]; then    
    echo "$ESPTOOL_PATH"
    echo ""
else
    echo "ERROR: Please export ESPTOOL_PATH in download.sh firstly, exit!!!"
    exit
fi

if [ $COM ]; then    
    echo "$COM"
    echo ""
else
    echo "ERROR: Please export COM in download.sh firstly, exit!!!"
    exit
fi

echo "Do u wanna check the flash size?enter (Y/y or N/n) to continue(default is N/n):"
echo ""
read input

if [[ $input == Y ]] || [[ $input == y ]]; then
    echo "pls coming into download model firstly!!"
    echo ""
    $ESPTOOL_PATH --port $COM flash_id    
fi

echo ""
:<<!
if yes,erase all flash otherwise dont erase anything
!
echo "Do u want to erase all flash? enter (Y/y or N/n) to continue(default is N/n):"
echo ""
read input

if [ -z "$input" ]; then
    erase_all_flash=0
elif [[ $input != Y ]] && [[ $input != y ]]; then
    erase_all_flash=0    
else
    erase_all_flash=1
    $ESPTOOL_PATH --port $COM erase_flash    
fi

:<<!
if yes,u should download the boot.bin+user.bin+blank.bin+esp_init_data.bin together
if no,u just have to download the user.bin
!

if [ $erase_all_flash != 1 ]; then
    echo "Is this new esp8266? enter (Y/y or N/n) to continue(default is N/n):"    
    echo ""
    read input

    if [ -z "$input" ]; then
        new_device=0
    elif [[ $input != Y ]] && [[ $input != y ]]; then
        new_device=0    
    else
        new_device=1
    fi
else
    echo "Now the esp8266 is new"
    echo ""
    new_device=1
fi


if [ $new_device == 1 ]; then

    if [ $BOOT_PATH ]; then        
        echo "$BOOT_PATH"
        echo ""
    else
        echo "ERROR: Please export BOOT_PATH in download.sh firstly, exit!!!"
        exit
    fi    

    if [ $BLANK_BIN_PATH ]; then        
        echo "$BLANK_BIN_PATH"
        echo ""
    else
        echo "ERROR: Please export BLANK_BIN_PATH in download.sh firstly, exit!!!"
        exit
    fi
fi

if [ $USER_BIN_PATH ]; then    
    echo "$USER_BIN_PATH"
    echo ""
else
    echo "ERROR: Please export USER_BIN_PATH in download.sh firstly, exit!!!"
    exit
fi

echo "what is the esp8266 flash size(MB)"
echo "    0=0.5MB"
echo "    1=1MB"
echo "    2=2MB"
echo "    3=4MB"
echo "    4=8MB"
echo "    5=16MB"
echo "enter (0/1/2/3/4/5, default 0):"
read input

if [ -z "$input" ]; then
    flash_size=0
    if [ $new_device == 1 ]; then
        blank_addr1=0x7B000 
        esp_init_data_addr=0x7C000
        blank_addr2=0x7E000            
    fi          
elif [ $input == 1 ]; then
    flash_size=1
    if [ $new_device == 1 ]; then
        blank_addr1=0xFB000
        esp_init_data_addr=0xFC000
        blank_addr2=0xFE000              
    fi    
elif [ $input == 2 ]; then
    flash_size=2
    if [ $new_device == 1 ]; then
        blank_addr1=0x1FB000
        esp_init_data_addr=0x1FC000
        blank_addr2=0x1FE000                
    fi    
elif [ $input == 3 ]; then
    flash_size=3
    if [ $new_device == 1 ]; then
        blank_addr1=0x3FB000
        esp_init_data_addr=0x3FC000
        blank_addr2=0x3FE000              
    fi    
elif [ $input == 4 ]; then
    flash_size=4
    if [ $new_device == 1 ]; then
        blank_addr1=0x7FB000
        esp_init_data_addr=0x7FC000
        blank_addr2=0x7FE000                
    fi    
elif [ $input == 5 ]; then
    flash_size=5      
    if [ $new_device == 1 ]; then
        blank_addr1=0xFFB000
        esp_init_data_addr=0xFFC000
        blank_addr2=0xFFE000               
    fi    
else
    flash_size=0
    if [ $new_device == 1 ]; then
        blank_addr1=0x7B000
        esp_init_data_addr=0x7C000
        blank_addr2=0x7E000               
    fi    
fi       

:<<!
whatever the flash size,the below two addrs are never change
!
boot_addr=0x00000
user1_addr=0x01000    

echo "Download is starting ^_^!!"
echo ""
if [ $new_device == 1 ]; then
    $ESPTOOL_PATH --port $COM write_flash \
    $boot_addr $BOOT_PATH \
    $user1_addr $USER_BIN_PATH \
    $blank_addr1 $BLANK_BIN_PATH \
    $esp_init_data_addr $ESP_INIT_DATA_DEFAULT_BIN_PATH \
    $blank_addr2 $BLANK_BIN_PATH
else
    echo "$user1_addr"    
    $ESPTOOL_PATH --port $COM write_flash $user1_addr $USER_BIN_PATH
fi

