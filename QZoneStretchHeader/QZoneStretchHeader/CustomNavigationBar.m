//
//  CustomNavigationBar.m
//  QZoneStretchHeader
//
//  Created by yuanping on 2019/1/22.
//  Copyright © 2019年 yuanping. All rights reserved.
//

#import "CustomNavigationBar.h"

@interface CustomNavigationBar() {
    UILabel *leftItem;
    UILabel *rightItem;
    UILabel *title;
}

@end

@implementation CustomNavigationBar

- (instancetype)initWithFrame:(CGRect)frame withStatusBarHeight:(float)statusBarHeight
{
    self = [super initWithFrame:frame];
    if (self) {
        leftItem = [[UILabel alloc] initWithFrame:CGRectMake(10, statusBarHeight, 80, 40)];
        rightItem = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 90, statusBarHeight, 80, 40)];
        title = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 200) / 2, statusBarHeight, 200, 40)];
        [self addSubview:leftItem];
        [self addSubview:rightItem];
        [self addSubview:title];
        leftItem.textAlignment = NSTextAlignmentCenter;
        rightItem.textAlignment = NSTextAlignmentCenter;
        title.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void) setTitle:(NSString *)title color:(UIColor *)color {
    self->title.text = title;
    self->title.textColor = color;
}

- (void)setLeftItem:(NSString *)leftItem color:(UIColor *)color {
    self->leftItem.text = leftItem;
    self->leftItem.textColor = color;
}

- (void)setRightItem:(NSString *)rightItem color:(UIColor *)color {
    self->rightItem.text = rightItem;
    self->rightItem.textColor = color;
}

@end
