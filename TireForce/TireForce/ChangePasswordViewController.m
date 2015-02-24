//
//  ForgotPasswordViewController.m
//  TireForce
//
//  Created by CANOPUS5 on 24/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "UserInformation.h"
#import "WebServiceHandler.h"
#import "XMLDictionary.h"
#import "HUDManager.h"
@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[_buttonSend layer] setCornerRadius:4.0];
    [[_buttonSend layer] setBorderWidth:1.0];
    [[_buttonSend layer] setBorderColor:[UIColor darkGrayColor].CGColor];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)SendButtonAction:(id)sender
{
 if(_textFieldEmail.text.length==0)
 {
     [[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Email" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];

 }else if(_textFieldOldPassword.text==0)
 {
     [[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Old Password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
 }
else if(_textFieldNewPassword.text==0)
{
    [[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter New Password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
}
else
{
    NSDictionary *dict=@{@"UserLogin": _textFieldEmail.text,
                         @"Password": _textFieldOldPassword.text,
                         @"IsMh5": @"false",
                         @"token": [UserInformation sharedInstance].token,
                         @"NewPass":_textFieldNewPassword.text,
                         };
    [HUDManager showHUDWithText:PleaseWait];
    [[WebServiceHandler webServiceHandler] changePassword:dict completionHandlerSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [HUDManager hideHUD];
    NSDictionary *dict= [[XMLDictionaryParser sharedInstance] dictionaryWithData:responseObject];
        NSString *errorCode=[dict valueForKey:@"ErrorCode"];
        NSString *value=[dict valueForKey:@"Success"];
        
        if([errorCode isEqualToString:@"0"] && [value isEqualToString:@"true"])
        {
                [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Password Changed" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        }
        else if([errorCode isEqualToString:@"1"] && [value isEqualToString:@"false"])
        {
            [[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Invalid User Or Pass" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        }
            } completionHandlerFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [HUDManager hideHUD];
    }];
}
}

@end
