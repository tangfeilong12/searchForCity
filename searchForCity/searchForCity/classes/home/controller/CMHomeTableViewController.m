//
//  CMHomeTableViewController.m
//  searchForCity
//
//  Created by mac on 15/11/16.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "CMHomeTableViewController.h"
#import "CMHomeGrupItem.h"
#import "CMHomeCellItem.h"
#import "MJExtension.h"
#import "CMHomeTableViewCell.h"
#import "CMHomeSectionHeader.h"
#import "CMHomeDetailViewController.h"

#define homeHeaderH 80
#define homeCellH 210
@interface CMHomeTableViewController ()
@property(nonatomic, strong) NSArray *homeArray;
@end

@implementation CMHomeTableViewController
/**
 *  懒加载模型数组
 *
 *  @return <#return value description#>
 */
-(NSArray *)homeArray
{

    if (_homeArray == nil) {
        
        NSString * path = [[NSBundle mainBundle] pathForResource:@"HomeDatas.plist" ofType:nil];
        NSArray *temp = [NSArray arrayWithContentsOfFile:path];
        _homeArray =[CMHomeGrupItem objectArrayWithKeyValuesArray:temp];
    }
    return _homeArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    //1.设置导行栏的配制
    [self setupNavInfor];
 
    
}

-(void)setupNavInfor
{
    
    //1.设置左右两边的按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItem:@"search_icon_white_6P@2x" target:self sel:@selector(rightBtnClick:)];

    
    //2.设置头部segment
    [self setupHeadTitleView];
    
}
/**
 *  设置导行栏标题的view
 */
-(void)setupHeadTitleView
{
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"推荐",@"附近"]];
    segment.frame = CGRectMake(0, 0, self.view.bounds.size.width*0.5, 35);
    segment.tintColor = CMColor(26, 163, 146, 1);
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    dic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    segment.selectedSegmentIndex = 0;
    [segment setTitleTextAttributes:dic forState:UIControlStateNormal];
    [segment setTitleTextAttributes:dic forState:UIControlStateSelected];
    self.navigationItem.titleView = segment;
    
    [segment addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];

}

-(void)rightBtnClick:(UIButton *) btn
{
    NSLog(@"right");

}
/**
 *  进行归位操作
 *
 *  @param btn <#btn description#>
 */
-(void)leftBtnClick:(UIButton *) btn
{
    NSLog(@"left");
    
}
/**
 *  头部segment选择按钮
 *
 *  @param segment
 */
-(void)segmentChanged:(UISegmentedControl *) segment
{

    NSLog(@"segment");

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 生命周期方法
-(void)viewWillAppear:(BOOL)animated
{
//这里我用下面的代码不要隐藏导行条没效果，这里并不知道下面两行代码的区别，用最下面那行代码才能将隐藏的条弄出来
//    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillAppear:YES];


}
-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.homeArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    CMHomeGrupItem * groupItem = self.homeArray[section];
    
    NSInteger count = groupItem.body.count;
    
    return count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CMHomeTableViewCell * cell = [CMHomeTableViewCell homeTableViewCell:tableView];
    
    CMHomeGrupItem * groupItem = self.homeArray[indexPath.section];
    CMHomeCellItem * cellItem = groupItem.body[indexPath.row];
    
    cell.item = cellItem;
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return homeCellH;

}
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    CMHomeSectionHeader * head = [CMHomeSectionHeader homeSectionHeader:tableView];
    head.groupItem = self.homeArray[section];
    
    return head;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return homeHeaderH;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    CMHomeDetailViewController * homeDetailCTR = [[CMHomeDetailViewController alloc] init];
    
    [self.navigationController pushViewController:homeDetailCTR animated:YES];
    

}
@end
