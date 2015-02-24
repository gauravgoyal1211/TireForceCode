//
//  EditPriceMarkupViewController.h
//  TireForce
//
//  Created by CANOPUS5 on 18/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface EditPriceMarkupViewController : BaseViewController
@property (nonatomic,strong) NSMutableArray *arrayForCostJson;
@property (nonatomic) NSInteger seletedIndex;
@property (weak, nonatomic) IBOutlet UILabel *labelPriceHeader;
@property (nonatomic,strong) NSString *lableString;
@property (weak, nonatomic) IBOutlet UISwitch *switchForPercentage;
@property (weak, nonatomic) IBOutlet UISwitch *switchForDollar;
@property (weak, nonatomic) IBOutlet UITextField *textFieldForPercentage;
@property (weak, nonatomic) IBOutlet UITextField *textFieldForDollar;
@property(strong,nonatomic) NSString *parentID;
@end
