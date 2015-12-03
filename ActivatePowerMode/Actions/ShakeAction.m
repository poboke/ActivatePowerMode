//
//  ShakeAction.m
//  ActivatePowerMode
//
//  Created by Jobs on 15/12/2.
//  Copyright © 2015年 Jobs. All rights reserved.
//

#import "ShakeAction.h"

@implementation ShakeAction

+ (void)shakeView:(NSView *)view
{
    if (![ConfigManager sharedManager].isEnableShake) {
        return;
    }
    
    CGFloat intensity = arc4random() % 3 + 1;
    CGFloat x = intensity * ((arc4random() % 2 == 0) ? -1 : 1);
    CGFloat y = intensity * ((arc4random() % 2 == 0) ? -1 : 1);
    [self moveView:view toPoint:CGPointMake(x, y)];
    
    CGFloat shakeDurationTime = 0.00618;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(shakeDurationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self moveView:view toPoint:CGPointMake(0, 0)];
    });
}


+ (void)moveView:(NSView *)view toPoint:(CGPoint)point
{
    CGSize size = view.frame.size;
    view.frame = (CGRect){point, size};
}

@end
