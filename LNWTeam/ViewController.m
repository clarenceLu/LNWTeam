//
//  ViewController.m
//  LNWTeam
//
//  Created by lujiawei on 25/11/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>
#import <math.h>
#import "LocationManagerData.h"




#define DEF_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

#define DEF_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ViewController () <ARSCNViewDelegate>{
    
    
    ARSCNView *arview;
    UILabel *lable;
    
    CMMotionManager *motionManager;
    NSOperationQueue *quene;
    UIImageView *directionImage;
    
}

@end

    
@implementation ViewController



-(void)removeMotion{
    
    [motionManager stopAccelerometerUpdates];
    [motionManager stopGyroUpdates];
    
}


-(void)playMusic{

    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Justin Jesso-Stargazing.mp3" withExtension:nil];
    AVPlayer*_player=[AVPlayer playerWithURL:url];
    AVPlayerLayer*playerLayer=[AVPlayerLayer playerLayerWithPlayer:_player];
    
    playerLayer.frame = CGRectMake(0, 0,DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT);
    [[self view].layer addSublayer:playerLayer];
    [_player play];
}

- (void)configureGrro
{
    
    if ([motionManager isGyroAvailable]) {
//        [motionManager startGyroUpdatesToQueue:quene withHandler:^(CMGyroData *gyroData, NSError *error) {
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//
//                NSLog(@"%f",gyroData.rotationRate.x);
//                NSLog(@"%f",gyroData.rotationRate.y);
//                NSLog(@"%f",gyroData.rotationRate.z);
//
//            });
//        }];
//
        [motionManager setDeviceMotionUpdateInterval:0.05f];
        [motionManager startDeviceMotionUpdatesToQueue:quene withHandler:^(CMDeviceMotion *deviceMotion, NSError *error) {
            
            CMAttitude *attitude = deviceMotion.attitude;
            
            float angleX = -attitude.pitch/M_PI*180;
            float angleY = attitude.roll/M_PI*180;
            float angleZ = -attitude.yaw/M_PI*180;
            
            
//            NSLog(@"angleX%f",angleX);
//            NSLog(@"angleY%f",angleY);
//            NSLog(@"angleZ%f",angleZ);
            
        }];
        
        
        
    }else{
        NSLog(@"陀螺仪不能使用");
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self playMusic];
    
    motionManager = [[CMMotionManager alloc]init];
    quene = [[NSOperationQueue alloc]init];
    
    [self configureGrro];
    
    arview = [[ARSCNView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    [[self view] addSubview:arview];
    
    arview.delegate = self;
    
    directionImage = [[UIImageView alloc] initWithFrame:CGRectMake(DEF_SCREEN_WIDTH/2-30, DEF_SCREEN_HEIGHT-120, 60, 60)];
    [directionImage setImage:[UIImage imageNamed:@"arrow.jpg"]];
    [[self view] addSubview:directionImage];
    
    lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [lable setTextColor:[UIColor redColor]];
    lable.text = [NSString stringWithFormat:@"%f    %f",[LocationManagerData sharedManager].LocationPoint_xy.x,[LocationManagerData sharedManager].LocationPoint_xy.y];
    [[self view] addSubview:lable];
    
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(setLableText) userInfo:nil repeats:true];
    [timer fire];
    
}

-(void)setLableText{
    
    int multiplier = 1000000;
    
    float target_x = 125.52*multiplier;
    float target_Y = 35.33*multiplier;
    
    
    float local_x =[LocationManagerData sharedManager].LocationPoint_xy.x *multiplier;
    float local_y =[LocationManagerData sharedManager].LocationPoint_xy.y *multiplier;

    
    float line1 = abs((int)(target_x-local_x));
    float line2 = abs((int)(local_y-target_Y));
    
    float line3 = sqrt((target_x-local_x)*(target_x-local_x)+(target_Y-local_y)*(target_Y-local_y));
    
    
    float limit = atan(line1/line2);
    
    
     lable.text = [NSString stringWithFormat:@"%f   %f",[LocationManagerData sharedManager].LocationPoint_xy.x,[LocationManagerData sharedManager].LocationPoint_xy.y];
    
    
    NSLog(@"%f",-[LocationManagerData sharedManager].direction);
    
    if(local_y<target_Y){
    
    
    if(target_x>local_x){
        
         directionImage.transform = CGAffineTransformMakeRotation(-[LocationManagerData sharedManager].direction+limit);
    }else{

         directionImage.transform = CGAffineTransformMakeRotation(-[LocationManagerData sharedManager].direction-limit);
        
    }
        
    }else{
        if(target_x>local_x){
            
            directionImage.transform = CGAffineTransformMakeRotation(-[LocationManagerData sharedManager].direction+(3.14-limit));
        }else{
            
            directionImage.transform = CGAffineTransformMakeRotation(-[LocationManagerData sharedManager].direction+(limit-3.14));
            
        }
    }
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Create a session configuration
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];

    // Run the view's session
    [arview.session runWithConfiguration:configuration];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Pause the view's session
    [arview.session pause];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - ARSCNViewDelegate

/*
// Override to create and configure nodes for anchors added to the view's session.
- (SCNNode *)renderer:(id<SCNSceneRenderer>)renderer nodeForAnchor:(ARAnchor *)anchor {
    SCNNode *node = [SCNNode new];
 
    // Add geometry to the node...
 
    return node;
}
*/

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    // Present an error message to the user
    
}

- (void)sessionWasInterrupted:(ARSession *)session {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay
    
}

- (void)sessionInterruptionEnded:(ARSession *)session {
    // Reset tracking and/or remove existing anchors if consistent tracking is required
    
}

@end
