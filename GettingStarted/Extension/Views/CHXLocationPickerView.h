//
//  CHXLocationPickerView.h
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

#import <UIKit/UIKit.h>

#pragma mark - 地区选择器

// This class will needed `~/Resource/ProvincesAndCitiesAndAreas.h`
@class CHXLocationPickerView;

@protocol CHXLocationPickerDelegate <NSObject>

@optional
- (void)locationPickerViewWillAppear:(CHXLocationPickerView *)locationPickerView;
- (void)locationPickerViewDidAppear:(CHXLocationPickerView *)locationPickerView;
- (void)locationPickerViewWillDisAppear:(CHXLocationPickerView *)locationPickerView;
- (void)locationPickerViewDidDisAppear:(CHXLocationPickerView *)locationPickerView;

- (void)locationPickerView:(CHXLocationPickerView *)locationPickerView didSelectItem:(NSString *)item;

@end

typedef NS_ENUM(NSInteger, CHXLocationPickerType) {
    CHXLocationPickerTypeProvinces = 1,
    CHXLocationPickerTypeCites = 2,
    CHXLocationPickerTypeAreas = 3
};

@interface CHXLocationPickerView : UIView

@property (nonatomic, assign) id<CHXLocationPickerDelegate> delegate;
@property (nonatomic, assign) CHXLocationPickerType locationPickerType;
@property (nonatomic, copy) void (^didSelectItem)(NSString *item);

/**
 *  初始化地区选择器
 *
 *  @param locationPickerType 选择器类型，可选 [省份，省份和城市，省份和城市和区域]
 *  @param didSelectItem      选中回掉
 *
 *  @return 地区选择器
 */
- (instancetype)initWithLocationPickerType:(CHXLocationPickerType)locationPickerType
                              selectedItem:(void (^)(NSString *item))didSelectItem;

/**
 *  弹出选择器
 *
 *  @param view 选择器父视图
 */
- (void)showInView:(UIView *)view;

@end


