//
//  CCAudioOperator.h
//  Rainville-mac
//
//  Created by 冯明庆 on 13/12/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

@import Foundation;

#import "CCStatusBarPackager.h"
#import "CCAudioHandler.h"

@interface CCAudioOperator : NSObject

@property (nonatomic , strong , readonly) NSEvent *eventKeyMonitor ;

@end

#pragma mark - -----

#import "CCMainController.h"

@interface CCAudioOperator (CCWindow)

@property (nonatomic , strong) CCMainController *mainController ;
@property (nonatomic , strong) NSWindow *window;
- (void) ccMakeBriefWindowVisiable ;

@end

