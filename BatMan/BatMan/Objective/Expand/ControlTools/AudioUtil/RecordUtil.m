//
//  RecordUtil.m
//  Objective
//
//  Created by Bruce on 2017/7/5.
//  Copyright © 2017年 cndotaisbestdota. All rights reserved.
//

#import "RecordUtil.h"
#define kChildPath @"Chat/Recoder"
#define kRecoderType @".wav"

static RecordUtil *record = nil;
@interface RecordUtil ()<AVAudioRecorderDelegate>
{
    NSDate *_startDate;
    NSDate *_endDate;
    void (^recordFinish)(NSString *recordPath);
}

@property (nonatomic, strong) NSDictionary *recordSetting;

@end
@implementation RecordUtil


+ (instancetype)shareInstance
{
    if (record == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            record = [[RecordUtil alloc] init];
        });
    }
    return record;
}

// 开始录音
+ (void)startRecordingWithFileName:(NSString *)fileName
                        completion:(void (^)(NSError *))completion
{
    [[RecordUtil shareInstance] startRecordingWithFileName:fileName
                                                  completion:completion];
}

+ (void)stopRecordingWithCompletion:(void (^)(NSString *))completion
{
    [[RecordUtil shareInstance] stopRecordingWithCompletion:completion];
}

+ (BOOL)isRecording
{
    return [[RecordUtil shareInstance] isRecording];
}

+ (void)cancelCurrentRecording
{
    [[RecordUtil shareInstance] cancelCurrentRecording];
}
+ (BOOL)canRecord
{
    return [[RecordUtil shareInstance] canRecord];
}


- (void)startRecordingWithFileName:(NSString *)fileName completion:(void (^)(NSError *))completion
{
    NSError *error = nil;
    NSString *wavFilePath = [self recorderPathWithFileName:fileName];
    NSURL *wavUrl = [[NSURL alloc] initFileURLWithPath:wavFilePath];
    
    _recorder = [[AVAudioRecorder alloc] initWithURL:wavUrl settings:self.recordSetting error:&error];
    _recorder.meteringEnabled = YES;
    if (!_recorder || error) {
        _recorder = nil;
        if (completion) {
            error = [NSError errorWithDomain:NSLocalizedString(@"error.initRecorderFail", @"Failed to initialize AVAudioRecorder") code:123 userInfo:nil];
            completion(error);
        }
        return;
    }
    _recorder.meteringEnabled = YES;
    _recorder.delegate = self;
    [_recorder record];
    if (completion) {
        completion(error);
    }
}
- (void)stopRecordingWithCompletion:(void (^)(NSString *))completion
{
    recordFinish = completion;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.recorder stop];
    });
}
// 录音文件主路径
- (NSString *)recorderMainPath
{
    return [FileManager pathInCacheDirectoryWithfileName:kChildPath];
}
- (NSString *)recorderPathWithFileName:(NSString *)fileName
{
    NSString *path = [self recorderMainPath];
    NSString *aFilePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileName]];
    NSString *wavFilePath = [[aFilePath stringByDeletingPathExtension]
                             stringByAppendingPathExtension:@"wav"];
    return wavFilePath;
}


// 取消录音
- (void)cancelCurrentRecording
{
    _recorder.delegate = nil;
    if (_recorder.recording) {
        [_recorder stop];
    }
    _recorder = nil;
    recordFinish = nil;
}

- (BOOL)isRecording
{
    return [_recorder isRecording];
}

- (BOOL)canRecord
{
    __block BOOL bCanRecord = YES;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                bCanRecord = granted;
            }];
        }
    }
    return bCanRecord;
}

- (NSDictionary *)recordSetting
{
    if (!_recordSetting) {
        _recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [NSNumber numberWithFloat: 8000.0],AVSampleRateKey, //采样率
                          [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                          [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,//采样位数 默认 16
                          [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,//通道的数目
                          nil];
    }
    
    return _recordSetting;
}

#pragma mark - AVAudioRecorderDelegate

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder
                           successfully:(BOOL)flag
{
    NSString *recordPath = [[_recorder url] path];
    
    if (recordFinish) {
        if (!flag) {
            recordPath = nil;
        }
        recordFinish(recordPath);
    }
    _recorder = nil;
    recordFinish = nil;
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder
                                   error:(NSError *)error{
    NSLog(@"audioRecorderEncodeErrorDidOccur");
}

+ (void)requestAccessForAudio {
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    switch (status) {
        case AVAuthorizationStatusNotDetermined: {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized: {
            break;
        }
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
            break;
        default:
            break;
    }
}



@end
