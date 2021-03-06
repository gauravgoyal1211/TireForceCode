//
//  SearchResultViewController.h
//  TireForce
//
//  Created by CANOPUS4 on 11/03/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchResultViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property  (weak, nonatomic) IBOutlet UITableView *SeachTableView;

@property NSMutableArray *dataArr;
@property(nonatomic,strong) NSMutableArray *uniqueSupplierCountArray;

@property(strong,nonatomic)NSMutableDictionary *SupplierNameDict;
@property(strong,nonatomic)NSDictionary *SupplierjsonDict;

@end
