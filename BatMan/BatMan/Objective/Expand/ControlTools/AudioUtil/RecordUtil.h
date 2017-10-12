//
//  RecordUtil.h
//  Objective
//
//  Created by Bruce on 2017/7/5.
//  Copyright © 2017年 cndotaisbestdota. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface RecordUtil : NSObject
+(instancetype)shareInstance;

@property (nonatomic, strong) AVAudioRecorder *recorder;
// 开始录音
+ (void)startRecordingWithFileName:(NSString *)fileName
                        completion:(void(^)(NSError *error))completion;
// 停止录音
+ (void)stopRecordingWithCompletion:(void(^)(NSString *recordPath))completion;

// 是否拥有权限
+ (BOOL)canRecord;

// 当前是否正在录音
+(BOOL)isRecording;

// 取消当前录制
+ (void)cancelCurrentRecording;
+ (void)requestAccessForAudio;
@end
