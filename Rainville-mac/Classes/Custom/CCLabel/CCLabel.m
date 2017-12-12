//
//  CCLabel.m
//  Rainville-mac
//
//  Created by 冯明庆 on 11/12/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

#import "CCLabel.h"

@interface CCLabel ()

@property (nonatomic , strong) CATextLayer *layerText ;

@end

@implementation CCLabel

- (instancetype)initWithFrame:(NSRect)frameRect {
    if ((self = [super initWithFrame:frameRect])) {
        self.wantsLayer = YES;
    }
    return self;
}
- (void)setFrame:(NSRect)frame {
    self.layerText.frame = frame;
}

- (void)layout {
    [super layout];
    [self.layer addSublayer:self.layerText];
}

- (void)setSText:(NSString *)sText {
    self.layerText.string = sText;
}
- (void)setSAttributedString:(NSMutableAttributedString *)sAttributedString {
    self.layerText.string = sAttributedString;
}
- (void)setSFontName:(NSString *)sFontName {
    self.layerText.font = ((__bridge CFTypeRef)sFontName);
}
- (void)setFFontSize:(CGFloat)fFontSize {
    self.layerText.fontSize = fFontSize;
}
- (void)setAlignment:(NSTextAlignment)alignment {
    NSString *s = kCAAlignmentLeft;
    switch (alignment) {
        case NSTextAlignmentLeft:{
            s = kCAAlignmentLeft;
        }break;
        case NSTextAlignmentRight:{
            s = kCAAlignmentRight;
        }break;
        case NSTextAlignmentCenter:{
            s = kCAAlignmentCenter;
        }break;
        case NSTextAlignmentNatural:{
            s = kCAAlignmentNatural;
        }break;
        case NSTextAlignmentJustified:{
            s = kCAAlignmentJustified;
        }break;
            
        default:
            break;
    }
    self.layerText.alignmentMode = s;
}
- (void)setColorText:(NSColor *)colorText {
    self.layerText.foregroundColor = colorText.CGColor;
}
- (void)setWrapped:(BOOL)wrapped {
    self.layerText.wrapped = wrapped;
}

- (CATextLayer *)layerText {
    if (_layerText) return _layerText;
    CATextLayer *l = [CATextLayer layer];
    l.frame = self.bounds;
    _layerText = l;
    return _layerText;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
}

@end

#pragma mark - -----

@interface NSLabel ()

- (void) ccDefaultSettings ;

@end

@implementation NSLabel

@synthesize text = _text;

- (instancetype)initWithFrame:(NSRect)frameRect {
    if ((self = [super initWithFrame:frameRect])) {
        [self ccDefaultSettings];
    }
    return self;
}

- (void) ccDefaultSettings {
    self.bordered = false;
    self.editable = false;
    self.selectable = false;
}

- (void)setText:(NSString *)text {
    self.stringValue = text;
}
- (NSString *)text {
    return self.stringValue;
}

@end
