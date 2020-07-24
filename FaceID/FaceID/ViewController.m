//
//  ViewController.m
//  FaceID
//
//  Created by YinGuang on 2020/7/24.
//  Copyright © 2020 YinGuang. All rights reserved.
//

#import "ViewController.h"
#import "WM_CenterFaceRecognitionView.h"
#import "WM_HeaderFaceRecognitionView.h"



@interface ViewController ()
@property (nonatomic, strong) UIScrollView *backScrolliew;

@property (nonatomic, strong) UIButton *submitBut;

@property (nonatomic, strong) WM_CenterFaceRecognitionView *centerView;

@property (nonatomic, strong) WM_HeaderFaceRecognitionView *headerView;
@end

#define Height_NavBar ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 88.0 : 64.0)
#define ScreenSize      [UIScreen mainScreen].bounds.size

#define ScreenWidth     ([[UIScreen mainScreen] bounds].size.width)

#define ScreenHeight    ([[UIScreen mainScreen] bounds].size.height)
//各屏幕尺寸比例

#define ScaleW(width)  width*ScreenWidth/375

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initViews];
    [self configurations];
}

- (void)initViews {
    [self.view addSubview:self.backScrolliew];
    [self.backScrolliew addSubview:self.centerView];
    [self.backScrolliew addSubview:self.headerView];
    
}
- (void)configurations {
   self.title = @"人脸识别";
    
}


#pragma mark- getter
- (UIScrollView *)backScrolliew {
    if (!_backScrolliew) {
        _backScrolliew = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ScaleW(5), ScreenWidth, ScreenHeight)];
        _backScrolliew.contentSize = CGSizeMake(ScreenWidth, ScaleW(700));
        _backScrolliew.backgroundColor = [UIColor lightGrayColor];
    }
    return _backScrolliew;
}
- (WM_HeaderFaceRecognitionView *)headerView {
    if (!_headerView) {
        _headerView = [[WM_HeaderFaceRecognitionView alloc] initWithFrame:CGRectMake(0, 70, ScreenWidth, ScaleW(380))];
       
//        [_headerView setFaceBlock:^{
//            [self.headerView endDeal];
//            
//        }];
    }
    return _headerView;;
}
- (WM_CenterFaceRecognitionView *)centerView {
    if (!_centerView) {
        _centerView = [[WM_CenterFaceRecognitionView alloc] initWithFrame:CGRectMake(0, ScreenHeight-ScaleW(100)-64, ScreenWidth, ScaleW(70))];
    }
    return _centerView;
}

@end
