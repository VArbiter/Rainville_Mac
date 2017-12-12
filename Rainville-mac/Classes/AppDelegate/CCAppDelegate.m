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

@property (nonatomic , strong) NSWindow *window;

@property (nonatomic , strong) CCMainController *mainController ;

@end

@implementation CCAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    [self.window center];
    [self.window makeKeyAndOrderFront:nil];
    [self.window.contentView addSubview:self.mainController.view];
    self.mainController.view.frame = self.window.contentView.bounds;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return false ; // 最小化窗口 . 不退出
}

- (void)applicationWillTerminate:(NSNotification *)notification {
    
}

- (CCMainController *)mainController {
    if (_mainController) return _mainController;
    CCMainController *m = [[CCMainController alloc] init];
    _mainController = m;
    return _mainController;
}

- (NSWindow *)window {
    if (_window) return _window;
    NSWindowStyleMask style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable
    | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable | NSWindowStyleMaskTexturedBackground ;
    NSWindow *w = [[NSWindow alloc] initWithContentRect:(NSRect){0,0,320,567}
                                              styleMask:style
                                                backing:NSBackingStoreBuffered
                                                  defer:YES
                                                 screen:NSScreen.mainScreen];
    w.contentMinSize = (CGSize){320,567};
    w.contentMaxSize = (CGSize){320,567};
    w.backgroundColor = NSColor.whiteColor;
    w.title = _CC_APP_NAME_();
    _window = w;
    return _window;
}

@end
