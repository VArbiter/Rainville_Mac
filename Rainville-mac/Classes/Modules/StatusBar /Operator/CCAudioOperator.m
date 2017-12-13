//
//  CCAudioOperator.m
//  Rainville-mac
//
//  Created by 冯明庆 on 13/12/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

#import "CCAudioOperator.h"

@interface CCAudioOperator () < NSCopying , NSMutableCopying >

@property (nonatomic , strong) CCAudioHandler *handler ;
@property (nonatomic , strong) CCStatusBarPackager *packager ;
@property (nonatomic , strong , readwrite) NSEvent *eventKeyMonitor ;

- (void) ccDefaultSettings ;

@end

static CCAudioOperator *__instance = nil;

@implementation CCAudioOperator

+ (void)load {
    [NSNotificationCenter.defaultCenter addObserverForName:NSApplicationDidFinishLaunchingNotification
                                                    object:nil
                                                     queue:nil
                                                usingBlock:^(NSNotification * _Nonnull note) {
        __instance = [[CCAudioOperator alloc] init];
    }];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [super allocWithZone:zone];
    });
    return __instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return __instance;
}
- (id)mutableCopyWithZone:(NSZone *)zone {
    return __instance;
}

- (instancetype)init {
    if ((self = [super init])) {
        [self ccDefaultSettings];
    }
    return self;
}

- (void) ccDefaultSettings {
    __weak typeof(self) pSelf = self;
    self.packager.bClick = ^(NSMenuItem *sender) {
        [pSelf.handler ccSetPlayingArray:sender.aVolumes complete:^(CCAudioHandler *sender) {
            
        }];
    };
    self.packager.bPlayAction = ^(NSMenuItem *sender, BOOL isPlay) {
        if (isPlay) {
            [pSelf.handler ccPlay];
        }
        else [pSelf.handler ccPause];
    };
    [self eventKeyMonitor];
}

- (CCStatusBarPackager *)packager {
    if (_packager) return _packager;
    CCStatusBarPackager *p = [[CCStatusBarPackager alloc] init];
    _packager = p;
    return _packager;
}

- (CCAudioHandler *)handler {
    if (_handler) return _handler;
    CCAudioHandler *a = CCAudioHandler.shared;
    _handler = a;
    return _handler;
}

- (NSEvent *)eventKeyMonitor {
    if (_eventKeyMonitor) return _eventKeyMonitor;
#warning TODO >>>
    // 需要将 App 加入【设置】-【安全性与隐私】-【辅助功能】, 否则无效
    NSEvent *e = [NSEvent addGlobalMonitorForEventsMatchingMask:NSEventMaskKeyDown
                                                        handler:^(NSEvent *event){
       NSString *chars = [[event characters] lowercaseString];
       unichar character = [chars characterAtIndex:0];
       NSLog(@"keydown globally! Which key? This key: %c", character);
   }];
    _eventKeyMonitor = e;
    return _eventKeyMonitor;
}

@end
