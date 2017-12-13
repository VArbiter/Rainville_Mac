//
//  CCStatusBarPackager.m
//  Rainville-mac
//
//  Created by 冯明庆 on 13/12/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

#import "CCStatusBarPackager.h"

@interface CCStatusBarPackager () < NSCopying , NSMutableCopying >

@property (nonatomic , strong , readwrite) NSStatusItem *statusItem ;
@property (nonatomic , strong , readwrite) NSPopover *popover;
@property (nonatomic , assign , readwrite) CCStatusBarController *contentController ;
@property (nonatomic , strong , readwrite) NSEvent *eventMouseLeft ;

- (void) ccDefaultSettings ;
- (void) ccBarItemAction : (NSStatusBarButton *) item ;

@end

static CCStatusBarPackager *__instance = nil;

@implementation CCStatusBarPackager

+ (void)load {
    [NSNotificationCenter.defaultCenter addObserverForName:NSApplicationDidFinishLaunchingNotification
                                                    object:nil
                                                     queue:nil
                                                usingBlock:^(NSNotification * _Nonnull note) { 
        __instance = [[CCStatusBarPackager alloc] init];
    }];
}

- (instancetype)init {
    if ((self = [super init])) {
        [self ccDefaultSettings];
    }
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[super allocWithZone:zone] init];
    });
    return __instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return __instance;
}
- (id)mutableCopyWithZone:(NSZone *)zone {
    return __instance;
}

- (void) ccDefaultSettings {
    [self statusItem];
}

- (void) ccBarItemAction : (NSStatusBarButton *) item {
    [self.popover showRelativeToRect:item.bounds
                              ofView:item
                       preferredEdge:NSRectEdgeMaxY];
}

- (NSStatusItem *)statusItem {
    if (_statusItem) return _statusItem;
    NSStatusItem *b = [NSStatusBar.systemStatusBar statusItemWithLength:NSVariableStatusItemLength];
    [b.button setImage:[NSImage imageNamed:@"icon_status_bar"]];
    b.target = self;
    b.action = @selector(ccBarItemAction:);
    _statusItem = b;
    return _statusItem;
}

- (NSPopover *)popover {
    if (_popover) return _popover;
    NSPopover *p = [[NSPopover alloc] init];
    p.behavior = NSPopoverBehaviorTransient;
    p.appearance = [NSAppearance appearanceNamed:NSAppearanceNameVibrantDark];
    p.contentViewController = self.contentController;
    _popover = p;
    return _popover;
}

- (CCStatusBarController *)contentController {
    if (_contentController) return _contentController;
    CCStatusBarController *c = [[CCStatusBarController alloc] init];
    _contentController = c;
    return _contentController;
}

- (NSEvent *)eventMouseLeft {
    if (_eventMouseLeft) return _eventMouseLeft;
    __weak typeof(self) pSelf = self;
    NSEvent *e = [NSEvent addGlobalMonitorForEventsMatchingMask:NSEventMaskLeftMouseDown handler:^(NSEvent * sender) {
        if (pSelf.popover.isShown) {
            [pSelf.popover close];
        }
    }];
    _eventMouseLeft = e;
    return _eventMouseLeft;
}

@end
