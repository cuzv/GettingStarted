//
//  LocationPickerView.h
//  GettingStarted
//
//  Created by Moch Xiao on 10/29/14.
//  Copyright (c) 2014 Foobar. All rights reserved.
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


