//
//  LoginViewContoller.m
//  LNWTeam
//
//  Created by lujiawei on 25/11/2017.
//  Copyright © 2017 lujiawei. All rights reserved.
//

#import "LoginViewContoller.h"
#import "ViewController.h"
#import "LooperConfig.h"
#import "AFNetworkTool.h"
#import "DataHander.h"
#import "LooperToolClass.h"
#import "SelectViewController.h"
@interface cirlemodel:NSObject
@property(assign,nonatomic)CGFloat orignX;
@property(assign,nonatomic)CGFloat orignY;
@property(assign,nonatomic)CGFloat width;
@property(assign,nonatomic)CGFloat offsetX;
@property(assign,nonatomic)CGFloat offsetY;
- (instancetype)initModelWith:(CGFloat)orignx andy:(CGFloat)origny andwidth:(CGFloat)width andOffsetX:(CGFloat)offsetx andOffsetY:(CGFloat)offsety;
@end

@interface linemodel:NSObject
@property(assign,nonatomic)CGFloat beginX;
@property(assign,nonatomic)CGFloat beginY;
@property(assign,nonatomic)CGFloat opacity;
@property(assign,nonatomic)CGFloat closeX;
@property(assign,nonatomic)CGFloat closeY;
- (instancetype)initModelWith:(CGFloat)beginx andy:(CGFloat)beginy andOpacity:(CGFloat)opacity andCloseX:(CGFloat)closex andCloseY:(CGFloat)closey;
@end

@interface LoginViewContoller ()<UITextFieldDelegate>
{
    UITextField *phoneText;
    UITextField *codeText;
    
    UIButton *sendBtn;
    UIButton *joinBtn;
    
    NSTimer *downTimer;
    UILabel *downNum;
    
    UIButton *backBtn;
    
    
    int downTime;
    
}
@property(assign,nonatomic)CGFloat screenWidth;
@property(assign,nonatomic)CGFloat screenHeight;
@property(strong,nonatomic)UIView *bgview;
@property(assign,nonatomic)NSUInteger point;
@property(strong,nonatomic)NSMutableArray *cirleArry;
@property(strong,nonatomic)NSTimer *timer;
@end

@implementation LoginViewContoller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.bgview];
    [self initprama];
    [self draw];
    _timer=[NSTimer scheduledTimerWithTimeInterval:0.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    
    [self getCreditHistory];
    
    
      [self initBtn];
    
}
-(void)initView{
    UIImage *image=[UIImage imageNamed:@"login.png"];
    UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self.view), image.size.height/image.size.width*DEF_WIDTH(self.view))];
    imageV.image=image;
    [self.bgview addSubview:imageV];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(DEF_WIDTH(self.view)/2-50*DEF_Adaptation_Font, 160*DEF_Adaptation_Font*0.5, 100*DEF_Adaptation_Font, 100*DEF_Adaptation_Font)];
    label.text=@"LNW\nTEAM";
    label.textColor=[UIColor whiteColor];
    label.numberOfLines=2;
    label.font=[UIFont boldSystemFontOfSize:24];
    label.textAlignment=NSTextAlignmentCenter;
    [self.bgview addSubview:label];
    
    
    
   
}
//加载数据
-(void)getCreditHistory{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
//    [dic setObject:@"超级大怪兽" forKey:@"user_name"];
//    [dic setObject:@"123456" forKey:@"user_pass"];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"http://91cp.xin/api/thon/getMusicList" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==0){
            
        }
    }fail:^{
        
    }];
}



#pragma-BackGroundV
- (void)initprama{
    _screenWidth=[UIScreen mainScreen].bounds.size.width;
    _screenHeight=[UIScreen mainScreen].bounds.size.height;
    _point=13;
    _cirleArry=[NSMutableArray arrayWithCapacity:_point];
    for (NSUInteger i=0; i<_point; i++) {
        cirlemodel *cirle=[[cirlemodel alloc]initModelWith:[self randomBetween:0 And:self.screenWidth] andy:[self randomBetween:0 And:self.screenHeight] andwidth:[self randomBetween:1 And:9] andOffsetX:[self randomBetween:10 And:-10]/40 andOffsetY:[self randomBetween:10 And:-10]/40];
        [_cirleArry addObject:cirle];
    }
    
}


- (void)run{
    [self.bgview removeFromSuperview];
    self.bgview=nil;
    [self.view addSubview:self.bgview];
  
    
    for (int i=0; i<_point; i++) {
        cirlemodel *model=_cirleArry[i];
        model.orignX+=model.offsetX;
        model.orignY+=model.offsetY;
        if (model.orignX>_screenWidth) {
            model.orignX=0;
        }else if(model.orignX<0){
            model.orignX=_screenWidth;
        }
        
        if (model.orignY>_screenHeight) {
            model.orignY=0;
        }else if (model.orignY<0){
            model.orignY=_screenHeight;
        }
    }
    [self draw];
    
  
    
}

- (void)draw{
     [self initView];
    for (cirlemodel *model in _cirleArry) {
        [self drawCirleWithPrama:model.orignX andy:model.orignY andRadio:model.width andOffsetX:model.offsetX andOffsetY:model.offsetY];
    }
    for (int i=0; i<_point; i++) {
        for (int j=0; j<_point; j++) {
            if (i+j<_point) {
                cirlemodel *model1=_cirleArry[i+j];
                cirlemodel*model2=_cirleArry[i];
                float a=ABS(model1.orignX-model2.orignX);
                float b=ABS(model1.orignY-model2.orignY);
                float length=sqrtf(a*a+b*b);
                float lineOpacity;
                if (length<=_screenWidth/2) {
                    lineOpacity=0.2;
                }else if (_screenWidth/2>length>_screenWidth){
                    lineOpacity=0.15;
                }else if(_screenWidth>length>_screenHeight/2){
                    lineOpacity=0.1;
                }else{
                    lineOpacity=0.0;
                }
                if (lineOpacity>0) {
                    [self drawLinewithPrama:model2.orignX andy:model2.orignY andOpacity:lineOpacity andCloseX:model1.orignX andCloseY:model1.orignY];
                }
            }
        }
    }
    
    
}
-(void)initBtn{
    [self createLB:@"手机号" andPoint:CGPointMake(106*DEF_Adaptation_Font*0.5, 680*DEF_Adaptation_Font*0.5)];
    [self createLB:@"验证码" andPoint:CGPointMake(106*DEF_Adaptation_Font*0.5, 830*DEF_Adaptation_Font*0.5)];
    phoneText=[self createTextField:@"" andImg:@"bg_textField.png" andRect:CGRectMake(106, 740, 428, 50) andTag:100];
    [phoneText becomeFirstResponder];
    codeText=[self createTextField:@"" andImg:@"bg_textField.png" andRect:CGRectMake(106, 890, 428, 50) andTag:101];
    sendBtn =[LooperToolClass createBtnImageNameReal:nil andRect:CGPointMake(393*DEF_Adaptation_Font*0.5,880*DEF_Adaptation_Font*0.5) andTag:1001 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(160*DEF_Adaptation_Font*0.5,40*DEF_Adaptation_Font*0.5) andTarget:self];
    [sendBtn setTitle:@"发送验证码" forState:(UIControlStateNormal)];
    sendBtn.titleLabel.font=[UIFont boldSystemFontOfSize:12*DEF_Adaptation_Font];
    [sendBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
     [[[UIApplication sharedApplication].delegate window] addSubview:sendBtn];
    
    UIImage *image=[UIImage imageNamed:@"btn_login.png"];
    backBtn=[LooperToolClass createBtnImageNameReal:@"btn_login.png" andRect:CGPointMake(DEF_WIDTH(self.view)/2-image.size.width/2, DEF_HEIGHT(self.view)-150*DEF_Adaptation_Font*0.5) andTag:1002 andSelectImage:nil andClickImage:nil andTextStr:nil andSize:CGSizeMake(image.size.width, image.size.height) andTarget:self];
//最高权限
    [[[UIApplication sharedApplication].delegate window] addSubview:backBtn];

    
    
}
-(void)downTimer{
    downTime  =  downTime - 1;
    downNum.text = [NSString stringWithFormat: @"%d秒后可重发",downTime];
    if(downTime == 1){
        [downNum removeFromSuperview];
        sendBtn.hidden= NO;
    }
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    if (button.tag==1001) {
        {
            if([[self securityForTelephone:phoneText.text]intValue]){
//                [_obj requestDataCode:phoneText.text];
                
                sendBtn.hidden= YES;
                downTime = 60;
                
                [downTimer invalidate];
                
                downTimer =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(downTimer) userInfo:nil repeats:YES];
                
                downNum = [LooperToolClass createLableView:CGPointMake(393*DEF_Adaptation_Font*0.5,890*DEF_Adaptation_Font*0.5) andSize:CGSizeMake(150*DEF_Adaptation_Font*0.5, 20*DEF_Adaptation_Font*0.5) andText:[NSString stringWithFormat: @"%d秒后可重发",downTime] andFontSize:10 andColor:[UIColor grayColor] andType:NSTextAlignmentRight];
                [[[UIApplication sharedApplication].delegate window] addSubview:downNum];
            }else{
                [[DataHander sharedDataHander] showViewWithStr:@"输入手机号码错误" andTime:1 andPos:CGPointZero];
            }
        }
    }
    if (button.tag==1002) {
//         if([[self securityForTelephone:phoneText.text]intValue]){
             NSArray *views=[[UIApplication sharedApplication].delegate window].subviews;
             for (UIView *view in views) {
                 if ([view isKindOfClass:[UILabel class]]||[view isKindOfClass:[UIImageView class]]||[view isKindOfClass:[UIButton class]]) {
                      [view setHidden:YES];
                 }
                
             }
             [self getSelectViewData];
//         }
    }
}
-(void)getSelectViewData{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:50];
    [AFNetworkTool Clarnece_Post_JSONWithUrl:@"http://91cp.xin/api/thon/getUserLike" parameters:dic  success:^(id responseObject) {
        if([responseObject[@"status"] intValue]==200){
            SelectViewController *selectVC=[[SelectViewController alloc]init];
            selectVC.dataSources=responseObject[@"data"];
            [self.navigationController pushViewController:selectVC animated:NO];
        }
    }fail:^{
    }];
}
//验证 ：验证请求的是手机号
-(NSNumber*)securityForTelephone:(NSString *)mobile{
    if (mobile.length < 11)
    {
        return 0;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return @1;
        }else{
            return 0;
        }
    }
}
-(UILabel *)createLB:(NSString *)text andPoint:(CGPoint)point{
    UILabel *phoneLB=[[UILabel alloc]initWithFrame:CGRectMake(point.x, point.y, 300*DEF_Adaptation_Font*0.5, 50*DEF_Adaptation_Font*0.5)];
    phoneLB.text=text;
    phoneLB.textColor=[UIColor grayColor];
    phoneLB.font=[UIFont boldSystemFontOfSize:12*DEF_Adaptation_Font];
    [[[UIApplication sharedApplication].delegate window] addSubview:phoneLB];
    return phoneLB;
}
-(UITextField*)createTextField:(NSString*)string andImg:(NSString*)image andRect:(CGRect)rect andTag:(int)num{
    
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(rect.origin.x*DEF_Adaptation_Font*0.5, rect.origin.y*DEF_Adaptation_Font*0.5, rect.size.width*DEF_Adaptation_Font*0.5, rect.size.height*DEF_Adaptation_Font*0.5)];
    bgView.image = [UIImage imageNamed:image];
    bgView.userInteractionEnabled = YES;
    [[[UIApplication sharedApplication].delegate window] addSubview:bgView];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(-2*DEF_Adaptation_Font,0*DEF_Adaptation_Font,  rect.size.width*DEF_Adaptation_Font*0.5, rect.size.height*DEF_Adaptation_Font*0.5)];
    [textField setPlaceholder:string];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    textField.tag =num;
    textField.font =[UIFont fontWithName:looperFont size:13*DEF_Adaptation_Font];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    textField.delegate = self;
    [bgView  addSubview:textField];
    
    return textField;
    
}
#pragma -UITextfieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"textField:%@ \n range:%ld \n string:%@",textField.text,range.length,string);
    if (textField.tag==101) {
        NSInteger num=0;
        if (range.length==0) {
            num=range.location+1;
        }
        else   if (range.length==1) {
            num=range.location;
        }
        if (num==6) {
            if([[self securityForTelephone:phoneText.text]intValue]){
                [joinBtn setSelected:YES];
                joinBtn.backgroundColor=[UIColor whiteColor];
            }else{
                [joinBtn setSelected:NO];
                joinBtn.backgroundColor=[UIColor clearColor];
            }
        }else{
            [joinBtn setSelected:NO];
            joinBtn.backgroundColor=[UIColor clearColor];
        }
    }else if (textField.tag==100){
        //手机号输入
        if ([self securityForTelephone:[NSString stringWithFormat:@"%@%@",textField.text,string]]) {
            if (codeText.text.length==6) {
                [joinBtn setSelected:YES];
                joinBtn.backgroundColor=[UIColor whiteColor];
            }else{
                [joinBtn setSelected:NO];
                joinBtn.backgroundColor=[UIColor clearColor];
            }
        }else{
            [joinBtn setSelected:NO];
            joinBtn.backgroundColor=[UIColor clearColor];
        }
    }
    return YES;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


#pragma -Cricle
- (UIView*)bgview{
    if (!_bgview) {
        _bgview =  [UIView new];
        _bgview.frame=self.view.bounds;
        _bgview.backgroundColor=[UIColor whiteColor];
    }
    return _bgview;
}

//随机返回某个区间范围内的值
- (float) randomBetween:(float)smallerNumber And:(float)largerNumber
{
    //设置精确的位数
    int precision = 100;
    //先取得他们之间的差值
    float subtraction = largerNumber - smallerNumber;
    //取绝对值
    subtraction = ABS(subtraction);
    //乘以精度的位数
    subtraction *= precision;
    //在差值间随机
    float randomNumber = arc4random() % ((int)subtraction+1);
    //随机的结果除以精度的位数
    randomNumber /= precision;
    //将随机的值加到较小的值上
    float result = MIN(smallerNumber, largerNumber) + randomNumber;
    //返回结果
    return result;
}

/*
 画圈
 */
- (void)drawCirleWithPrama:(CGFloat)beginx andy:(CGFloat)beginy andRadio:(CGFloat)width andOffsetX:(CGFloat)offsetx andOffsetY:(CGFloat)offsety{
    CAShapeLayer *solidLine =  [CAShapeLayer layer];
    CGMutablePathRef solidPath =  CGPathCreateMutable();
    solidLine.lineWidth = 7.0f ;
    solidLine.strokeColor = [UIColor colorWithRed:100/255.0f green:100/255.0f blue:100/255.0f alpha:0.4].CGColor;
    solidLine.fillColor = [UIColor clearColor].CGColor;
    CGPathAddEllipseInRect(solidPath, nil, CGRectMake(beginx,  beginy, width, width));
    solidLine.path = solidPath;
    CGPathRelease(solidPath);
    [self.bgview.layer addSublayer:solidLine];
    
}

/*
 划线
 */

- (void)drawLinewithPrama:(CGFloat)beginx andy:(CGFloat)beginy andOpacity:(CGFloat)opacity andCloseX:(CGFloat)closex andCloseY:(CGFloat)closey{
    
    CAShapeLayer *solidShapeLayer = [CAShapeLayer layer];
    
    CGMutablePathRef solidShapePath =  CGPathCreateMutable();
    [solidShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [solidShapeLayer setStrokeColor:[UIColor colorWithRed:100/255.0f green:100/255.0f blue:100/255.0f alpha:opacity].CGColor];
    solidShapeLayer.lineWidth =0.5f ;
    CGPathMoveToPoint(solidShapePath, NULL, beginx, beginy);
    CGPathAddLineToPoint(solidShapePath, NULL, closex,closey);
    
    [solidShapeLayer setPath:solidShapePath];
    CGPathRelease(solidShapePath);
    [self.bgview.layer addSublayer:solidShapeLayer];
}
@end


@implementation cirlemodel

- (instancetype)initModelWith:(CGFloat)orignx andy:(CGFloat)origny andwidth:(CGFloat)width andOffsetX:(CGFloat)offsetx andOffsetY:(CGFloat)offsety{
    
    if (self=[super init]) {
        self.orignX=orignx;
        self.orignY=origny;
        self.width=width;
        self.offsetX=offsetx;
        self.offsetY=offsety;
    }
    return self;
    
}

@end


@implementation linemodel

- (instancetype)initModelWith:(CGFloat)beginx andy:(CGFloat)beginy andOpacity:(CGFloat)opacity andCloseX:(CGFloat)closex andCloseY:(CGFloat)closey{
    
    if (self=[super init]) {
        self.beginX=beginx;
        self.beginY=beginy;
        self.opacity=opacity;
        self.closeX=closex;
        self.closeY=closey;
    }
    return self;
    
}
@end
