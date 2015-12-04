//
//  ActivatePowerMode.m
//  ActivatePowerMode
//
//  Created by Jobs on 15/12/1.
//  Copyright © 2015年 Jobs. All rights reserved.
//

#import "ActivatePowerMode.h"
#import "IDESourceCodeEditor+Hook.h"
#import "MainMenuItem.h"
#import "SparkAction.h"

@interface ActivatePowerMode ()

@end


@implementation ActivatePowerMode

@synthesize enablePlugin = _enablePlugin;

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    // Load only into Xcode
    NSString *identifier = [NSBundle mainBundle].bundleIdentifier;
    if (![identifier isEqualToString:@"com.apple.dt.Xcode"]) {
        return;
    }
    
    [self sharedPlugin];
}


+ (instancetype)sharedPlugin
{
    static ActivatePowerMode *_sharedPlugin;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedPlugin = [[self alloc] init];
    });
    
    return _sharedPlugin;
}


- (instancetype)init
{
    if (self = [super init]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidFinishLaunching:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
    }
    
    return self;
}


- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSApplicationDidFinishLaunchingNotification
                                                  object:nil];
    
    [self addPluginsMenu];
    
    if ([ConfigManager sharedManager].isEnablePlugin) {
        self.enablePlugin = YES;
    }
}


- (void)addPluginsMenu
{
    // Add Plugins menu next to Window menu
    NSMenu *mainMenu = [NSApp mainMenu];
    NSMenuItem *pluginsMenuItem = [mainMenu itemWithTitle:@"Plugins"];
    if (!pluginsMenuItem) {
        pluginsMenuItem = [[NSMenuItem alloc] init];
        pluginsMenuItem.title = @"Plugins";
        pluginsMenuItem.submenu = [[NSMenu alloc] initWithTitle:pluginsMenuItem.title];
        NSInteger windowIndex = [mainMenu indexOfItemWithTitle:@"Window"];
        [mainMenu insertItem:pluginsMenuItem atIndex:windowIndex];
    }
    
    NSMenuItem *mainMenuItem = [[MainMenuItem alloc] init];
    [pluginsMenuItem.submenu addItem:mainMenuItem];
}


- (void)setEnablePlugin:(BOOL)enablePlugin
{
    _enablePlugin = enablePlugin;
    
    [IDESourceCodeEditor hook];
    
    [SparkAction sharedAction].enableAction = _enablePlugin;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
