//
//  ViewController.m
//  QZoneStretchHeader
//
//  Created by yuanping on 2019/1/22.
//  Copyright © 2019年 yuanping. All rights reserved.
//

#import "ViewController.h"
#import "CustomNavigationBar.h"

static float navigationHeight = 40;
static const float imageSizeRadio = 0.7f;
static const float tableViewOffsetTop = 160;
static float lastOffsetY = -160;

@interface ViewController() {
    UITableView *tableView;
    CustomNavigationBar *navigationBar;
    UIImageView *imageView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        navigationHeight += [UIApplication sharedApplication].statusBarFrame.size.height;
    });
    CGRect frame = self.view.frame;
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, imageSizeRadio * frame.size.width)];
    imageView.image = [UIImage imageNamed:@"backgroud"];
    [self.view addSubview:imageView];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, navigationHeight, frame.size.width, frame.size.height) style:UITableViewStylePlain];
    tableView.contentInset = UIEdgeInsetsMake(tableViewOffsetTop, 0, 0, 0);
    tableView.backgroundColor = [UIColor clearColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = false;
    [self.view addSubview:tableView];
    
    navigationBar = [[CustomNavigationBar alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, navigationHeight) withStatusBarHeight:[UIApplication sharedApplication].statusBarFrame.size.height];
    navigationBar.backgroundColor = [UIColor clearColor];
    [navigationBar setTitle:@"QQ空间" color:[UIColor whiteColor]];
    [navigationBar setLeftItem:@"LeftItem" color:[UIColor whiteColor]];
    [navigationBar setRightItem:@"RightItem" color:[UIColor whiteColor]];
    [self.view addSubview:navigationBar];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [tableView removeObserver:self forKeyPath:@"contentOffset"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.text = @"Label";
    }
    return cell;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        float offsetY = tableView.contentOffset.y;
        
        if (offsetY < -tableViewOffsetTop) { // 下拉放大
            imageView.frame = ({
                CGRect frame = imageView.frame;
                frame.size.width -= (offsetY - lastOffsetY);
                frame.size.height = frame.size.width * imageSizeRadio;
                frame.origin.x += (offsetY - lastOffsetY) / 2;
                frame;
            });
        }
        
        if (offsetY <= 0 && offsetY >= -tableViewOffsetTop) { // 滑动时，UIImageView随着一起移动
            float radio = 1 - (-offsetY / tableViewOffsetTop);
            navigationBar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:radio];
            [navigationBar setTitle:@"QQ空间" color:[UIColor whiteColor]];
            [navigationBar setLeftItem:@"LeftItem" color:[UIColor whiteColor]];
            [navigationBar setRightItem:@"RightItem" color:[UIColor whiteColor]];
            imageView.frame = ({
                CGRect frame = imageView.frame;
                frame.origin.y -= (offsetY - lastOffsetY);
                frame.origin.y = frame.origin.y > 0 ? 0 : frame.origin.y;
                frame;
            });
        } else if (offsetY > 0) { // 向上滑动超过NavigationBar的高度
            navigationBar.backgroundColor = [UIColor whiteColor];
            [navigationBar setTitle:@"QQ空间" color:[UIColor greenColor]];
            [navigationBar setLeftItem:@"LeftItem" color:[UIColor greenColor]];
            [navigationBar setRightItem:@"RightItem" color:[UIColor greenColor]];
        }
        lastOffsetY = offsetY;
    }
}

@end
