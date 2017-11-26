//
//  SelectViewController.m
//  LNWTeam
//
//  Created by 工作 on 2017/11/25.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "SelectViewController.h"
#import "CCDraggableContainer.h"
#import "SelectView.h"
#import "LooperConfig.h"
#import "LooperToolClass.h"
#import "SearchViewController.h"
@interface SelectViewController ()<CCDraggableContainerDataSource,CCDraggableContainerDelegate>
{
    UIButton *dislikeBtn;
    UIButton *likeBtn;
}
@property (nonatomic, strong) CCDraggableContainer *container;
//@property (nonatomic, strong) NSMutableArray *dataSources;
@end

@implementation SelectViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createInit];
}
-(void)createInit{
    
    // 防止视图变黑
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 70*DEF_Adaptation_Font*0.5, DEF_WIDTH(self.view), 50*DEF_Adaptation_Font*0.5)];
    contentLabel.text=@"左滑，pass；右滑，yes";
    contentLabel.textColor=[UIColor grayColor];
    contentLabel.font=[UIFont boldSystemFontOfSize:18];
    contentLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:contentLabel];
    
    dislikeBtn=[LooperToolClass createBtnImageNameReal:@"btn_PhotoClose.png" andRect:CGPointMake(140*DEF_Adaptation_Font*0.5, DEF_WIDTH(self.view)+210*DEF_Adaptation_Font*0.5) andTag:1002 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(100*DEF_Adaptation_Font*0.5, 100*DEF_Adaptation_Font*0.5) andTarget:self];
    [self.view addSubview:dislikeBtn];
    likeBtn=[LooperToolClass createBtnImageNameReal:@"activity_follow.png" andRect:CGPointMake(370*DEF_Adaptation_Font*0.5, DEF_WIDTH(self.view)+180*DEF_Adaptation_Font*0.5) andTag:1003 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(150*DEF_Adaptation_Font*0.5, 150*DEF_Adaptation_Font*0.5) andTarget:self];
    [self.view addSubview:likeBtn];
    UIImage *image=[UIImage imageNamed:@"btn_jump.png"];
    UIButton *jumpBtn=[LooperToolClass createBtnImageNameReal:@"btn_jump.png" andRect:CGPointMake(DEF_WIDTH(self.view)-image.size.width/3-40*DEF_Adaptation_Font*0.5, DEF_HEIGHT(self.view)-image.size.height/3-40*DEF_Adaptation_Font*0.5) andTag:1004 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(image.size.width/3, image.size.height/3) andTarget:self];
    [self.view addSubview:jumpBtn];
    // 初始化Container
    self.container = [[CCDraggableContainer alloc] initWithFrame:CGRectMake(0, 150*DEF_Adaptation_Font*0.5, CCWidth, CCWidth) style:CCDraggableStyleUpOverlay];
    self.container.delegate = self;
    self.container.dataSource = self;
    self.container.backgroundColor = [UIColor colorWithRed:0.792 green:0.918 blue:0.808 alpha:1.00];
    [self.view addSubview:self.container];
    // 重启加载
    [self.container reloadData];
}

- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    if (button.tag==1002) {
        [UIView animateWithDuration:0.5 animations:^{
           dislikeBtn.transform = CGAffineTransformMakeScale(1.1, 1.1);
        } completion:^(BOOL finished) {
            dislikeBtn.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }
    if (button.tag==1003) {
        [UIView animateWithDuration:0.5 animations:^{
            likeBtn.transform = CGAffineTransformMakeScale(1.1, 1.1);
        } completion:^(BOOL finished) {
            likeBtn.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }
    if (button.tag==1004) {
        SearchViewController *searchVC=[[SearchViewController alloc]init];
          [self.navigationController pushViewController:searchVC animated:NO];
    }
    
}
-(NSMutableArray *)dataSources{
    if (!_dataSources) {
        _dataSources=[[NSMutableArray alloc]init];
        
    }
    return _dataSources;
}



#pragma mark - CCDraggableContainer DataSource

- (CCDraggableCardView *)draggableContainer:(CCDraggableContainer *)draggableContainer viewForIndex:(NSInteger)index {
    
    SelectView *selectV = [[SelectView alloc] initWithFrame:draggableContainer.bounds andDataDic:self.dataSources[index]];
    return selectV;
}

- (NSInteger)numberOfIndexs {
    return self.dataSources.count;
}

#pragma mark - CCDraggableContainer Delegate

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer draggableDirection:(CCDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio heightRatio:(CGFloat)heightRatio {
    
    CGFloat scale = 1 + ((kBoundaryRatio > fabs(widthRatio) ? fabs(widthRatio) : kBoundaryRatio)) / 4;
    if (draggableDirection == CCDraggableDirectionLeft) {
         dislikeBtn.transform = CGAffineTransformMakeScale(scale, scale);
    }
    if (draggableDirection == CCDraggableDirectionRight) {
         likeBtn.transform = CGAffineTransformMakeScale(scale, scale);
    }
}

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer cardView:(CCDraggableCardView *)cardView didSelectIndex:(NSInteger)didSelectIndex {
    
    NSLog(@"点击了Tag为%ld的Card", (long)didSelectIndex);
}

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer finishedDraggableLastCard:(BOOL)finishedDraggableLastCard {
    
    [draggableContainer reloadData];
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
