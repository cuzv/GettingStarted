


# HttpManager 使用说明

```objective-c
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
```

## POST 传参注意事项：

- 第一种方式：将请求参数拼接到 URLString 上，parameters 参数接 nil。估计应该是后台的特殊要求

    完整参数形式：`BaseURL`/`mehtodName`?`parametersKey`=key1=value1&key2=value2...
    
- 第二种方式：标准 POST 方式
    
    URLString 接接口地址，parameters 接参数对象。完整参数形式：`BaseURL`/`mehtodName`; 传递参数在 HTTPBody 里面


## 关于参数格式转换的说明

后台代码如下

```php
// json_request.php
<?php
if ($receive = $_POST['paramJson']) {

	$obj = json_decode($receive, true);
	
	$response = $obj['emailAddress'];
	$responseArray = array(
		"code" => "1",
		"content" => $response
	);
	
	echo json_encode($responseArray, true);
} else {
	$responseArray = array(
		"code" => "0",
		"content" => "could not receive post datas"
	);
	
	echo json_encode($responseArray, true);
}

?>
```

需要注意的是：如上后台代码，服务器通过`parametersKey`(paramJson)来接收传递的 post 数据，所以不能使用` AFNetworking` 的 `AFHTTPRequestSerializer` 转换参数格式，会变成参数 JSON[@{`parametersKey`:`parameters`}]整个为转换后的格式，而正确格式应该是@{`parametersKey`:JSON[parameters]}，即：@{`parametersKey`:`JSONString`}。故将传递的参数转为正确格式，再给 AFNetworking 处理即可(不使用 AFNetworking 的 JSON 转换器)

```objective-c
NSData *JSONData = [self dataWithJSONObject:parameters];
NSString *JSONString = [self stringWithJSONData:JSONData];
NSDictionary *paramDictionary = @{CHParametersKey:JSONString};
```

## 测试

「团队宝」后台接收的参数是 base64 加密后的内容

### 测试一

拼接 URL，这种情况是否使用 `AFHTTPRequestSerializer` 都无影响，因为转换的是 POST 请求中 `parameters` 参数接的值，而这种情况为 nil

```objective-c
    #define kMessageList @"getMobileMessageList"
    NSString *const CHDebugHttpBaseURL = @"http://www.team168.com/servlet/ci/3/";
    NSString *const CHParametersKey = @"key";
    NSDictionary *dict = @{@"cid":@"1001",
                           @"oid":@"6611"};
    NSString *URLString = [self URLStringWithParameters:dict];
    NSString *base64EncodedString = [URLString base64EncodedString];
    NSString *paramEncode = [NSString stringWithFormat:@"v4_%@.do?%@=%@", kMessageList, CHParametersKey, base64EncodedString];
    
    NSLog(@"%@", paramEncode);
    // 方式一
    [[CHHTTPSessionManager sharedInstance] POST:paramEncode parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject[@"RI"]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error: %@", [error localizedDescription]);
    }];
```

### 测试二

需要关闭 `AFHTTPRequestSerializer` 因为后台接收的是 base64 格式的数据。原理同测试 php 代码的例子

```objective-c
    // 方式二
    NSString *const CHDebugHttpBaseURL = @"http://www.team168.com/servlet/ci/3/";
    #define kMessageList @"getMobileMessageList"
    NSString *const CHParametersKey = @"key";
    NSDictionary *dict = @{@"cid":@"1001",
                           @"oid":@"6611"};
    NSString *URLString = [self URLStringWithParameters:dict];
    NSString *base64EncodedString = [URLString base64EncodedString];
    NSDictionary *paramDicionary = @{CHParametersKey:base64EncodedString};
    
    [[CHHTTPSessionManager sharedInstance] POST:[NSString stringWithFormat:@"v4_%@.do", kMessageList]
                                     parameters:paramDicionary success:^(NSURLSessionDataTask *task, id responseObject) {
                                         NSLog(@"%@", responseObject[@"RI"]);
                                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                         NSLog(@"error: %@", [error localizedDescription]);
                                     }];
```

