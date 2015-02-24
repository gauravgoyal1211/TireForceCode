
//
//  AddSupplierViewController.m
//  TireForce
//
//  Created by CANOPUS5 on 23/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import "AddSupplierViewController.h"
#import "IQDropDown.h"
#import "WebServiceHandler.h"
#import "UserInformation.h"
#import "HUDManager.h"
@interface AddSupplierViewController ()
    @property (weak, nonatomic) IBOutlet IQDropDown *textFieldSupplierName;
    @property (weak, nonatomic) IBOutlet UITextField *textFieldUserName;
    @property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
    @property (weak, nonatomic) IBOutlet UIButton *buttonToActiveState;
    @property (weak, nonatomic) IBOutlet UIButton *ButtonAdd;
@end

@implementation AddSupplierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // customization
    {
        [[_buttonToActiveState layer] setMasksToBounds:YES];
        [[_buttonToActiveState layer] setCornerRadius:4.0];
        [[_buttonToActiveState layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        [[_buttonToActiveState layer] setBorderWidth:1.0];
        [_buttonToActiveState setTag:0];
        [[_ButtonAdd layer] setMasksToBounds:YES];
        [[_ButtonAdd layer] setCornerRadius:4.0];
        [_textFieldSupplierName setItemList:[_dictForSupplierAvailable allKeys]];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonActiveAction:(UIButton *)sender {
    if(sender.tag==0)
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"checkGray"] forState:UIControlStateNormal];
        sender.tag=1;
    }else
    {
        [sender setBackgroundImage:nil forState:UIControlStateNormal];
        sender.tag=0;
    }
}
- (IBAction)ButtonAddAction:(UIButton *)sender {
    
    [self webSeviceCalling];
}


#pragma mark- -webservice Calling-
-(void)webSeviceCalling
{
    
    BOOL isactive=(BOOL)_buttonToActiveState.tag;
    NSString  *supplierId=[_dictForSupplierAvailable valueForKey:_textFieldSupplierName.text];
    NSDictionary *dictNew=@{
                            @"userid":[UserInformation sharedInstance].userId,
                            @"token":[UserInformation sharedInstance].token,
                            @"User":_textFieldUserName.text,
                            @"pass":_textFieldPassword.text,
                            @"supplierid":supplierId,
                            @"active":(isactive)?@"true":@"false"
                            };
    [HUDManager showHUDWithText:PleaseWait];
    [[WebServiceHandler webServiceHandler] addSupplier:dictNew completionHandlerSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [HUDManager hideHUD];
                [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Supplier Added Successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        if([self.delegate respondsToSelector:@selector(needToUpdate)])
        {
            [self.delegate needToUpdate];
        }
        
    } completionHandlerFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [HUDManager hideHUD];
    }];
}

@end
