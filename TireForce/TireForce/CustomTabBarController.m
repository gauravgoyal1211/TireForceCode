//
//  customTabBarControllerViewController.m
//  SnapNPop
//
//  Created by Canopus 6 on 28/05/14.
//  Copyright (c) 2014 Canopus. All rights reserved.
//

#import "CustomTabBarController.h"

@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
    }
   
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self customizeTabBarItem];
    [self setDelegate:self];
    
	// Do any additional setup after loading the view.
}

-(void)customizeTabBarItem
{
    
    // TabBarSetUp
    
    UITabBar *tabBar = (UITabBar *)self.tabBar;

    
    //tab1
    UITabBarItem *item1 = [tabBar.items objectAtIndex:0];
    item1.image = [[UIImage imageNamed:@"dash-board"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    item1.selectedImage = [[UIImage imageNamed:@"dash-boardSel"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //tab2
    UITabBarItem *item2 = [tabBar.items objectAtIndex:1];
    item2.image = [[UIImage imageNamed:@"setting"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    item2.selectedImage = [[UIImage imageNamed:@"settingSel"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //tab3
    UITabBarItem *item3 = [tabBar.items objectAtIndex:2];
    item3.image = [[UIImage imageNamed:@"connector"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    item3.selectedImage = [[UIImage imageNamed:@"connectorSel"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //tab4
    UITabBarItem *item4 = [tabBar.items objectAtIndex:3];
    item4.image = [[UIImage imageNamed:@"price"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    item4.selectedImage = [[UIImage imageNamed:@"priceSel"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    UITabBarItem *item5 = [tabBar.items objectAtIndex:4];
    item5.image = [[UIImage imageNamed:@"web"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    item5.selectedImage = [[UIImage imageNamed:@"webSelect"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // for ios 7
    [[UITabBar appearance] setTintColor:[UIColor yellowColor
                                         ]];
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:39.0/255.0 green:39.0/255.0 blue:39.0/255.0 alpha:1.0]];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- -UiTabBarcontrollerDelegate-

- (void)tabBarController:(UITabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"controller class: %@", NSStringFromClass([viewController class]));
    NSLog(@"controller title: %@", viewController.title);
    NSLog(@"%@",self.navigationController.viewControllers);
    
    if (viewController == tabBarController.moreNavigationController)
    {
//        tabBarController.moreNavigationController.delegate = self;
    }
}
@end
