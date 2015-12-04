//
//  IDESourceCodeEditor+Hook.m
//  ActivatePowerMode
//
//  Created by Jobs on 15/12/1.
//  Copyright © 2015年 Jobs. All rights reserved.
//

#import "IDESourceCodeEditor+Hook.h"
#import "ShakeAction.h"
#import "SparkAction.h"
#import "APMPlayer.h"

@implementation IDESourceCodeEditor (Hook)

+ (void)hook
{
    [self jr_swizzleMethod:@selector(textView:shouldChangeTextInRange:replacementString:)
                withMethod:@selector(hook_textView:shouldChangeTextInRange:replacementString:)
                     error:nil];
}


- (BOOL)hook_textView:(NSTextView *)textView shouldChangeTextInRange:(NSRange)affectedCharRange replacementString:(NSString *)replacementString
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
    
    [ShakeAction shakeView:textView];
    
    [[APMPlayer defaultPlayer] playSound];
    
    return [self hook_textView:textView shouldChangeTextInRange:affectedCharRange replacementString:replacementString];
}

@end
