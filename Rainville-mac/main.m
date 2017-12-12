//
//  main.m
//  Rainville-mac
//
//  Created by 冯明庆 on 06/12/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CCAppDelegate.h"

static CCAppDelegate *__delegate = nil;

int main(int argc, const char * argv[]) {
    if (!__delegate) __delegate = [[CCAppDelegate alloc] init];
    NSApplication.sharedApplication.delegate = __delegate;
    return NSApplicationMain(argc, argv);
}
