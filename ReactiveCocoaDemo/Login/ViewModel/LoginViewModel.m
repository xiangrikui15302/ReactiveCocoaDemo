//
//  LoginViewModel.m
//  ReactiveCocoaDemo
//
//  Created by 于朝盼 on 2019/3/15.
//  Copyright © 2019 于朝盼. All rights reserved.
//

#import "LoginViewModel.h"

@interface LoginViewModel()

@end
@implementation LoginViewModel

- (void)initialize
{
    // 数据绑定
    RAC(self,self.imgUrlString) = [[RACObserve(self, self.mobilePhone) map:^id _Nullable(id  _Nullable value) {
        if(![@"" isEqualToString:self.mobilePhone]){
            return @"http://www.pptbz.com/pptpic/UploadFiles_6909/201203/2012031220134655.jpg";

        }
        return @"";
    }] distinctUntilChanged];
    
    // 按钮有效性
    self.loginSignal = [[RACSignal combineLatest:@[RACObserve(self, mobilePhone),RACObserve(self, verifyCode)]
                                          reduce:^(NSString *mobilePhone, NSString *verifyCode){
                                              return @(mobilePhone.length>0 && verifyCode.length>0);
                                          }] distinctUntilChanged];
    // 登录命令
    @weakify(self);
    self.loginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self); // 先weak再strong.可以很好的管理Block内部对self的引用
        if(self.mobilePhone.length != 11){
            NSString *errorDomain = @"mobile is not aviable";
            return [RACSignal error:[NSError errorWithDomain:errorDomain code:-1001 userInfo:@{NSLocalizedDescriptionKey:@"请正确输入手机号"}]];
        }else if (self.verifyCode.length != 4){
            NSString *errorDomain = @"verifyCode is not aviable";
            return [RACSignal error:[NSError errorWithDomain:errorDomain code:-1002 userInfo:@{NSLocalizedDescriptionKey:@"请正确输入验证码"}]];
        }
        @weakify(self);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            @strongify(self);
//            @weakify(self);
            // 发起网络请求
            
            // 网络成功后
            [subscriber sendNext:nil];
            /// 必须sendCompleted 否则command.executing一直为1 导致HUD 一直 loading
            [subscriber sendCompleted];
            return nil;
        }];
    }];
}
@end

