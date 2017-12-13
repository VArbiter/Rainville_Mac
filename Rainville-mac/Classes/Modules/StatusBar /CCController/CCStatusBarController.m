//
//  CCStatusBarController.m
//  Rainville-mac
//
//  Created by 冯明庆 on 13/12/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

#import "CCStatusBarController.h"

@interface CCStatusBarController ()

@end

@implementation CCStatusBarController

- (void)loadView {
    NSView *v =  [[NSView alloc] init];
    v.wantsLayer = YES;
    self.view = v;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = (CGRect){0,0,600 , NSScreen.mainScreen.frame.size.height};
}

@end
