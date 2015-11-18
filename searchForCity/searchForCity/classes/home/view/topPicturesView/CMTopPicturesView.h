//
//  CMTopPicturesView.h
//  searchForCity
//
//  Created by mac on 15/11/18.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMTopPicturesView : UIView
/**
 *  传入图片的数组
 */
@property(nonatomic, strong) NSArray *imagesArray;
/**
 *  设置标点的颜色
 */
@property(nonatomic, strong) UIColor *indexColor;
/**
 *  设置选中的标点的颜色
 */
@property(nonatomic, strong) UIColor *currentIndexColor;
/**
 *  更改pagecontrol的index图标
 */
@property(nonatomic, strong) UIImage *indexImage;
/**
 *  更改pagecontrol的当前选中的index图标
 */
@property(nonatomic, strong) UIImage *currentIndexImage;

+(instancetype)topPictureView;
@end
