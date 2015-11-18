//
//  CMTopPicturesView.m
//  searchForCity
//
//  Created by mac on 15/11/18.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "CMTopPicturesView.h"
@interface CMTopPicturesView()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageCTR;

@property (strong, nonatomic) NSMutableArray *pictureArray;

@property (weak, nonatomic) NSTimer * timer;
@end

@implementation CMTopPicturesView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    //1.基本设置操作
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    //2.添加定时器，自动切换图片
    [self startTime];

}
/**
*  懒加载
*
*  @return
*/
-(NSMutableArray *)pictureArray
{

    if (_pictureArray == nil) {
        
        _pictureArray = [NSMutableArray array];

    }

    return _pictureArray;
}
/**
 *  构造方法
 *
 *  @return <#return value description#>
 */
+(instancetype)topPictureView
{

    CMTopPicturesView *topView = [[[NSBundle mainBundle] loadNibNamed:@"CMTopPictureView" owner:nil options:nil] lastObject];

    return topView;
}
/**
 *  翻到下一页图片
 */
-(void)nextPage
{

    NSInteger currentIndex = self.pageCTR.currentPage;
    
    NSInteger nextIndex = currentIndex + 1;
    
    NSInteger count = self.imagesArray.count;
    
    if (nextIndex >= count) {
        
        nextIndex = 0;
        
    }
    self.pageCTR.currentPage = nextIndex;
    self.scrollView.contentOffset = CGPointMake(self.pageCTR.currentPage*self.widthM, 0);
}

/**
 *  开始时间
 */
-(void)startTime
{
    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    self.timer =time;
    [[NSRunLoop mainRunLoop] addTimer:time forMode:NSRunLoopCommonModes];

}
/**
 *  暂停时间
 */
-(void)stopTime
{

    [self.timer invalidate];
    
    self.timer = nil;

}

-(void)setImagesArray:(NSArray *)imagesArray
{
    //1.赋值变量
    _imagesArray = imagesArray;
    
    //2.添加图片到scrollview中去，并设置相关信息
    [self setupImagesToScrollView:imagesArray];

}
/**
 *  添加图片到scrollview中去
 *
 *  @param imagesArray
 */
-(void)setupImagesToScrollView:(NSArray *) imagesArray
{
    
    //1.将imageview添加到scrollview中去
    NSInteger count = imagesArray.count;
    
    for (int i = 0 ; i < count; i ++) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.image = [UIImage imageNamed:imagesArray[i]];
        [self.scrollView addSubview:imageV];
        
    }
    //2.设置好pagecontrol
    self.pageCTR.numberOfPages = count;
    
    
}
/**
 *  设置标点的颜色
 *
 *  @param indexColor
 */
-(void)setIndexColor:(UIColor *)indexColor
{

    self.pageCTR.pageIndicatorTintColor = indexColor;

}
/**
 *  设置选中的标点的颜色
 *
 *  @param currentIndexColor
 */
-(void)setCurrentIndexColor:(UIColor *)currentIndexColor
{

    self.pageCTR.currentPageIndicatorTintColor = currentIndexColor;
}
/**
 *  更改pagecontrol的index图标
 *
 *  @param indexImage <#indexImage description#>
 */
-(void)setIndexPicture:(UIImage *)indexImage
{


    [self.pageCTR setValue:indexImage forKey:@"_pageImage"];
    
}
/**
 *  更改pagecontrol的当前选中的index图标
 *
 *  @param currentIndexImage
 */
-(void)setCurrentIndexPicture:(UIImage *)currentIndexImage
{

    [self.pageCTR setValue:currentIndexImage forKey:@"_currentPageImage"];
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    //1.设置scrollview的frame值
    NSInteger count = self.imagesArray.count;
    self.scrollView.contentSize = CGSizeMake(self.widthM*count, self.heightM);
    self.scrollView.frame = self.bounds;
    
    //2.设置pagecontrol的frame值
    CGFloat pageW = 80;
    CGFloat pageH = 20;
    CGFloat PageX = self.widthM - pageW -10;
    CGFloat PageY = self.heightM -pageH -10;
    self.pageCTR.frame = CGRectMake(PageX, PageY, pageW, pageH);
    
    //3.设置内部所有图片的frame值
    CGFloat pictureY = 0;
    CGFloat pictureW = self.widthM;
    CGFloat pictureH = self.heightM;
    
    for (int i = 0; i < count; i++) {
        CGFloat pictureX = i * pictureW;
        
        UIImageView * imageV = self.scrollView.subviews[i];
        
        imageV.frame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
 
    }

}
#pragma mark - scrollviewdelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    //1.算出当前在第几页
    CGFloat offX = scrollView.contentOffset.x;
    
    NSInteger indexPage =  (offX + self.widthM*0.5)/self.widthM;
    
    //2.改变pagecontrol显示的页码数
    self.pageCTR.currentPage = indexPage;

}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{

    [self stopTime];

}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

    [self startTime];

}

@end
