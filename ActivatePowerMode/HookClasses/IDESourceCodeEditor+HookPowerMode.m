//
//  IDESourceCodeEditor+HookPowerMode.m
//  ActivatePowerMode
//
//  Created by Jobs on 15/12/1.
//  Copyright © 2015年 Jobs. All rights reserved.
//

#import "IDESourceCodeEditor+HookPowerMode.h"
#import "ShakeAction.h"
#import "SparkAction.h"
#import "APMPlayer.h"

@implementation IDESourceCodeEditor (HookPowerMode)

+ (void)hookPowerMode
{
    [self jr_swizzleMethod:@selector(textView:shouldChangeTextInRange:replacementString:)
                withMethod:@selector(powerMode_textView:shouldChangeTextInRange:replacementString:)
                     error:NULL];
}


- (BOOL)powerMode_textView:(NSTextView *)textView shouldChangeTextInRange:(NSRange)affectedCharRange replacementString:(NSString *)replacementString
{
    // Get the position under the cursor
    NSUInteger count = 0;
    NSInteger location = textView.selectedRange.location;
    NSRect rect = *[textView.layoutManager rectArrayForCharacterRange:NSMakeRange(location, 0)
                                         withinSelectedCharacterRange:NSMakeRange(location, 0)
                                                      inTextContainer:textView.textContainer
                                                            rectCount:&count];
    CGPoint position = rect.origin;

    // Get the color under the cursor
    location = MAX(location - 1, 0);
    NSRange range = NSMakeRange(location, 1);
    NSColor *color = [self.sourceCodeDocument.textStorage colorAtCharacterIndex:location
                                                                 effectiveRange:&range
                                                                        context:nil];
    if (!color) {
        color = [NSColor whiteColor];
    }
    
    [[SparkAction sharedAction] sparkAtPosition:position withColor:color inView:textView];

    [ShakeAction shakeView:textView.superview.superview.superview];
    
    [[APMPlayer defaultPlayer] playSound];
    
    return [self powerMode_textView:textView shouldChangeTextInRange:affectedCharRange replacementString:replacementString];
}

@end
