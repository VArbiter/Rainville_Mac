//
//  CCMainController.m
//  Rainville-mac
//
//  Created by 冯明庆 on 12/12/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

#import "CCMainController.h"

#import "CCLabel.h"
#import "CCLocalizedHelper.h"

@interface CCMainController ()

@property (nonatomic , strong) NSLabel *labelPoem ;

@end

@implementation CCMainController

- (void)loadView {
    NSView *v =  [[NSView alloc] init]; // 必须重写 , 否则默认去寻找 xib
    v.wantsLayer = YES; // 必须设置为 YES , 否则 默认不显示 layer 层
    self.view = v;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.backgroundColor = [NSColor colorWithRed:39.f / 255.f green:44.f / 255.f blue:50.f / 255.f alpha:1.f].CGColor;
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
    l.text = [NSString stringWithFormat:@"\n\n\n%@",_CC_RAIN_POEM_()];
    l.backgroundColor = NSColor.clearColor;
    l.textColor = [NSColor colorWithRed:67.f / 255.f green:77.f / 255.f blue:91.f / 255.f alpha:1.f];
    _labelPoem = l;
    return _labelPoem;
}


@end
