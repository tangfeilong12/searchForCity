//
//  CMHomeDetailViewController.m
//  searchForCity
//
//  Created by mac on 15/11/18.
//  Copyright © 2015年 mac. All rights reserved.
//


#define pictureViewH 200
#define selectionViewH 44
#define footerViewH 44
#define insertHeaderH (pictureViewH+selectionViewH)
#define insertFooterH footerViewH
#define navViewH 64

#import "CMHomeDetailViewController.h"
#import "CMNavView.h"
#import "CMTopPicturesView.h"
#import "CMSectionView.h"
@interface CMHomeDetailViewController()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, weak) UITableView *detailTableView;
@end
@implementation CMHomeDetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    //0.自己来调动切入,同时用动画隐藏导行栏
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //1.创建所有子控件
    [self setupAllchilds];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    //防止拖动一下就出现导航条的情况
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

/**
 *  创建所有子控件
 */
-(void)setupAllchilds
{

    //1.创建tableView
    UITableView * detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    self.detailTableView = detailTableView;
    detailTableView.contentInset = UIEdgeInsetsMake(insertHeaderH, 0, insertFooterH, 0);
    detailTableView.contentOffset = CGPointMake(0,-insertHeaderH);
    detailTableView.scrollIndicatorInsets = detailTableView.contentInset;
    detailTableView.delegate = self;
    detailTableView.dataSource = self;
    [self.view addSubview:detailTableView];
    
    //2.创建头部图片
    CMTopPicturesView * pictureView = [CMTopPicturesView topPictureView];
    pictureView.imagesArray = @[@"img_00",@"img_01",@"img_02",@"img_03",@"img_04"];
    pictureView.backgroundColor = [UIColor redColor];
    [self.view addSubview:pictureView];
    
    
    
    //3.创建头部选择卡
//    UIView * selectionView = [[UIView alloc] init];
    CMSectionView *selectionView = [CMSectionView sectionView];
//    selectionView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:selectionView];
    
    //4.创建尾部选择卡
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:footerView];
    
    //5.自定义导行条
    CMNavView * navView = [CMNavView navView];
    navView.backgroundColor = CMColor(49, 192, 152, 0.8);
    __unsafe_unretained typeof(self) detailCtr = self;
    navView.popToCurrentView = ^{
    
        [detailCtr.navigationController popViewControllerAnimated:YES];
    
    };
    [self.view addSubview:navView];
    
    
    //6.布局所有子控件
    [pictureView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.equalTo(pictureViewH);
    }];
    
    
    [selectionView makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.top.equalTo(pictureView.bottom);
        make.height.equalTo(selectionViewH);
        
    }];
    
    [footerView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.bottom.equalTo(self.view.bottom);
        make.height.equalTo(footerViewH);

    }];
    
    [detailTableView makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.bottom.equalTo(self.view.bottom);
        make.top.equalTo(self.view.top);
    }];
    
    [navView makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.top.equalTo(self.view.top);
        make.height.equalTo(navViewH);

    }];
}

#pragma mark - uitableview代理方法和数据源方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    
    return cell;
}
@end

