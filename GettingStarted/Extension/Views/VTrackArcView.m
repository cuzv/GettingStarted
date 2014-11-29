//
//  TrackArcView.m
//  GettingStarted
//
//  Created by Moch on 10/29/14.
//  Copyright (c) 2014 Moch. All rights reserved.
//

#import "VTrackArcView.h"

#pragma mark - 录音音轨波形图

#define kSilenceVolume 45.0f
#define kSoundMeterCount 6
#define kMaxRecordDuration HUGE_VAL
#define kWaveUpdateFrequency 0.1f

@interface VTrackArcView () {
    int soundMeters[kSoundMeterCount];
}

@property (nonatomic, strong) UIColor *stokeColor;
@property(nonatomic, assign) NSTimeInterval recordTime;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation VTrackArcView

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) {
        [self stopAnimation];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
                   stokeColor:(UIColor *)aColor
                       record:(AVAudioRecorder *)aRecorder {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    self.stokeColor = aColor;
    self.recorder = aRecorder;
    [self initialize];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }
    
    [self initialize];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    [self initialize];
    
    return self;
}

- (void)initialize {
    for(int i = 0; i < kSoundMeterCount; i++) {
        soundMeters[i] = kSilenceVolume;
    }
    self.backgroundColor = [UIColor clearColor];
    if (!self.stokeColor) {
        self.stokeColor = [UIColor lightGrayColor];
    }
}

- (void)updateMeters {
    [self.recorder updateMeters];
    if (self.recordTime > kMaxRecordDuration) {
        return;
    }
    self.recordTime += kWaveUpdateFrequency;
    if ([self.recorder averagePowerForChannel:0] < -kSilenceVolume) {
        [self addSoundMeterItem:kSilenceVolume];
        return;
    }
    [self addSoundMeterItem:[self.recorder averagePowerForChannel:0]];
    NSLog(@"volume:%f",[self.recorder averagePowerForChannel:0]);
}

- (void)addSoundMeterItem:(int)lastValue{
    for(int i = 0; i < kSoundMeterCount - 1; i++) {
        soundMeters[i] = soundMeters[i + 1];
    }
    soundMeters[kSoundMeterCount - 1] = lastValue;
    
    [self setNeedsDisplay];
}

#pragma mark - Drawing operations

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    int baseLine = CGRectGetHeight(self.bounds) / 2;
    static int multiplier = 1;
    int maxLengthOfWave = 45;
    int maxValueOfMeter = 400;
    int yHeights[6];
    float segement[6] = {0.05, 0.2, 0.35, 0.25, 0.1, 0.05};
    
    [self.stokeColor set];
    CGContextSetLineWidth(context, 2.0);
    
    for (int x = kSoundMeterCount - 1; x >= 0; x--) {
        int multiplier_i = ((int)x % 2) == 0 ? 1 : -1;
        CGFloat y = ((maxValueOfMeter * (maxLengthOfWave - abs(soundMeters[(int)x]))) / maxLengthOfWave);
        yHeights[kSoundMeterCount - 1 - x] = multiplier_i * y * segement[kSoundMeterCount - 1 - x]  * multiplier+ baseLine;
    }
    [self drawLinesWithContext:context BaseLine:baseLine HeightArray:yHeights lineWidth:1.0 alpha:0.8 percent:1.00 segementArray:segement];
    [self drawLinesWithContext:context BaseLine:baseLine HeightArray:yHeights lineWidth:0.5 alpha:0.4 percent:0.66 segementArray:segement];
    [self drawLinesWithContext:context BaseLine:baseLine HeightArray:yHeights lineWidth:0.5 alpha:0.2 percent:0.33 segementArray:segement];
    multiplier = -multiplier;
}

- (void)drawLinesWithContext:(CGContextRef)context
                    BaseLine:(float)baseLine
                 HeightArray:(int*)yHeights
                   lineWidth:(CGFloat)width
                       alpha:(CGFloat)alpha
                     percent:(CGFloat)percent
               segementArray:(float *)segement {
    CGFloat start = 0;
    NSLog(@"%@", self.stokeColor);
    [self.stokeColor set];
    CGContextSetLineWidth(context, width);
    for (int i = 0; i < 6; i++) {
        if (i % 2 == 0) {
            CGContextMoveToPoint(context, start, baseLine);
            CGFloat width = CGRectGetWidth(self.bounds);
            CGContextAddCurveToPoint(context,
                                     width *segement[i] / 2 + start,
                                     (yHeights[i] - baseLine)*percent + baseLine,
                                     width * segement[i] + width * segement[i + 1] / 2 + start,
                                     (yHeights[i + 1] - baseLine) * percent + baseLine,
                                     width *segement[i] + width * segement[i + 1] + start,
                                     baseLine);
            start += width * segement[i] + width *segement[i + 1];
        }
    }
    CGContextStrokePath(context);
}

#pragma mark - public

- (void)startAnimation {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kWaveUpdateFrequency
                                                  target:self
                                                selector:@selector(updateMeters)
                                                userInfo:nil
                                                 repeats:YES];
    self.timer.fireDate = [NSDate date];
    [self.timer fire];
}

- (void)stopAnimation {
    for (int i = 0; i < kSoundMeterCount; i++) {
        soundMeters[i] = kSilenceVolume;
    }
    [self.timer invalidate];
    self.timer = nil;
    self.recordTime = 0;
    [self setNeedsDisplay];
}

@end
