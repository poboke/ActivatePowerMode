//
//  APMPlayer.h
//  ActivatePowerMode
//
//  Created by hewigovens on 12/3/15.
//  Copyright © 2015 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APMPlayer : NSObject
@property (nonatomic, assign) BOOL enable;
+(instancetype)defaultPlayer;
- (void)playSound;
- (void)playSoundWithPath:(NSString *)path;
@end
