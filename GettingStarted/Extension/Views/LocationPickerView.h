//
//  LocationPickerView.h
//  GettingStarted
//
//  Created by Moch on 10/29/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 地区选择器

// This class will needed `~/Resource/ProvincesAndCitiesAndAreas.h`
@class LocationPickerView;

@protocol CHLocationPickerDelegate <NSObject>

@optional
- (void)locationPickerViewWillAppear:(LocationPickerView *)locationPickerView;
- (void)locationPickerViewDidAppear:(LocationPickerView *)locationPickerView;
- (void)locationPickerViewWillDisAppear:(LocationPickerView *)locationPickerView;
- (void)locationPickerViewDidDisAppear:(LocationPickerView *)locationPickerView;

- (void)locationPickerView:(LocationPickerView *)locationPickerView didSelectItem:(NSString *)item;

@end

typedef NS_ENUM(NSInteger, CHLocationPickerType) {
    CHLocationPickerTypeProvinces = 1,
    CHLocationPickerTypeCites = 2,
    CHLocationPickerTypeAreas = 3
};

@interface LocationPickerView : UIView

@property (nonatomic, assign) id <CHLocationPickerDelegate> delegate;
@property (nonatomic, assign) CHLocationPickerType locationPickerType;
@property (nonatomic, copy) void (^didSelectItem)(NSString *item);

/**
 *  初始化地区选择器
 *
 *  @param locationPickerType 选择器类型，可选 [省份，省份和城市，省份和城市和区域]
 *  @param didSelectItem      选中回掉
 *
 *  @return 地区选择器
 */
- (instancetype)initWithLocationPickerType:(CHLocationPickerType)locationPickerType
                              selectedItem:(void (^)(NSString *item))didSelectItem;

/**
 *  弹出选择器
 *
 *  @param view 选择器父视图
 */
- (void)showInView:(UIView *)view;

@end


