//
//  EditDataConnnectorCell.h
//  TireForce
//
//  Created by CANOPUS5 on 16/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQDropDown.h"
@interface DataConnnectorCell : UITableViewCell
@property (weak, nonatomic) IBOutlet IQDropDown *textFieldSupplierName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUserName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (weak, nonatomic) IBOutlet UIButton *buttonToActiveState;
@property (weak, nonatomic) IBOutlet UIButton *ButtonSave;

@end
