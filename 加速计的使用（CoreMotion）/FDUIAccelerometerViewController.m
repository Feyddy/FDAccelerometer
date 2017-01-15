//
//  FDUIAccelerometerViewController.m
//  加速计的使用（CoreMotion）
//
//  Created by 徐忠林 on 15/01/2017.
//  Copyright © 2017 Feyddy. All rights reserved.
//

#import "FDUIAccelerometerViewController.h"

@interface FDUIAccelerometerViewController ()<UIAccelerometerDelegate>
@property (nonatomic, strong) UIButton *btn;

@end

@implementation FDUIAccelerometerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /**
     *  获取到加速计的单利对象
     */
    UIAccelerometer * accelertometer = [UIAccelerometer sharedAccelerometer];
    /**
     *  设置加速计的代理
     */
        accelertometer.delegate = self;
    /**
     *  updateInterval  刷新频率，一秒更新30次
     */
    accelertometer.updateInterval = 1.0/1.0;
    
    
    UIButton * button =({
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"我是加速计" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor blueColor];
        [self.view addSubview:btn];
        btn.frame = CGRectMake(10, 20, 100, 50);
        
        
        
        btn;
    });
    self.btn = button;

}

#pragma mark --UIAccelerometerDelegate
static NSInteger shakeCount = 0;
static NSDate * shakeStart;
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration{
    
    NSString * strinfo = [NSString stringWithFormat:@"x:%g \t y:%g \t z :%g",acceleration.x,acceleration.y,acceleration.z];
    NSLog(@"str - %@",strinfo);
    //检测摇动 1.5 为轻摇 。2.0 为重摇
    if (fabs(acceleration.x)>1.8 || abs(acceleration.y>1.8)||abs(acceleration.z>1.8)) {
        NSLog(@"你摇动我了");
    }
    self.btn.frame = CGRectMake(fabs(acceleration.x) *100, fabs(acceleration.y) *100, 100, 40);
    
    
    NSDate * now = [[NSDate alloc]init];
    NSDate * checkDate = [[NSDate alloc]initWithTimeInterval:1.5f sinceDate:shakeStart];
    if ([now compare:checkDate] ==NSOrderedDescending || shakeStart ==nil) {
        
        shakeStart = [NSDate date];
        
    }
    if (fabs(acceleration.x)>1.7 || abs(acceleration.y>1.7)||abs(acceleration.z>1.7)) {
        shakeCount++;
        if (shakeCount>2) {
            NSLog(@"你已经把我摇动了");
            shakeCount = 0;
            shakeStart = [NSDate date];
            
        }
        
        
    }
}



@end
