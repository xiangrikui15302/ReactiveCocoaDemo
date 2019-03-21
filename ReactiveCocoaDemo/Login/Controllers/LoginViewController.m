//
//  LoginViewController.m
//  ReactiveCocoaDemo
//
//  Created by 于朝盼 on 2019/3/15.
//  Copyright © 2019 于朝盼. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "UIImageView+WebCache.h"
#import "ViewController.h"
#import <ReactiveObjC/RACReturnSignal.h>

@interface LoginViewController ()

@property (nonatomic,strong)LoginViewModel *viewModel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)bindViewModel{
    [super bindViewModel];
    
    @weakify(self);
    [RACObserve(self.viewModel, imgUrlString) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.headImg sd_setImageWithURL:x];
    }];
    
    RAC(self.viewModel, mobilePhone) =  [RACSignal merge:@[RACObserve(self.mobileField, text),self.mobileField.rac_textSignal]];
//    [self.mobileField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"%@",x);
//    }];
//    [[self.mobileField.rac_textSignal bind:^RACStreamBindBlock{
//
//        return ^RACStream *(id value, BOOL *stop){
//
//            // 什么时候调用block:当信号有新的值发出，就会来到这个block。
//
//            // block作用:做返回值的处理
//
//            // 做好处理，通过信号返回出去.
//            return [RACReturnSignal return:[NSString stringWithFormat:@"输出:%@",value]];
//        };
//    }] subscribeNext:^(id  _Nullable x) {
//
//    }];
    
    [[self.mobileField.rac_textSignal flattenMap:^__kindof RACSignal * _Nullable(NSString * _Nullable value) {
        
        return [RACReturnSignal return:[NSString stringWithFormat:@"输出：%@",value]];
    }] subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"%@",x);
    }];
    
    RAC(self.viewModel, verifyCode) = [RACSignal merge:@[RACObserve(self.vercodeField, text),self.vercodeField.rac_textSignal]];
    
    RAC(self.loginBtn, enabled) = self.viewModel.loginSignal;
    
    [[[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] doNext:^(__kindof UIControl * _Nullable x) {
        
        
    }] subscribeNext:^(UIButton *sender) {
        @strongify(self);
        [self.viewModel.loginCommand execute:nil];
    }];
    
    // 数据成功
    [self.viewModel.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        // 登录成功，页面跳转
        ViewController *viewController = [[ViewController alloc]init];
        viewController.delegateSignal = [RACSubject subject];
        [viewController.delegateSignal subscribeNext:^(id  _Nullable x) {
            NSLog(@"viewController点击了按钮");
        }];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }];
    // 错误信息
    [self.viewModel.loginCommand.errors subscribeNext:^(NSError * _Nullable x) {
        // 处理验证错误的error
    }];
}

@end
