//
//  CMHomeSectionHeader.m
//  searchForCity
//
//  Created by mac on 15/11/17.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "CMHomeSectionHeader.h"

@interface CMHomeSectionHeader()

@property (weak, nonatomic)  UILabel *titleLabel;

@property (weak, nonatomic)  UILabel *detailLabel;

@property (nonatomic, weak)  UIImageView *accessoryImage;


@end
@implementation CMHomeSectionHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)homeSectionHeader:(UITableView *)tableView
{
    NSString * ID = @"homeSecionHeader";
    CMHomeSectionHeader * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (header == nil) {
        
        
        header = [[CMHomeSectionHeader alloc] initWithReuseIdentifier:ID];
        
    }

    return header;
}
/**
 *  初始化头部view中的所有子控件
 *
 *  @param reuseIdentifier
 *
 *  @return
 */
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    self.contentView.backgroundColor = [UIColor redColor];
    if (self) {
        
        //1.添加子控件
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel = titleLabel;
        [self.contentView addSubview: titleLabel];
        
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.textColor = [UIColor whiteColor];
        self.detailLabel = detailLabel;
        [self.contentView addSubview:detailLabel];
        
        UIImageView *accessoryImage = [[UIImageView alloc] init];
        self.accessoryImage = accessoryImage;
        [self.contentView addSubview:accessoryImage];
        
        
        //2.布局子控件
        [titleLabel makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView.left).offset(10);
            make.centerY.equalTo(self.contentView.centerY);
            
        }];
        
        [accessoryImage makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.contentView.right).offset(-10);
            make.width.equalTo(46);
            make.height.equalTo(36);
            make.centerY.equalTo(self.contentView.centerY);
            
        }];
        
        [detailLabel makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.accessoryImage.left).offset(-5);
            make.centerY.equalTo(self.contentView.centerY);
            
        }];
        
    }

    return self;
}
/**
 *  给头部view设置属性值
 *
 *  @param groupItem <#groupItem description#>
 */
-(void)setGroupItem:(CMHomeGrupItem *)groupItem
{

    _groupItem = groupItem;
    
    self.titleLabel.text = groupItem.tag_name;
    
    self.detailLabel.text = groupItem.section_count;
    
    self.accessoryImage.image = [UIImage imageNamed:@"taoge"];
    
    self.contentView.backgroundColor = [UIColor colorWithString:groupItem.color alpha:1];
}


@end
