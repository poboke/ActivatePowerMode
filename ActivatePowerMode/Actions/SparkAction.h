//
//  SparkAction.h
//  ActivatePowerMode
//
//  Created by Jobs on 15/12/2.
//  Copyright © 2015年 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SparkAction : NSObject

@property (nonatomic, assign, getter=isEnableAction) BOOL enableAction;

+ (instancetype)sharedAction;
- (void)sparkAtPosition:(CGPoint)position withColor:(NSColor *)color inView:(NSView *)view;

@end
