//
//  RtmpClient.h
//  GN100
//
//  Created by chuanliang on 15/11/13.
//  Copyright © 2015年 chuanliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "AudioRecoder.h"
#import "AudioPlayer.h"

#include "rtmp.h"
#include "amf.h"
#include "log.h"
#include "speex.h"
#include "speex_header.h"

@protocol RtmpClientDelegate <NSObject>

-(void)EventCallback:(int)event;

@end
@interface RtmpClient : NSObject<AudioRecordDelegate>
{
    AudioRecoder *mAudioRecord;
    AudioPlayer  *mAudioPlayer;
    
    RTMP *pPubRtmp;
    RTMP *pPlayRtmp;
    BOOL isStartPub;
    BOOL isStartPlay;
    BOOL isPause;
    
    SpeexBits ebits; //speex encoder
    int enc_frame_size;
    void *enc_state;
    char *output_buffer;
    short *pcm_buffer;
    UInt32 pubTs;
    
    SpeexBits *dbits;//speex decoder;
    int dec_frame_size;
    void* dec_state;
    
    NSCondition *condition;
    
    id<RtmpClientDelegate> outDelegate;
}

-(id)initWithSampleRate:(int)sampleRate withEncoder:(int)audioEncoder;

-(void)setOutDelegate:(id<RtmpClientDelegate>)delegate;

-(void)startPublishWithUrl:(NSString*) rtmpURL;
-(void)stopPublish;

-(void)startPlayWithUrl:(NSString*)rtmpURL IsTeacher:(BOOL)isTeacher;
-(void)stopPlay;
-(void)pause;
-(void)resume;
-(void)close;

@end
