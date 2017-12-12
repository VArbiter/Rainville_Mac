//
//  AppDelegate.m
//  Rainville-mac
//
//  Created by 冯明庆 on 06/12/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

#import "AppDelegate.h"

#import "CCMainViewController.h"

@interface AppDelegate ()

@property (nonatomic , strong) NSWindow *window;

@property (nonatomic , strong) CCMainViewController *mainController ;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self.window.contentView addSubview:self.mainController.view];
    self.mainController.view.frame = self.window.contentView.bounds;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return false ; // 最小化窗口 . 不退出
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    
}

- (CCMainViewController *)mainController {
    if (_mainController) return _mainController;
    CCMainViewController *m = [[CCMainViewController alloc] init];
    _mainController = m;
    return _mainController;
}

- (NSWindow *)window {
    if (_window) return _window;
    
    NSUInteger iStyle = NSTitledWindowMask | NSClosableWindowMask
    | NSMiniaturizableWindowMask | NSResizableWindowMask | NSTexturedBackgroundWindowMask ;
    
    NSWindow *w = [NSWindow alloc] initWithContentRect:(NSRect){0,0,} styleMask:<#(NSWindowStyleMask)#> backing:<#(NSBackingStoreType)#> defer:<#(BOOL)#> screen:<#(nullable NSScreen *)#>
    return _window;
}

@end
