//
//  SparkAction.m
//  ActivatePowerMode
//
//  Created by Jobs on 15/12/2.
//  Copyright © 2015年 Jobs. All rights reserved.
//

#import "SparkAction.h"
#import "ParticleView.h"

NSInteger const MaxParticleCount = 100;

@interface SparkAction ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableDictionary *particleDictionary;
@property (nonatomic, assign) NSInteger particleIndex;

@end


@implementation SparkAction

@synthesize enableAction = _enableAction;

+ (instancetype)sharedAction
{
    static SparkAction *_sharedAction;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedAction = [[self alloc] init];
    });
    
    return _sharedAction;
}


- (instancetype)init
{
    if (self = [super init]) {
        
        _particleIndex = 0;
        _particleDictionary = [NSMutableDictionary dictionary];
    }
    
    return self;
}


- (void)sparkAtPosition:(CGPoint)position withColor:(NSColor *)color inView:(NSView *)view
{
    if (![ConfigManager sharedManager].isEnableSpark) {
        return;
    }
    
    NSInteger number = 5 + RandomRange(0, 5);
    
    for (NSInteger i = 0; i < number; i++) {
        ParticleView *particle = [[ParticleView alloc] initWithPosition:position color:color];
        [view addSubview:particle];
        
        self.particleIndex = (self.particleIndex + 1) % MaxParticleCount;
        [self.particleDictionary[@(self.particleIndex)] removeFromSuperview];
        self.particleDictionary[@(self.particleIndex)] = particle;
    }
}


- (void)update
{
    [self.particleDictionary enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, ParticleView *particle, BOOL *stop) {
    
        if (particle.alpha <= 0.1) {
            [particle removeFromSuperview];
            [self.particleDictionary removeObjectForKey:key];
            return;
        }
        
        particle.alpha *= 0.91;
    
        particle.velocity = (Velocity){
            particle.velocity.x,
            particle.velocity.y + 0.175
        };
        
        particle.position = (CGPoint){
            particle.position.x + particle.velocity.x,
            particle.position.y + particle.velocity.y
        };
    }];
}


- (void)setEnableAction:(BOOL)enableAction
{
    _enableAction = enableAction;
    
    if (_enableAction) {
        [self.timer invalidate];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.025 target:self selector:@selector(update) userInfo:nil repeats:YES];
    } else {
        [self.timer invalidate];
    }
}

@end
