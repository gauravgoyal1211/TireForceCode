
//
//  AddPartViewController.m
//  TireForce
//
//  Created by CANOPUS5 on 19/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//



#import "AddPartViewController.h"
#import "HUDManager.h"
#import "WebServiceHandler.h"
#import "UserInformation.h"
extern BOOL needToUpdate;
@interface AddPartViewController ()


@end

@implementation AddPartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[_buttonAdd layer] setCornerRadius:4.0];
    [[_buttonAdd layer] setBorderColor:[UIColor colorWithRed:223.0/255.0 green:170.0/255.0 blue:13.0/255.0 alpha:1.0].CGColor];
    [[_buttonAdd layer] setBorderWidth:1.0];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addButtonAction:(id)sender {

    if(_textFieldPartName.text.length>0 && _textFieldPartPrice.text.length>0)
    {

        needToUpdate=YES;
        NSString *userId=[UserInformation sharedInstance].userId;
        NSString *token=[UserInformation sharedInstance].token
        ;
        NSDictionary *dict=@{@"userid":userId,
                                  @"token":token,
                                  @"ParentId":_parentId,
                                  @"Uid":@"",
                                  @"PartNum":_textFieldPartName.text,
                                  @"Price":_textFieldPartPrice.text,
                             };
        [HUDManager showHUDWithText:PleaseWait];
        [[WebServiceHandler webServiceHandler] addPart:dict completionHandlerSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Part added successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil] show];
            [HUDManager hideHUD];
        } completionHandlerFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [HUDManager hideHUD];
        }];
    }else
    {
        [[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Required Information" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    }
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
