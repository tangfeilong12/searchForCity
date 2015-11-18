//
//  CMHomeTableViewCell.m
//  searchForCity
//
//  Created by mac on 15/11/17.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "CMHomeTableViewCell.h"
#import "CMLeftViewController.h"
#import "UIImageView+WebCache.h"

@interface CMHomeTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageBack;

@property (weak, nonatomic) IBOutlet UILabel *detailAddress;
@property (weak, nonatomic) IBOutlet UILabel *loveLabel;

@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;

@end


@implementation CMHomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 *  从xib中加载我们需要的定制cell。
 *
 *  @param tableView
 *
 *  @return
 */

+(instancetype)homeTableViewCell:(UITableView *) tableView
{
    NSString * ID = @"homeCell";
    CMHomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {

        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CMHomeTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

-(void)setItem:(CMHomeCellItem *)item
{

    _item = item;
    
    [self.imageBack sd_setImageWithURL:[NSURL URLWithString:item.imageURL] placeholderImage:[UIImage imageNamed:@"EXP_likeList_backImage6"]];
    
    self.detailAddress.text = item.poi_name;
    self.introduceLabel.text = item.section_title;
    self.loveLabel.text = item.fav_count;

}

@end
