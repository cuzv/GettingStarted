//
//  CHXCodeLicenser.m
//  GettingStarted
//
//  Created by Moch Xiao on 2014-12-14.
//  Copyright (c) 2014 Moch Xiao (https://github.com/atcuan).
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "CHXCodeLicenser.h"
#import <sys/stat.h>

@interface CHXCodeLicenser ()
@property (nonatomic, strong) NSArray *fileExtensionNames;
@end

extern NSString *const MITLicense;

@implementation CHXCodeLicenser

+ (instancetype)sharedInstance {
    static CHXCodeLicenser *_sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [self new];
    });
    
    return _sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _fileExtensionNames = @[@"h", @"m", @"mm", @"c", @"cpp", @"cc", @"swift"];
    }
    
    return self;
}

- (void)licenseCodeWithCreater:(NSString *)creater organization:(NSString *)organizationName projectName:(NSString *)projectName filePath:(NSString *)filePath toLicenseType:(CHXLicenseType)licenseType {
    // 判断是否为目录
    NSFileManager *fileManger = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist = [fileManger fileExistsAtPath:filePath isDirectory:&isDirectory];
    if (!isExist) {
        NSLog(@"输入路径格式错误或者文件不存在！");
        return;
    }
    
    if (isDirectory) {
        // 获取当前目录下的所有内容
        NSArray *directoryContent = [fileManger contentsOfDirectoryAtPath:filePath error:nil];
        
        // 遍历数组中的所有子文件(夹)
        [directoryContent enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj characterAtIndex:0] != '.' && ![[obj lowercaseString] containsString:@"vendor"]) {
                NSString *currentFilePath = [filePath stringByAppendingPathComponent:obj];
                [self licenseCodeWithCreater:creater organization:organizationName projectName:projectName filePath:currentFilePath toLicenseType:licenseType];
            }
        }];
    } else {
        // 对文件进行处理
        // 过滤文件，只取代码文件: .h .m .mm .c .cpp .cc .swift
        NSString *fileExtensionName = [[filePath pathExtension] lowercaseString];
        if (![self.fileExtensionNames containsObject:fileExtensionName]) {
            return;
        };
        
        
        // 读取文件内容
        NSError *error;
        NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
        }
        
        // 找到正文开始处
        NSUInteger blankLineLocation = [content rangeOfString:@"\n\n"].location;
        NSUInteger importLineLocation = [content rangeOfString:@"#"].location;
        NSUInteger declarelineLocation = [content rangeOfString:@"@"].location;
        NSUInteger minLocation = MIN(blankLineLocation, MIN(importLineLocation, declarelineLocation));
        
        // 获取文件名
        NSString *fileName = [filePath lastPathComponent];
        
        // 获取文件创建日期
        NSString *filePathURLString = [NSString stringWithFormat:@"file://%@", filePath];
        NSURL *filePathURL = [NSURL URLWithString:filePathURLString];
        NSDate *retrieveDate;
        [filePathURL getResourceValue:&retrieveDate forKey:NSURLCreationDateKey error:&error];
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
        }
        
        // 格式化日期显示
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *fileCreationDateString = [dateFormatter stringFromDate:retrieveDate];
        
        // 替换许可声明文本
        NSString *licesneContent = [NSString stringWithFormat:[NSString stringWithFormat:@"%@", MITLicense],
                                    fileName, projectName, creater, fileCreationDateString, organizationName];
        NSString *newContent = [content stringByReplacingCharactersInRange:NSMakeRange(0, minLocation) withString:licesneContent];
        
        NSData *newContentData = [newContent dataUsingEncoding:NSUTF8StringEncoding];
        
        // 写入新文本
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
        // 清空数据
        [fileHandle truncateFileAtOffset:0];
        // 重新写入数据
        [fileHandle writeData:newContentData];
        // 同步数据
        [fileHandle synchronizeFile];
        
        NSString *doneMission = [NSString stringWithFormat:@"file: %@: licensed done!", filePath];
        NSLog(@"%@", doneMission);
    }
}

@end


#pragma mark - MITLicense

NSString *const MITLicense =
@"//\n"
"//  %@\n"
"//  %@\n"
"//\n"
"//  Created by %@ on %@.\n"
"//  Copyright (c) 2014 %@.\n"
"//\n"
"//  Permission is hereby granted, free of charge, to any person obtaining a copy\n"
"//  of this software and associated documentation files (the \"Software\"), to deal\n"
"//  in the Software without restriction, including without limitation the rights\n"
"//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell\n"
"//  copies of the Software, and to permit persons to whom the Software is\n"
"//  furnished to do so, subject to the following conditions:\n"
"//\n"
"//  The above copyright notice and this permission notice shall be included in\n"
"//  all copies or substantial portions of the Software.\n"
"//\n"
"//  THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\n"
"//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\n"
"//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\n"
"//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\n"
"//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\n"
"//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN\n"
"//  THE SOFTWARE.\n"
"//";
