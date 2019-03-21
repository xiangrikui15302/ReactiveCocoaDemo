//
//  ViewController.h
//  ReactiveCocoaDemo
//
//  Created by 于朝盼 on 2019/3/15.
//  Copyright © 2019 于朝盼. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) RACSubject *delegateSignal;

@end

