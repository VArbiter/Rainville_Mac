//
//  CCMainViewController.m
//  Rainville-mac
//
//  Created by 冯明庆 on 06/12/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

#import "CCMainViewController.h"
#import "CCLabel.h"
#import "CCLocalizedHelper.h"

@interface CCMainViewController ()

@property (nonatomic , strong) NSLabel *labelPoem ;

@end

@implementation CCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.backgroundColor = NSColor.cyanColor.CGColor;
}

- (void)viewWillLayout {
    [super viewWillLayout];
    [self.view addSubview:self.labelPoem];
}

- (NSLabel *)labelPoem {
    if (_labelPoem) return _labelPoem;
    NSLabel *l = [[NSLabel alloc] initWithFrame:self.view.bounds];
    l.font = [NSFont systemFontOfSize:12.f];
    l.alignment = NSTextAlignmentCenter;
    l.maximumNumberOfLines = 0;
    l.text = _CC_RAIN_POEM_();
    l.backgroundColor = NSColor.blackColor;
    _labelPoem = l;
    return _labelPoem;
}

@end
