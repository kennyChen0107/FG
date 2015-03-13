//
//  CenterViewController.m
//  FG
//
//  Created by Kenny on 2015/3/6.
//  Copyright (c) 2015年 FG. All rights reserved.
//

#import "CenterViewController.h"

@interface CenterViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTableView
{
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.backgroundColor = [UIColor clearColor];
    self.backTopBtn.hidden = YES;
    self.appendBtn.hidden = YES;
    [_backTopBtn addTarget:self action:@selector(backTopHandler:) forControlEvents:UIControlEventTouchUpInside];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = @"Test";
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor colorWithRed:84.0/255.0 green:140.0/255.0 blue:100.0/255.0 alpha:1];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 150, 30)];
    switch (section) {
        case 0:
            titleLabel.text = @"Fashion";
            break;
        case 1:
            titleLabel.text = @"Beauty";
            break;
        case 2:
            titleLabel.text = @"生活";
            break;
    }
    [headerView addSubview:titleLabel];
    
    return headerView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.y > 15){
        self.backTopBtn.hidden = NO;
        self.appendBtn.hidden = NO;
    }else{
        self.backTopBtn.hidden = YES;
        self.appendBtn.hidden = YES;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

-(void)backTopHandler:(UIButton *)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        [_mainTableView setContentOffset:CGPointMake(0, 0)];
    }];
}


@end
