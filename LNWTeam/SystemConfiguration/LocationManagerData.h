//
//  LocationManagerData.h
//  Looper
//
//  Created by lujiawei on 24/08/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface LocationManagerData : CLLocationManager <CLLocationManagerDelegate>
{

    CGPoint LocationPoint_xy;
    float  direction;

}

+(instancetype)sharedManager;
-(void)getLocalationPoint;

@property(nonatomic)CGPoint LocationPoint_xy;
@property(nonatomic)float  direction;
@end

