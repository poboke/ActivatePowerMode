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
    
    // 这里最小摇动参数为1, 最大为3. 效果更好 (free well than ever!)
    //TODO: 增加参数输入, 在界面上设置为可变摇动参数(Add this intensity value on GUI for min and max.)
    CGFloat intensity = 1 + arc4random_uniform(3);
    CGFloat x = intensity * ((arc4random_uniform(2) == 0) ? -1 : 1);
    CGFloat y = intensity * ((arc4random_uniform(2) == 0) ? -1 : 1);
    
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
