//
//  FDUIDeviceMethodViewController.m
//  加速计的使用（CoreMotion）
//
//  Created by 徐忠林 on 15/01/2017.
//  Copyright © 2017 Feyddy. All rights reserved.
//

#import "FDUIDeviceMethodViewController.h"

@interface FDUIDeviceMethodViewController ()

@end

@implementation FDUIDeviceMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];


}

- (void)orientationChanged:(NSNotification *)notification {

}

-(void) viewDidDisappear {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}


- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"开始晃动");
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake)
    {
        // FlyElephant  http://www.cnblogs.com/xiaofeixiang
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FlyElephant" object:self];
        NSLog(@"摇一摇");
    }
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"取消");
}




@end
