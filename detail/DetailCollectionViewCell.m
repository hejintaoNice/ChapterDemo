//
//  DetailCollectionViewCell.m
//  detail
//
//  Created by hejintao on 2017/5/26.
//  Copyright © 2017年 hither. All rights reserved.
//

#import "DetailCollectionViewCell.h"
#import "Masonry.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(1.f)]

@interface DetailCollectionViewCell ()

@property (nonatomic,strong) UILabel *label;

@end

@implementation DetailCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
        self.contentView.backgroundColor = RGBCOLOR(230, 230, 230);
    }
    return self;
}

-(void)configUI{
    [self.contentView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.contentView);
    }];
}

-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.textColor = [UIColor lightGrayColor];
        _label.font = [UIFont systemFontOfSize:14];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

-(void)configData:(NSString *)str{
    self.label.text = str;
}

@end
