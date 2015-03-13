//
//  LeftMenuViewController.m
//  FG
//
//  Created by Kenny on 2015/3/6.
//  Copyright (c) 2015年 FG. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "LeftMenuMainCell.h"
@interface LeftMenuViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *titleArray;
    NSMutableArray *detailArray;
    BOOL isOpen;
    NSIndexPath *selectIndex;
}
@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSMutableArray *fashionDetail = [[NSMutableArray alloc] initWithObjects:@"穿搭", @"News", nil];
    NSMutableArray *beautyDetail = [[NSMutableArray alloc] initWithObjects:@"A", @"B", @"C", @"D", nil];
    NSMutableArray *lifeDetail = [[NSMutableArray alloc] initWithObjects:@"A", @"B", @"C", nil];
    NSMutableArray *test = [[NSMutableArray alloc] initWithObjects:nil];
    
    titleArray = [[NSMutableArray alloc] initWithObjects:@"Fashion", @"Beauty", @"生活", @"測試", nil];
    detailArray = [[NSMutableArray alloc] initWithObjects:fashionDetail, beautyDetail, lifeDetail, test, nil];
    
    _leftTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _leftTableView.separatorColor = [UIColor blackColor];
    _leftTableView.dataSource = self;
    _leftTableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [titleArray count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(isOpen){
        if(section == selectIndex.section){
            return [[detailArray objectAtIndex:selectIndex.section]count]+1;
        }
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[detailArray objectAtIndex:indexPath.section]count] != 0 && indexPath.row == 0){
        static NSString *cellIdentifier = @"LeftMenuMainCell";
        LeftMenuMainCell *cell = (LeftMenuMainCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell){
            cell = [[[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil] objectAtIndex:0];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.titleLabel.text = [titleArray objectAtIndex:indexPath.section];
        if(isOpen && selectIndex.section == indexPath.section){
            [cell changeArrowImg:YES];
        }else{
            [cell changeArrowImg:NO];
        }
        return cell;
    }else{
        static NSString *cellIdentifier = @"Cell";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if([[detailArray objectAtIndex:indexPath.section]count] == 0){
            cell.textLabel.text = [titleArray objectAtIndex:indexPath.section];
        }else{
            cell.textLabel.text = [[detailArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row - 1];
        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[detailArray objectAtIndex:indexPath.section]count] != 0 && indexPath.row == 0){
        if(isOpen){
            if(selectIndex.section != indexPath.section){
                [self didSelectRowDo:NO nextDo:YES];
            }else{
                isOpen = NO;
                [self didSelectRowDo:NO nextDo:NO];
                selectIndex = nil;
            }
        }else{
            selectIndex = indexPath;
            [self didSelectRowDo:YES nextDo:NO];
        }
    }else{
        NSLog(@"你點了第%ld個section的第%ld個row", (long)indexPath.section, (long)indexPath.row);
    }
}

-(void)didSelectRowDo:(BOOL)firstInsert nextDo:(BOOL)nextInsert
{
    isOpen = firstInsert;
    
    LeftMenuMainCell *cell = (LeftMenuMainCell *)[self.leftTableView cellForRowAtIndexPath:selectIndex];
    [cell changeArrowImg:firstInsert];
    
    NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
    int contentCount = (int)[[detailArray objectAtIndex:selectIndex.section]count];
    [self.leftTableView beginUpdates];
    for (NSUInteger i = 1; i <= contentCount; i++) {
        NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:selectIndex.section];
        [rowToInsert addObject:indexPathToInsert];
    }
    if(firstInsert){
        [self.leftTableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }else{
        [self.leftTableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationLeft];
    }
    [self.leftTableView endUpdates];
    if(nextInsert){
        selectIndex = [_leftTableView indexPathForSelectedRow];
        [self didSelectRowDo:YES nextDo:NO];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}

@end
