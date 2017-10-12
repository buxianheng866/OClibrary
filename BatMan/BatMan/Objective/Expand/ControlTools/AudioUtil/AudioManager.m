//
//  AudioManager.m
//  Objective
//
//  Created by Bruce on 2017/7/5.
//  Copyright © 2017年 cndotaisbestdota. All rights reserved.
//

#import "AudioManager.h"
static AudioManager *manager = nil;

@implementation AudioManager
+(instancetype)sharedInstance{
    if (manager == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            manager = [[AudioManager alloc] init];
        });
    }
    return manager;
}

-(instancetype)init{
    if (self = [super init]) {
        [self setupProximitySensor];
        [self registerNotifications];
        
    }
    return self;
}

- (void)registerNotifications
{
    [self unregisterNotifications];
    if (_isSupportProximitySensor) {
        static NSString *notif = @"UIDeviceProximityStateDidChangeNotification";
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(sensorStateChanged:)
                                                     name:notif
                                                   object:nil];
    }
}

- (void)unregisterNotifications {
    if (_isSupportProximitySensor) {
        static NSString *notif = @"UIDeviceProximityStateDidChangeNotification";
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:notif
                                                      object:nil];
    }
}

- (void)setupProximitySensor
{
    UIDevice *device = [UIDevice currentDevice];
    [device setProximityMonitoringEnabled:YES];
    _isSupportProximitySensor = device.proximityMonitoringEnabled;
    if (_isSupportProximitySensor) {
        [device setProximityMonitoringEnabled:NO];
    } else {
        
    }
}

- (int)currentRecordTime
{
    NSDate *date = [NSDate date];
    int numer = (int)[date timeIntervalSinceDate:self->_recorderStartDate];
    return numer;
}


@end
