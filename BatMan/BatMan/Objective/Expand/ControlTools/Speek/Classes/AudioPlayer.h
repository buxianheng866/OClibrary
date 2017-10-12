//  AudioPlayer.h
//  GN100
//
//  Created by chuanliang on 15/11/13.
//  Copyright © 2015年 chuanliang. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <CoreFoundation/CoreFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#include <unistd.h>

#define kNumberBuffers 3

@interface AudioPlayer : NSObject
{
    AudioQueueRef					mQueue;
    AudioQueueBufferRef				mBuffers[kNumberBuffers];
    AudioStreamBasicDescription     mPlayFormat;
    int                             mIndex;
@public
    BOOL                            isStartPlay;
    BOOL                            isPause;
    int                             mBufferByteSize;
    int                             pip_fd[2];
   
}

-(id)initWithSampleRate:(int)sampleRate;
-(void)startPlayWithBufferByteSize:(int)bufferByteSize;
-(void)stopPlay;
-(void)pause;
-(void)resume;
-(void)putAudioData:(short*)pcmData;

@end
