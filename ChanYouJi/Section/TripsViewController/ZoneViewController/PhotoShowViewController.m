//
//  PhotoShowViewController.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "PhotoShowViewController.h"
#import "UIImageView+WebCache.h"

#define SCREENWIDE [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGTH [UIScreen mainScreen].bounds.size.height
@interface PhotoShowViewController () <UIScrollViewDelegate>

@property (nonatomic ,retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIImageView *photoImage;
@property (nonatomic)  CGFloat offset;


@end

@implementation PhotoShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
    self.view.backgroundColor = [UIColor blackColor];
    self.offset = self.pictureCount * SCREENWIDE;
    [self.view addSubview:self.scrollView];
    
}
// 点击事件
- (void)tapAction:(UITapGestureRecognizer *)tap{
    [self dismissViewControllerAnimated:NO completion:nil];
}
// 创建scrollView

- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame)*self.photoArray.count, CGRectGetHeight(_scrollView.frame));
        _scrollView.contentOffset = CGPointMake(self.pictureCount * SCREENWIDE, 0);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.tag = 1;
        _scrollView.delegate = self;
        
        for (int i = 0; i < self.photoArray.count; i ++) {
            UIImageView *imageView = self.photoArray[i];
            
            UIScrollView *imageZoom = [[UIScrollView alloc] initWithFrame:CGRectMake(i * CGRectGetWidth(self.view.frame), 0, CGRectGetWidth(imageView.frame), CGRectGetHeight(self.view.frame))];
            imageZoom.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame));
            imageZoom.tag = 2;
            imageZoom.delegate = self;
            imageZoom.minimumZoomScale = 1.0;
            imageZoom.maximumZoomScale = 3.0;
            
            [imageZoom addSubview:imageView];
            [_scrollView addSubview:imageZoom];
        }
    }
    return _scrollView;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    if (scrollView.tag == 2) {
        for (UIImageView *imageView in scrollView.subviews) {
            return imageView;
        }
        return nil;
    }
    return nil;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.tag == 1) {
        if (self.offset != scrollView.contentOffset.x) {
            for (UIScrollView *iamgeZoom in scrollView.subviews) {
                [UIView animateWithDuration:0.3 animations:^{
                    iamgeZoom.zoomScale = 1.0;
                }];
            }
            self.offset = scrollView.contentOffset.x;
        }
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    if (scrollView.tag == 2) {
        for (UIView *view in scrollView.subviews) {
            view.center = [self centerOfScrollViewContent:scrollView];
        }
    }
}

- (CGPoint)centerOfScrollViewContent:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    CGPoint actualCenter = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                       scrollView.contentSize.height * 0.5 + offsetY);
    return actualCenter;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
