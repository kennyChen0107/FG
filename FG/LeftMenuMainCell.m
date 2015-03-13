//
//  LeftMenuMainCellTableViewCell.m
//  FG
//
//  Created by Kenny on 2015/3/9.
//  Copyright (c) 2015年 FG. All rights reserved.
//

#import "LeftMenuMainCell.h"

@implementation LeftMenuMainCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)changeArrowImg:(BOOL)isOpen
{
    if(isOpen){
        self.arrowImg.image = [UIImage imageNamed:@"UpAccessory.png"];
    }else{
        self.arrowImg.image = [UIImage imageNamed:@"DownAccessory.png"];
    }
}


@end
