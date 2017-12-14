//
//  CCAudioPreset.m
//  Rainville
//
//  Created by 冯明庆 on 17/1/6.
//  Copyright © 2017年 冯明庆. All rights reserved.
//

#import "CCAudioPreset.h"
#import "CCLocalizedHelper.h"

NSDictionary <NSString * , NSArray <NSNumber *> *> * __dSettings = nil;
NSArray <NSArray <NSNumber *> *> * __aVolumes = nil;
NSArray <NSURL *> * __aFilePaths = nil;

NSDictionary <NSString * , NSArray <NSNumber *> *> * cc_default_audio_settings(void) {
    
    if (__dSettings) return __dSettings;
    
    NSArray <NSString *> *array = _CC_ARRAY_ITEM_();
    NSDictionary *d = @{array[0] : cc_default_audio_volumes()[0],
                        array[1] : cc_default_audio_volumes()[1],
                        array[2] : cc_default_audio_volumes()[2],
                        array[3] : cc_default_audio_volumes()[3],
                        array[4] : cc_default_audio_volumes()[4],
                        array[5] : cc_default_audio_volumes()[5],
                        array[6] : cc_default_audio_volumes()[6],
                        array[7] : cc_default_audio_volumes()[7],
                        array[8] : cc_default_audio_volumes()[8],
                        array[9] : cc_default_audio_volumes()[9],
                        array[10] : cc_default_audio_volumes()[10],
                        array[11] : cc_default_audio_volumes()[11],
                        array[12] : cc_default_audio_volumes()[12],
                        array[13] : cc_default_audio_volumes()[13],
                        array[14] : cc_default_audio_volumes()[14],
                        array[15] : cc_default_audio_volumes()[15],
                        array[16] : cc_default_audio_volumes()[16],
                        array[17] : cc_default_audio_volumes()[17],
                        array[18] : cc_default_audio_volumes()[18],
                        array[19] : cc_default_audio_volumes()[19],
                        array[20] : cc_default_audio_volumes()[20],
                        array[21] : cc_default_audio_volumes()[21]};
    __dSettings = d;
    return __dSettings;
}

NSArray <NSArray <NSNumber *> *> * cc_default_audio_volumes(void) {
    
    if (__aVolumes) return __aVolumes;
    
    NSArray <NSNumber *> * _CC_FAIRY_RAIN_ = @[@(.0f),@(.0f),@(.0f),@(.0f),@(.1f),@(.2f),@(.3f),@(.4f),@(.5f),@(.6f)];
    
    NSArray <NSNumber *> * _CC_BEDROOM_ = @[@(.0f),@(.0f),@(.0f),@(.0f),@(.1f),@(.2f),@(.3f),@(.2f),@(.1f),@(.0f)];
    
    NSArray <NSNumber *> * _CC_UNDER_THE_PORCH_ = @[@(.0f),@(.3f),@(.25),@(.25f),@(.3f),@(.25f),@(.2f),@(.15f),@(.1f),@(.0f)];
    
    NSArray <NSNumber *> * _CC_DISTANT_STORM_ = @[@(.7f),@(.6f),@(.5f),@(.4f),@(.3f),@(.2f),@(.2f),@(.3f),@(.2f),@(.1f)];
    
    NSArray <NSNumber *> * _CC_GETTING_WET_ = @[@(.7f),@(.5f),@(.2f),@(.35f),@(.55f),@(.35f),@(.3f),@(.5f),@(.2f),@(.2f)];
    
    NSArray <NSNumber *> * _CC_ONLY_RUMBLE_ = @[@(.7f),@(.5f),@(.15f),@(.15f),@(.15f),@(.15f),@(.1f),@(.1f),@(.0f),@(.0f)];
    
    NSArray <NSNumber *> * _CC_UNDER_THE_LEAVES_ = @[@(.3f),@(.3f),@(.0f),@(.0f),@(.0f),@(.3f),@(.0f),@(.0f),@(.1f),@(.2f)];
    
    NSArray <NSNumber *> * _CC_DARK_RAIN_ = @[@(.0f),@(.5f),@(.4f),@(.3f),@(.2f),@(.0f),@(.0f),@(.1f),@(.1f),@(.0f)];
    
    NSArray <NSNumber *> * _CC_JUNGLE_LODGE_ = @[@(.7f),@(.0f),@(.2f),@(.0f),@(.25f),@(.0f),@(.25f),@(.0f),@(.2f),@(.0f)];
    
    NSArray <NSNumber *> * _CC_BROWN_NOISE_ = @[@(.65f),@(.6f),@(.55f),@(.5f),@(.45f),@(.4f),@(.35f),@(.3f),@(.25),@(.2f)];
    
    NSArray <NSNumber *> * _CC_PINK_NOISE_ = @[@(.3f),@(.3f),@(.3f),@(.3f),@(.3f),@(.3f),@(.3f),@(.3f),@(.3f),@(.3f)];
    
    NSArray <NSNumber *> * _CC_WHITE_NOISE_ = @[@(.2f),@(.25f),@(.3f),@(.35f),@(.4f),@(.45f),@(.5f),@(.55f),@(.6f),@(.65f)];
    
    NSArray <NSNumber *> * _CC_GREY_NOISE_ = @[@(.5f),@(.45f),@(.4f),@(.3f),@(.3f),@(.3f),@(.25f),@(.25f),@(.3f),@(.35f)];
    
    // ----------
    
    NSArray <NSNumber *> * _CC_60_HZ_ = @[@(.4f),@(.5f),@(.4f),@(.0f),@(.0f),@(.0f),@(.0f),@(.0f),@(.0f),@(.0f)];
    
    NSArray <NSNumber *> * _CC_125_HZ_ = @[@(.0f),@(.4f),@(.5f),@(.4f),@(.0f),@(.0f),@(.0f),@(.0f),@(.0f),@(.0f)];
    
    NSArray <NSNumber *> * _CC_250_HZ_ = @[@(.0f),@(.0f),@(.4f),@(.5f),@(.4f),@(.0f),@(.0f),@(.0f),@(.0f),@(.0f)];
    
    NSArray <NSNumber *> * _CC_500_HZ_ = @[@(.0f),@(.0f),@(.0f),@(.4f),@(.5f),@(.4f),@(.0f),@(.0f),@(.0f),@(.0f)];
    
    NSArray <NSNumber *> * _CC_1K_HZ_ = @[@(.0f),@(.0f),@(.0f),@(.0f),@(.4f),@(.5f),@(.4f),@(.0f),@(.0f),@(.0f)];
    
    NSArray <NSNumber *> * _CC_2K_HZ_ = @[@(.0f),@(.0f),@(.0f),@(.0f),@(.0f),@(.4f),@(.5f),@(.4f),@(.0f),@(.0f)];
    
    NSArray <NSNumber *> * _CC_4K_HZ_ = @[@(.0f),@(.0f),@(.0f),@(.0f),@(.0f),@(.0f),@(.4f),@(.5f),@(.4f),@(.0f)];
    
    NSArray <NSNumber *> * _CC_8K_HZ_ = @[@(.0f),@(.0f),@(.0f),@(.0f),@(.0f),@(.0f),@(.0f),@(.4f),@(.5f),@(.6f)];
    
    NSArray <NSNumber *> * _CC_DEFAULT_PRESET_ = _CC_PINK_NOISE_.copy;
    
    NSArray *a = @[_CC_DEFAULT_PRESET_,
                   _CC_FAIRY_RAIN_,
                   _CC_BEDROOM_,
                   _CC_UNDER_THE_PORCH_,
                   _CC_DISTANT_STORM_,
                   _CC_GETTING_WET_,
                   _CC_ONLY_RUMBLE_,
                   _CC_UNDER_THE_LEAVES_,
                   _CC_DARK_RAIN_,
                   _CC_JUNGLE_LODGE_,
                   _CC_BROWN_NOISE_,
                   _CC_PINK_NOISE_,
                   _CC_WHITE_NOISE_,
                   _CC_GREY_NOISE_,
                   _CC_60_HZ_,
                   _CC_125_HZ_,
                   _CC_250_HZ_,
                   _CC_500_HZ_,
                   _CC_1K_HZ_,
                   _CC_2K_HZ_,
                   _CC_4K_HZ_,
                   _CC_8K_HZ_];
    __aVolumes = a;
    return __aVolumes;
}

NSArray <NSURL *> * cc_audio_file_path(void) {
    
    if (__aFilePaths) return __aFilePaths;
    
    NSMutableArray *a = [NSMutableArray array];
    for (short i = 0; i < 10; i++) {
        NSString *s = [NSString stringWithFormat:@"_%d",i];
        NSString *sPath = [[NSBundle mainBundle] pathForResource:s ofType:@"wav"];
        [a addObject:[NSURL fileURLWithPath:sPath]];
    }
    __aFilePaths = a;
    return __aFilePaths;
}

