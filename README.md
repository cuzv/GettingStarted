# GettingStarted

This is a iPhone initial Project. Already prepared AFNetworking packing, Folder struct.

Created by Moch on 8/15/14.

Copyright (c) 2014 Moch. All rights reserved.

## Folder structs

- References 定义和字符串数字常量定义(优先考虑使用常量)
	- AssistanceMacro.h 代码帮助宏
	- AppPrefix.h   预处理，自己的.h写这里面. pch文件导出该文件
	- AppMacro.h    App 相关宏定义
    - AppConstant.m App 相关常量定义	
    - NIConstant.m 网络请求接口定义
- General 	项目中通用代码
- MakeBetter 类别，子类
	- Original 
	- Dependence
- Modules 项目功能模块
	- Home
	- PersonalCenter
	- Search
- Models	数据相关的模型文件
- Resources			资源文件
	- ProvincesAndCitiesAndAreas.plist
- Utilities 工具类
	- HTTPManager   网络请求封装
	- AcountManager	账户相关
	- VerificationManager 验证提交信息
	- PersistenceManager 本地缓存(归档)
- Vendors	三方类库
	- Base64
	- NSHashes
	- MLEmojiLabel 自定义映射表表情显示标签
	- AwesomeMenu 
	- WDActivityIndicator
