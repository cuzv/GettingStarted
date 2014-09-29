//
//  UIView+Animation.h
//  GettingStarted
//
//  Created by Moch on 8/24/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Toast.h"

typedef NS_ENUM(NSInteger, CHAnimationOrientation) {
    CHToastAppearOrientationHorizontal,
    CHAnimationOrientationVertical
};

@interface UIView (Animation)

- (void)shake;
- (void)shakeWithOrientation:(CHAnimationOrientation)orientation;
- (void)shakeForToastAppearOrientation:(CHToastAppearOrientation)orientation;

- (void)addLoadingAnimation;
- (void)addLoadingAnimationWitchColor:(UIColor *)color;
- (void)removeLoadingAnimation;

+ (CABasicAnimation *)rotationFromValue:(NSValue *)fromValue toValue:(NSValue *)toValue;
@end
