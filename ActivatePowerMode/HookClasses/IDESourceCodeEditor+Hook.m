//
//  IDESourceCodeEditor+Hook.m
//  ActivatePowerMode
//
//  Created by Jobs on 15/12/1.
//  Copyright © 2015年 Jobs. All rights reserved.
//

#import "IDESourceCodeEditor+Hook.h"


@implementation IDESourceCodeEditor (Hook)

+ (void)hook
{
    [self jr_swizzleMethod:@selector(textView:shouldChangeTextInRange:replacementString:) withMethod:@selector(hook_textView:shouldChangeTextInRange:replacementString:) error:nil];
}


- (BOOL)hook_textView:(NSTextView *)textView shouldChangeTextInRange:(NSRange)affectedCharRange replacementString:(NSString *)replacementString
{
    [self shake];
    
    return [self hook_textView:textView shouldChangeTextInRange:affectedCharRange replacementString:replacementString];
}


- (void)shake
{
    CGFloat intensity = arc4random() % 3 + 1;
    CGFloat x = intensity * ((arc4random() % 2 == 0) ? -1 : 1);
    CGFloat y = intensity * ((arc4random() % 2 == 0) ? -1 : 1);
    [self moveToPoint:CGPointMake(x, y)];
    
    CGFloat shakeDurationTime = 0.00618;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(shakeDurationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self moveToPoint:CGPointMake(0, 0)];
    });
}


- (void)moveToPoint:(CGPoint)point
{
    CGSize size = self.view.frame.size;
    self.view.frame = (CGRect){point, size};
}

@end
