//
//  WM_CenterFaceRecognitionView.m
//  SSKJ
//
//  Created by YinGuang on 2020/6/13.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "WM_CenterFaceRecognitionView.h"
#import "Masonry.h"
#import "NSObject+FactoryClass.h"

//屏幕相关
#define AppWindow ([UIApplication sharedApplication].keyWindow)

#define WindowContent  ([[UIScreen mainScreen] bounds])

#define ScreenSize      [UIScreen mainScreen].bounds.size

#define ScreenWidth     ([[UIScreen mainScreen] bounds].size.width)

#define ScreenHeight    ([[UIScreen mainScreen] bounds].size.height)

#define ScreenMaxLength (MAX(ScreenWidth,ScreenHeight))

#define ScreenMinLength (MIN(ScreenWidth,ScrrenHeight))


// 副字体色
#define kSubTextColor UIColorFromRGB(0x868686)
//各屏幕尺寸比例

#define ScaleW(width)  width*ScreenWidth/375

@interface WM_CenterFaceRecognitionView ()

@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) UIImageView *headerView2;
@property (nonatomic, strong) UIImageView *headerView3;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *titleLabel2;
@property (nonatomic, strong) UILabel *titleLabel3;
@end
@implementation WM_CenterFaceRecognitionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}
- (void)initViews {
    self.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.headerView];
    [self addSubview:self.headerView2];
    [self addSubview:self.headerView3];
    [self addSubview:self.titleLabel];
    [self addSubview:self.titleLabel2];
    [self addSubview:self.titleLabel3];
}
- (void)initViewsLayouts {
    CGFloat width = (ScreenWidth-ScaleW(51)*3)/4;
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(width);
        make.width.height.mas_equalTo(ScaleW(51));
        make.top.mas_equalTo(ScaleW(0));
        
    }];
    [self.headerView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(width*2+ScaleW(51));
        make.width.height.mas_equalTo(ScaleW(51));
        make.top.mas_equalTo(ScaleW(0));
    }];
    [self.headerView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(width*3+ScaleW(102));
        make.width.height.mas_equalTo(ScaleW(51));
        make.top.mas_equalTo(ScaleW(0));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.headerView.mas_centerX);
        make.top.mas_equalTo(self.headerView.mas_bottom).offset(ScaleW(10));
        make.height.mas_equalTo(ScaleW(17));
    }];
    [self.titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.headerView2.mas_centerX);
        make.top.mas_equalTo(self.headerView2.mas_bottom).offset(ScaleW(10));
             make.height.mas_equalTo(ScaleW(17));
    }];
    [self.titleLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.headerView3.mas_centerX);
        make.top.mas_equalTo(self.headerView3.mas_bottom).offset(ScaleW(10));
             make.height.mas_equalTo(ScaleW(17));
    }];
}
- (void)updateConstraints {
    [super updateConstraints];
    [self initViewsLayouts];
}
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (UIImageView *)headerView {
    if (!_headerView) {
        _headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"haderFaceww"]];
        
    
    }
    return _headerView;
}

- (UIImageView *)headerView2 {
    if (!_headerView2) {
        _headerView2 =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"haderFaceww2"]];
    }
    return _headerView2;
}
- (UIImageView *)headerView3 {
    if (!_headerView3) {
        _headerView3 =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"haderFaceww3"]];
    }
    return _headerView3;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [self createLabel:@"不能佩戴眼睛" FontTemp:[UIFont systemFontOfSize:12] textColor:[UIColor redColor] textAlignment:1 numberOfLines:1];
    }
    return _titleLabel;
}
- (UILabel *)titleLabel2 {
    if (!_titleLabel2) {
        _titleLabel2 = [self createLabel:@"不能遮挡脸部" FontTemp:[UIFont systemFontOfSize:12] textColor:[UIColor redColor] textAlignment:1 numberOfLines:1];
    }
    return _titleLabel2;
}
- (UILabel *)titleLabel3 {
    if (!_titleLabel3) {
        _titleLabel3 = [self createLabel:@"不能仰头俯拍" FontTemp:[UIFont systemFontOfSize:12] textColor:[UIColor redColor] textAlignment:1 numberOfLines:1];
    }
    return _titleLabel3;
}

@end
