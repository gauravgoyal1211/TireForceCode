
//
//  ForgotMyPasswordViewController.m
//  TireForce
//
//  Created by CANOPUS16 on 07/03/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import "ForgotMyPasswordViewController.h"

@interface ForgotMyPasswordViewController ()

@end

@implementation ForgotMyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[_buttonSend layer] setCornerRadius:4.0];
    [[_buttonSend layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    [[_buttonSend layer] setBorderWidth:1];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sendButtonAction:(id)sender {
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
     [self.navigationController setNavigationBarHidden:YES animated:YES];
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
