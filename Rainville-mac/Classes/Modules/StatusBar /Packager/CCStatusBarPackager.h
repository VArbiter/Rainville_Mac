//
//  CCStatusBarPackager.h
//  Rainville-mac
//
//  Created by 冯明庆 on 13/12/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Cocoa;

#import "CCStatusBarController.h"
#import "CCLocalizedHelper.h"
#import "CCAudioPreset.h"

@interface CCStatusBarPackager : NSObject

// absolute singleton

@property (nonatomic , strong , readonly) NSStatusItem *statusItem ;

@property (nonatomic , strong , readonly) NSMenu *menuRainType ;

@end

#pragma mark - -----

@interface NSMenuItem (CCAssists_MenuItem)

@property (nonatomic , strong) NSArray *aVolumes ;
@property (nonatomic , assign) NSInteger iIndex ;
@property (nonatomic , assign) NSTimeInterval intervalTimeCount ;

@end

#pragma mark - -----

@interface CCStatusBarPackager (CCAssists)

- (void) ccAutoAddMethod ;

@property (nonatomic , copy) void (^bClick)(NSMenuItem *sender);
@property (nonatomic , copy) void (^bPlayAction)(NSMenuItem *sender , BOOL isPlay);
@property (nonatomic , copy) void (^bShowWindow)(NSMenuItem *sender);
@property (nonatomic , copy) void (^bTimerAction)(NSMenuItem *sender);
@property (nonatomic , copy) void (^bAuthorAction)(NSMenuItem *sender);
- (void) ccTriggerAction : (NSMenuItem *) item ;
- (void) ccPlayAction : (NSMenuItem *) item ;
- (void) ccPauseAction : (NSMenuItem *) item ;
- (void) ccShowWindowAction : (NSMenuItem *) item ;
- (void) ccInitTimerAction : (NSMenuItem *) item ;
- (void) ccShowAuthorAction : (NSMenuItem *) item ;
- (void) ccQuitAppAction : (NSMenuItem *) item ;

@end
