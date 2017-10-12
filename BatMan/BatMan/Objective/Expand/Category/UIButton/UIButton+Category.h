//
//  UIButton+Category.h
//  Objective
//
//  Created by Bruce on 2017/7/4.
//  Copyright © 2017年 cndotaisbestdota. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, JKImagePosition) {
    LXMImagePositionLeft = 0,              //图片在左，文字在右，默认
    LXMImagePositionRight = 1,             //图片在右，文字在左
    LXMImagePositionTop = 2,               //图片在上，文字在下
    LXMImagePositionBottom = 3,            //图片在下，文字在上
};
typedef void (^TouchedBlock)(NSInteger tag);


@interface UIButton (Category)

/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
 *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
 *
 *  @param spacing 图片和文字的间隔
 */
- (void)setImagePosition:(JKImagePosition)postion spacing:(CGFloat)spacing;


/**
 *  @brief  使用颜色设置按钮背景
 *
 *  @param backgroundColor 背景颜色
 *  @param state           按钮状态
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;



/**
 @brief 点击回调block

 @param touchHandler block
 */
-(void)addActionHandler:(TouchedBlock)touchHandler;



/**
 @brief 计时器

 @param timeout 时间
 @param tittle button文字描述
 @param waitTittle 计时文字描述
 */
-(void)startTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle;
@end
