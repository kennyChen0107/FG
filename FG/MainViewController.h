//
//  MainViewController.h
//  FG
//
//  Created by Kenny on 2015/3/6.
//  Copyright (c) 2015年 FG. All rights reserved.
//

#import <UIKit/UIKit.h>
#define Stat
#define SliderOffset 200
enum MenuOpen{
    initMenu,
    leftMenuOpen,
    rightMenuOpen,
};

typedef enum MenuClick{
    leftClick,
    rightClick
} menuClick;

@interface MainViewController : UIViewController
@end
