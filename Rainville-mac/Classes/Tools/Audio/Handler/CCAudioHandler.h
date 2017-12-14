//
//  CCAudioHandler.h
//  Rainville-mac
//
//  Created by 冯明庆 on 13/12/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

@import Foundation;
#import "CCAudioPreset.h"

typedef enum {
    cc_audio_playing_option_none = 0,
    cc_audio_playing_option_play ,
    cc_audio_playing_option_pause
} cc_audio_playing_option_t;

typedef NSString * cc_audio_player_notification_s NS_EXTENSIBLE_STRING_ENUM;

FOUNDATION_EXPORT cc_audio_player_notification_s _CC_PLAYER_STATUS_DID_CHANGE_NOTIFICATION_;

@interface CCAudioHandler : NSObject

+ (instancetype) shared ;
- (void) ccSetPlayingArray : (NSArray <NSNumber *> *) aVolume
                  complete : (void (^)(CCAudioHandler *sender)) bComplete ;
- (void) ccSetStopAfter : (NSTimeInterval) interval
               complete : (void (^)(CCAudioHandler *sender)) bComplete ;

- (void) ccPlay ;
- (void) ccPause ;
@property (nonatomic , assign , readonly) cc_audio_playing_option_t option ;
@property (nonatomic , copy) void (^bCurrentTime)(CCAudioHandler *sender , NSString *sFormattedTime , BOOL stop) ;
@property (nonatomic , assign , readonly) BOOL isEmpty ;

@end
