//
//  AddPartViewController.h
//  TireForce
//
//  Created by CANOPUS5 on 19/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface AddPartViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textFieldPartName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPartPrice;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;
@property(nonatomic,strong) NSString *parentId;






@end
