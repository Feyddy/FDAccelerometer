//
//  ViewController.m
//  加速计的使用（CoreMotion）
//
//  Created by 徐忠林 on 13/01/2017.
//  Copyright © 2017 Feyddy. All rights reserved.
//

#import "ViewController.h"
#import "FDUIDeviceMethodViewController.h"
#import "FDUIAccelerometerViewController.h"
#import "FDCoreMotionViewController.h"
#import "FDPedometerViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *btn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    //实现摇一摇
    UIButton* deviceBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 100, 150, 30)];
    [deviceBtn setTitle:@"UIDevice" forState:UIControlStateNormal];
    deviceBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:deviceBtn];
    [deviceBtn addTarget:self action:@selector(UIDeviceAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton* accelerometerBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 150, 150, 30)];
    [accelerometerBtn setTitle:@"Accelerometer" forState:UIControlStateNormal];
    accelerometerBtn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:accelerometerBtn];
    [accelerometerBtn addTarget:self action:@selector(accelerometerbtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton* coreMotionBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 200, 150, 30)];
    [coreMotionBtn setTitle:@"coreMotion" forState:UIControlStateNormal];
    coreMotionBtn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:coreMotionBtn];
    [coreMotionBtn addTarget:self action:@selector(coreMotionBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    //实现计步器
    UIButton* pedometerBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 250, 150, 30)];
    [pedometerBtn setTitle:@"pedometer" forState:UIControlStateNormal];
    pedometerBtn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:pedometerBtn];
    [pedometerBtn addTarget:self action:@selector(pedometerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)UIDeviceAction {
    [self.navigationController pushViewController:[[FDUIDeviceMethodViewController alloc] init] animated:YES];
    
}

- (void)accelerometerbtnAction {
     [self.navigationController pushViewController:[[FDUIAccelerometerViewController alloc] init] animated:YES];
}

- (void)coreMotionBtnAction {
    [self.navigationController pushViewController:[[FDCoreMotionViewController alloc] init] animated:YES];
}


- (void)pedometerBtnAction {
     [self.navigationController pushViewController:[[FDPedometerViewController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
