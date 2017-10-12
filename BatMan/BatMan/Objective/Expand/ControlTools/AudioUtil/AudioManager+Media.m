//
//  AudioManager+Media.m
//  Objective
//
//  Created by Bruce on 2017/7/5.
//  Copyright © 2017年 cndotaisbestdota. All rights reserved.
//

#import "AudioManager+Media.h"
#import "EMVoiceConverter.h"
@implementation AudioManager (Media)

#pragma Record

/*fileName*/
- (NSString *)currentRecordFileName
{
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    NSString *fileName = [NSString stringWithFormat:@"%ld",(long)timeInterval];
    return fileName;
}

// 开始录音
- (void)asyncStartRecordingcompletion:(void(^)(NSError *error))completion{
    
    
    if ([self isRecording]) {
        [self cancelCurrentRecording];
        return;
    }
    if ([self isPlaying]) {
        [self stopPlaying];
    }
    
    NSString *fileName = [self currentRecordFileName];
    _recorderStartDate = [NSDate date];
    [self setupAudioSessionCategory:LP_AUDIORECORDER
                           isActive:YES];
    [RecordUtil startRecordingWithFileName:fileName completion:completion];
}

// 停止录音
-(void)asyncStopRecordingWithCompletion:(void(^)(NSString *recordPath,
                                                 NSInteger aDuration,
                                                 NSError *error))completion{
    NSError *error = nil;
    
    __weak typeof(self) weakSelf = self;
    _recorderEndDate = [NSDate date];
    
    if([_recorderEndDate timeIntervalSinceDate:_recorderStartDate] < 1.0){
        if (completion) {
            error = [NSError errorWithDomain:NSLocalizedString(@"error.recordTooShort", @"Recording time is too short")
                                        code:-102
                                    userInfo:nil];
            completion(nil,0,error);
        }
        
        // 如果录音时间较短，延迟1秒停止录音（iOS中，如果快速开始，停止录音，UI上会出现红条,为了防止用户又迅速按下，UI上需要也加一个延迟，长度大于此处的延迟时间，不允许用户循序重新录音）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [RecordUtil stopRecordingWithCompletion:^(NSString *recordPath) {
                [weakSelf setupAudioSessionCategory:LP_DEFAULT isActive:NO];
            }];
        });
        return ;
    }
    
    [RecordUtil stopRecordingWithCompletion:^(NSString *recordPath) {
        if (completion) {
            if (recordPath) {
                //录音格式转换，从wav转为amr
                NSString *amrFilePath = [[recordPath stringByDeletingPathExtension]
                                         stringByAppendingPathExtension:@"amr"];
                BOOL convertResult = [self convertWAV:recordPath toAMR:amrFilePath];
                if (convertResult) {
                    // 删除录的wav
                    NSFileManager *fm = [NSFileManager defaultManager];
                    [fm removeItemAtPath:recordPath error:nil];
                }
                completion(amrFilePath,(int)[self->_recorderEndDate timeIntervalSinceDate:self->_recorderStartDate],nil);
            }
            [weakSelf setupAudioSessionCategory:LP_DEFAULT isActive:NO];
        }
    }];
}


// 取消录音
-(void)cancelCurrentRecording{
    [RecordUtil cancelCurrentRecording];
}
// 获取录音状态
-(BOOL)isRecording{
    return [RecordUtil isRecording];
}
-(BOOL)canRecord
{
    return [RecordUtil canRecord];
}

#pragma mark - AudioPlayer
// 播放音频
- (void)asyncPlayingWithPath:(NSString *)aFilePath
                  completion:(void(^)(NSError *error))completon{
    BOOL isNeedSetActive = YES;
    // 如果正在播放音频，停止当前播放。
    if([PlayerUtil isPlaying]){
        [PlayerUtil stopCurrentPlaying];
        isNeedSetActive = NO;
    }
    
    if (isNeedSetActive) {
        // 设置播放时需要的category
        [self setupAudioSessionCategory:LP_AUDIOPLAYER
                               isActive:YES];
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *wavFilePath = [[aFilePath stringByDeletingPathExtension] stringByAppendingPathExtension:@"wav"];
    //如果转换后的wav文件不存在, 则去转换一下
    if (![fileManager fileExistsAtPath:wavFilePath]) {
        BOOL covertRet = [self convertAMR:aFilePath toWAV:wavFilePath];
        if (!covertRet) {
            if (completon) {
                completon([NSError errorWithDomain:NSLocalizedString(@"error.initRecorderFail", @"File format conversion failed")
                                              code:-122
                                          userInfo:nil]);
            }
            return ;
        }
    }
    [PlayerUtil asyncPlayingWithPath:wavFilePath
                            completion:^(NSError *error)
     {
         [self setupAudioSessionCategory:LP_DEFAULT
                                isActive:NO];
         if (completon) {
             completon(error);
         }
     }];
}

// 停止播放
- (void)stopPlaying{
    [PlayerUtil stopCurrentPlaying];
    [self setupAudioSessionCategory:LP_DEFAULT
                           isActive:NO];
}

- (void)stopPlayingWithChangeCategory:(BOOL)isChange{
    [PlayerUtil stopCurrentPlaying];
    if (isChange) {
        [self setupAudioSessionCategory:LP_DEFAULT
                               isActive:NO];
    }
}
// 获取播放状态
- (BOOL)isPlaying{
    return [PlayerUtil isPlaying];
}



-(NSError *)setupAudioSessionCategory:(LPAudioSession)session
                             isActive:(BOOL)isActive{
    BOOL isNeedActive = NO;
    if (isActive != _currActive) {
        isNeedActive = YES;
        _currActive = isActive;
    }
    NSError *error = nil;
    NSString *audioSessionCategory = nil;
    switch (session) {
        case LP_AUDIOPLAYER:
            // 设置播放category
            audioSessionCategory = AVAudioSessionCategoryPlayback;
            break;
        case LP_AUDIORECORDER:
            // 设置录音category
            audioSessionCategory = AVAudioSessionCategoryRecord;
            break;
        default:
            // 还原category
            audioSessionCategory = AVAudioSessionCategoryAmbient;
            break;
    }
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    // 如果当前category等于要设置的，不需要再设置
    if (![_currCategory isEqualToString:audioSessionCategory]) {
        [audioSession setCategory:audioSessionCategory error:nil];
    }
    if (isNeedActive) {
        BOOL success = [audioSession setActive:isActive
                                   withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation
                                         error:&error];
        if(!success || error){
            error = [NSError errorWithDomain:NSLocalizedString(@"error.initPlayerFail", @"Failed to initialize AVAudioPlayer")
                                        code:-1
                                    userInfo:nil];
            return error;
        }
    }
    _currCategory = audioSessionCategory;
    
    return error;
}

#pragma mark - Convert

- (BOOL)convertAMR:(NSString *)amrFilePath
             toWAV:(NSString *)wavFilePath
{
    BOOL ret = NO;
    BOOL isFileExists = [[NSFileManager defaultManager] fileExistsAtPath:amrFilePath];
    if (isFileExists) {
        [EMVoiceConverter amrToWav:amrFilePath wavSavePath:wavFilePath];
        isFileExists = [[NSFileManager defaultManager] fileExistsAtPath:wavFilePath];
        if (isFileExists) {
            ret = YES;
        }
    }
    
    return ret;
}

- (BOOL)convertWAV:(NSString *)wavFilePath
             toAMR:(NSString *)amrFilePath {
    BOOL ret = NO;
    BOOL isFileExists = [[NSFileManager defaultManager] fileExistsAtPath:wavFilePath];
    if (isFileExists) {
        [EMVoiceConverter wavToAmr:wavFilePath amrSavePath:amrFilePath];
        isFileExists = [[NSFileManager defaultManager] fileExistsAtPath:amrFilePath];
        if (!isFileExists) {
            
        } else {
            ret = YES;
        }
    }
    
    return ret;
}



@end
