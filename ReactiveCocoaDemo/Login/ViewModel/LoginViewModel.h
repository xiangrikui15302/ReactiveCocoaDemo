//
//  LoginViewModel.h
//  ReactiveCocoaDemo
//
//  Created by 于朝盼 on 2019/3/15.
//  Copyright © 2019 于朝盼. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject

@property (nonatomic, copy)NSString *mobilePhone;
@property (nonatomic, copy)NSString *verifyCode;
@property (nonatomic, copy)NSString *imgUrlString;
// 按钮能否点击
@property (nonatomic, strong)RACSignal *loginSignal;
// 登录按钮点击执行的命令
@property (nonatomic, strong)RACCommand *loginCommand;

- (void)initialize;
@end

NS_ASSUME_NONNULL_END
