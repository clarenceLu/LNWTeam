//
//  LoginViewContoller.m
//  LNWTeam
//
//  Created by lujiawei on 25/11/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "LoginViewContoller.h"
#import "ViewController.h"

@interface LoginViewContoller ()

@end

@implementation LoginViewContoller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    ViewController *vc = [[ViewController alloc] init];
    
    [[self navigationController]pushViewController:vc animated:false];
    
    [self createHudView];
}



-(void)createHudView{
    
    
    
    
    
    
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
