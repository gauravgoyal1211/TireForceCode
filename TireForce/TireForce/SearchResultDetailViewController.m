//
//  SearchResultDetailViewController.m
//  TireForce
//
//  Created by CANOPUS4 on 12/03/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import "SearchResultDetailViewController.h"
#import "SearchResultDetailTableViewCell.h"
#import "UserInformation.h"
#import "WebServiceHandler.h"
#import "FPPopoverController.h"
#import "FPPopoverView.h"
#import "popViewTableControllerTableViewController.h"
#import "XMLDictionary.h"
#import "ForwordActionViewController.h"


@interface SearchResultDetailViewController ()
{
    NSMutableArray *arrPrice;
    NSString *PriceStr;
    NSString *Availabilitystr;
    CGFloat AvailabilityCG;
   
}
@end

@implementation SearchResultDetailViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    _PopUpSrollView.hidden=YES;
    _PopUpSrollView.clipsToBounds=NO;
    _PopUpView.clipsToBounds=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
    [[_PopUpView layer] setMasksToBounds:YES];
    [[_PopUpView layer] setCornerRadius:7.0];
    [[_PopUpSrollView layer] setMasksToBounds:YES];
    [[_PopUpSrollView layer] setCornerRadius:7.0];
    
    self.navigationController.toolbarHidden = YES;
    
    arrPrice=[[NSMutableArray alloc]init];
    
    UIImage *image = [UIImage imageNamed:@"frd-y"];
   
    
    UIButton* RightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [RightButton setImage:image forState:UIControlStateNormal];
    [RightButton addTarget:self action:@selector(rightBarButtonItemHandler) forControlEvents:UIControlEventTouchUpInside];
    RightButton.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *NavRightButton = [[UIBarButtonItem alloc] initWithCustomView:RightButton];
    self.navigationItem.rightBarButtonItem = NavRightButton;
    
    
   //    NSLog(@"%@",self.SupplierDataArr);
//    NSLog(@"%lu",(unsigned long)self.SupplierDataArr.count);
//    
    
}

-(void)rightBarButtonItemHandler
{
    ForwordActionViewController * ForwordActionViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"ForNav"];
    [self.navigationController pushViewController:ForwordActionViewController animated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self webSeviceCallingForPrice];
    [  _tbl_SearchDetail reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return _SupplierDataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier=@"cell";
    
    SearchResultDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[SearchResultDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
  //  cell.Price.text=[arrPrice objectAtIndex:indexPath.row];

    
    if ([_SupplierDataArr count] > 0)
    {
        
        NSDictionary *dict =[_SupplierDataArr objectAtIndex:indexPath.row];
        if([dict valueForKey:@"Model"]!=nil && ![[dict valueForKey:@"Model"] isEqual:[NSNull null]])
            cell.Model.text=[dict valueForKey:@"Model"];
        
        if([dict valueForKey:@"Size"]!=nil && ![[dict valueForKey:@"Size"] isEqual:[NSNull null]])
            cell.Size.text=[dict valueForKey:@"Size"];
        
       
        
        if([dict valueForKey:@"Manufacturer"]!=nil && ![[dict valueForKey:@"Manufacturer"] isEqual:[NSNull null]])
            cell.Manufacture.text=[dict valueForKey:@"Manufacturer"];
        
        
        
        
        if([dict valueForKey:@"Availability"]!=nil && ![[dict valueForKey:@"Availability"] isEqual:[NSNull null]])
            
         AvailabilityCG = [[dict valueForKey:@"Availability"] floatValue];
           Availabilitystr =[NSString stringWithFormat:@"(%0.0f in Stock)",AvailabilityCG];
        
       // NSLog(@"%@",Availabilitystr);
        
           cell.Availability.text=Availabilitystr;

           // cell.Availability.text=[dict valueForKey:@"Availability"];
        
        if ([arrPrice count]>indexPath.row)
           
             cell.Price.text = [arrPrice objectAtIndex:indexPath.row];
        else
            cell.Price.text=@"Waiting For Price";
    }
    
   
    //Coding For PopUp Button
    
    cell.btnForOnCheck.tag=indexPath.row;
    [cell.btnForOnCheck addTarget:self action:@selector(OnCheckButton:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)webSeviceCallingForPrice
{
    
    for (int i=0; i<_SupplierDataArr.count; i++)
    {
        NSLog(@"%lu",(unsigned long)_SupplierDataArr.count);
        _DataDic=[_SupplierDataArr objectAtIndex:i];
        
   
    NSDictionary *dictSearchTireResultPrice=@{
                                         @"userid":[UserInformation sharedInstance].userId,
                                         @"token":[UserInformation sharedInstance].token,
                                         @"Uid":[_DataDic valueForKey:@"UID"],
                                         @"supplierId":[_DataDic valueForKey:@"supplierid"]  ,
                                         @"Manufacturer":[_DataDic valueForKey:@"Manufacturer"],
                                         @"Diameterv":@"0",
                                         @"ItemId":[_DataDic valueForKey:@"Item"]
                                         };
    
    [[WebServiceHandler webServiceHandler]GetPriceForTire:dictSearchTireResultPrice completionHandlerSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
        
         NSDictionary *dict1= [[XMLDictionaryParser sharedInstance] dictionaryWithData:responseObject];
         
         NSLog(@"%@",dict1);
         
         if(dict1!=nil)
         {
             NSString *p= @"$ ";
             NSString *price=[[dict1 valueForKey:@"price_"] mutableCopy];
            PriceStr =[p stringByAppendingString:price];
            // NSLog(@"%@",PriceStr);
             [arrPrice addObject:PriceStr];
             
         }
         
//         NSIndexPath *indexpath=[NSIndexPath indexPathForItem:i inSection:0];
//        [_tbl_SearchDetail reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexpath] withRowAnimation:UITableViewRowAnimationNone];
      
    
        
         [_tbl_SearchDetail reloadData];
         
         
     } completionHandlerFailure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
     }];
        
       
        
}

}


-(void)OnCheckButton:(UIButton*)sender
{

    if(sender.tag==0)
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"check-y"] forState:UIControlStateNormal];
        sender.tag=1;
    }else
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"uncheck-y"] forState:UIControlStateNormal];
                sender.tag=0;

    }
    
}

-(void)OnDetailButton:(UIButton*)sender
{
    NSInteger i=sender.tag;
    NSLog(@"%ld",(long)i);
    
    NSDictionary *PopDic=[_SupplierDataArr objectAtIndex:i];
      NSLog(@"%@",PopDic);
    
    if([PopDic valueForKey:@"Description"]!=nil && ![[PopDic valueForKey:@"Description"] isEqual:[NSNull null]])
    _lblDescriptionPop.text=[PopDic valueForKey:@"Description"];
    
    if([PopDic valueForKey:@"Item"]!=nil && ![[PopDic valueForKey:@"Item"] isEqual:[NSNull null]])
    _lblItemPop.text=[PopDic valueForKey:@"Item"];
    
    
    if([PopDic valueForKey:@"Manufacturer"]!=nil && ![[PopDic valueForKey:@"Manufacturer"] isEqual:[NSNull null]])
    _lblManuFacturerPop.text=[PopDic valueForKey:@"Manufacturer"];
    
    if([PopDic valueForKey:@"Model"]!=nil && ![[PopDic valueForKey:@"Model"] isEqual:[NSNull null]])
    _lblModelPop.text=[PopDic valueForKey:@"Model"];
    
    
    if([PopDic valueForKey:@"Size"]!=nil && ![[PopDic valueForKey:@"Size"] isEqual:[NSNull null]])
    _lblSizePop.text=[PopDic valueForKey:@"Size"];
    
    
    if([PopDic valueForKey:@"SupplierLocation"]!=nil && ![[PopDic valueForKey:@"SupplierLocation"] isEqual:[NSNull null]])
    _lblSupplierLocationPop.text=[PopDic valueForKey:@"SupplierLocation"];
    
    
    _tbl_SearchDetail.userInteractionEnabled=NO;
    _PopUpSrollView.hidden=NO;
    _PopUpView.hidden=NO;
    [self.view bringSubviewToFront:self.PopUpSrollView];
}

- (IBAction)OnPopUpHide:(id)sender
{
    _PopUpSrollView.hidden=YES;
    _tbl_SearchDetail.userInteractionEnabled=YES;
}
@end
