//
//  ConfigManager.m
//  ActivatePowerMode
//
//  Created by Jobs on 15/12/3.
//  Copyright © 2015年 Jobs. All rights reserved.
//

#import "ConfigManager.h"

static NSString * const ActivatePowerModePluginConfigKeyEnablePlugin = @"ActivatePowerModePluginConfigKeyEnablePlugin";
static NSString * const ActivatePowerModePluginConfigKeyEnableShake = @"ActivatePowerModePluginConfigKeyEnableShake";
static NSString * const ActivatePowerModePluginConfigKeyEnableSound = @"ActivatePowerModePluginConfigKeyEnableSound";

@implementation ConfigManager

+ (instancetype)sharedManager
{
    static ConfigManager *_sharedManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}


#pragma mark - Syntax sugar

- (BOOL)boolValueForKey:(NSString *)aKey
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:aKey] boolValue];
}


- (void)setBoolValue:(BOOL)boolValue forKey:(NSString *)aKey
{
    [[NSUserDefaults standardUserDefaults] setObject:@(boolValue) forKey:aKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - Property

- (BOOL)isEnablePlugin
{
    NSNumber *value = [[NSUserDefaults standardUserDefaults] objectForKey:ActivatePowerModePluginConfigKeyEnablePlugin];
    
    if (!value) {
        self.enablePlugin = YES;
        self.enableShake  = YES;
        self.enableSound  = YES;
        return YES;
    }
    
    return [value boolValue];
}


- (void)setEnablePlugin:(BOOL)enablePlugin
{
    [self setBoolValue:enablePlugin forKey:ActivatePowerModePluginConfigKeyEnablePlugin];
}


- (BOOL)isEnableShake
{
    return [self boolValueForKey:ActivatePowerModePluginConfigKeyEnableShake];
}


- (void)setEnableShake:(BOOL)enableShake
{
    [self setBoolValue:enableShake forKey:ActivatePowerModePluginConfigKeyEnableShake];
}


- (BOOL)isEnableSound
{
    return [self boolValueForKey:ActivatePowerModePluginConfigKeyEnableSound];
}


- (void)setEnableSound:(BOOL)enableSound
{
    [self setBoolValue:enableSound forKey:ActivatePowerModePluginConfigKeyEnableSound];
}

@end
