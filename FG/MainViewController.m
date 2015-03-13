//
//  MainViewController.m
//  FG
//
//  Created by Kenny on 2015/3/6.
//  Copyright (c) 2015年 FG. All rights reserved.
//

#import "MainViewController.h"
#import "LeftMenuViewController.h"
#import "CenterViewController.h"
#import "RightMenuViewController.h"

@interface MainViewController ()
{
    UIButton *leftButton;
    UIButton *rightButton;
    CenterViewController *centerView;
    LeftMenuViewController *leftMenu;
    RightMenuViewController *rightMenu;
    enum MenuOpen menu;
    UISwipeGestureRecognizer *swipeLeft;
    UISwipeGestureRecognizer *swipeRight;
    UIView *leftView;
    UIView *rightView;
    float sliderOffset;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    [self initView];
    
    self.view.userInteractionEnabled = YES;
    
    swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavigationBar
{
    leftButton  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftButton setImage:[UIImage imageNamed:@"leftMenu"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(menuSliderHandler:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    rightButton  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightButton setImage:[UIImage imageNamed:@"leftMenu"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(menuSliderHandler:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}


-(void)initView
{
    menu = initMenu;
    
    leftMenu = [[LeftMenuViewController alloc] init];
    [self addChildViewController:leftMenu];
    [self.view addSubview:leftMenu.view];
    
    rightMenu = [[RightMenuViewController alloc] init];
    [self addChildViewController:rightMenu];
    [self.view addSubview:rightMenu.view];
    
    centerView = [[CenterViewController alloc] init];
    [self addChildViewController:centerView];
    [centerView.view setFrame:self.view.frame];
    [self.view addSubview:centerView.view];
}

-(void)menuSliderHandler:(UIButton *)sender
{
    if([sender isEqual:leftButton]){
        [self animateHandler:leftClick];
    }else if([sender isEqual:rightButton]){
        [self animateHandler:rightClick];
    }
}

-(void)handleSwipe:(UISwipeGestureRecognizer *)gesture
{
    if(gesture.direction == UISwipeGestureRecognizerDirectionRight){
        if(menu == leftMenuOpen){
            return;
        }
        [self animateHandler:leftClick];
    }else if(gesture.direction == UISwipeGestureRecognizerDirectionLeft){
        if(menu == rightMenuOpen){
            return;
        }
        [self animateHandler:rightClick];
    }
}

-(void)animateHandler:(menuClick)click{
    [UIView animateWithDuration:0.3 animations:^{
        if(menu == initMenu){
            if(click == leftClick){
                [centerView.view setFrame:CGRectMake(SliderOffset, centerView.view.frame.origin.y, centerView.view.frame.size.width, centerView.view.frame.size.height)];
                [self.navigationController.navigationBar setFrame:CGRectMake(SliderOffset, self.navigationController.navigationBar.frame.origin.y, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
                menu = leftMenuOpen;
                leftMenu.view.hidden = NO;
                rightMenu.view.hidden = YES;
            }else if(click == rightClick){
                [centerView.view setFrame:CGRectMake(-SliderOffset, centerView.view.frame.origin.y, centerView.view.frame.size.width, centerView.view.frame.size.height)];
                [self.navigationController.navigationBar setFrame:CGRectMake(-SliderOffset, self.navigationController.navigationBar.frame.origin.y, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
                menu = rightMenuOpen;
                leftMenu.view.hidden = YES;
                rightMenu.view.hidden = NO;
            }
        }else{
            [centerView.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            //y座標起始位置20為加上Status Bar高度
            [self.navigationController.navigationBar setFrame:CGRectMake(0, 20, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
            menu = initMenu;
        }
    }];
}

@end
