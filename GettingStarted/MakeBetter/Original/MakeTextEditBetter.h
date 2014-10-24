//
//  MakeTextEditBetter.h
//  GettingStarted
//
//  Created by Moch on 10/24/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MakeTextEditBetter : NSObject

@property (nonatomic, weak) UILabel *countingLabel;
@property (nonatomic, assign) NSUInteger maximumLength;
// only text view use
@property (nonatomic, weak) UILabel *placeHolderLabel;

@end

@interface UITextView (TextConfigure)
@property (nonatomic, strong) MakeTextEditBetter *textConfigure;
@end

@interface UITextField (TextConfigure)
@property (nonatomic, strong) MakeTextEditBetter *textConfigure;

@end
