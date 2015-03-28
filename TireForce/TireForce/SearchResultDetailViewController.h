//
//  SearchResultDetailViewController.h
//  TireForce
//
//  Created by CANOPUS4 on 12/03/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)NSMutableArray *SupplierDataArr;
@property(weak,nonatomic) NSDictionary *DataDic;
@property(weak,nonatomic) NSDictionary *priceDict;

@property (weak, nonatomic) IBOutlet UITableView *tbl_SearchDetail;
@property (weak, nonatomic) IBOutlet UIView *PopUpView;
@property (weak, nonatomic) IBOutlet UIScrollView *PopUpSrollView;
@property (weak, nonatomic) IBOutlet UILabel *lblItemPop;
@property (weak, nonatomic) IBOutlet UILabel *lblDescriptionPop;
@property (weak, nonatomic) IBOutlet UILabel *lblManuFacturerPop;
@property (weak, nonatomic) IBOutlet UILabel *lblSizePop;
@property (weak, nonatomic) IBOutlet UILabel *lblModelPop;
@property (weak, nonatomic) IBOutlet UILabel *lblSupplierLocationPop;
- (IBAction)OnPopUpHide:(id)sender;

@end
