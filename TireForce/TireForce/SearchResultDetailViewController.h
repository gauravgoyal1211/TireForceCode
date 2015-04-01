//
//  SearchResultDetailViewController.h
//  TireForce
//
//  Created by CANOPUS4 on 12/03/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchResultDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)NSMutableArray *SupplierDataArr;

@property(weak,nonatomic) NSDictionary *DataDic;
@property(weak,nonatomic) NSDictionary *priceDict;

@property (weak, nonatomic) IBOutlet UITableView *tbl_SearchDetail;

@end
