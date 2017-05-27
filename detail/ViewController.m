//
//  ViewController.m
//  detail
//
//  Created by hejintao on 2017/5/26.
//  Copyright © 2017年 hither. All rights reserved.
//

#import "ViewController.h"
#import "DetailCollectionViewCell.h"
#import "MoreButtonView.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define CollectionViewNOXIBRegisterCell(collectionView, cellClass, cellID) [collectionView registerClass:[cellClass class] forCellWithReuseIdentifier:cellID];

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (assign, nonatomic) BOOL isOpen;
@property (assign, nonatomic) NSInteger showButtonNumber;
@property (copy, nonatomic) NSMutableArray *titleArr;
@property (nonatomic,strong) MoreButtonView *footer;
@property (strong, nonatomic) UIButton *theButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    _showButtonNumber = 12;
    _titleArr  = [NSMutableArray array];
    //准备测试数据
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 1000; i ++) {
            NSString *str = [NSString stringWithFormat:@"章节 %d",i];
            [_titleArr addObject:str];
        }
    });
    [self.collectionView reloadData];
}

- (void)handleAction:(UIButton *)sender{
    
    _isOpen = !_isOpen;
    _showButtonNumber = _isOpen ? _titleArr.count : 12;
    [sender setTitle: _isOpen ? @"收起" : @"查看更多" forState:UIControlStateNormal];
    [self.collectionView reloadData];
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 5;
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-60)/4, 29);
        NSInteger temp  = 12;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(temp, temp, temp, temp);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        CollectionViewNOXIBRegisterCell(_collectionView, DetailCollectionViewCell, @"DetailCollectionViewCell_id")
        [self.collectionView registerClass:[MoreButtonView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView_id"];
    }
    return _collectionView;
}

#pragma mark -- UICollectionViewDelegate && dataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  _showButtonNumber;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DetailCollectionViewCell_id" forIndexPath:indexPath];
    [cell configData:_titleArr[indexPath.row]];
    return cell;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (UIButton *)theButton{
    
    if (!_theButton) {
        _theButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH-30, 40)];
        [_theButton setTitle:@"查看更多" forState:UIControlStateNormal];
        [_theButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_theButton addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
        [_theButton setBackgroundColor:[UIColor whiteColor]];
        _theButton.layer.cornerRadius = 15;
        _theButton.layer.masksToBounds = YES;
        _theButton.layer.borderWidth = 1;
        _theButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return _theButton;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
        MoreButtonView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView_id" forIndexPath:indexPath];
        [footer addSubview:self.theButton];
    return footer;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 50);
}


@end
