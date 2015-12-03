//
//  ActivatePowerMode.m
//  ActivatePowerMode
//
//  Created by Jobs on 15/12/1.
//  Copyright © 2015年 Jobs. All rights reserved.
//

#import "ActivatePowerMode.h"
#import "IDESourceCodeEditor+Hook.h"
#import "APMPlayer.h"

@interface ActivatePowerMode ()

@end


@implementation ActivatePowerMode

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
}


- (void)addPluginsMenu
{
    NSMenu *mainMenu = [NSApp mainMenu];
    if (!mainMenu) {
        return;
    }
    
    // Add Plugins menu next to Window menu
    NSMenuItem *pluginsMenuItem = [mainMenu itemWithTitle:@"Plugins"];
    if (!pluginsMenuItem) {
        pluginsMenuItem = [[NSMenuItem alloc] init];
        pluginsMenuItem.title = @"Plugins";
        pluginsMenuItem.submenu = [[NSMenu alloc] initWithTitle:pluginsMenuItem.title];
        NSInteger windowIndex = [mainMenu indexOfItemWithTitle:@"Window"];
        [mainMenu insertItem:pluginsMenuItem atIndex:windowIndex];
    }
    
    // Add "Enable Activate Power Mode" menu item
    NSMenuItem *subMenuItem = [[NSMenuItem alloc] init];
    subMenuItem.title = @"Enable Activate Power Mode";
    subMenuItem.target = self;
    subMenuItem.action = @selector(toggleMenu:);
    subMenuItem.state = NSOffState;
    [pluginsMenuItem.submenu addItem:subMenuItem];
    
    NSMenuItem *playSoundItem = [[NSMenuItem alloc] init];
    playSoundItem.title = @"Enable Play Sound";
    playSoundItem.target = self;
    playSoundItem.action = @selector(toggleSound:);
    playSoundItem.state = NSOffState;
    [pluginsMenuItem.submenu addItem:playSoundItem];
}


- (void)toggleMenu:(NSMenuItem *)menuItem
{
    menuItem.state = !menuItem.state;
    [IDESourceCodeEditor hook];
}

- (void)toggleSound:(NSMenuItem *)menuItem
{
    menuItem.state = !menuItem.state;
    [APMPlayer defaultPlayer].enable = ![APMPlayer defaultPlayer].enable;
}

- (void)activatePowerMode
{
    // Jobs
    NSLog(@"Hello world!");
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
