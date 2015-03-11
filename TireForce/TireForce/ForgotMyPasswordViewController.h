//
//  ForgotMyPasswordViewController.h
//  TireForce
//
//  Created by CANOPUS16 on 07/03/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface ForgotMyPasswordViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmailID;
@property (weak, nonatomic) IBOutlet UIButton *buttonSend;

@end
