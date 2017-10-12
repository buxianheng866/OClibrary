//
//  PlayerUtil.m
//  Objective
//
//  Created by Bruce on 2017/7/5.
//  Copyright © 2017年 cndotaisbestdota. All rights reserved.
//

#import "PlayerUtil.h"

#import <AVFoundation/AVFoundation.h>
static PlayerUtil *player = nil;
@interface PlayerUtil ()<AVAudioPlayerDelegate>
{
    AVAudioPlayer *_player;
    void (^playFinish)(NSError *error);
}
@end
@implementation PlayerUtil

#pragma mark - public
+ (BOOL)isPlaying{
    return [[PlayerUtil sharedInstance] isPlaying];
}

+ (NSString *)playingFilePath{
    return [[PlayerUtil sharedInstance] playingFilePath];
}

+ (void)asyncPlayingWithPath:(NSString *)aFilePath
                  completion:(void(^)(NSError *error))completon{
    [[PlayerUtil sharedInstance] asyncPlayingWithPath:aFilePath
                                             completion:completon];
}

+ (void)stopCurrentPlaying{
    [[PlayerUtil sharedInstance] stopCurrentPlaying];
}


#pragma mark - private
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[self alloc] init];
    });
    
    return player;
}

// 当前是否正在播放
- (BOOL)isPlaying
{
    return [_player isPlaying];
}

// 得到当前播放音频路径
- (NSString *)playingFilePath
{
    NSString *path = nil;
    if (_player && _player.isPlaying) {
        path = _player.url.path;
    }
    
    return path;
}
- (void)asyncPlayingWithPath:(NSString *)aFilePath
                  completion:(void(^)(NSError *error))completon{
    playFinish = completon;
    NSError *error = nil;
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:aFilePath]) {
        error = [NSError errorWithDomain:NSLocalizedString(@"error.notFound", @"File path not exist")
                                    code:-1
                                userInfo:nil];
        if (playFinish) {
            playFinish(error);
        }
        playFinish = nil;
        
        return;
    }
    
    NSURL *wavUrl = [[NSURL alloc] initFileURLWithPath:aFilePath];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:wavUrl error:&error];
    if (error || !_player) {
        _player = nil;
        error = [NSError errorWithDomain:NSLocalizedString(@"error.initPlayerFail", @"Failed to initialize AVAudioPlayer")
                                    code:-1
                                userInfo:nil];
        if (playFinish) {
            playFinish(error);
        }
        playFinish = nil;
        return;
    }
    
    _player.delegate = self;
    [_player prepareToPlay];
    [_player play];
}

// 停止当前播放
- (void)stopCurrentPlaying{
    if(_player){
        _player.delegate = nil;
        [_player stop];
        _player = nil;
    }
    if (playFinish) {
        playFinish = nil;
    }
}

- (void)dealloc{
    if (_player) {
        _player.delegate = nil;
        [_player stop];
        _player = nil;
    }
    playFinish = nil;
}

#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player
                       successfully:(BOOL)flag{
    if (playFinish) {
        playFinish(nil);
    }
    if (_player) {
        _player.delegate = nil;
        _player = nil;
    }
    playFinish = nil;
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player
                                 error:(NSError *)error{
    if (playFinish) {
        NSError *error = [NSError errorWithDomain:NSLocalizedString(@"error.palyFail", @"Play failure")
                                             code:-1
                                         userInfo:nil];
        playFinish(error);
    }
    if (_player) {
        _player.delegate = nil;
        _player = nil;
    }
}

@end
