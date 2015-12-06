//
//  ConfigManager.h
//  ActivatePowerMode
//
//  Created by Jobs on 15/12/3.
//  Copyright © 2015年 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigManager : NSObject

@property (nonatomic, assign, getter=isEnablePlugin) BOOL enablePlugin;
@property (nonatomic, assign, getter=isEnableSpark) BOOL enableSpark;
@property (nonatomic, assign, getter=isEnableShake) BOOL enableShake;
@property (nonatomic, assign, getter=isEnableSound) BOOL enableSound;

+ (instancetype)sharedManager;

@end
