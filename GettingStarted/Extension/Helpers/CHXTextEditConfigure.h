//
//  TextEditConfigure.h
//  GettingStarted
//
//  Created by Moch Xiao on 10/24/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CHXTextEditConfigure : NSObject

@property (nonatomic, weak) UILabel *countingLabel;
@property (nonatomic, assign) NSUInteger maximumLength;
// only text view use
@property (nonatomic, weak) UILabel *placeHolderLabel;

@end

@interface UITextView (TextConfigure)

/**
 *  设置文本编辑监控
 *
 *  @param textConfigure 编辑监控代理
 */
- (void)chx_setTextConfigure:(CHXTextEditConfigure *)textConfigure;

/**
 *  获取文本编辑监控代理
 *
 *  @return 文本编辑监控代理
 */
- (CHXTextEditConfigure *)chx_textConfigure;

@end

@interface UITextField (TextConfigure)

/**
 *  设置文本编辑监控
 *
 *  @param textConfigure 编辑监控代理
 */
- (void)chx_setTextConfigure:(CHXTextEditConfigure *)textConfigure;

/**
 *  获取文本编辑监控代理
 *
 *  @return 文本编辑监控代理
 */
- (CHXTextEditConfigure *)chx_textConfigure;

@end
