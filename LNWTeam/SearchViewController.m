//
//  SearchViewController.m
//  LNWTeam
//
//  Created by 工作 on 2017/11/26.
//  Copyright © 2017年 lujiawei. All rights reserved.
//

#import "SearchViewController.h"
#import "LooperToolClass.h"
#import "LooperConfig.h"
#import "ViewController.h"
@interface SearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UISearchBar*  mySeatchBar;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *searchDatas;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self.view), DEF_HEIGHT(self.view))];
    imageV.image=[UIImage imageNamed:@"search.png"];
    imageV.contentMode=UIViewContentModeScaleAspectFill;
    imageV.clipsToBounds=YES;
    [self.view addSubview:imageV];
    UIView *backV=[[UIView alloc]initWithFrame:imageV.frame];
    backV.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [imageV addSubview:backV];
    [self createSerachViewHud];
}
#pragma -UISearchBar
-(void)createSerachViewHud{
    UIButton *backBtn = [LooperToolClass createBtnImageNameReal:@"btn_ticketBack.png" andRect:CGPointMake(0,50*DEF_Adaptation_Font*0.5) andTag:100 andSelectImage:@"btn_ticketBack.png" andClickImage:@"btn_ticketBack.png" andTextStr:nil andSize:CGSizeMake(106*DEF_Adaptation_Font*0.5,84*DEF_Adaptation_Font*0.5) andTarget:self];
    [self.view addSubview:backBtn];
    UIButton *serachBtn = [LooperToolClass createBtnImageName:@"chatlist_serach.png" andRect:CGPointMake(503, 46) andTag:101 andSelectImage:@"chatlist_serach.png" andClickImage:@"chatlist_serach.png" andTextStr:nil andSize:CGSizeZero andTarget:self];
    [self.view addSubview:serachBtn];
    //    UIImageView *line = [LooperToolClass createImageView:@"bg_serach_line.png" andRect:CGPointMake(66, 120) andTag:100 andSize:CGSizeMake(519, 1) andIsRadius:false];
    //     [self addSubview:line];
    UIView *lineV=[[UIView alloc]initWithFrame:CGRectMake(60*DEF_Adaptation_Font*0.5, 115*DEF_Adaptation_Font*0.5, 519*DEF_Adaptation_Font*0.5, 1.0*DEF_Adaptation_Font*0.5)];
    lineV.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
    [self.view addSubview:lineV];
    
    mySeatchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(76 * DEF_Adaptation_Font*0.5, 60 * DEF_Adaptation_Font*0.5, 477*0.5*DEF_Adaptation_Font, 50 * DEF_Adaptation_Font*0.5)];
    mySeatchBar.delegate = self;
    [mySeatchBar setBackgroundColor:[UIColor clearColor]];
    [[[mySeatchBar.subviews objectAtIndex:0].subviews objectAtIndex:0] removeFromSuperview];
    mySeatchBar.autocorrectionType = UITextAutocorrectionTypeDefault;
    mySeatchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    mySeatchBar.barStyle = UIBarStyleBlack;
    mySeatchBar.placeholder = @"全局搜索";
    [mySeatchBar becomeFirstResponder];
    [self.view addSubview:mySeatchBar];
    
    UITextField *txfSearchField = [mySeatchBar valueForKey:@"_searchField"];
    txfSearchField.font=[UIFont systemFontOfSize:14*DEF_Adaptation_Font];
    [txfSearchField setBackgroundColor:[UIColor clearColor]];
    [txfSearchField setLeftViewMode:UITextFieldViewModeNever];
    [txfSearchField setRightViewMode:UITextFieldViewModeNever];
    [txfSearchField setBackground:[UIImage imageNamed:@"searchbar_bgImg.png"]];
    [txfSearchField setBorderStyle:UITextBorderStyleNone];
    txfSearchField.layer.borderColor = [UIColor clearColor].CGColor;
    txfSearchField.clearButtonMode=UITextFieldViewModeNever;
}
-(void)updateData{
    _searchDatas=@[@"驾车模式",@"步行模式",@"公车模式",@"骑行模式",@"飞行模式",@"私人游模式",@"快速非拥挤模式",@"最近省油模式",@"自定义模式"];
    [self.tableView reloadData];
}
- (IBAction)btnOnClick:(UIButton *)button withEvent:(UIEvent *)event{
    if(button.tag==100){
        [self.navigationController popViewControllerAnimated:YES];
    }else if(button.tag==101){
        [self updateData];
        [self.view endEditing:true];
    }
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self updateData];
    [self.view endEditing:true];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma -UITableView,在这里没用到，直接使用了familyRankView
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 130*DEF_Adaptation_Font*0.5, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 130*DEF_Adaptation_Font*0.5) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = NO;
        _tableView.backgroundColor=[UIColor clearColor];
        //取消button点击延迟
        _tableView.delaysContentTouches = NO;
        //禁止上拉
        _tableView.alwaysBounceVertical=YES;
        _tableView.bounces=NO;
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.searchDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.accessoryType=UITableViewCellStyleDefault;
    cell.backgroundColor=[UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(self.view), 30*DEF_Adaptation_Font)];
    label.text=[NSString stringWithFormat:@"       %@",[self.searchDatas objectAtIndex:indexPath.row]];
    label.font=[UIFont boldSystemFontOfSize:20];
    [cell.contentView addSubview:label];
    UIView *backV=[[UIView alloc]initWithFrame:CGRectMake(10, 29*DEF_Adaptation_Font, DEF_WIDTH(self.view)-20, 1.0*DEF_Adaptation_Font*0.5)];
    backV.backgroundColor=[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.3];
    [cell.contentView addSubview:backV];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  30*DEF_Adaptation_Font;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"选择了列表中的%@", [self.searchDatas objectAtIndex:indexPath.row]);
    ViewController *vc = [[ViewController alloc] init];
    [[self navigationController]pushViewController:vc animated:false];
}


@end
