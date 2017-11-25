//
//  ViewController.m
//  LNWTeam
//
//  Created by lujiawei on 25/11/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "ViewController.h"


#define DEF_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

#define DEF_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ViewController () <ARSCNViewDelegate>{
    
    
    ARSCNView *arview;

}

@end

    
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    arview = [[ARSCNView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    [[self view] addSubview:arview];

    arview.delegate = self;
    
    
    // Create a new scene
   // SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/ship.scn"];
    
    // Set the scene to the view
    //arview.scene = scene;
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
