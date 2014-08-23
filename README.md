# GettingStarted

This is a iPhone initial Project. Already prepared AFNetworking packing, Folder struct.

Created by Moch on 8/15/14.

Copyright (c) 2014 Moch. All rights reserved.

## Folder structs

- Brief  			宏定义和字符串数字常量定义(优先考虑使用常量)
	- AppPrefix.h   预处理，自己的.h写这里面. pch文件导出该文件
	- AppMacro.h    App 相关宏定义
    - AppConstant.m App 相关常量定义	
    - NIConstant.m 网络请求接口定义
	- AssistanceMacro.h 代码帮助宏
- Common 			复用性高的一些文件
	- Categories
	- Classess
	- Views
- Modules 			项目功能模块
	- Home
	- PersonalCenter
	- Search
- Models 			数据相关的模型文件
- Resources			资源文件
	- ProvincesAndCitiesAndAreas.plist
- Utils  			工具类
	- HTTPManager   网络请求封装
	- AcountManager	账户相关
	- VerificationManager 验证提交信息
- Vendors 			三方类库
	- Base64
	- NSString-Hashes
	- MJRefresh
	- SVProgressHUD
