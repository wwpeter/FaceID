//
//  NSObject+FactoryClass.h
//  Wzbao
//
//  Created by wangwei on 2017/7/6.
//  Copyright © 2017年 AaronZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (FactoryClass)

- (UIButton *)createBut:(NSString *)title getBackGround:(UIColor *)color getTitleColor:(UIColor *)titleColor getFont:(UIFont *)font;
- (UIButton *)createImageBut:(NSString *)imageStr;

- (UILabel *)createLabel:(NSString *)title FontTemp:(UIFont* )font textColor:(UIColor *)textColor textAlignment:(NSInteger)alignment numberOfLines:(NSInteger)numberOfLines;//传入 font textAlignment  是居左居中右

- (UIImageView *)createImageView:(NSString *)imageStr setcontentMode:(UIViewContentMode)contentMode;

- (UIImageView *)createImageView:(NSString *)imageStr setcontentMode:(UIViewContentMode)contentMode cornerRadius:(CGFloat)cornerRadius;

- (UIImageView *)createImageView:(NSString *)imageStr setIntegerMode:(NSInteger)contentMode;

/* 快速创建view */

- (UIView *)createView:(UIColor *)backGroundColor;

/// 添加四边阴影效果
- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor;

/* 增加tableview的footerView */
- (UIView *)createTableViewFooterView:(UIColor *)color;
@end
