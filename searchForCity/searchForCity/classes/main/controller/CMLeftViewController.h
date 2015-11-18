//
//  CMLeftViewController.h
//  searchForCity
//
//  Created by mac on 15/11/16.
//  Copyright © 2015年 mac. All rights reserved.
//

typedef enum{
    leftViewBtnCity = 0,
    leftViewBtnHome,
    leftViewBtnSearch,
    leftViewBtnLogin,
    leftViewBtnSina,
    leftViewBtnWeiXin,
    leftViewBtnMessage,
    leftViewBtnSetting
} leftViewBtnType;

#import <UIKit/UIKit.h>
#import "CMHomeTableViewCell.h"
@class CMLeftViewController;
@protocol CMLeftViewDelegate <NSObject>
@required
-(void)leftView:(CMLeftViewController *) leftViewCtr from:(NSInteger) fromIndex to:(NSInteger) toIndex;
@end
@interface CMLeftViewController : UIViewController

@property(nonatomic, weak) id<CMLeftViewDelegate> delegate;

@end
