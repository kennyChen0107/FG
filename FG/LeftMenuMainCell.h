//
//  LeftMenuMainCellTableViewCell.h
//  FG
//
//  Created by Kenny on 2015/3/9.
//  Copyright (c) 2015年 FG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuMainCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImg;
-(void)changeArrowImg:(BOOL)isOpen;
@end
