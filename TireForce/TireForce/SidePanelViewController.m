//
//  RXSidePanelVC.m
//  RoxleApp
//
//  Created by Arjun Hastir on 09/01/15.
//  Copyright (c) 2015 Mobiloitte. All rights reserved.
//

#import "SidePanelViewController.h"

@interface SidePanelViewController ()

@end

@implementation SidePanelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) awakeFromNib
{
    [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"sideMenu"]];
    [self setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"CentreNavigationID"]];
}


@end
