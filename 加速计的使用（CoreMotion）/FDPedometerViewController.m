//
//  FDPedometerViewController.m
//  加速计的使用（CoreMotion）
//
//  Created by 徐忠林 on 15/01/2017.
//  Copyright © 2017 Feyddy. All rights reserved.
//

#import "FDPedometerViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface FDPedometerViewController ()
@property (nonatomic,strong) UILabel *stepLabel;
@property (nonatomic,strong) CMPedometer *stepCounter;
@end

@implementation FDPedometerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 300, 100)];
    self.stepLabel.numberOfLines = 0;
    self.stepLabel.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.stepLabel];
    
    //判断版本号使用不同的方法
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [self CMPedometerMethod];//最新的兼容所有的版本号
    }else
    {
        [self CMStepCounterMethod];
    }

    
}


- (void)CMPedometerMethod {
    // 1.判断计步器是否可用
    if (![CMPedometer isStepCountingAvailable]) return;
    
    // 2.创建计步器对象
    self.stepCounter = [[CMPedometer alloc] init];
    
    // 3.开始计步(走多少步之后调用一次该方法)
    [ self.stepCounter queryPedometerDataFromDate:[NSDate dateWithTimeIntervalSinceNow:-60*60*24*1] toDate:[NSDate dateWithTimeIntervalSinceNow:-60*60*24*0] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"error===%@",error);
        }
        else {
            NSLog(@"步数===%@",pedometerData.numberOfSteps);
            NSLog(@"距离===%@",pedometerData.distance);
            
            self.stepLabel.text = [NSString stringWithFormat:@"您行走的距离%@米 \n 已经走了%@步", pedometerData.distance,pedometerData.numberOfSteps];
        }
    }];
    
    //注：Error Domain=CMErrorDomain Code=103 "The operation couldn’t be completed. (CMErrorDomain error 103.)"如果出现这个，将CMPedometer设置成属性就行了

}

- (void)CMStepCounterMethod {
    // 1.判断计步器是否可用
    if (![CMStepCounter isStepCountingAvailable]) return;
    
    // 2.创建计步器对象
    CMStepCounter *stepCounter = [[CMStepCounter alloc] init];
    
    // 3.开始计步(走多少步之后调用一次该方法)
    [stepCounter startStepCountingUpdatesToQueue:[NSOperationQueue mainQueue] updateOn:5 withHandler:^(NSInteger numberOfSteps, NSDate *timestamp, NSError *error) {
        self.stepLabel.text = [NSString stringWithFormat:@"您已经走了%ld步", numberOfSteps];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
