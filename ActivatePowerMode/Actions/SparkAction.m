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
@property (nonatomic, strong) NSMutableArray *particles;
@property (nonatomic, assign) NSInteger particleIndex;

@end


@implementation SparkAction

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
        
        _particles = [NSMutableArray array];
        for (NSInteger i = 0; i < MaxParticleCount; i++) {
            ParticleView *particle = [[ParticleView alloc] init];
            particle.alpha = 0;
            [_particles addObject:particle];
        }
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.025 target:self selector:@selector(update) userInfo:nil repeats:YES];
    }
    
    return self;
}


- (void)sparkAtPosition:(CGPoint)position withColor:(NSColor *)color inView:(NSView *)view
{
    NSInteger number = 5 + RandomRange(0, 10);
    
    for (NSInteger i = 0; i < number; i++) {
        
        ParticleView *particle = [[ParticleView alloc] initWithPosition:position color:color];
        [view addSubview:particle];
        
        self.particleIndex = (self.particleIndex + 1) % MaxParticleCount;
        [self.particles[self.particleIndex] removeFromSuperview];
        self.particles[self.particleIndex] = particle;
    }
}


- (void)update
{
    for (NSInteger i = 0; i < self.particles.count; i++) {
        
        ParticleView *particle = self.particles[i];
        
        if (particle.alpha <= 0.1) {
            [particle removeFromSuperview];
            continue;
        }
        
        particle.velocity = (Velocity){
            particle.velocity.x,
            particle.velocity.y + 0.175
        };
        particle.position = (CGPoint){
            particle.position.x + particle.velocity.x,
            particle.position.y + particle.velocity.y
        };
        particle.alpha *= 0.93;
    }
}

@end
