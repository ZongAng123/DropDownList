//
//  RootViewController.m
//  DropDownList
//
//  Created by 纵昂 on 2017/3/3.
//  Copyright © 2017年 纵昂. All rights reserved.
//
#define KSIZE ([UIScreen mainScreen].bounds.size)
#import "RootViewController.h"
#import "CharTableViewCell.h"
#import "charModel.h"

@interface RootViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) NSMutableArray *listHeadData;
@property (nonatomic, strong) NSMutableArray *rotaYN;

@end

@implementation RootViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.title = @"聊一聊";
    [self initData];
    [self createTableView];
    [self requestDataSource];
}

- (void)initData{
    if (!_listArray || !_listHeadData || !_rotaYN) {
        _listArray = [[NSMutableArray alloc] init];
        _listHeadData = [[NSMutableArray alloc] init];
        _rotaYN = [[NSMutableArray alloc] init];
    }
}

- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 20/ 375.0 * KSIZE.width, KSIZE.width, KSIZE.height - 64 - 30 / 375.0 * KSIZE.width)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.rowHeight = 66 / 375.0 * KSIZE.width;
    _tableView.sectionHeaderHeight = 50 / 375.0 * KSIZE.width;
}

- (void)requestDataSource{
    NSString * pathOne = [[NSBundle mainBundle] pathForResource:@"list" ofType:@"plist"];;
    NSArray * arrayOne = [NSArray arrayWithContentsOfFile:pathOne];
    NSLog(@"%ld", arrayOne.count);
    for (NSDictionary * dict in arrayOne) {
        NSString * title = dict[@"name"];
        [_listHeadData addObject:title];
        NSMutableArray * array = [[NSMutableArray alloc]init];
        for (NSDictionary * dic in dict[@"groups"]) {
            charModel * model = [[charModel alloc] init];
            model.iconName = dic[@"icon"];
            model.name = dic[@"name"];
            model.intro = dic[@"intro"];
            model.timer = dic[@"timer"];
            [array addObject:model];
        }
        
        [_listArray addObject:array];
        
        
        
        [_rotaYN addObject:@NO];
    }
    [_tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 66 / 375.0 * KSIZE.width;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([_rotaYN[section] boolValue]==YES) {
        return [_listArray[section] count];
    }
    else{
        return 0;
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _listHeadData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CharTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[CharTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    charModel * model = _listArray[indexPath.section][indexPath.row];
    //        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    [cell setModel:model];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45.0f;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320 / 375.0 * KSIZE.width, 45 / 375.0 * KSIZE.width)];
    view.backgroundColor=[UIColor whiteColor];
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15 / 375.0 * KSIZE.width, 13 / 375.0 * KSIZE.width, 11 / 375.0 * KSIZE.width, 18 / 375.0 * KSIZE.width)];
    [button setImage:[UIImage imageNamed:@"pulldownList.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(openCLick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    button.tag = 1000 + section;
    
    
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(46 / 375.0 * KSIZE.width, 0, 200 / 375.0 * KSIZE.width, 45 / 375.0 * KSIZE.width)];
    lable.text=_listHeadData[section];
    lable.textColor=[UIColor colorWithRed:0.31 green:0.85 blue:0.56 alpha:1.0];
    lable.font = [UIFont boldSystemFontOfSize:15 / 375.0 * KSIZE.width];
    [view addSubview:lable];
    
    
    CGFloat rota;
    if ([_rotaYN[section] boolValue]==NO) {
        rota=0;
    }
    else{
        rota=M_PI_2;
    }
    button.transform=CGAffineTransformMakeRotation(rota);
    
    
    
    
    return view;
    
}

-(void)openCLick:(UIButton *)button
{
    NSInteger section=button.tag-1000;
    
    if ([_rotaYN[section] boolValue]==NO) {
        [_rotaYN replaceObjectAtIndex:section withObject:@YES];
    }
    else{
        [_rotaYN replaceObjectAtIndex:section withObject:@NO];
    }
    
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationTop];
    
}

@end
