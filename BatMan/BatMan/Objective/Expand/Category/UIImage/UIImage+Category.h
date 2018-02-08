//
//  UIImage+Category.h
//  Objective
//
//  Created by Bruce on 2017/7/4.
//  Copyright © 2017年 cndotaisbestdota. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)
/**
 *  @brief  根据颜色生成纯色图片
 *
 *  @param color 颜色
 *
 *  @return 纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  @brief  取图片某一点的颜色
 *
 *  @param point 某一点
 *
 *  @return 颜色
 */
- (UIColor *)colorAtPoint:(CGPoint )point;

/**
 压缩后的图片

 @param image .
 @param scale .
 @return .
 */
+ (UIImage *)scaleImage:(UIImage *)image sclae:(CGFloat)scale;

/**
 *  @brief  截图指定view成图片
 *
 *  @param view 一个view
 *
 *  @return 图片
 */

+ (UIImage *)captureWithView:(UIView *)view;

/**
 *  @brief  根据bundle中的文件名读取图片
 *
 *  @param name 图片名
 *
 *  @return 无缓存的图片
 */
+ (UIImage *)imageWithFileName:(NSString *)name;


/**
 *  @brief  合并两个图片
 *
 *  @param firstImage  一个图片
 *  @param secondImage 二个图片
 *
 *  @return 合并后图片
 */
+ (UIImage*)mergeImage:(UIImage*)firstImage withImage:(UIImage*)secondImage;
/**
 *  @brief  修正图片的方向
 *
 *  @param srcImg 图片
 *
 *  @return 修正方向后的图片
 */
+ (UIImage *)fixOrientation:(UIImage *)srcImg;
/**
 *  @brief  旋转图片
 *
 *  @param degrees 角度
 *
 *  @return 旋转后图片
 */
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

/**
 *  @brief  旋转图片
 *
 *
 *  @return 旋转后图片
 */
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;

/**
 *  @brief  垂直翻转
 *
 *  @return  翻转后的图片
 */
- (UIImage *)flipVertical;
/**
 *  @brief  水平翻转
 *
 *  @return 翻转后的图片
 */
- (UIImage *)flipHorizontal;

/**
 *  @brief  角度转弧度
 *
 *  @param degrees 角度
 *
 *  @return 弧度
 */
+(CGFloat)degreesToRadians:(CGFloat)degrees;
/**
 *  @brief  弧度转角度
 *
 *  @param radians 弧度
 *
 *  @return 角度
 */
+(CGFloat)radiansToDegrees:(CGFloat)radians;

/**
 图片裁剪

 @param image 图片的size
 @param size imageView的size
 @param rect 裁剪区域
 @return 图片
 */
+ (UIImage *)cutImage:(UIImage *)image
        imageViewSize:(CGSize)size
             clipRect:(CGRect)rect;

// iOS 获取本地视频的缩略图
+ (UIImage *)getImage:(NSString *)videoURL;

/*
*压缩原图获得小于某个M为单位大小的新图片
*/
+(UIImage *)getNewImageFromImage:(UIImage *)image LessThanMB:(CGFloat)mb;

//UIImage等比例缩放
+(UIImage *)scaleImage:(UIImage *)image toScale:(CGFloat)scaleSize;
@end
