//
//  CMHomeSectionHeader.h
//  searchForCity
//
//  Created by mac on 15/11/17.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMHomeGrupItem.h"
@interface CMHomeSectionHeader : UITableViewHeaderFooterView

@property(nonatomic, strong) CMHomeGrupItem * groupItem;

+(instancetype)homeSectionHeader:(UITableView *) tableView;
@end
