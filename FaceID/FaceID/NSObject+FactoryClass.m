//
//  NSObject+FactoryClass.m
//  Wzbao
//
//  Created by wangwei on 2017/7/6.
//  Copyright © 2017年 AaronZhang. All rights reserved.
//

#import "NSObject+FactoryClass.h"

@implementation NSObject (FactoryClass)

- (UIButton *)createBut:(NSString *)title getBackGround:(UIColor *)color getTitleColor:(UIColor *)titleColor getFont:(UIFont *)font {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setBackgroundColor:color];
    button.titleLabel.font = font;
    
    return button;
}
- (UIButton *)createImageBut:(NSString *)imageStr {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    
    return button;
}

- (UILabel *)createLabel:(NSString *)title FontTemp:(UIFont* )font textColor:(UIColor *)textColor textAlignment:(NSInteger)alignment numberOfLines:(NSInteger)numberOfLines {
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.text = title;
    if (textColor) {
        label.textColor = textColor;
    }
    switch (alignment) {
        case 0: {
            label.textAlignment = NSTextAlignmentLeft;
        }
            break;
        case 1: {
            label.textAlignment = NSTextAlignmentCenter;
        }
            break;
        case 2: {
            label.textAlignment = NSTextAlignmentRight;
        }
            break;
            
        default:
            break;
    }
    label.numberOfLines = numberOfLines;
    
    
    return label;
}
- (UIImageView *)createImageView:(NSString *)imageStr setcontentMode:(UIViewContentMode)contentMode {
    UIImageView *imageView = [[UIImageView alloc] init];
   
    imageView.contentMode = contentMode;
    
    return imageView;
}

- (UIImageView *)createImageView:(NSString *)imageStr setcontentMode:(UIViewContentMode)contentMode cornerRadius:(CGFloat)cornerRadius {
    UIImageView *imageView = [[UIImageView alloc] init];
//    if (!isEmptyString(imageStr)) {
//        imageView.image = [UIImage imageNamed:imageStr];
//    }
    imageView.contentMode = contentMode;
    imageView.layer.cornerRadius = cornerRadius;
    
    return imageView;
}
- (UIImageView *)createImageView:(NSString *)imageStr setIntegerMode:(NSInteger)contentMode {
    UIImageView *imageView = [[UIImageView alloc] init];
//    if (!isEmptyString(imageStr)) {
//        imageView.image = [UIImage imageNamed:imageStr];
//    }
    if (contentMode ==0) {
        imageView.contentMode = UIViewContentModeScaleToFill;
    } else if (contentMode ==1) {
        imageView.contentMode = UIViewContentModeScaleAspectFit;
    } else if(contentMode ==2) {
        imageView.contentMode = UIViewContentModeScaleAspectFill;
    } else {
        imageView.contentMode = UIViewContentModeCenter;
    }
    
    return imageView;
}
/*
 [_rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
 */
- (UIView *)createView:(UIColor *)backGroundColor {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = backGroundColor;
    
    return view;
}

/// 添加四边阴影效果
- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
     // 阴影颜色
       theView.layer.shadowColor = theColor.CGColor;
       // 阴影偏移，默认(0, -3)
       theView.layer.shadowOffset = CGSizeMake(2,2);
       // 阴影透明度，默认0
       theView.layer.shadowOpacity = 0.2;
       // 阴影半径，默认3
       theView.layer.shadowRadius = 3.5;
}
- (UIView *)createTableViewFooterView:(UIColor *)color {
    UIColor *temp = color?:[UIColor lightGrayColor];
    UIView *footerView = [self createView:temp];
    footerView.frame = CGRectMake(0, 0, 375, 20);
    
    return footerView;
}
@end
