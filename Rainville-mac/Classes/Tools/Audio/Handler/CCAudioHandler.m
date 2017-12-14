//
//  CCAudioHandler.m
//  Rainville-mac
//
//  Created by 冯明庆 on 13/12/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

#import "CCAudioHandler.h"

@import AVFoundation;
@import MediaPlayer;

cc_audio_player_notification_s _CC_PLAYER_STATUS_DID_CHANGE_NOTIFICATION_ = @"CC_PLAYER_STATUS_DID_CHANGE_NOTIFICATION";

NSTimeInterval _CC_FADE_DURATION_ = 1.f;

@interface CCAudioHandler ()

@property (nonatomic , strong) NSOperationQueue *queueOperation ;
@property (nonatomic , strong) dispatch_source_t timer ;

@property (nonatomic , assign) NSInteger iCountTime ; // 倒计时时间
@property (nonatomic , strong) NSArray <NSNumber *> *aVolumesCurrent ; // 当前音频数组
@property (nonatomic , strong) NSMutableArray <AVAudioPlayer *> *aPlayers ; // 播放器队列

@property (nonatomic , assign , readwrite) cc_audio_playing_option_t option ;

- (void) ccInterPause ;

+ (NSString *) ccFormatTime : (NSTimeInterval) interval ;

@end

@implementation CCAudioHandler

+ (instancetype)shared {
    static CCAudioHandler *__handler;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __handler = [[self alloc] init];
    });
    return __handler;
}

- (void) ccSetPlayingArray : (NSArray <NSNumber *> *) aVolume
                  complete : (void (^)(CCAudioHandler *sender)) bComplete {
    self.aVolumesCurrent = nil;
    self.aVolumesCurrent = aVolume.copy;
    [self ccPlay];
}

- (void) ccSetStopAfter : (NSTimeInterval) interval
               complete : (void (^)(CCAudioHandler *sender)) bComplete {
    if (self.timer) {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
    
    __weak typeof(self) pSelf = self;
    void (^bSafeBlock)(CCAudioHandler * , NSString * , BOOL) = ^ (CCAudioHandler *sender , NSString *sFormattedTime , BOOL stop) {
        if (NSThread.isMainThread) {
            if (pSelf.bCurrentTime) pSelf.bCurrentTime(pSelf, sFormattedTime , stop);
        } else {
            if (!pSelf.bCurrentTime) return ;
            dispatch_sync(dispatch_get_main_queue(), ^{
                pSelf.bCurrentTime(pSelf, sFormattedTime , stop);
            });
        }
    };
    
    if (interval == 0) {
        self.iCountTime = 0;
        if (bSafeBlock) bSafeBlock(self , @"00 : 00" , YES);
        if (self.timer) {
            dispatch_source_cancel(self.timer);
        }
        return ;
    }
    self.iCountTime = interval;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.timer, dispatch_walltime(NULL, 0), 1.f * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        BOOL isStop = -- pSelf.iCountTime <= 0 ;
#if DEBUG
        NSLog(@"_CC_COUNT_TIME_REMAIN_%ld",(long)pSelf.iCountTime);
#endif
        if (isStop) {
            pSelf.option = cc_audio_playing_option_pause;
            [pSelf ccInterPause];
            dispatch_source_cancel(pSelf.timer);
            dispatch_source_set_cancel_handler(self.timer, ^{
                if (bSafeBlock) bSafeBlock(pSelf , @"00 : 00" , YES);
                pSelf.timer = nil;
            });
        }
        if (bSafeBlock) bSafeBlock(pSelf , [CCAudioHandler ccFormatTime:pSelf.iCountTime] , isStop);
    });
    dispatch_resume(self.timer);
}

- (void) ccPlay {
    __weak typeof(self) pSelf = self;
    [self.aPlayers enumerateObjectsUsingBlock:^(AVAudioPlayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [pSelf.queueOperation addOperationWithBlock:^{
            if (obj.isPlaying) {
                obj.volume = pSelf.aVolumesCurrent[idx].floatValue;
            }
            else {
                obj.volume = .0f;
                [obj play];
                [obj setVolume:pSelf.aVolumesCurrent[idx].floatValue
                  fadeDuration:_CC_FADE_DURATION_];
            }
        }];
    }];
    self.option = cc_audio_playing_option_play;
    [NSNotificationCenter.defaultCenter postNotificationName:_CC_PLAYER_STATUS_DID_CHANGE_NOTIFICATION_
                                                      object:nil
                                                    userInfo:@{@"key" : @(self.option)}];
}
- (void) ccPause {
    __weak typeof(self) pSelf = self;
    [self.aPlayers enumerateObjectsUsingBlock:^(AVAudioPlayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [pSelf.queueOperation addOperationWithBlock:^{
            if (obj.isPlaying) {
                [obj setVolume:.0f
                  fadeDuration:_CC_FADE_DURATION_];
            }
        }];
    }];
    dispatch_time_t t = dispatch_time(DISPATCH_TIME_NOW, (int64_t)((_CC_FADE_DURATION_ + .2f) * NSEC_PER_SEC));
    dispatch_after(t, dispatch_get_main_queue(), ^{
        [pSelf ccInterPause];
    });
    self.option = cc_audio_playing_option_pause;
    [NSNotificationCenter.defaultCenter postNotificationName:_CC_PLAYER_STATUS_DID_CHANGE_NOTIFICATION_
                                                      object:nil
                                                    userInfo:@{@"key" : @(self.option)}];
}

- (BOOL)isEmpty {
    return !(_aVolumesCurrent && (_aVolumesCurrent.count > 0));
}

#pragma mark - -----

- (void) ccInterPause {
    [self.aPlayers makeObjectsPerformSelector:@selector(pause)];
}

+ (NSString *) ccFormatTime : (NSTimeInterval) interval {
    long fSeconds = ((NSInteger)interval) % 60 ;
    long fMinutes = (((NSInteger)interval) / 60) % 60 ;
    long fHours = ((NSInteger)interval) / 3600 ;
    if (fHours < 1) {
        return [NSString stringWithFormat:@"%02ld : %02ld", fMinutes , fSeconds];
    }
    return [NSString stringWithFormat:@"%02ld : %02ld : %02ld", fHours , fMinutes , fSeconds];
}

- (NSOperationQueue *)queueOperation {
    if (_queueOperation) return _queueOperation;
    NSOperationQueue *q = NSOperationQueue.alloc.init;
    _queueOperation = q;
    return _queueOperation;
}

- (NSMutableArray<AVAudioPlayer *> *)aPlayers {
    if (_aPlayers) return _aPlayers;
    NSMutableArray <AVAudioPlayer *> * a = [NSMutableArray array];
    NSArray <NSURL *> *aWavs = cc_audio_file_path() ;
    [aWavs enumerateObjectsUsingBlock:^(NSURL * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSError *e = nil;
        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:obj
                                                                       error:&e];
        player.volume = 0.0f ;
        player.numberOfLoops = -1 ;
        [a addObject:e ? AVAudioPlayer.new : player];
        [player prepareToPlay];
    }];
    _aPlayers = a;
    return _aPlayers;
}

@end
