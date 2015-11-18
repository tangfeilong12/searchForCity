//
//  CMLeftViewController.m
//  searchForCity
//
//  Created by mac on 15/11/16.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "CMLeftViewController.h"
#import "CMLeftButton.h"

@interface CMLeftViewController ()
@property (weak, nonatomic) IBOutlet UIButton *testBtn;
@property (weak, nonatomic) IBOutlet UIView *middle;

@property (weak, nonatomic) IBOutlet UIView *bottom;
@property (weak, nonatomic) IBOutlet UIView *top;

@property (weak, nonatomic) UIButton * selectedBtn;
//用来装所有的按钮数组
@property(nonatomic, strong) NSArray * btnArray;

@end

@implementation CMLeftViewController
/**
 *  懒加载数组，获得所有按钮
 *
 *  @return
 */
-(NSArray *)btnArray
{
    if (_btnArray == nil) {
        
        NSMutableArray * temp = [NSMutableArray array];
        
        [temp addObjectsFromArray:[self searchForBtn:self.top]];
        
        [temp addObjectsFromArray:[self searchForBtn:self.middle]];
        
        [temp addObjectsFromArray:[self searchForBtn:self.bottom]];
        
        _btnArray = temp;
        //给按钮绑定枚举值
        for (int i = 0; i < temp.count; i++) {
            
             UIButton * btn = temp[i];
            
             btn.tag = i;
            
        }
        
    }
    
    return _btnArray;
}
/**
 *  获得传入view的所有按钮的数组
 *
 *  @param currentView
 *
 *  @return
 */
-(NSArray *)searchForBtn:(UIView *) currentView
{
     NSMutableArray * temp = [NSMutableArray array];
    
    for (int i = 0; i < currentView.subviews.count; i++) {
        
        UIButton * btn = currentView.subviews[i];
        NSLog(@"%@",btn.currentTitle);
        if ([btn isKindOfClass:[UIButton class]]) {
            
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
            
            
            [temp addObject:btn];
        }
        
    }
    
    return temp;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.btnArray;
    
    [self.testBtn sizeToFit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
-(void)btnClick:(UIButton *)btn
{
    
    if ([self.delegate respondsToSelector:@selector(leftView:from:to:)]) {
        
        [self.delegate leftView:self from:self.selectedBtn.tag to:btn.tag];
        
    }
    //1.设置选中按钮
    self.selectedBtn.selected = NO;
    
    btn.selected = YES;
    
    self.selectedBtn = btn;
    

}
@end
