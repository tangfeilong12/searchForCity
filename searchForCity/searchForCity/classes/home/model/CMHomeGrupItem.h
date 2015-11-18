//
//  CMHomeGrupItem.h
//  searchForCity
//
//  Created by mac on 15/11/17.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMHomeGrupItem : NSObject
@property(nonatomic, copy) NSString *color;
@property(nonatomic, copy) NSString *tag_name;
@property(nonatomic, copy) NSString *section_count;
@property(nonatomic, strong) NSArray *body;
@end
