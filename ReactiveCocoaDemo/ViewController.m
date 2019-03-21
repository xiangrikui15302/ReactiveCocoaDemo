//
//  ViewController.m
//  ReactiveCocoaDemo
//
//  Created by 于朝盼 on 2019/3/15.
//  Copyright © 2019 于朝盼. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"1");
        [subscriber sendNext:@"发送了信号"];
        NSLog(@"2");
        [subscriber sendCompleted];// 发送成功，订阅可自动移除
        
        // 手动移除订阅
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"3");
        }];
    }];
    NSLog(@"4");
    
    // 订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"5");
        NSLog(@"%@",x);
    }];
    
    // 打印结果  4  1 5 发送了信号  2 3
}

-(void)initUI{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 100, 40)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)clickAction:(UIButton *)btn{
    if(self.delegateSignal){
        [self.delegateSignal sendNext:nil];
    }
}
@end
