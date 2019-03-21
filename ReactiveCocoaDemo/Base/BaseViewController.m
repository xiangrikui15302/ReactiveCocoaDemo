//
//  BaseViewController.m
//  ReactiveCocoaDemo
//
//  Created by 于朝盼 on 2019/3/18.
//  Copyright © 2019 于朝盼. All rights reserved.
//

#import "BaseViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface BaseViewController ()

@end

@implementation BaseViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    BaseViewController *viewController = [super allocWithZone:zone];
    @weakify(viewController)
    [[viewController
      rac_signalForSelector:@selector(viewDidLoad)]
     subscribeNext:^(id x) {
         @strongify(viewController)
         [viewController bindViewModel];
     }];
    return viewController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)bindViewModel{
    
}

@end
