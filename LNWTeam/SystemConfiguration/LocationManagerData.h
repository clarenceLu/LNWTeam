
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
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


