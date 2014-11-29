//
//  UITextFieldExtension.m
//  GettingStarted
//
//  Created by Moch on 10/29/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "UITextFieldExtension.h"
#import "UIViewExtension.h"

@implementation UITextFieldExtension

@end


#pragma mark - 快速创建文本域

@implementation UITextField (VGenerate)

+ (instancetype)v_textFieldWithFrame:(CGRect)frame
					   textAlignment:(NSTextAlignment)alignment
								font:(UIFont *)font
				  displayBorderLayer:(BOOL)display {
    UITextField *textField = [[self alloc] initWithFrame:frame];
    textField.backgroundColor = [UIColor whiteColor];
    textField.textAlignment = alignment ? : NSTextAlignmentLeft;
    textField.font = font ? : [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    textField.userInteractionEnabled = YES;
    textField.clearButtonMode = UITextFieldViewModeNever;
    textField.clearsOnBeginEditing = YES;
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.rightViewMode = UITextFieldViewModeAlways;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
    textField.leftView = view;
    textField.rightView = view;
    
    if (display) {
        [textField v_setCornerRadius:5];
        [textField v_setBorderWidth:0.5 color:[UIColor lightGrayColor]];
    }
    
    textField.autocorrectionType = UITextAutocorrectionTypeDefault;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;

    return textField;
}

+ (instancetype)v_textFieldWithSize:(CGSize)size
							 center:(CGPoint)center
					  textAlignment:(NSTextAlignment)alignment
							   font:(UIFont *)font
				 displayBorderLayer:(BOOL)display {
    CGRect frame = CGRectMake(center.x - size.width / 2,
                              center.y - size.height / 2,
                              size.width,
                              size.height);
    return [self v_textFieldWithFrame:frame textAlignment:alignment font:font displayBorderLayer:display];
}

@end
