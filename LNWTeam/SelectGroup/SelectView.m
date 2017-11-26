//
//  SelectView.m
//  LNWTeam
//
//  Created by 工作 on 2017/11/25.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "SelectView.h"
#import "LooperConfig.h"
#import "UIImageView+WebCache.h"
@interface SelectView()
@property(nonatomic,strong)NSDictionary *dataDic;
@end
@implementation SelectView
- (instancetype)initWithFrame:(CGRect)frame andDataDic:(NSDictionary *)dataDic{
    if (self=[super initWithFrame:frame]) {
        self.dataDic=dataDic;
        [self initView];
    }
    return self;
}
-(void)initView{
    UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,DEF_WIDTH(self) , DEF_HEIGHT(self))];
    [imageV sd_setImageWithURL:[NSURL URLWithString:[_dataDic objectForKey:@"like_url"]] placeholderImage:nil options:(SDWebImageRetryFailed)];
    [self addSubview:imageV];
    UILabel *label=[[UILabel  alloc]initWithFrame:CGRectMake(0, 30*DEF_Adaptation_Font*0.5, self.frame.size.width-20*DEF_Adaptation_Font, 50*DEF_Adaptation_Font)];
    label.text=[self.dataDic objectForKey:@"like_name"];
    label.font=[UIFont boldSystemFontOfSize:24];
    label.textColor=[UIColor whiteColor];
    label.shadowColor=[UIColor blackColor];
    label.shadowOffset=CGSizeMake(1, 1);
    label.textAlignment=NSTextAlignmentCenter;
    [self addSubview:label];
    UILabel *content=[[UILabel  alloc]initWithFrame:CGRectMake(0, 65*DEF_Adaptation_Font, self.frame.size.width-20*DEF_Adaptation_Font, 90*DEF_Adaptation_Font)];
    content.text=[self.dataDic objectForKey:@"like_title"];
    content.font=[UIFont boldSystemFontOfSize:22];
    content.numberOfLines=0;
    content.textColor=[UIColor whiteColor];
    content.shadowColor=[UIColor blackColor];
    content.shadowOffset=CGSizeMake(1, 1);
    content.textAlignment=NSTextAlignmentCenter;
    [self addSubview:content];
    
    
}
@end
