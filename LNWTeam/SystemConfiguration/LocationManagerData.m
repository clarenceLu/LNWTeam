//
//  LocationManagerData.m
//  Looper
//
//  Created by lujiawei on 24/08/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "LocationManagerData.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>


@implementation LocationManagerData

@synthesize LocationPoint_xy = _LocationPoint_xy;
@synthesize direction = _direction;

+ (instancetype)sharedManager
{
    static LocationManagerData *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LocationManagerData alloc] init];
    });
    
    return instance;
}


-(void)getLocalationPoint{
    self.delegate=self;
    //设置定位精度：最佳精度
    self.desiredAccuracy = kCLLocationAccuracyBest;
    [self requestWhenInUseAuthorization];
    [self requestAlwaysAuthorization];
    [self startUpdatingLocation];
    [self startUpdatingHeading];
}



- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{

    CGFloat angle = newHeading.magneticHeading * M_PI / 180;
    
    NSLog(@"%f",newHeading.magneticHeading);
    
    _direction =angle;
    
}


- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{

    CLLocation *location=[locations firstObject];
    
    CLLocationCoordinate2D coordinate=location.coordinate;
    
    NSLog(@"您的当前位置:经度：%f,纬度：%f,海拔：%f,航向：%f,速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);

    _LocationPoint_xy = CGPointMake(coordinate.longitude, coordinate.latitude);
    

}

@end
