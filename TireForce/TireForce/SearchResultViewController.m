
//  SearchResultViewController.m
//  TireForce
//
//  Created by CANOPUS4 on 11/03/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import "SearchResultViewController.h"
#import "SearchResultTableViewCell.h"
#import "SearchResultDetailViewController.h"
#import "UserInformation.h"
#import "WebServiceHandler.h"
#import "HUDManager.h"

@interface SearchResultViewController ()
{
    NSMutableArray *arrSupplierCount;
    NSMutableDictionary *dictCount;
    NSDictionary *DicForNextController;
    NSMutableArray *arrSupplierDidSelect;
}
//-(NSString*) bv_jsonStringWithPrettyPrint:(BOOL) prettyPrint;
@end

@implementation SearchResultViewController
@synthesize uniqueSupplierCountArray;


//-(NSString*) bv_jsonStringWithPrettyPrint:(BOOL) prettyPrint
//{
//    NSLog(@"%@",_SupplierjsonDict);
//    NSError *error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_SupplierjsonDict
//                                                       options:(NSJSONWritingOptions)    (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
//                                                         error:&error];
//    
//    if (! jsonData) {
//        NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
//        return @"{}";
//    } else {
//        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    }
//}
//

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%@",_SupplierjsonDict);
    
    NSLog(@"%@",_dataArr);
    NSLog(@"%lu",_dataArr.count);
    NSLog(@"%@",_SupplierNameDict);
    
    dictCount=[[NSMutableDictionary alloc] init];
    arrSupplierCount=[[NSMutableArray alloc]init];
    arrSupplierDidSelect=[[NSMutableArray alloc]init];
    
    for (int i=0; i<_dataArr.count; i++)
    {
        NSDictionary *dict=[_dataArr objectAtIndex:i];
        NSString *SupplierId=[dict valueForKey:@"supplierid"];
        [arrSupplierCount addObject:SupplierId];
        NSLog(@"%@",arrSupplierCount);
    }
    
   self.uniqueSupplierCountArray = [NSMutableArray array];
    [self.uniqueSupplierCountArray addObjectsFromArray:[[NSSet setWithArray:arrSupplierCount] allObjects]];
    
    NSCountedSet *set = [[NSCountedSet alloc] initWithArray:arrSupplierCount];
    NSLog(@"%@",set);
    
    NSString *itemStrID;
    
    for (id item in set)
    {
        NSLog(@"Name=%@, Count=%lu", item, (unsigned long)[set countForObject:item]);
        
        itemStrID=item,[set countForObject:item];

        [dictCount setObject:@([set countForObject:item]) forKey:itemStrID];
    }
   
   
    NSLog(@"%@",self.uniqueSupplierCountArray);
    [self.SeachTableView reloadData];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    [arrSupplierDidSelect removeAllObjects];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return self.uniqueSupplierCountArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier=@"cell";
    SearchResultTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[SearchResultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:identifier];
    }
    
    NSString *supplireID =[self.uniqueSupplierCountArray objectAtIndex:indexPath.row];
    
     if([self.SupplierNameDict valueForKey:supplireID]!=nil && ![[self.SupplierNameDict valueForKey:supplireID] isEqual:[NSNull null]])
         
    cell.lblSupplierNo.text=[self.SupplierNameDict valueForKey:supplireID];
    
    
    NSInteger val=[[dictCount valueForKey:supplireID] integerValue];
    cell.lblResultCount.text=[NSString stringWithFormat:@"%ld",(long)val];
    
    [HUDManager hideHUD];
    return cell;

    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResultDetailViewController *SearchResultDetail=[self.storyboard instantiateViewControllerWithIdentifier:@"SearchResultDetail"];
    
     NSString *supplireID =[self.uniqueSupplierCountArray objectAtIndex:indexPath.row];
    
    for (int i=0; i<_dataArr.count; i++)
    {
        NSDictionary *dict=[_dataArr objectAtIndex:i];
        NSString *SupplierId=[dict valueForKey:@"supplierid"];
       
        if ([supplireID isEqualToString:SupplierId])
        {
            [arrSupplierDidSelect addObject:dict];
        }
       
        
    }
    NSLog(@"%@",arrSupplierDidSelect);
    NSLog(@"%lu",(unsigned long)arrSupplierDidSelect.count);
    SearchResultDetail.SupplierDataArr=arrSupplierDidSelect;
    [self.navigationController pushViewController:SearchResultDetail animated:YES];
        
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
