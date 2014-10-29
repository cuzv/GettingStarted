//
//  TrackArcView.h
//  GettingStarted
//
//  Created by Moch on 10/29/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#pragma mark - 录音音轨波形图

@interface TrackArcView : UIView

@property(nonatomic, weak) AVAudioRecorder *recorder;
@property(nonatomic, assign, readonly) NSTimeInterval recordTime;

/**
 *  初始化音轨视图
 *
 *  @param frame     位置
 *  @param aColor    音轨颜色
 *  @param aRecorder 录音器
 *
 *  @return 音轨视图实例
 */
- (instancetype)initWithFrame:(CGRect)frame stokeColor:(UIColor *)aColor record:(AVAudioRecorder *)aRecorder;

/**
 *  开始波动动画
 */
- (void)startAnimation;

/**
 *  结束波形动画
 */
- (void)stopAnimation;

@end
