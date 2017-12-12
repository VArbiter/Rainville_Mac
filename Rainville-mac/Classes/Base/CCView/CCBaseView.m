//
//  CCBaseView.m
//  Rainville-mac
//
//  Created by 冯明庆 on 06/12/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

#import "CCBaseView.h"

@implementation CCBaseView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    
}

- (void)dealloc {
#if DEBUG
    NSLog(@" \n ----- _CC_%@_DEALLOC_",NSStringFromClass(self.class));
#endif
}

@end
