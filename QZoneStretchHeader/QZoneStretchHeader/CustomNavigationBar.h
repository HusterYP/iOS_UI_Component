//
//  CustomNavigationBar.h
//  QZoneStretchHeader
//
//  Created by yuanping on 2019/1/22.
//  Copyright © 2019年 yuanping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavigationBar : UIView

@property (nonatomic, strong) NSString *leftItem;
@property (nonatomic, strong) NSString *rightItem;
@property (nonatomic, strong) NSString *title;

- (instancetype)initWithFrame:(CGRect)frame withStatusBarHeight:(float)statusBarHeight;
- (void)setTitle:(NSString *)title color:(UIColor *)color;
- (void)setLeftItem:(NSString *)leftItem color:(UIColor *)color;
- (void)setRightItem:(NSString *)rightItem color:(UIColor *)color;

@end
