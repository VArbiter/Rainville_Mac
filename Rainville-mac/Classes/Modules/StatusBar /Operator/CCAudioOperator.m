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

@end
