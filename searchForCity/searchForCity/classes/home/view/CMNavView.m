//
//  CMNavView.m
//  searchForCity
//
//  Created by mac on 15/11/18.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "CMNavView.h"
@interface CMNavView()
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBack;

@end;
@implementation CMNavView



+(instancetype)navView
{

    CMNavView * navView = [[[NSBundle mainBundle] loadNibNamed:@"CMNavView" owner:nil options:nil] lastObject];
    return navView;
}
- (IBAction)backBtnClick:(id)sender {
    
    NSLog(@"left");
    self.popToCurrentView();
    
}
- (IBAction)shareBtnClick:(id)sender {
    
    NSLog(@"right");
    
}

@end
