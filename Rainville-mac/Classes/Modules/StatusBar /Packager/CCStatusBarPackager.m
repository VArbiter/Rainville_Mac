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
    b.toolTip = _CC_RAIN_POEM_();
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

- (void)setIntervalTimeCount:(NSTimeInterval)intervalTimeCount {
    objc_setAssociatedObject(self, "CC_ASSOCIATE_MENU_ITEM_TIME_INTERVAL", @(intervalTimeCount), OBJC_ASSOCIATION_ASSIGN);
}
- (NSTimeInterval)intervalTimeCount {
    return [objc_getAssociatedObject(self, "CC_ASSOCIATE_MENU_ITEM_TIME_INTERVAL") doubleValue];
}

@end

@implementation CCStatusBarPackager (CCAssists)

- (void)setBClick:(void (^)(NSMenuItem *))bClick {
    objc_setAssociatedObject(self, "CC_ASSOCIATE_STATUS_PACKAGER_CLICK_ACTION", bClick, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(NSMenuItem *))bClick {
    return objc_getAssociatedObject(self, "CC_ASSOCIATE_STATUS_PACKAGER_CLICK_ACTION");
}
- (void)setBPlayAction:(void (^)(NSMenuItem *, BOOL))bPlayAction {
    objc_setAssociatedObject(self, "CC_ASSOCIATE_STATUS_PACKAGER_PLAYING_ACTION", bPlayAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(NSMenuItem *, BOOL))bPlayAction {
    return objc_getAssociatedObject(self, "CC_ASSOCIATE_STATUS_PACKAGER_PLAYING_ACTION");
}
- (void)setBShowWindow:(void (^)(NSMenuItem *))bShowWindow {
    objc_setAssociatedObject(self, "CC_ASSOCIATE_STATUS_PACKAGER_SHOW_WINDOW_ACTION", bShowWindow, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(NSMenuItem *))bShowWindow {
    return objc_getAssociatedObject(self, "CC_ASSOCIATE_STATUS_PACKAGER_SHOW_WINDOW_ACTION");
}
- (void)setBTimerAction:(void (^)(NSMenuItem *))bTimerAction {
    objc_setAssociatedObject(self, "CC_ASSOCIATE_STATUS_PACKAGER_TIMER_ACTION", bTimerAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(NSMenuItem *))bTimerAction {
    return objc_getAssociatedObject(self, "CC_ASSOCIATE_STATUS_PACKAGER_TIMER_ACTION");
}

- (void) ccAutoAddMethod {
    NSMenuItem *itemRainType = [[NSMenuItem alloc] initWithTitle:_CC_APP_DESP_() action:nil keyEquivalent:@""];
    [self.menuRainType insertItem:itemRainType atIndex:0];
    
    NSMenu *menuRain = [[NSMenu alloc] init];
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
    
    NSMenuItem *itemRainTime = [[NSMenuItem alloc] initWithTitle:_CC_COUNT_DOWN_() action:nil keyEquivalent:@""];
    [self.menuRainType addItem:itemRainTime];
    
    NSMenu *menuRainTime = [[NSMenu alloc] init];
    itemRainTime.submenu = menuRainTime;
    
    NSArray <NSString *> *aTime = @[@"0" , @"5" , @"10" , @"15" , @"20" ,
                                    @"25" , @"30" , @"35" , @"40" , @"45" ,
                                    @"50" , @"55" , @"60" , @"90" , @"120" ];
    [aTime enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMenuItem *item = [[NSMenuItem alloc] init];
        item.iIndex = idx;
        item.intervalTimeCount = obj.doubleValue;
        if (obj.doubleValue == .0f) {
            item.title = _CC_STOP_();
        }
        else item.title = [[obj stringByAppendingString:@" "] stringByAppendingString:_CC_COUNT_DOWN_MINUTES_()];
        item.target = self;
        item.action = @selector(ccInitTimerAction:);
        [menuRainTime addItem:item];
    }];
    
    NSMenuItem *itemRainPause = [[NSMenuItem alloc] init];
    itemRainPause.title = _CC_STOP_();
    itemRainPause.target = self;
    itemRainPause.action = @selector(ccPauseAction:);
    itemRainPause.keyEquivalent = @"P";
    [self.menuRainType addItem:itemRainPause];
    
    NSMenuItem *itemRainPlay = [[NSMenuItem alloc] init];
    itemRainPlay.title = _CC_PLAY_();
    itemRainPlay.target = self;
    itemRainPlay.action = @selector(ccPlayAction:);
    itemRainPlay.keyEquivalent = @"R";
    [self.menuRainType addItem:itemRainPlay];
    
    NSMenuItem *itemThanks = [[NSMenuItem alloc] init];
    itemThanks.title = _CC_HINT_WELCOME_USE_RAINVILLE_();
    itemThanks.target = self;
    itemThanks.action = @selector(ccShowWindowAction:);
    itemThanks.keyEquivalent = @"T";
    [self.menuRainType addItem:itemThanks];
}

- (void) ccTriggerAction : (NSMenuItem *) item {
    if (self.bClick) self.bClick(item);
}
- (void) ccPlayAction : (NSMenuItem *) item {
    if (self.bPlayAction) self.bPlayAction(item, YES);
}
- (void) ccPauseAction : (NSMenuItem *) item {
    if (self.bPlayAction) self.bPlayAction(item, false);
}
- (void) ccShowWindowAction : (NSMenuItem *) item {
    if (self.bShowWindow) self.bShowWindow(item);
}
- (void) ccInitTimerAction : (NSMenuItem *) item {
    if (self.bTimerAction) self.bTimerAction(item);
}

@end
