//
//  LocationPicker.h
//  GettingStarted
//
//  Created by Moch on 8/21/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>

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

- (instancetype)initWithLocationPickerType:(CHLocationPickerType)locationPickerType selectedItem:(void (^)(NSString *item))didSelectItem;

// Call this method, cant not support orientation autolayout. use `showInView:`
- (void)present;

- (void)showInView:(UIView *)view;

@end
