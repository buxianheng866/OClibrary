//
//  FileManager.m
//  Objective
//
//  Created by Bruce on 2017/7/4.
//  Copyright © 2017年 cndotaisbestdota. All rights reserved.
//

#import "FileManager.h"
#import <sys/param.h>
#import <sys/mount.h>
#include <sys/types.h>
#include <sys/stat.h>
#import <sys/sysctl.h>
#import <mach/mach.h>
@implementation FileManager

#pragma mark 路劲操作


+ (NSString *)pathInCacheDirectoryWithfileName:(NSString *)filName
{
    NSString *path = [self pathInCacheDirectory:filName];
    
    if ([self createFolder:path])
    {
        return path;
    }
    
    return nil;
}

+ (NSString* )pathInCacheDirectory:(NSString *)fileName
{
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cachePaths objectAtIndex:0];
    return [cachePath stringByAppendingPathComponent:fileName];
}





+ (BOOL)writeUploadDataWithName:(NSString *)fileName andImage:(UIImage *)image{
    
    NSString *filePath = [self pathInCacheDirectoryWithfileName: fileName];
    
    return [UIImageJPEGRepresentation(image, 1.0) writeToFile:filePath options:NSAtomicWrite error:nil];
}

+ (BOOL)deleteCacheWithName:(NSString *)fileName{
    NSString *filePath = [self pathInCacheDirectoryWithfileName: fileName];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:filePath]) {
        return [fm removeItemAtPath:filePath error:nil];
    }else{
        return YES;
    }
}


+ (BOOL)createFolder:(NSString *)path{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    BOOL isCreated = NO;
    if (!(isDir == YES && existed == YES)){
        isCreated = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }else{
        isCreated = YES;
    }
    return isCreated;
}

#pragma mark 文件操作

- (float)fileSizeAtPath:(NSString *)path{
    struct stat st;
    if(lstat([path cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0){
        return (float)st.st_size/1024/1024;
    }
    return 0;
}
- (void)cleanAllData
{
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                       NSArray *file = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       NSLog(@"files :%lu",(unsigned long)[file count]);
                       for (NSString *p in file) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
}
- (void)clearCacheSuccess
{
    
}

-(long long)getTotalDiskSize // 总磁盘
{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0)
    {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_blocks);
    }
    return freeSpace / 1024 / 1024 / 1024;
}

- (float)getCacheImage {

    float size =(float)[[SDImageCache sharedImageCache] getSize];
    size = size / 1024.0 / 1024.0;
    return size;
}
- (void)cleanCacheImage {
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        
    }];
}


// 获取当前设备可用内存(单位：MB）
- (double)availableMemory
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0;
}

// 获取当前任务所占用的内存（单位：MB）
- (double)usedMemory
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    
    return taskInfo.resident_size / 1024.0 / 1024.0;
}

- (void)clearAllCookies{
    NSURL *url = [NSURL URLWithString:@"API_HOST"];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url];
    for (int i = 0; i < [cookies count]; i++) {
        NSHTTPCookie *cookie = (NSHTTPCookie *)[cookies objectAtIndex:i];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        
    }
}




@end
