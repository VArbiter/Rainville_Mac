//
//  CCAppDelegate.m
//  Rainville-mac
//
//  Created by 冯明庆 on 06/12/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

#import "CCAppDelegate.h"

#import "CCLocalizedHelper.h"
#import "CCMainController.h"

@interface CCAppDelegate ()

@end

@implementation CCAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {

}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return false ; // 最小化窗口 . 不退出
}

- (void)applicationWillTerminate:(NSNotification *)notification {
    
}

@end
