//
//  CMHomeTableViewCell.h
//  searchForCity
//
//  Created by mac on 15/11/17.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMHomeCellItem.h"
@interface CMHomeTableViewCell : UITableViewCell

@property(nonatomic, strong) CMHomeCellItem * item;

+(instancetype)homeTableViewCell:(UITableView *) tableView;
@end
