//
//  UIBarButtonItem+extension.m
//  searchForCity
//
//  Created by mac on 15/11/16.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "UIBarButtonItem+extension.h"

@implementation UIBarButtonItem (extension)

+(instancetype)barButtonItem:(NSString *) imageName target :(id) target sel :(SEL)action
{
    //1.设置按钮的信息
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    btn.frame = CGRectMake(0, 0, 20, 20);
    //2.设置barbuttonitem
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return barItem;
}
@end
