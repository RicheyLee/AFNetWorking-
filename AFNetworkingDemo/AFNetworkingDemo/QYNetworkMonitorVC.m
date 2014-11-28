//
//  QYNetworkMonitorVC.m
//  AFNetworkingDemo
//
//  Created by qingyun on 14-11-28.
//  Copyright (c) 2014年 hnqingyun. All rights reserved.
//

#import "QYNetworkMonitorVC.h"
#import "AFNetworking/AFNetworkReachabilityManager.h"

@interface QYNetworkMonitorVC ()
@property (nonatomic, strong) AFNetworkReachabilityManager *manager;
@end

@implementation QYNetworkMonitorVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *msgArr = @[@"不可达", @"2G/3G/4G", @"Wi-Fi"];
    
    _manager = [AFNetworkReachabilityManager sharedManager];
    
    [_manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络状态" message:[NSString stringWithFormat:@"当前网络是：%@", msgArr[status]] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
    }];
}

- (IBAction)networkMonitor:(id)sender {
    UIButton *btn = (UIButton *)sender;

    if (!btn.selected) {
        [_manager startMonitoring];
        btn.highlighted = NO;
        [btn setSelected:YES];
        [btn setTitle:@"停止检测" forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    } else {
        [_manager stopMonitoring];
        btn.highlighted = YES;
        [btn setSelected:NO];
        [btn setTitle:@"开始检测" forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        
    }
}

@end
