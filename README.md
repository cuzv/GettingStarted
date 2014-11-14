# GettingStarted

This is a iPhone initial Project. Already prepared AFNetworking packing, Folder struct.

Created by Moch on 8/15/14.

Copyright (c) 2014 Moch. All rights reserved.

## Folder structs

- Application 定义和字符串数字常量定义(优先考虑使用常量)
	- AssistanceMacro.h 代码帮助宏
	- AppPrefix.h   预处理，自己的.h写这里面. pch文件导出该文件
	- AppMacro.h    App 相关宏定义
    - AppConstant.m App 相关常量定义	
    - NIConstant.m 网络请求接口定义
- Base 	基类
- Generator 项目通用代码
	- Views
	- Classess
	- Categories 
	- Dependence
- Modules 项目功能模块
	- Home
	- PersonalCenter
	- Search
- Models	数据相关的模型文件
- Resources			资源文件
	- ProvincesAndCitiesAndAreas.plist
- Helps 工具类(与项目相关)
	- HTTPManager   网络请求封装
	- AcountManager	账户相关
- Vendors	三方类库
	- Base64
	- NSHashes
	- MLEmojiLabel 自定义映射表表情显示标签
	- AwesomeMenu 
	- WDActivityIndicator
