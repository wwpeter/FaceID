//
//  WM_HeaderFaceRecognitionView.h
//  SSKJ
//
//  Created by YinGuang on 2020/6/13.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


// 纯白色
#define kMainWihteColor UIColorFromRGB(0xFFFFFF)

//由十六进制转换成是十进制
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]
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


typedef void(^WM_HeaderFaceRecognitionViewBlcok)(void);
@interface WM_HeaderFaceRecognitionView : UIView

@property (nonatomic, copy) WM_HeaderFaceRecognitionViewBlcok faceBlock;

- (void)endDeal;//处理
@end

NS_ASSUME_NONNULL_END
