//
//  ParticleView.m
//  ActivatePowerMode
//
//  Created by Jobs on 15/12/2.
//  Copyright © 2015年 Jobs. All rights reserved.
//

#import "ParticleView.h"

CGFloat const ParticleWidth = 3.0;

@implementation ParticleView

- (instancetype)initWithPosition:(CGPoint)position color:(NSColor *)color
{
    CGRect frame = (CGRect){position, CGSizeMake(ParticleWidth, ParticleWidth)};
    
    if (self = [super initWithFrame:frame]) {
        
        _position = position;
        _color    = color;
        _alpha    = 1.0;
        _velocity = (Velocity){
            -1.0 + (RandomRange(0, 100) / 100.0) * 2,
            -3.5 + (RandomRange(0, 100) / 100.0) * 2
        };
    }
    
    return self;
}


- (void)setPosition:(CGPoint)position
{
    _position = position;
    self.frame = (CGRect){position, self.frame.size};
}


- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    NSColor *color = [self.color colorWithAlphaComponent:self.alpha + 0.3];
    [color set];
    
    NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:dirtyRect xRadius:ParticleWidth yRadius:ParticleWidth];
    [path fill];
}

@end
