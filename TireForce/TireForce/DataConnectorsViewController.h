//
//  EditDataConnectorsViewController.h
//  TireForce
//
//  Created by CANOPUS5 on 16/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface DataConnectorsViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end
