//
//  FDCoreMotionViewController.m
//  加速计的使用（CoreMotion）
//
//  Created by 徐忠林 on 15/01/2017.
//  Copyright © 2017 Feyddy. All rights reserved.
//

#import "FDCoreMotionViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface FDCoreMotionViewController ()

@property (nonatomic,strong) CMMotionManager *motionManager;
@property (strong, nonatomic) NSOperationQueue *queue;

@property (nonatomic,strong) UILabel *infoLabel;;

@end

@implementation FDCoreMotionViewController

- (CMMotionManager *)motionManager
{
    if (_motionManager == nil) {
        _motionManager = [[CMMotionManager alloc] init];
    }
    return _motionManager;
}

- (NSOperationQueue *)queue
{
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
     CoreMotion在处理加速计数据和陀螺仪数据的时是一个非常重要的框架，框架本身集成了很多算法获取原生的数据，而且能很好的展现出来，CoreMotion与UIKit不同，连接的是UIEvent而不是事件响应链。CoreMotion相对于接收数据只是更简单的分发motion事件。
     
     注：CMMotionManager
     类实际上不是一个单例，但应用程序应该把它当做一个单例，我们应该仅为每个应用程序创建一个CMMotionManager
     实例，使用普通的alloc和init方法。所以，如果应用中需要多处访问动作管理器时，可能需要在应用程序委托中创建它并提供从这里访问它的权限。
     除了CMMotionManager
     类，Core Motion还提供了其他的一些类，比如CMAccerometerData和CMCyroData，它们是一些简单容器，用于让应用程序访问动作数据。
     动作管理器需要一个队列，以便在每次发生事件时在其中放入一些要完成的工作，这些工作由你将提供给它的代码块指定。CMMotionManager
     的文档明确警告不要将其放入系统的默认队列里，这样可能是默认队列最终被这些事件填满，因而无法处理其他事件。
     
     
     */
    
    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 , 100, 200, 100)];
    self.infoLabel.backgroundColor = [UIColor orangeColor];
    self.infoLabel.numberOfLines = 0;
    [self.view addSubview:self.infoLabel];
    
    
    //获取陀螺仪信息
    if (!self.motionManager.isGyroAvailable) {
        return;
    }
    [self pushGyro];
    
    
    
//    //获取加速计信息
//    [self acceleratorAction];
    
}

#pragma mark - 加速计
/*
 CMMotionManager类能够使用到设备的所有移动数据(motion data)，Core Motion框架提供了两种对motion数据的操作方式:
 */
- (void)acceleratorAction {
    
    
    // 1.判断加速计是否可用
    if (!self.motionManager.isAccelerometerAvailable) return NSLog(@"Feyddy") ;
    
    // 2.设置采样间隔
    self.motionManager.accelerometerUpdateInterval = 1.0;
    
    
    /*
    pull方式:能够以CMMotionManager的只读方式获取当前任何传感器状态或是组合数据； 在有需要的时候，再主动去采集数据（基于事件的动作）
    */
    
    // 3.1.开始采样
    [self.motionManager startAccelerometerUpdates];
    
    //在需要的时候采集加速度数据
    CMAcceleration acc = self.motionManager.accelerometerData.acceleration;
    NSLog(@"%f, %f, %f", acc.x, acc.y, acc.z);
    
    self.infoLabel.text = [NSString stringWithFormat:@"x轴：%f，y轴:%f,z轴：%f", acc.x, acc.y, acc.z];
    
    
    /*
     push方式：是以块或者闭包的形式收集到想要得到的数据并且在特定周期内得到实时的更新；实时采集所有数据（时刻监视，采集频率高）
     */
    // 3.2.开始采样
    [self.motionManager startAccelerometerUpdatesToQueue:self.queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        if (error) return ;
        // 获取到加速计信息
        CMAcceleration acceleration = accelerometerData.acceleration;
        NSLog(@"x:%f y:%f z:%f", acceleration.x, acceleration.y, acceleration.z);
        self.infoLabel.text = [NSString stringWithFormat:@"x轴：%f，y轴:%f,z轴：%f", acceleration.x, acceleration.y, acceleration.z];
    }];
    
    
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CMAcceleration acceleration=_motionManager.accelerometerData.acceleration;
    NSLog(@"%f---%f---%f",acceleration.x,acceleration.y,acceleration.z);
     self.infoLabel.text = [NSString stringWithFormat:@"x轴：%f，y轴:%f,z轴：%f", acceleration.x, acceleration.y, acceleration.z];
}

#pragma mark - 获取陀螺仪信息
- (void)pushGyro
{
    // 1.陀螺仪是否可用
    if (!self.motionManager.isGyroAvailable) return;
    
    // 2.设置采样间隔
    self.motionManager.gyroUpdateInterval = 1.0;
    
    // 3.开始采样
    [self.motionManager startGyroUpdatesToQueue:self.queue withHandler:^(CMGyroData *gyroData, NSError *error) {
        if (error) return;
        
        CMRotationRate rotationRate = gyroData.rotationRate;
        NSLog(@"x:%f y:%f z:%f", rotationRate.x, rotationRate.y, rotationRate.z);
         self.infoLabel.text = [NSString stringWithFormat:@"x轴：%f，y轴:%f,z轴：%f", rotationRate.x, rotationRate.y, rotationRate.z];
        
        [self.view setNeedsLayout];
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
