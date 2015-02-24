

//
//  BaseViewController.m
//  TireForce
//
//  Created by CANOPUS5 on 18/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(10, 0, 100, 35)];
    UIImageView *imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Tire Force_Logo"]];
    [imgView setFrame:CGRectMake(0, 0, 120, 35)];
    [view setBackgroundColor:[UIColor clearColor]];
    [view addSubview:imgView];
    self.navigationItem.titleView=view;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
