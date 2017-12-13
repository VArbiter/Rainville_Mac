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

@end

#pragma mark - -----

@interface CCStatusBarPackager (CCAssists)

- (void) ccAutoAddMethod ;

@property (nonatomic , copy) void (^bClick)(NSMenuItem *sender);
- (void) ccTriggerAction : (NSMenuItem *) item ;

@end
