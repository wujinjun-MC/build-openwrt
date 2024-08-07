
# 云编译OpenWrt

## 由wujinjun-MC修改

修改内容:

1. 增加6.6系列内核支持(测试中，已知 Phiconn N1 卡死)
2. 默认编译芯片s905d，Immortalwrt
3. 远程SSH，方便调试和`make menuconfig`
4. 充分利用硬盘空间，防止空间不足失败
5. Immortalwrt-master默认配置增加常用软件包，~~导出镜像包括ext4和squashfs~~(引起导出镜像错误)
6. 修复luci-app-amlogic未安装
7. 可修改Boot和系统分区容量大小，扩容以防后续安装插件空间不足
8. 生成编译生成的所有ipk包到`all_ipks.tar.gz`，生成编译目录文件树到`filetree.txt`
9. 默认IP: 192.168.3.3

注意事项:

1. 远程SSH需要Cpolar账户，获取TOKEN后在右上角的 Settings > Secrets > Actions > New repostiory secret，添加两个secret:
    1. Name: SSH_PUB_KEY, Value: 自己的SSH公钥
    2. Name: REVERSE_PROXY_TOKEN, Value: Cpolar token
2. ~~开启远程SSH可能导致workflow运行45分钟时被强制停止，刷新页面后显示跳过，记得经常保存配置文件并下载~~ 使用`Cpolar`或其他的`Reverse Proxy`/`内网穿透`，伪入站连接式SSH，已绕过(低调谨防abuse)
3. 如非amlogic-s9xxx机型，在diy-part1.sh和diy-part2.sh中删除src-git开头的有关amlogic的仓库

## 以下为原始Readme内容

在线云编译，是github推出的一项服务，它提供了高性能的虚拟服务器环境，基于它可以进行构建、测试、打包、部署项目。利用它可以省去本地搭建或者购买服务器的时间成本，你只需要使用本仓库的代码，按照下方的使用方法，修改一些参数，即可开始编译openwrt，等待几个小时后，你就可以下载固件了。

说明：源码来自各位大佬分享，为了方便编译，做了一些修改，可以支持不同分支的opewrt源码，同时集成了打包img镜像的功能。

- 官方源码：    https://github.com/openwrt/openwrt      

- lede源码：    https://github.com/coolsnowwolf/lede  

- lienol源码：  https://github.com/Lienol/openwrt 

- immortalwrt源码： https://github.com/immortalwrt/immortalwrt

### 操作教程由“实用技能”提供 @shiyongjineng

#### 观看视频教程↓↓点击下方↓↓进行观看！

[![从零开始：自己编译OpenWrt系统！一个视频就够了！](https://res.cloudinary.com/marcomontalbano/image/upload/v1692411463/video_to_markdown/images/youtube--_3B-y73JRQ4-c05b58ac6eb4c4700831b2b3070cd403.jpg)](https://youtu.be/_3B-y73JRQ4 "从零开始：自己编译OpenWrt系统！一个视频就够了！")

[![openwrt在线编译教程](https://res.cloudinary.com/marcomontalbano/image/upload/v1692156705/video_to_markdown/images/youtube--6j4ofS0GT38-c05b58ac6eb4c4700831b2b3070cd403.jpg)](https://www.youtube.com/watch?v=6j4ofS0GT38 "openwrt在线编译教程")

[![电视盒子专用：利用Flippy内核工具打包，将OpenWrt固件转成img镜像文件，](https://res.cloudinary.com/marcomontalbano/image/upload/v1692927730/video_to_markdown/images/youtube--EPNsHRj3eXE-c05b58ac6eb4c4700831b2b3070cd403.jpg)](https://youtu.be/EPNsHRj3eXE "电视盒子专用：利用Flippy内核工具打包，将OpenWrt固件转成img镜像文件，")


## 使用方法

1，注册账号

- 点击github.com 网站右上角的【Sign up】按钮，根据要求填写完成即可！

2，设置权限

- 右上角点击自己的头像，下拉菜单中选择【Settings/设置】 > 【Developer settings/开发者设置】 > 【Personal access tokens/个人访问令牌 > 【Tokens（classic）/令牌（经典）】 > 【 Generate new token/生成新令牌 】 ( Name: GITHUB_TOKEN, Select: public_repo )，其他选项根据自己需要可以多选，提交保存，复制系统生成的加密 KEY 的值，先保存到自己电脑的记事本，下一步会用到这个值。

- 打开仓库 https://github.com/xinlingduyu/build-openwrt ，点击右上的 Fork 按钮，复制一份仓库代码到自己的账户下，稍等几秒钟，提示 Fork 完成后，到自己的账户下访问自己仓库里的 build-openwrt 。在右上角的 Settings > Secrets > Actions > New repostiory secret ( Name: GH_TOKEN, Value: 填写刚才GITHUB_TOKEN的值 )，保存。并在左侧导航栏的 Actions > General > Workflow permissions 下选择 Read and write permissions 并保存。图示如下：



3，设置config
- 进入config文件夹，需要用哪个分支的源码，就打开哪个文件夹。
   
设置config文件，可以从本地设置好后，复制进去替换掉即可。


4，添加插件或主题

-  进入config文件夹，需要用哪个分支的源码，就打开哪个文件夹。打开diy-part2.sh文件，电视盒子必须安装amlogic插件，格式如下：

    #####Add a feed source
    
    echo 'src-git amlogic https://github.com/ophub/luci-app-amlogic' >>feeds.conf.default
    
   
5，开始编译，
 
 - 点击菜单栏的【Actions】，左边菜单栏选择编译流程（说明：通用编译适合常用设备，如果你是电视盒子，那么请选择电视盒子编译）
 
 
 7，下载固件
 
 
 由于时间仓促，修改可能不到位，后续慢慢补充！

  
