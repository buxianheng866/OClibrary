//
//  AudioManager+Media.h
//  Objective
//
//  Created by Bruce on 2017/7/5.
//  Copyright © 2017年 cndotaisbestdota. All rights reserved.
//

#import "AudioManager.h"
typedef NS_ENUM(NSInteger, LPAudioSession){
    LP_DEFAULT = 0,
    LP_AUDIOPLAYER,
    LP_AUDIORECORDER
};

@interface AudioManager (Media)

#pragma mark - AudioRecorder
// 开始录音
- (void)asyncStartRecordingcompletion:(void(^)(NSError *error))completion;

// 停止录音
-(void)asyncStopRecordingWithCompletion:(void(^)(NSString *recordPath,
                                                 NSInteger aDuration,
                                                 NSError *error))completion;
// 取消录音
-(void)cancelCurrentRecording;


// 当前是否正在录音
-(BOOL)isRecording;


#pragma mark - AudioPlayer
// 播放音频
- (void)asyncPlayingWithPath:(NSString *)aFilePath
                  completion:(void(^)(NSError *error))completon;
// 停止播放
- (void)stopPlaying;

- (void)stopPlayingWithChangeCategory:(BOOL)isChange;

// 当前是否正在播放
-(BOOL)isPlaying;
@end
