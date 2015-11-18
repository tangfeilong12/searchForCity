//
//  CMMainViewController.m
//  searchForCity
//
//  Created by mac on 15/11/16.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "CMMainViewController.h"
#import "CMLeftViewController.h"
#import "CMHomeTableViewController.h"
#import "CMDiscoverTableViewController.h"
#import "CMNavViewController.h"
#import "CMCityViewController.h"


#define maxY 50.0
#define maxX ([UIScreen mainScreen].bounds.size.width - 50.0)
#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH  [UIScreen mainScreen].bounds.size.height
@interface CMMainViewController ()<CMLeftViewDelegate>

@property(nonatomic, weak) UIViewController * showIngCTR;
@property(nonatomic, weak) UIView * showIngView;
@property(nonatomic, assign) CGFloat zoomScale;
//判断是不是处于收缩状态
@property(nonatomic, assign) BOOL isZoom;
//引用当前遮盖
@property(nonatomic, weak) UIButton * btnMask;
@end

@implementation CMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        self.view.backgroundColor = [UIColor grayColor];
   
    //1.设置左侧菜单栏
    [self setupLeftMenu];
    
    //2.创建主窗口的各子控制器
    [self setupAllChild];
    
    //3.添加手势识别器，实现侧滑效果
    [self setupGestureForMainView];

}
/**
 *  设置左侧菜单栏
 */
-(void)setupLeftMenu
{
    
    //1.创建左侧栏的控制器
    CMLeftViewController * ctr = [[CMLeftViewController alloc] init];
    UIView *leftView = ctr.view;
    ctr.delegate = self;
    [self.view addSubview: leftView];
    [self addChildViewController:ctr];
    
    
    
    //2.设置左侧栏view的布局
    [leftView makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.left);
        
        make.top.equalTo(self.view.top);
        
        make.bottom.equalTo(self.view.bottom);
        
        make.right.equalTo(self.view.right).offset(-50);
    }];

}
/**
 *  创建所有子控制器
 */
-(void)setupAllChild
{

    //0.城市选择控制器
    CMCityViewController * cityCTR = [[CMCityViewController alloc] init];
    [self createOneCtr:cityCTR];
    
    
    //1.主页子控制器
    CMHomeTableViewController * homeCTR = [[CMHomeTableViewController alloc] init];
    [self createOneCtr:homeCTR];

    
    //2.发现子控制器
    CMDiscoverTableViewController *discoverCTR = [[CMDiscoverTableViewController alloc] init];
    [self createOneCtr:discoverCTR];
}
/**
 *  创建一个子控制器
 */
-(void)createOneCtr:(UIViewController *) ctr
{

    CMNavViewController * nav = [[CMNavViewController alloc] initWithRootViewController:ctr];
    
    ctr.navigationItem.leftBarButtonItem =[UIBarButtonItem barButtonItem:@"artcleList_btn_info_6P" target:self sel:@selector(navLeftBtnClick:)];
    
    //子控制器数组中已经有了侧边栏控制器，因此这里要等于1,将首页控制器的页面放在主页上显示
    if (self.childViewControllers.count == 2) {

        [self.view addSubview:nav.view];
        self.showIngView = nav.view;
    }
    
    [self addChildViewController:nav];

}
/**
 *  导行控制器的左边按钮
 *
 *  @param btn
 */
-(void)navLeftBtnClick:(UIButton *)btn
{

    
    NSLog(@"leftbtn");
    if (self.isZoom == 0) {
        
        [self viewToMaxTranslattion];
    }else{
    
        [self viewToMinTranslation];
    }
}
/**
 *  创建手势实现抽屉效果
 */
-(void)setupGestureForMainView
{

    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(infactPanTransForm:)];
    
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    
    
    [self.view addGestureRecognizer:pan];
//    [self.view addGestureRecognizer:tap];
}
-(void)tapAction:(UITapGestureRecognizer *) tap
{


    NSLog(@"---------");

}
/**
 *  托动手势调用的方法，用来实现抽屉效果
 *
 *  @param pan
 */
-(void)infactPanTransForm:(UIPanGestureRecognizer *) pan
{
    

    //0.通过手势得到当前的x值的偏移量
    CGFloat offX = [pan translationInView:pan.view].x;
    
    //1.计算出最新显示的showingview的frame，然后在判断边界情况，进行归位操作
    CGRect currentRect = [self showingViewForFrame:offX];
    
    if (currentRect.origin.x > maxX || currentRect.origin.x < 0) {
        
        [self gestureRecognizerStateEndedForAction];
        
        return;
    }

    //2.通过计算出的数据，直接作用于showingview的transform属性值
    self.showIngView.transform = CGAffineTransformTranslate(self.showIngView.transform, offX, 0);
    self.showIngView.transform = CGAffineTransformScale(self.showIngView.transform, self.zoomScale, self.zoomScale);
    NSLog(@"=====");
    
    [pan setTranslation:CGPointZero inView:pan.view];
    
    //3.松手后要进行归位操作
    if (pan.state == UIGestureRecognizerStateEnded) {
    
        [self gestureRecognizerStateEndedForAction];
    }
}
/**
 *  对当前的显示的view进行归位操作，归位到最初位置，还是归位到最大位置
 */
-(void)gestureRecognizerStateEndedForAction
{

    if (self.showIngView.frame.origin.x > screenW*0.5) {
        
        [self viewToMaxTranslattion];
       
    }else {
        
        [self viewToMinTranslation];
    }
}
/**
 *  当前显示的view定位到最大值
 */
-(void)viewToMaxTranslattion
{

    CGFloat scale = (screenH - maxY*2)/screenH;
    
    CGFloat width = screenW*scale;
    
    CGFloat padding = (screenW - width)*0.5;
    
    CGFloat offX = maxX - padding;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.showIngView.transform = CGAffineTransformMakeScale(scale, scale);
        self.showIngView.transform = CGAffineTransformTranslate(self.showIngView.transform, offX/scale, 0);
    } completion:^(BOOL finished) {
        
        //添加一个遮盖
        self.isZoom = YES;
        
        [self addMaskToShowingView];
        
    }];


}
/**
 *  当前显示的view定位到最原始的初始位置
 */
-(void)viewToMinTranslation
{

    [UIView animateWithDuration:0.5 animations:^{
        
        self.showIngView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        //删除一个遮盖
        self.isZoom = NO;
        
        [self removeMaskBtnFromShowingView];
        
    }];

}
/**
 *  添加遮盖到当前显示的view上去
 */
-(void)addMaskToShowingView
{
    
    if (self.btnMask) {
        return;
    }
    //1.创建一个遮盖
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
    CGRect rect = self.showIngView.bounds;
    btn.frame = rect;
    btn.backgroundColor = CMColor(36, 153, 190, 0.5);
    self.btnMask = btn;
    //2.设置按钮点击事件
    [btn addTarget:self action:@selector(viewToMinTranslation) forControlEvents:UIControlEventTouchUpInside];
    
    [self.showIngView addSubview:btn];
    
}
/**
 *  移除遮盖
 */
-(void)removeMaskBtnFromShowingView
{

    [self.btnMask removeFromSuperview];
    self.btnMask = nil;

}

/**
 *  计算出在托动过程中当前显示的view的frame值
 *
 *  @param offX
 *
 *  @return
 */
-(CGRect)showingViewForFrame:(CGFloat) offX
{
    
    CGFloat scale = maxY/maxX;
//     NSLog(@"%f====%f",scale,maxX);
    CGFloat offY = scale * offX;
   
    //以前的rect
    CGRect preRect = self.showIngView.frame;
    
    CGFloat preX = preRect.origin.x;
    CGFloat PreY = preRect.origin.y;
    CGFloat preW = preRect.size.width;
    CGFloat preH = preRect.size.height;
    
    //当前的rect
    CGFloat currentY = PreY + offY;
    CGFloat currentH = screenH - currentY*2;
    CGFloat zoomScale = currentH/preH;
    self.zoomScale = zoomScale;
    CGFloat currentX = preX + offX;
    CGFloat currentW = zoomScale * preW;
    
    CGRect currentRect = CGRectMake(currentX, currentY, currentW, currentH);
    return currentRect;
}

#pragma mark - CMLeftViewDelegate代理方法
-(void)leftView:(CMLeftViewController *)leftViewCtr from:(NSInteger)fromIndex to:(NSInteger)toIndex
{

    switch (toIndex) {
        case leftViewBtnCity:
            [self transformMainView:toIndex];
            break;
        case leftViewBtnHome:
            [self transformMainView:toIndex];
            break;
            
        case leftViewBtnSearch:
            NSLog(@"3");
            [self transformMainView:toIndex];
            break;
            
        case leftViewBtnLogin:
        case leftViewBtnSina:
        case leftViewBtnWeiXin:
            NSLog(@"4");
            break;

        case leftViewBtnMessage:
            break;
            
        case leftViewBtnSetting:
            break;

        default:
            break;
    }
}
/**
 *  切换主窗口上的视图控制器
 *
 *  @param toIndex
 */
-(void)transformMainView:(NSInteger) toIndex
{
    
    
    //0.这里我给toindex加一个1,那是因为子控制器数组中有一个侧边栏控制器了
    UIViewController *CTR = self.childViewControllers[toIndex+1];
    //1.判断切换的视图是不是已经显示在main上面了，如果是就不需要做相关操作
    if (self.showIngView == CTR.view) {
        return;
    }
    
    //2.切换mainview上的控制器view
    [self.showIngView removeFromSuperview];
    [self removeMaskBtnFromShowingView];
    
    [self.view addSubview:CTR.view];
    CTR.view.transform = self.showIngView.transform;
    
    self.showIngView = CTR.view;
    [self addMaskToShowingView];
    
    //3.当前showingview的页面返回到最初始位置
//    [self viewToMinTranslation];

}
@end
