//
//  FileManager.h
//  Objective
//
//  Created by Bruce on 2017/7/4.
//  Copyright © 2017年 cndotaisbestdota. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
@interface FileManager : NSObject
#pragma mark 路劲操作

 // 生成路劲
+ (NSString *)pathInCacheDirectoryWithfileName:(NSString *)filName;


//删除APP沙盒暂存的文件
+ (BOOL)deleteCacheWithName:(NSString *)fileName;

//把图片先写入到APP沙盒暂存
+ (BOOL)writeUploadDataWithName:(NSString *)fileName andImage:(UIImage *)image;

#pragma mark 文件操作




// 计算单个文件大小
- (float)fileSizeAtPath:(NSString *)path;


// 总磁盘大小

- (long long)getTotalDiskSize;

/**
 清除所有
 */
- (void)cleanAllData;


// 获取当前设备可用内存(单位：MB）
- (double)availableMemory;

// 获取当前任务所占用的内存（单位：MB）
- (double)usedMemory;


/**
 清除所有cookie
 */
- (void)clearAllCookies;

/**
  SDWebImage clean
 */
- (void)cleanCacheImage;

/**
 SDWebimage

 @return ..
 */
- (float)getCacheImage;


@end
