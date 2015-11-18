//
//  CMSectionView.m
//  searchForCity
//
//  Created by mac on 15/11/18.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "CMSectionView.h"
@interface CMSectionView()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *slideLineCentX;

@property (weak, nonatomic) IBOutlet UIButton *inforBtn;

@property (weak, nonatomic) IBOutlet UIButton *recoBtn;

@property (weak, nonatomic) IBOutlet UIView *slideLine;

@end
@implementation CMSectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)sectionView
{

    CMSectionView *sectionView = [[[NSBundle mainBundle] loadNibNamed:@"CMSectionView" owner:nil options:nil] lastObject];

    return sectionView;
}


-(void)awakeFromNib
{


    self.translatesAutoresizingMaskIntoConstraints = NO;

}
/**
 *  点击按钮实现slideline的动画效果
 *
 *  @param btn
 */
- (IBAction)btnClick:(UIButton *) btn {
        //1.删除原来的约束
        [self removeConstraint:self.slideLineCentX];
    
        //2.添加新的约束
         NSLayoutConstraint *con = [NSLayoutConstraint constraintWithItem:self.slideLine attribute:(NSLayoutAttributeCenterX) relatedBy:NSLayoutRelationEqual toItem:btn attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
        [self addConstraint:con];
        self.slideLineCentX = con;
        //3.实现动画效果
        [UIView animateWithDuration:1 animations:^{
            
            [self layoutIfNeeded];
            
        }];

}


@end
