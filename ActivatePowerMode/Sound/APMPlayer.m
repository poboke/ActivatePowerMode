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

+(instancetype)defaultPlayer {
    static dispatch_once_t onceToken;
    static APMPlayer *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [APMPlayer new];
        NSString *customAudioPath = [@"~/.powermode.aiff" stringByExpandingTildeInPath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:customAudioPath]) {
            instance.sound = [[NSSound alloc] initWithContentsOfFile:customAudioPath byReference:YES];
        } else {
            NSString *selfPath = @"~/Library/Application Support/Developer/Shared/Xcode/Plug-ins/ActivatePowerMode.xcplugin";
            NSBundle *selfBundle = [NSBundle bundleWithPath:[selfPath stringByExpandingTildeInPath]];
            instance.sound = [[NSSound alloc] initWithContentsOfFile:[selfBundle pathForResource:@"sound" ofType:@"aiff"] byReference:YES];
        }
    });
    return instance;
}

- (void)playSound
{
    [self.sound play];
}

- (void)playSoundWithPath:(NSString *)path
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        self.sound = [[NSSound alloc] initWithContentsOfFile:path byReference:YES];
        [self.sound play];
    }
}

@end
