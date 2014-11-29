//
//  LocationPickerView.m
//  GettingStarted
//
//  Created by Moch on 10/29/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "VLocationPickerView.h"
#import "VGlobalServices.h"

#pragma mark - 地区选择器

@interface VLocationPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;

// datas
@property (nonatomic, strong) NSArray *provinces;
@property (nonatomic, strong) NSArray *cites;
@property (nonatomic, strong) NSArray *areas;

@end

@implementation VLocationPickerView

- (instancetype)init {
    return [self initWithLocationPickerType:CHLocationPickerTypeProvinces selectedItem:self.didSelectItem];
}

- (instancetype)initWithLocationPickerType:(CHLocationPickerType)locationPickerType
                              selectedItem:(void (^)(NSString *item))didSelectItem {
    self = [super init];
    if (self) {
        self.locationPickerType = locationPickerType;
        self.didSelectItem = didSelectItem;
        self.backgroundColor = [UIColor clearColor];
        [self initialPickerView];
        [self provinces];
    }
    return self;
}

- (NSArray *)provinces {
    if (!_provinces) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ProvincesAndCitiesAndAreas" ofType:@"plist"];
        _provinces = [NSArray arrayWithContentsOfFile:plistPath];
        _cites = _provinces[0][@"cities"] ? : nil;
        _areas = _cites[0][@"areas"] ? : nil;
    }
    
    return _provinces;
}

- (void)initialPickerView {
    if (!_pickerView) {
        _pickerView = [UIPickerView new];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.frame = CGRectMake(0, v_screenWidth() - 216, 0, 0);
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        [self addSubview:_pickerView];
    }
}

- (void)showInView:(UIView *)view {
    [view endEditing:YES];
    [view addSubview:self];
    [self appear];
}

- (void)appear {
    self.frame = CGRectOffset(v_screenBounds(), 0, v_screenHeight());
    if ([_delegate respondsToSelector:@selector(locationPickerViewWillAppear:)]) {
        [_delegate locationPickerViewWillAppear:self];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformTranslate(self.transform, 0, -v_screenHeight());
    } completion:^(BOOL finished) {
        if ([_delegate respondsToSelector:@selector(locationPickerViewDidAppear:)]) {
            [_delegate locationPickerViewDidAppear:self];
        }
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self disAppear];
}

- (void)disAppear {
    if ([_delegate respondsToSelector:@selector(locationPickerViewWillDisAppear:)]) {
        [_delegate locationPickerViewWillDisAppear:self];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if ([_delegate respondsToSelector:@selector(locationPickerViewDidDisAppear:)]) {
            [_delegate locationPickerViewDidDisAppear:self];
        }
    }];
}


// data source
// 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.locationPickerType;
}

// 每一列行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger numberOfRowsInComponent = 0;
    switch (component) {
        case 0:
            numberOfRowsInComponent = _provinces.count;
            break;
        case 1:
            numberOfRowsInComponent = _cites.count;
            break;
        case 2:
            numberOfRowsInComponent = _areas.count;
            break;
        default:
            break;
    }
    
    return numberOfRowsInComponent;
}

- (void)callbackWithItem:(NSString *)item {
    if ([_delegate respondsToSelector:@selector(locationPickerView:didSelectItem:)] &&
        [item isKindOfClass:[NSString class]]) {
        [_delegate locationPickerView:self didSelectItem:item];
    }
    if (_didSelectItem) {
        _didSelectItem(item);
    }
}

// delegate will call messages
- (NSString *)callbackItemWithFirstComponetDidSelectedRow:(NSInteger)row {
    NSString *callbackitem = nil;
    switch (self.locationPickerType) {
        case CHLocationPickerTypeProvinces:
            // 只选择省份
            callbackitem = _provinces[row][@"state"];
            break;
        case CHLocationPickerTypeCites:
            // 选择省份、市区
            // 根据第一个分组省份数据更新第二个分组市区数据
            _cites = _provinces[row][@"cities"];
            [_pickerView reloadComponent:1];
            [_pickerView selectRow:0 inComponent:1 animated:YES];
            
            // 未拖动第二个分组，返回第二个分组第一元素
            callbackitem = [NSString stringWithFormat:@"%@%@",
                            _provinces[row][@"state"], _cites[0][@"city"]];
            break;
        case CHLocationPickerTypeAreas:
            // 选择省份、市区、县区
            // 根据第一个分组省份数据更新第二个分组市区数据
            _cites = _provinces[row][@"cities"];
            [_pickerView reloadComponent:1];
            [_pickerView selectRow:0 inComponent:1 animated:YES];
            
            // 根据第二个分组第一个市区数据更新第三个分组县区数据
            _areas = _cites[0][@"areas"];
            [_pickerView reloadComponent:2];
            [_pickerView selectRow:0 inComponent:2 animated:YES];
            callbackitem = [NSString stringWithFormat:@"%@%@%@",
                            _provinces[row][@"state"],
                            _cites[0][@"city"],
                            _areas.count ? _areas[0] : @""];
            break;
        default:
            break;
    }
    return callbackitem;
}

- (NSString *)callbackItemWithSecondComponetDidSelectedRow:(NSInteger)row {
    NSString *callbackitem = nil;
    switch (self.locationPickerType) {
        case CHLocationPickerTypeCites:
            callbackitem = [NSString stringWithFormat:@"%@%@",
                            _provinces[[_pickerView selectedRowInComponent:0]][@"state"],
                            _cites[row][@"city"]];
            break;
        case CHLocationPickerTypeAreas:
            // 根据第二个分组市区数据更新第三个分组县区数据
            _areas = _cites[row][@"areas"];
            [_pickerView reloadComponent:2];
            [_pickerView selectRow:0 inComponent:2 animated:YES];
            callbackitem = [NSString stringWithFormat:@"%@%@%@",
                            _provinces[[_pickerView selectedRowInComponent:0]][@"state"],
                            _cites[row][@"city"],
                            _areas.count ? _areas[0] : @""];
            
            break;
        default:
            break;
    }
    return callbackitem;
}

- (NSString *)callbackItemWithThirdComponetDidSelectedRow:(NSInteger)row {
    return [NSString stringWithFormat:@"%@%@%@",
            _provinces[[_pickerView selectedRowInComponent:0]][@"state"],
            _cites[[_pickerView selectedRowInComponent:1]][@"city"],
            _areas.count ? _areas[row] : @""];
}

#pragma mark - delegate

// 每一列的每一行的title
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *titleForComponent = nil;
    switch (component) {
        case 0:
            if ([_provinces[row] isKindOfClass:[NSString class]]) {
                // 如过只有一个分组，直接返回分组数组下的字符串元素
                titleForComponent = _provinces[row];
            } else if ([_provinces[row] isKindOfClass:[NSDictionary class]]) {
                // 如果有两个分组，返回分组元素字典下的某个value值
                titleForComponent = _provinces[row][@"state"];
            }
            break;
        case 1:
            // 如果有2个分组，返回第1个分组字典元素对应的某个value值
            titleForComponent = _cites[row][@"city"];
            break;
        case 2:
            // 如果有3个分组，返回第2个分组字典元素对应的某个value值
            titleForComponent = _areas[row];
        default:
            break;
    }
    return titleForComponent;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *callbackitem = nil;
    switch (component) {
            // 第一个分组拖动完成
        case 0:
            callbackitem = [self callbackItemWithFirstComponetDidSelectedRow:row];
            break;
        case 1:
            // 第二分组拖动完成
            callbackitem = [self callbackItemWithSecondComponetDidSelectedRow:row];
            break;
        case 2: {
            // 第三个分组拖动完成
            callbackitem = [self callbackItemWithThirdComponetDidSelectedRow:row];
        }
            break;
        default:
            break;
    }
    [self callbackWithItem:callbackitem];
}

/*
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
            // 第一个分组拖动完成
        case 0: {
            if (CHLocationPickerTypeProvinces == self.locationPickerType) {
                // 只选择省份
                [self callbackWithItem:_provinces[row][@"state"]];
            } else if (CHLocationPickerTypeCites == self.locationPickerType) {
                // 选择省份、市区
                // 根据第一个分组省份数据更新第二个分组市区数据
                _cites = _provinces[row][@"cities"];
                [pickerView reloadComponent:1];
                [pickerView selectRow:0 inComponent:1 animated:YES];
                
                // 未拖动第二个分组，返回第二个分组第一元素
                NSString *item = [NSString stringWithFormat:@"%@%@", _provinces[row][@"state"], _cites[component][@"city"]];
                [self callbackWithItem:item];
            } else if (CHLocationPickerTypeAreas == self.locationPickerType) {
                // 选择省份、市区、县区
                // 根据第一个分组省份数据更新第二个分组市区数据
                _cites = _provinces[row][@"cities"];
                [pickerView reloadComponent:1];
                [pickerView selectRow:0 inComponent:1 animated:YES];
                
                // 根据第二个分组第一个市区数据更新第三个分组县区数据
                _areas = _cites[0][@"areas"];
                [pickerView reloadComponent:2];
                [pickerView selectRow:0 inComponent:2 animated:YES];
                NSString *item = [NSString stringWithFormat:@"%@%@%@", _provinces[row][@"state"], _cites[component][@"city"], _areas.count ? _areas[0] : @""];
                [self callbackWithItem:item];
            }
        }
            break;
        case 1: {
            // 第二分组拖动完成
            NSString *item = nil;
            if (CHLocationPickerTypeCites == self.locationPickerType) {
                item = [NSString stringWithFormat:@"%@%@", _provinces[[pickerView selectedRowInComponent:0]][@"state"], _cites[row][@"city"]];
            } else if (CHLocationPickerTypeAreas == self.locationPickerType) {
                // 根据第二个分组市区数据更新第三个分组县区数据
                _areas = _cites[row][@"areas"];
                [pickerView reloadComponent:2];
                [pickerView selectRow:0 inComponent:2 animated:YES];
                item = [NSString stringWithFormat:@"%@%@%@", _provinces[[pickerView selectedRowInComponent:0]][@"state"], _cites[row][@"city"], _areas.count ? _areas[0] : @""];
            }
            [self callbackWithItem:item];
        }
            break;
        case 2: {
            // 第三个分组拖动完成
            NSString *item = [NSString stringWithFormat:@"%@%@%@", _provinces[[pickerView selectedRowInComponent:0]][@"state"],_cites[[_pickerView selectedRowInComponent:1]][@"city"], _areas.count ? _areas[row] : @""];
            [self callbackWithItem:item];
        }
            break;
        default:
            break;
    }
}

*/

@end
