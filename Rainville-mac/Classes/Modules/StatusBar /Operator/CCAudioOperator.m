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
            if (pSelf.handler.isEmpty) {
                [pSelf.handler ccSetPlayingArray:cc_default_audio_volumes()[0]
                                        complete:nil];
            }
            else [pSelf.handler ccPlay];
        }
        else [pSelf.handler ccPause];
    };
    self.packager.bShowWindow = ^(NSMenuItem *sender) {
        [pSelf ccMakeBriefWindowVisiable];
    };
    self.packager.bTimerAction = ^(NSMenuItem *sender_menu_item) {
        if (pSelf.handler.option != cc_audio_playing_option_play) {
            [pSelf.handler ccSetPlayingArray:cc_default_audio_volumes()[0]
                                    complete:nil];
        }
        [pSelf.handler ccSetStopAfter:(sender_menu_item.intervalTimeCount * 60.f) complete:^(CCAudioHandler *sender) {
            
        }];
    };
    [self eventKeyMonitor];
    
    NSString *s_temp_title = self.packager.item_rain_time.title;
    self.handler.bCurrentTime = ^(CCAudioHandler *sender, NSString *sFormattedTime, BOOL stop) {
        if (stop) {
            pSelf.packager.item_rain_time.title = s_temp_title;
        }
        else pSelf.packager.item_rain_time.title = [NSString stringWithFormat:@"%@ ( %@ )" , s_temp_title , sFormattedTime];
    };
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
    __weak typeof(self) pSelf = self;
    a.bCurrentTime = ^(CCAudioHandler *sender, NSString *sFormattedTime, BOOL stop) {
        if (stop) [sender ccPause];
        if (pSelf.window.isVisible) {
            pSelf.mainController.sTime = sFormattedTime;
        }
    };
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
#if DEBUG
       NSLog(@"key: %c", character);
#endif
   }];
    _eventKeyMonitor = e;
    return _eventKeyMonitor;
}

@end

#pragma mark - -----

#import <objc/runtime.h>

@implementation CCAudioOperator (CCWindow)

- (void) ccMakeBriefWindowVisiable {
    if (self.window.isVisible) {
        [self.window orderOut:nil];
    }
    else {
        [self.window center];
        [self.window makeKeyAndOrderFront:nil];
    }
}

- (void)setMainController:(CCMainController *)mainController {
    objc_setAssociatedObject(self, "CC_ASSSOCIATE_OPERATOR_MAIN_CONTROLLER", mainController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CCMainController *)mainController {
    id t = objc_getAssociatedObject(self, "CC_ASSSOCIATE_OPERATOR_MAIN_CONTROLLER");
    if (t) return t;
    CCMainController *m = [[CCMainController alloc] init];
    objc_setAssociatedObject(self, "CC_ASSSOCIATE_OPERATOR_MAIN_CONTROLLER", m, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    t = m;
    return t;
}

- (void)setWindow:(NSWindow *)window {
    objc_setAssociatedObject(self, "CC_ASSSOCIATE_OPERATOR_MAIN_WINDOW", window, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSWindow *)window {
    id t = objc_getAssociatedObject(self, "CC_ASSSOCIATE_OPERATOR_MAIN_WINDOW");
    if (t) return t;
    // (NSRect){0,0,320,567}
    NSWindowStyleMask style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable
    | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskTexturedBackground ;
    NSWindow *w = [[NSWindow alloc] initWithContentRect:(NSRect){0,0,320,320}
                                              styleMask:style
                                                backing:NSBackingStoreBuffered
                                                  defer:YES
                                                 screen:NSScreen.mainScreen];
    w.contentMinSize = (CGSize){320,320};
    w.contentMaxSize = (CGSize){320,320};
    w.backgroundColor = NSColor.whiteColor;
    w.releasedWhenClosed = false; // 关闭不释放
    w.title = _CC_APP_NAME_();
    [w.contentView addSubview:self.mainController.view];
    self.mainController.view.frame = w.contentView.bounds;
    objc_setAssociatedObject(self, "CC_ASSSOCIATE_OPERATOR_MAIN_WINDOW", w, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    t = w;
    return t;
}

@end

