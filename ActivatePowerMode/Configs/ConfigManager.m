//
//  ConfigManager.m
//  ActivatePowerMode
//
//  Created by Jobs on 15/12/3.
//  Copyright © 2015年 Jobs. All rights reserved.
//

#import "ConfigManager.h"

static NSString * const ActivatePowerModePluginConfigKeyEnablePlugin = @"ActivatePowerModePluginConfigKeyEnablePlugin";
static NSString * const ActivatePowerModePluginConfigKeyEnableSpark = @"ActivatePowerModePluginConfigKeyEnableSpark";
static NSString * const ActivatePowerModePluginConfigKeyEnableShake = @"ActivatePowerModePluginConfigKeyEnableShake";
static NSString * const ActivatePowerModePluginConfigKeyEnableSound = @"ActivatePowerModePluginConfigKeyEnableSound";


@implementation ConfigManager

@synthesize enablePlugin = _enablePlugin;
@synthesize enableSpark  = _enableSpark;
@synthesize enableShake  = _enableShake;
@synthesize enableSound  = _enableSound;

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
    if (!_enablePlugin) {

        NSNumber *value = [[NSUserDefaults standardUserDefaults] objectForKey:ActivatePowerModePluginConfigKeyEnablePlugin];
        
        if (!value) {
            // First time runing
            self.enablePlugin = YES;
            self.enableSpark  = YES;
            self.enableShake  = YES;
            self.enableSound  = YES;
            _enablePlugin = YES;
        } else {
            _enablePlugin = [value boolValue];
        }
    }
    
    return _enablePlugin;
}


- (void)setEnablePlugin:(BOOL)enablePlugin
{
    _enablePlugin = enablePlugin;
    [self setBoolValue:enablePlugin forKey:ActivatePowerModePluginConfigKeyEnablePlugin];
}


- (BOOL)isEnableSpark
{
    if (!_enableSpark) {
        _enableSpark = [self boolValueForKey:ActivatePowerModePluginConfigKeyEnableSpark];
    }
    
    return _enableSpark;
}


- (void)setEnableSpark:(BOOL)enableSpark
{
    _enableSpark = enableSpark;
    [self setBoolValue:enableSpark forKey:ActivatePowerModePluginConfigKeyEnableSpark];
}


- (BOOL)isEnableShake
{
    if (!_enableShake) {
        _enableShake = [self boolValueForKey:ActivatePowerModePluginConfigKeyEnableShake];
    }
    
    return _enableShake;
}


- (void)setEnableShake:(BOOL)enableShake
{
    _enableShake = enableShake;
    [self setBoolValue:enableShake forKey:ActivatePowerModePluginConfigKeyEnableShake];
}


- (BOOL)isEnableSound
{
    if (!_enableSound) {
        _enableSound = [self boolValueForKey:ActivatePowerModePluginConfigKeyEnableSound];
    }
    
    return _enableSound;
}


- (void)setEnableSound:(BOOL)enableSound
{
    _enableSound = enableSound;
    [self setBoolValue:enableSound forKey:ActivatePowerModePluginConfigKeyEnableSound];
}

@end
