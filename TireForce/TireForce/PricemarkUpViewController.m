//
//  PricemarkUpViewController.m
//  TireForce
//
//  Created by CANOPUS5 on 13/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import "PricemarkUpViewController.h"
#import "PriceMarkUpTableViewCell.h"
#import "EditPriceMarkupViewController.h"
#import "WebServiceHandler.h"
#import "XMLDictionary.h"
#import "HUDManager.h"
#import "PricingPartTableViewCell.h"
#import "AddPartViewController.h"
#import "UserInformation.h"
BOOL needToUpdate;
BOOL needUpdates;
@interface PricemarkUpViewController ()
{
    NSMutableArray *HeaderLabelArray;
    
    NSString *parentId;
    NSString *activeRuleName;
    NSMutableArray *arrayCostJson;
    NSMutableArray *arrayCustomObjectJson;
    NSString *g_identifier;
}
@end

@implementation PricemarkUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    g_identifier=@"cell";
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.title=@"Pricing";
    arrayCustomObjectJson=[[NSMutableArray alloc] init];
    HeaderLabelArray=[[NSMutableArray alloc] initWithObjects:
                      @"$0   - $50:  Cost + $",
                      @"$50  - $100: Cost + $",
                      @"$100 - $150: Cost + $",
                      @"$150 - $200: Cost + $",
                      @"$200 - $250: Cost + $",
                      @"$250 - $300: Cost + $",
                      @"$300 - $350: Cost + $",
                      @"$350 - $400: Cost + $",
                      @"$400 - $450: Cost + $",
                      @"$450 - $500: Cost + $", nil];
    [self.segmentControl setSelectedSegmentIndex:0];
    // Do any additional setup after loading the view.
    [self webServiceCalling];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
 if(needToUpdate==YES || needUpdates==YES)
 {
     needToUpdate=NO;
     needUpdates=NO;
     [arrayCostJson removeAllObjects];
     [arrayCustomObjectJson removeAllObjects];
     [self webServiceCalling];
 }
    
}
#pragma mark- -TableViewDelegateDatasource-

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([g_identifier isEqualToString:@"cell"])
    {
        return 50;
    }else
    {
        return 69;
    }

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([g_identifier isEqualToString:@"cell"])
    {
        return 10;
    }else
    {
        return arrayCustomObjectJson.count;
    }

}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([g_identifier isEqualToString:@"cell"])
    {
    PriceMarkUpTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:g_identifier];
    if (cell == nil)
    {
        cell = [[PriceMarkUpTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:g_identifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//        $0 - $xx:  Cost + $xx.xx      >

        NSDictionary *diction=[arrayCostJson objectAtIndex:indexPath.row];
        NSString *labelString=[HeaderLabelArray objectAtIndex:indexPath.row];
        NSString *amoutValue=[NSString stringWithFormat:@" %@",[diction valueForKey:@"Amount"]];
        labelString=[labelString stringByAppendingString:amoutValue];
        [cell.labelHeader setText:labelString];
    return cell;
    }
    else
    {
        PricingPartTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:g_identifier];
        if (cell == nil)
        {
            cell = [[PricingPartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:g_identifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        NSDictionary *tempDictionary=[arrayCustomObjectJson objectAtIndex:indexPath.row];
        
        NSString *partNum=[tempDictionary valueForKey:@"PartNum"];
        NSString *price=[[tempDictionary valueForKey:@"Price"] stringValue];

        [cell.partName setText:partNum];
        [cell.price setText:price];
        return cell;
    }
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    // Force your tableview margins (this may be a bad idea)
    if ([self.tableView1 respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView1 setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView1 respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView1 setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    
    if([g_identifier isEqualToString:@"cell"])
    return NO;
    else
        return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete

        NSDictionary *tempDict=[arrayCustomObjectJson objectAtIndex:indexPath.row];
        NSString *userId=[UserInformation sharedInstance].userId;
        NSString *token=[UserInformation sharedInstance].token;
        NSString *UId=[NSString stringWithFormat:@"%@",[tempDict valueForKey:@"UId"]];
        NSDictionary *dict=@{@"userid":userId,@"token":token,@"ParentId":parentId,@"Uid":UId};
        [HUDManager showHUDWithText:PleaseWait];
        [[WebServiceHandler webServiceHandler] deletePart:dict completionHandlerSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            [arrayCustomObjectJson removeObjectAtIndex:indexPath.row];
            [self.tableView1 deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [HUDManager hideHUD];
        } completionHandlerFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [HUDManager hideHUD];
        }];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([g_identifier isEqualToString:@"cell"])
    {
        EditPriceMarkupViewController *editPrice =  [self.storyboard instantiateViewControllerWithIdentifier:@"editPriceMarkup"];
        editPrice.lableString=[HeaderLabelArray objectAtIndex:indexPath.row];
        editPrice.arrayForCostJson=[arrayCostJson mutableCopy];
        editPrice.seletedIndex=indexPath.row;
        editPrice.parentID=parentId;
        [self.navigationController pushViewController:editPrice animated:YES];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark- -SwitchAction-
-(IBAction)indexChanged:(UISegmentedControl *)sender
{
    switch (self.segmentControl.selectedSegmentIndex)
    {
        case 0:
            g_identifier=@"cell";
            [self.tableView1 reloadData];
            self.navigationItem.rightBarButtonItem=nil;
            break;
        case 1:
            g_identifier=@"cell2";
            [self.tableView1 reloadData];
            self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
            break;
                default:
            break;
    } 
}


#pragma mark- -WebserviceCalling-
-(void)webServiceCalling
{
    [self.tableView1 setHidden:YES];
    NSString *userId=[UserInformation sharedInstance].userId;
    NSString *token=[UserInformation sharedInstance].token;
    NSDictionary *dict=@{@"userid":userId,@"token":token};
    [HUDManager showHUDWithText:PleaseWait];
    [[WebServiceHandler webServiceHandler] getTirePriceWith:dict completionHandlerSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.tableView1 setHidden:NO];
        NSError *error = nil;
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"<string xmlns=\"http://tempuri.org/\">" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"</string>" withString:@""];
        NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:&error];
        NSDictionary *costDiactionary=[jsonResponse valueForKey:@"Cost"];
       arrayCostJson=[[costDiactionary valueForKey:@"items"] mutableCopy];
        NSDictionary *customDictionary=[jsonResponse valueForKey:@"Custom"];
//        arrayCustomObjectJson=[customDictionary valueForKey:@"Items"];
        NSDictionary *CustomItemDictionary=[customDictionary valueForKey:@"Items"];
        {
            for (id key in CustomItemDictionary) {
                [arrayCustomObjectJson addObject:[[CustomItemDictionary objectForKey:key] mutableCopy]];
            }
        }
        
        parentId=[jsonResponse valueForKey:@"UId"];
        activeRuleName=[jsonResponse valueForKey:@"activeRuleName"];
        [HUDManager hideHUD];
        [self.tableView1 reloadData];
    } completionHandlerFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [HUDManager hideHUD];
    }];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark- -AddButtonAction-
-(void)addAction:(id)sender
{
    AddPartViewController *addPart =  [self.storyboard instantiateViewControllerWithIdentifier:@"addPart"];
    addPart.parentId=parentId;
    [self.navigationController pushViewController:addPart animated:YES];
}
@end
