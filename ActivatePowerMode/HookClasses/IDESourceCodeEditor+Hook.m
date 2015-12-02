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


@implementation IDESourceCodeEditor (Hook)

+ (void)hook
{
    [self jr_swizzleMethod:@selector(textView:shouldChangeTextInRange:replacementString:) withMethod:@selector(hook_textView:shouldChangeTextInRange:replacementString:) error:nil];
}


- (BOOL)hook_textView:(NSTextView *)textView shouldChangeTextInRange:(NSRange)affectedCharRange replacementString:(NSString *)replacementString
{
    NSUInteger count = 0;
    NSInteger location = textView.selectedRange.location;
    NSRect rect = *[textView.layoutManager rectArrayForCharacterRange:NSMakeRange(location, 0)
                                         withinSelectedCharacterRange:NSMakeRange(location, 0)
                                                      inTextContainer:textView.textContainer
                                                            rectCount:&count];
    [[SparkAction sharedAction] sparkAtPosition:rect.origin inView:textView];
    
    [ShakeAction shakeView:textView];
    
    return [self hook_textView:textView shouldChangeTextInRange:affectedCharRange replacementString:replacementString];
}



@end
