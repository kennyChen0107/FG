//
//  RightMenuViewController.m
//  FG
//
//  Created by Kenny on 2015/3/6.
//  Copyright (c) 2015年 FG. All rights reserved.
//

#import "RightMenuViewController.h"

@interface RightMenuViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *titleArray;
}
@end

@implementation RightMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    titleArray = [[NSMutableArray alloc] initWithObjects:@"登入", @"G幣", @"訊息", @"話題", @"朋友", @"收藏", nil];
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _rightTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titleArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.imageView.image = [UIImage imageNamed:@"leftMenu.png"];
    cell.textLabel.text = [titleArray objectAtIndex:indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

@end
