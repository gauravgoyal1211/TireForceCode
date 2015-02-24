//
//  ViewController.m
//  TireForce
//
//  Created by CANOPUS5 on 12/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//
#import "LoginViewController.h"
#import "WebServiceHandler.h"
#import "TFUtility.h"
#import "HUDManager.h"
#import "XMLDictionary.h"
#import "UserInformation.h"
#import "SidePanelViewController.h"
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

@interface LoginViewController ()
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    {
        [[_buttonSignIn layer]setMasksToBounds:YES];
        [[_buttonSignIn layer] setCornerRadius:4.0];
        [[TFUtility sharedInstance] setLeftPadding:_textFieldUserName imageName:nil width:7];
        [[TFUtility sharedInstance] setLeftPadding:_textFieldPassword imageName:nil width:7];
        [[_butttonRememberMe layer] setBorderWidth:2.0];
        [[_butttonRememberMe layer] setCornerRadius:12.5];
        [[_butttonRememberMe layer] setMasksToBounds:YES];
        [[_butttonRememberMe layer] setBorderColor:[UIColor colorWithRed:39.0/255.0 green:39.0/255.0 blue:39.0/255.0 alpha:1.0].CGColor];
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"Change" style:UIBarButtonItemStyleDone target:self action:@selector(registerAction:)];
    }
    
    if (IS_IPHONE_5)
    {
        [_distanceBWNViewAndLogo setConstant:170];
    }

}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"email"] length]>0)
    {
        _textFieldUserName.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
        _textFieldPassword.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
        _butttonRememberMe.tag=1;
        [_butttonRememberMe setBackgroundImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    }else
    {
        _textFieldUserName.text=@"";
        _textFieldPassword.text=@"";
        [_butttonRememberMe setTag:0];
        [_butttonRememberMe setBackgroundImage:nil forState:UIControlStateNormal];
        
        
    }

}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- -ButtonAction-

- (IBAction)actionSignIn:(id)sender {
    
    if(_textFieldUserName.text.length==0)
    {
        [_labelErrorMessage setText:@"*Please Enter Username"];
    }else if (_textFieldPassword.text.length==0)
    {
        [_labelErrorMessage setText:@"*Please Enter Password"];
    }else
    {
        [self callWebSerivceWithParameter:[self PreareDictionary]];
    }
}

- (IBAction)rememberMeButtonAction:(UIButton *)sender {
    
    if(sender.tag==0)
    {
        [_butttonRememberMe setBackgroundImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        sender.tag=1;
        [[NSUserDefaults standardUserDefaults] setObject:_textFieldUserName.text forKey:@"email"];
        [[NSUserDefaults standardUserDefaults] setObject:_textFieldPassword.text forKey:@"password"];
    }else
    {
         sender.tag=0;
        [_butttonRememberMe setBackgroundImage:nil forState:UIControlStateNormal];
         [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
    }
}

-(void)registerAction:(id)sender
{
    [self performSegueWithIdentifier:@"forgotPassword" sender:nil];
}


-(NSDictionary *)PreareDictionary
{
    NSDictionary *dict=@{@"UserLogin": _textFieldUserName.text,
                         @"Password": _textFieldPassword.text,
                         @"IsMh5": @0,
                         @"token": [UserInformation sharedInstance].token
                         };
    return dict;
}
#pragma mark- -WebserviceCalling-
-(void)callWebSerivceWithParameter:(NSDictionary *)dict
{
    [HUDManager showHUDWithText:PleaseWait];
    [[WebServiceHandler webServiceHandler] loginWithParameter:dict completionHandlerSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSXMLParser *parser =  responseObject;
        NSDictionary *dict=[[XMLDictionaryParser sharedInstance] dictionaryWithParser:parser];
        NSDictionary *soapBody=[dict valueForKey:@"soap:Body"];
        NSDictionary *loginResponce=[soapBody valueForKey:@"LoginResponse"];
        NSDictionary *loginResult=[loginResponce valueForKey:@"LoginResult"];
        
        NSString *ErrorCode=[loginResult valueForKey:@"ErrorCode"];
        NSString *Success=[loginResult valueForKey:@"Success"];

        [HUDManager hideHUD];
        if([ErrorCode isEqualToString:@"1"] || [Success isEqualToString:@"false"])
        {
            [[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Invalid User Or Password" delegate:nil   cancelButtonTitle:@"Ok"otherButtonTitles:nil, nil] show];
        }else if([Success isEqualToString:@"true"])
        {
            NSString *login=[loginResult valueForKey:@"login"];
            NSString  *UserId=[loginResult valueForKey:@"UserId"];
            NSString *Email=[loginResult valueForKey:@"Email"];
            [UserInformation sharedInstance].userName=login;
            [UserInformation sharedInstance].userId=UserId;
            [UserInformation sharedInstance].EmailId=Email;
            NSLog(@"%@",dict);
            [self performSegueWithIdentifier:@"loginSuccess" sender:nil];
        }
    } completionHandlerFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [HUDManager hideHUD];
    }];
}
#pragma mark- -TextFieldDelegate-
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_labelErrorMessage setText:@""];
}
@end
