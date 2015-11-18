//
//  CMNavView.h
//  searchForCity
//
//  Created by mac on 15/11/18.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMNavView : UIView

//传入点击导行栏按钮后，需要做的相关操作
@property (copy, nonatomic) void (^popToCurrentView)(void);
@property (copy, nonatomic) void (^shareInfor)(void);

+(instancetype)navView;
@end
