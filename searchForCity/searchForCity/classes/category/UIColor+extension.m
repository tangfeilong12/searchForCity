//
//  UIColor+extension.m
//  searchForCity
//
//  Created by mac on 15/11/17.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "UIColor+extension.h"

@implementation UIColor (extension)

+(instancetype)colorWithString:(NSString *) colorString alpha:(CGFloat) alpha
{

    //1.去掉字符串两端的空格
    NSCharacterSet * set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *str = [[colorString stringByTrimmingCharactersInSet:set] uppercaseString];
    
    //2.将rgb的值放入数组中去
    NSMutableArray * colorArray = [NSMutableArray array];
    for (int i = 0; i< 3; i++) {
        
        NSRange range = NSMakeRange(i*2, 2);
        
        [colorArray addObject:[str substringWithRange:range]];
        
    }
    //3.获得字符串转成整形
    NSInteger r;
    NSInteger g;
    NSInteger b;
    [[NSScanner scannerWithString:colorArray[0]] scanInteger:&r];
    
    [[NSScanner scannerWithString:colorArray[1]] scanInteger:&g];
    
    [[NSScanner scannerWithString:colorArray[2]] scanInteger:&b];

    return CMColor(r, g, b, alpha);
}


@end
