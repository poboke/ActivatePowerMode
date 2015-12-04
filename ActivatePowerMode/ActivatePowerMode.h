//
//  ActivatePowerMode.h
//  ActivatePowerMode
//
//  Created by Jobs on 15/12/1.
//  Copyright © 2015年 Jobs. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface ActivatePowerMode : NSObject

@property (nonatomic, assign, getter=isEnablePlugin) BOOL enablePlugin;

+ (instancetype)sharedPlugin;

@end