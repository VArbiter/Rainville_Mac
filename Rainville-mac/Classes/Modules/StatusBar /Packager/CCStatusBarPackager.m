//
//  CCStatusBarPackager.m
//  Rainville-mac
//
//  Created by 冯明庆 on 13/12/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

#import "CCStatusBarPackager.h"

@interface CCStatusBarPackager ()

@property (nonatomic , strong , readwrite) NSStatusItem *statusItem ;
@property (nonatomic , strong , readwrite) NSMenu *menuRainType ;

- (void) ccDefaultSettings ;

@end

@implementation CCStatusBarPackager

- (instancetype)init {
    if ((self = [super init])) {
        [self ccDefaultSettings];
        [self ccAutoAddMethod];
    }
    return self;
}

- (void) ccDefaultSettings {
    [self statusItem];
}

- (NSStatusItem *)statusItem {
    if (_statusItem) return _statusItem;
    NSStatusItem *b = [NSStatusBar.systemStatusBar statusItemWithLength:NSVariableStatusItemLength];
    [b.button setImage:[NSImage imageNamed:@"icon_status_bar"]];
    [b setToolTip:_CC_RAIN_POEM_()];
    b.menu = self.menuRainType;
    _statusItem = b;
    return _statusItem;
}

- (NSMenu *)menuRainType {
    if (_menuRainType) return _menuRainType;
    NSMenu *m = [[NSMenu alloc] initWithTitle:@"By Elwin Frederick"];
    _menuRainType = m;
    return _menuRainType;
}

@end

#pragma mark - -----

#import <objc/runtime.h>

@implementation NSMenuItem (CCAssists_MenuItem)

- (void)setAVolumes:(NSArray *)aVolumes {
    objc_setAssociatedObject(self, "CC_ASSOCIATE_MENU_ITEM_VOLUME_ARRAY", aVolumes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSArray *)aVolumes {
    return objc_getAssociatedObject(self, "CC_ASSOCIATE_MENU_ITEM_VOLUME_ARRAY");
}

- (void)setIIndex:(NSInteger)iIndex {
    objc_setAssociatedObject(self, "CC_ASSOCIATE_MENU_ITEM_INDEX", @(iIndex), OBJC_ASSOCIATION_ASSIGN);
}
- (NSInteger)iIndex {
    return [objc_getAssociatedObject(self, "CC_ASSOCIATE_MENU_ITEM_INDEX") integerValue];
}

@end

@implementation CCStatusBarPackager (CCAssists)

- (void)setBClick:(void (^)(NSMenuItem *))bClick {
    objc_setAssociatedObject(self, "CC_ASSOCIATE_STATUS_PACKAGER_CLICK_ACTION", bClick, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(NSMenuItem *))bClick {
    return objc_getAssociatedObject(self, "CC_ASSOCIATE_STATUS_PACKAGER_CLICK_ACTION");
}

- (void) ccAutoAddMethod {
    NSMenuItem *itemRainType = [[NSMenuItem alloc] initWithTitle:_CC_APP_DESP_() action:nil keyEquivalent:@""];
    [self.menuRainType insertItem:itemRainType atIndex:0];
    NSMenu *menuRain = [[NSMenu alloc] initWithTitle:@"RainType"];
    itemRainType.submenu = menuRain;
    
    NSDictionary <NSString * , NSArray <NSNumber *> *> * d = cc_default_audio_settings();
    NSArray <NSString *> * a = _CC_ARRAY_ITEM_();
    [a enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMenuItem *item = [[NSMenuItem alloc] init];
        item.iIndex = idx;
        item.aVolumes = d[obj];
        item.title = obj;
        item.target = self;
        item.action = @selector(ccTriggerAction:);
        [menuRain addItem:item];
    }];
}

- (void) ccTriggerAction : (NSMenuItem *) item {
    if (self.bClick) self.bClick(item);
}

@end
