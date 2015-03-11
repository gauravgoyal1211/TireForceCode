//
//  ViewController.h
//  TireForce
//
//  Created by CANOPUS5 on 13/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *outerViewOfLogin;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUserName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (weak, nonatomic) IBOutlet UIButton *buttonSignIn;
@property (weak, nonatomic) IBOutlet UILabel *labelErrorMessage;
@property (weak, nonatomic) IBOutlet UIButton *butttonRememberMe;
@end

