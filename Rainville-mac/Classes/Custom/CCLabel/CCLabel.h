//
//  CCLabel.h
//  Rainville-mac
//
//  Created by 冯明庆 on 11/12/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@import QuartzCore;

@interface CCLabel : NSView

@property (nonatomic , copy) NSString *sText ;
@property (nonatomic , copy) NSMutableAttributedString *sAttributedString ;
@property (nonatomic , copy) NSString *sFontName ;
@property (nonatomic , assign) CGFloat fFontSize ;
@property (nonatomic , assign) NSTextAlignment alignment ;
@property (nonatomic , strong) NSColor *colorText ;
@property (nonatomic , assign , getter=isWrapped) BOOL wrapped ;

@end

#pragma mark - -----

@interface NSLabel : NSTextField

@property (nonatomic , assign) NSString * text ;

@end
