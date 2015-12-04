//
//  MainMenuItem.m
//  ActivatePowerMode
//
//  Created by Jobs on 15/12/3.
//  Copyright © 2015年 Jobs. All rights reserved.
//

#import "MainMenuItem.h"
#import "ActivatePowerMode.h"

typedef NS_ENUM(NSUInteger, MenuItemType) {
    kMenuItemTypeEnablePlugin = 1,
    kMenuItemTypeEnableShake,
    kMenuItemTypeEnableSound,
};

@implementation MainMenuItem

- (instancetype)init
{
    if (self = [super init]) {
        
        self.title = [NSString stringWithFormat:@"Activate Power Mode (v%@)", PluginVersion];
        
        NSMenu *configMenu = [[NSMenu alloc] init];
        configMenu.autoenablesItems = NSOffState;
        self.submenu = configMenu;
        
        ConfigManager *configManager = [ConfigManager sharedManager];
        
        NSMenuItem *enablePluginMenuItem = [self menuItemWithTitle:@"Enable " type:kMenuItemTypeEnablePlugin];
        enablePluginMenuItem.state = configManager.isEnablePlugin;
        [configMenu addItem:enablePluginMenuItem];
        
        NSMenuItem *enableShakeMenuItem = [self menuItemWithTitle:@"Enable Shake  🗯" type:kMenuItemTypeEnableShake];
        enableShakeMenuItem.state = configManager.isEnableShake;
        [configMenu addItem:enableShakeMenuItem];
        
        NSMenuItem *enableSoundenuItem = [self menuItemWithTitle:@"Enable Sound  🎶" type:kMenuItemTypeEnableSound];
        enableSoundenuItem.state = configManager.isEnableSound;
        [configMenu addItem:enableSoundenuItem];
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
