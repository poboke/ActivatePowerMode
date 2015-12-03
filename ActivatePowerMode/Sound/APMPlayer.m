//
//  APMPlayer.m
//  ActivatePowerMode
//
//  Created by hewigovens on 12/3/15.
//  Copyright © 2015 Jobs. All rights reserved.
//

#import "APMPlayer.h"

@interface APMPlayer()

@property (nonatomic, strong) NSSound *sound;

@end


@implementation APMPlayer

+ (instancetype)defaultPlayer
{
    static APMPlayer *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [APMPlayer new];
        NSString *customAudioPath = [@"~/.powermode.aiff" stringByExpandingTildeInPath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:customAudioPath]) {
            _instance.sound = [[NSSound alloc] initWithContentsOfFile:customAudioPath byReference:YES];
        } else {
            NSString *selfPath = @"~/Library/Application Support/Developer/Shared/Xcode/Plug-ins/ActivatePowerMode.xcplugin";
            NSBundle *selfBundle = [NSBundle bundleWithPath:[selfPath stringByExpandingTildeInPath]];
            _instance.sound = [[NSSound alloc] initWithContentsOfFile:[selfBundle pathForResource:@"sound" ofType:@"aiff"] byReference:YES];
        }
    });
    
    return _instance;
}


- (void)playSound
{
    if (![ConfigManager sharedManager].isEnableSound) {
        return;
    }
    
    [self.sound play];
}


- (void)playSoundWithPath:(NSString *)path
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        self.sound = [[NSSound alloc] initWithContentsOfFile:path byReference:YES];
        [self playSound];
    }
}

@end
