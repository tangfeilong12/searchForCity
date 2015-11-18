//
//  CMNavViewController.m
//  searchForCity
//
//  Created by mac on 15/11/16.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "CMNavViewController.h"

@interface CMNavViewController ()

@end

@implementation CMNavViewController

+(void)initialize
{



}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"recomend_btn_gone"] forBarMetrics:UIBarMetricsDefault];
    
//    self.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
