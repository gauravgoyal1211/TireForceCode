//
//  TireQueriesViewController.h
//  TireForce
//
//  Created by CANOPUS5 on 13/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface TireQueriesViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tabelview;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@end
