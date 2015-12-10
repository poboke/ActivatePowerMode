//
//  MainMenuItem.m
//  ActivatePowerMode
//
//  Created by Jobs on 15/12/3.
//  Copyright © 2015年 Jobs. All rights reserved.
//

#import "MainMenuItem.h"
#import "ActivatePowerMode.h"
#import "SparkAction.h"

typedef NS_ENUM(NSUInteger, MenuItemType) {
    kMenuItemTypeEnablePlugin = 1,
    kMenuItemTypeEnableSpark,
    kMenuItemTypeEnableShake,
    kMenuItemTypeEnableSound,
};


@interface MainMenuItem ()

@property (nonatomic, strong) NSMenuItem *sparkMenuItem;
@property (nonatomic, strong) NSMenuItem *shakeMenuItem;
@property (nonatomic, strong) NSMenuItem *soundMenuItem;

@end


@implementation MainMenuItem

- (instancetype)init
{
    if (self = [super init]) {
        
        self.title = [NSString stringWithFormat:@"Activate Power Mode (v%@)", PluginVersion];
        
        NSMenu *configMenu = [[NSMenu alloc] init];
        configMenu.autoenablesItems = NSOffState;
        self.submenu = configMenu;
        
        ConfigManager *configManager = [ConfigManager sharedManager];
        
        NSMenuItem *pluginMenuItem = [self menuItemWithTitle:@"Enable" type:kMenuItemTypeEnablePlugin];
        pluginMenuItem.state = configManager.isEnablePlugin;
        [configMenu addItem:pluginMenuItem];
        
        self.sparkMenuItem = [self menuItemWithTitle:@"Enable Spark  ✨" type:kMenuItemTypeEnableSpark];
        self.sparkMenuItem.state = configManager.isEnableSpark;
        self.sparkMenuItem.enabled = configManager.isEnablePlugin;
        [configMenu addItem:self.sparkMenuItem];
        
        self.shakeMenuItem = [self menuItemWithTitle:@"Enable Shake  🗯" type:kMenuItemTypeEnableShake];
        self.shakeMenuItem.state = configManager.isEnableShake;
        self.shakeMenuItem.enabled = configManager.isEnablePlugin;
        [configMenu addItem:self.shakeMenuItem];
        
        self.soundMenuItem = [self menuItemWithTitle:@"Enable Sound  🎶" type:kMenuItemTypeEnableSound];
        self.soundMenuItem.state = configManager.isEnableSound;
        self.soundMenuItem.enabled = configManager.isEnablePlugin;
        [configMenu addItem:self.soundMenuItem];
    }
    
    return self;
}


- (NSMenuItem *)menuItemWithTitle:(NSString *)title type:(MenuItemType)type
{
    NSMenuItem *menuItem = [[NSMenuItem alloc] init];
    menuItem.title = title;
    menuItem.tag = type;
    menuItem.state = NSOffState;
    menuItem.target = self;
    menuItem.action = @selector(clickMenuItem:);
    return menuItem;
}


- (void)clickMenuItem:(NSMenuItem *)menuItem
{
    menuItem.state = !menuItem.state;
    
    ConfigManager *configManager = [ConfigManager sharedManager];
    
    MenuItemType type = menuItem.tag;
    
    switch (type) {
            
        case kMenuItemTypeEnablePlugin:
            configManager.enablePlugin = !configManager.isEnablePlugin;
            [ActivatePowerMode sharedPlugin].enablePlugin = configManager.isEnablePlugin;
            self.sparkMenuItem.enabled = configManager.isEnablePlugin;
            self.shakeMenuItem.enabled = configManager.isEnablePlugin;
            self.soundMenuItem.enabled = configManager.isEnablePlugin;
            break;
            
        case kMenuItemTypeEnableSpark:
            configManager.enableSpark = !configManager.isEnableSpark;
            [SparkAction sharedAction].enableAction = configManager.isEnableSpark;
            break;
            
        case kMenuItemTypeEnableShake:
            configManager.enableShake = !configManager.isEnableShake;
            break;
            
        case kMenuItemTypeEnableSound:
            configManager.enableSound = !configManager.isEnableSound;
            break;
    }
}

@end
