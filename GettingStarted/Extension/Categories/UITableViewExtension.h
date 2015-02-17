//
//  UITableViewExtension.h
//  GettingStarted
//
//  Created by Moch Xiao on 2014-11-18.
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITableViewExtension : NSObject

@end

#pragma mark - 快速创建表视图

@interface UITableView (CHXGenerate)

/**
 *  快速生成表视图
 *
 *  @param frame      位置
 *  @param style      样式
 *  @param dataSource 数据源
 *  @param delegate   委托
 *
 *  @return 表视图
 */
+ (instancetype)chx_tableViewWithFrame:(CGRect)frame
                                 style:(UITableViewStyle)style
                             dataSouce:(id<UITableViewDataSource>)dataSource
                              delegate:(id<UITableViewDelegate>) delegate;


/**
 *  快速生成表视图
 *
 *  @param size       大小
 *  @param center     中心点
 *  @param style      样式
 *  @param dataSource 数据源
 *  @param delegate   委托
 *
 *  @return 表视图
 */
+ (instancetype)chx_tableViewWithSize:(CGSize)size
                               center:(CGPoint)center
                                style:(UITableViewStyle)style
                            dataSouce:(id<UITableViewDataSource>)dataSource
                             delegate:(id<UITableViewDelegate>) delegate;
@end
