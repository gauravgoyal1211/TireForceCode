
//
//  TireQueriesViewController.m
//  TireForce
//
//  Created by CANOPUS5 on 13/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import "TireQueriesViewController.h"
#import "WebServiceHandler.h"
#import "UserInformation.h"
#import "XMLDictionary.h"
#import "TireQuriesTableViewCell.h"
#import "HUDManager.h"
@interface TireQueriesViewController ()
{
    NSMutableArray *reportArray;
}
@end

@implementation TireQueriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Tire Searches";
    [self.segmentControl setSelectedSegmentIndex:0];
//    reportArray=[[NSMutableArray alloc] init];
    
    [self callwebServicewithDays:1];
    self.automaticallyAdjustsScrollViewInsets = NO;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- -TableViewDelegate-
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    // Force your tableview margins (this may be a bad idea)
    if ([self.tabelview respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tabelview setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tabelview respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tabelview setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return reportArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    TireQuriesTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[TireQuriesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:identifier];
    }
    NSDictionary *dictTemp=[reportArray objectAtIndex:indexPath.row];
    NSString *count=[NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"Count"]];
    NSString *size=[NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"Size"]];
    [cell.labelSize setText:size];
    [cell.labelHitCount setText:count];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}
#pragma mark- -WebServiceCalling-
-(void)callwebServicewithDays:(int)days
{
    [reportArray removeAllObjects];
    [HUDManager showHUDWithText:PleaseWait];
    NSString *userId=[UserInformation sharedInstance].userId;
    NSString *token=[UserInformation sharedInstance].token;
    
    [[WebServiceHandler webServiceHandler] getTireQueriesWithUserID:userId withDays:days withToken:token completionHandlerSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSXMLParser *parser =  responseObject;
        NSDictionary *dict=[[XMLDictionaryParser sharedInstance] dictionaryWithParser:parser];
        NSDictionary *soapBody=[dict valueForKey:@"soap:Body"];
        NSDictionary *resultDict1=[soapBody valueForKey:@"GetSizeReportResponse"];
        NSDictionary *resultDict2=[resultDict1 valueForKey:@"GetSizeReportResult"];
        NSDictionary *reportDict=[resultDict2 valueForKey:@"Report"];
        if([[reportDict valueForKey:@"Report"] isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *temp=[reportDict valueForKey:@"Report"];
           if(reportArray==nil) reportArray=[[NSMutableArray alloc] init];
            [reportArray addObject:temp];
        }else
        {
            reportArray=[reportDict valueForKey:@"Report"];
        }
        
        
        [self.tabelview reloadData];
        [HUDManager hideHUD];
    } completionHandlerFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [HUDManager hideHUD];
    }];
}

#pragma mark- -SegmentControlMethode-
-(IBAction)indexChanged:(UISegmentedControl *)sender
{
    switch (self.segmentControl.selectedSegmentIndex)
    {
        case 0:
            [self callwebServicewithDays:1];
            break;
        case 1:
            [self callwebServicewithDays:7];
            break;
        case 2:
            [self callwebServicewithDays:30];
            break;
        case 3:
            [self callwebServicewithDays:90];
            break;

        default:
            break; 
    } 
}
@end
