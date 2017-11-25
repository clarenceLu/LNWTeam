//
//  AppDelegate.m
//  LNWTeam
//
//  Created by lujiawei on 25/11/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewContoller.h"
#import "LocationManagerData.h"



@interface AppDelegate ()

@end

@implementation AppDelegate 



//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
//    //获取最后一个定位数据
//    CLLocation* location = [locations lastObject];
//    //依次获取CLLocation中封装的经度、纬度、高度、速度、方向等信息
//    NSLog(@"经度:%g,纬度:%g,高度:%g,速度:%g,方向:%g",location.coordinate.latitude,location.coordinate.longitude,location.altitude,location.speed,location.course);
//}
////定位失败时激发的方法
//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
//    NSLog(@"定位失败：%@",error);
//}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    LoginViewContoller *loginVc = [[LoginViewContoller alloc] init];
    //  ShoppingViewController *start=[ShoppingViewController alloc];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVc];
    nav.delegate = self;
    nav.navigationBar.hidden = YES;
    nav.interactivePopGestureRecognizer.enabled = YES;
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
//    CLLocationManager *locationManager=[[CLLocationManager alloc] init];
//
//
//    if ([CLLocationManager locationServicesEnabled]) {
//        NSLog(@"开始执行定位服务");
//        //设置定位精度：最佳精度
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//        //设置距离过滤器为50米，表示每移动50米更新一次位置
//        //将试图控制器自身设置为CLLocationManager的delegate
//        //因此该试图控制器需要实现CLLocationManagerDelegate协议
//        locationManager.delegate = self;
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
//        {
//            [locationManager requestWhenInUseAuthorization];
//            [locationManager requestAlwaysAuthorization];
//        }
//        //开始监听定位信息
//        [locationManager startUpdatingLocation];
//    }else{
//        NSLog(@"无法使用定位服务！！！");
//    }
    
    
    
      [[LocationManagerData sharedManager] getLocalationPoint];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
