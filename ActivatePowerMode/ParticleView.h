//
//  ParticleView.h
//  ActivatePowerMode
//
//  Created by Jobs on 15/12/2.
//  Copyright © 2015年 Jobs. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef CGPoint Velocity;

@interface ParticleView : NSView

@property (nonatomic, assign) CGPoint position;
@property (nonatomic, strong) NSColor *color;
@property (nonatomic, assign) CGFloat alpha;
@property (nonatomic, assign) Velocity velocity;

- (instancetype)initWithPosition:(CGPoint)position color:(NSColor *)color;

@end
