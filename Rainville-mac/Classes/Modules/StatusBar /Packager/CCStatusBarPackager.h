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

@interface CCStatusBarPackager : NSObject

// absolute singleton

@property (nonatomic , strong , readonly) NSStatusItem *statusItem ;
@property (nonatomic , strong , readonly) NSPopover *popover;
@property (nonatomic , assign , readonly) CCStatusBarController *contentController ;
@property (nonatomic , strong , readonly) NSEvent *eventMouseLeft ;

@end
