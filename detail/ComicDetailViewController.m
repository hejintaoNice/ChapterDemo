//
//  ViewController.m
//  DT
//
//  Created by hejintao on 2017/6/1.
//  Copyright © 2017年 hither. All rights reserved.
//

#import "ComicDetailViewController.h"
#import "DetailSubOneVC.h"
#import "DetailSubTwoVC.h"
#import "DetailSubThreeVC.h"

@interface ComicDetailViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *mainScrollView;
@property (nonatomic,strong) DetailSubOneVC *oneVC;
@property (nonatomic,strong) DetailSubTwoVC *twoVC;
@property (nonatomic,strong) DetailSubThreeVC *threeVC;

@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIButton *centerBtn;
@property (nonatomic,strong) UIButton *rightBtn;

@property (nonatomic,strong) UIView *sliderView;

@end

@implementation ComicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configUI];
    
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _headerView.backgroundColor = [UIColor grayColor];
    }
    return _headerView;
}

-(DetailSubOneVC *)oneVC{
    if (!_oneVC) {
        _oneVC = [[DetailSubOneVC alloc]init];
    }
    return _oneVC;
}

-(DetailSubTwoVC *)twoVC{
    if (!_twoVC) {
        _twoVC = [[DetailSubTwoVC alloc]init];
    }
    return _twoVC;
}

-(DetailSubThreeVC *)threeVC{
    if (!_threeVC) {
        _threeVC = [[DetailSubThreeVC alloc]init];
    }
    return _threeVC;
}


-(UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _mainScrollView.delegate = self;
        _mainScrollView.backgroundColor = [UIColor whiteColor];
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.bounces = NO;
        NSArray *views = @[self.oneVC.view, self.twoVC.view,self.threeVC.view];
        for (int i = 0; i < views.count; i++){
            UIView *pageView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, _mainScrollView.frame.size.width, _mainScrollView.frame.size.height)];
            [pageView addSubview:views[i]];
            [_mainScrollView addSubview:pageView];
        }
        _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * (views.count), 0);
    }
    return _mainScrollView;
}

-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc]init];
        _leftBtn.titleLabel.font = HJTFont(14)
        [_leftBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
        [_leftBtn setTitle:@"左边" forState:UIControlStateNormal];
        _leftBtn.tag = 1;
    }
    return _leftBtn;
}

-(UIButton *)centerBtn{
    if (!_centerBtn) {
        _centerBtn = [[UIButton alloc]init];
        _centerBtn.titleLabel.font = HJTFont(14)
        [_centerBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
        [_centerBtn setTitle:@"中间" forState:UIControlStateNormal];
        _centerBtn.tag = 2;
    }
    return _centerBtn;
}

-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc]init];
        _rightBtn.titleLabel.font = HJTFont(14)
        [_rightBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn setTitle:@"右边" forState:UIControlStateNormal];
        _rightBtn.tag = 3;
    }
    return _rightBtn;
}

-(UIView *)sliderView{
    if (!_sliderView) {
        _sliderView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame)-2, SCREEN_WIDTH/3, 2)];
        _sliderView.backgroundColor = [UIColor whiteColor];
    }
    return _sliderView;
}

-(void)sliderAction:(UIButton *)sender{
    [self sliderAnimationWithTag:sender.tag];
    [UIView animateWithDuration:0.3 animations:^{
        self.mainScrollView.contentOffset = CGPointMake(SCREEN_WIDTH * (sender.tag - 1), 0);
    } completion:^(BOOL finished) {
        
    }];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double index_ = scrollView.contentOffset.x / SCREEN_WIDTH;
    [self sliderAnimationWithTag:(int)(index_+0.5)+1];
}
#pragma mark - sliderLabel滑动动画
- (void)sliderAnimationWithTag:(NSInteger)tag{
    self.leftBtn.selected = NO;
    self.centerBtn.selected = NO;
    self.rightBtn.selected = NO;
    UIButton *sender = [self buttonWithTag:tag];
    sender.selected = YES;
    //动画
    [UIView animateWithDuration:0.3 animations:^{
        self.sliderView.frame = CGRectMake(sender.frame.origin.x, self.sliderView.frame.origin.y, self.sliderView.frame.size.width, self.sliderView.frame.size.height);
        
    } completion:^(BOOL finished) {
        self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        self.centerBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        sender.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    }];
    
}

-(UIButton *)buttonWithTag:(NSInteger)tag{
    if (tag==1) {
        return self.leftBtn;
    }else if (tag==2){
        return self.centerBtn;
    }else if (tag==3){
        return self.rightBtn;
    }else{
        return nil;
    }
}

-(void)configUI{
    [self.view addSubview:self.mainScrollView];
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.sliderView];
    [self.headerView addSubview:self.leftBtn];
    [self.headerView addSubview:self.centerBtn];
    [self.headerView addSubview:self.rightBtn];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.headerView);
        make.height.equalTo(@40);
        make.right.equalTo(self.centerBtn.mas_left);
    }];
    
    [self.centerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftBtn);
        make.width.height.equalTo(self.leftBtn);
        make.right.equalTo(self.rightBtn.mas_left);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerBtn);
        make.width.height.equalTo(self.centerBtn);
        make.right.equalTo(self.headerView.mas_right);
    }];
}



@end
