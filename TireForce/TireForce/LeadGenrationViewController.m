
//
//  LeadGenrationViewController.m
//  TireForce
//
//  Created by CANOPUS5 on 13/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import "LeadGenrationViewController.h"
#import "LeadGenrationTableViewCell.h"
#import "HUDManager.h"
#import "WebServiceHandler.h"
#import "UserInformation.h"
#import "XMLDictionary.h"

@interface LeadGenrationViewController ()
{
    NSMutableArray *reportArray;
}
@end

@implementation LeadGenrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Lead Genrated";
    
    [self.segmentControl setSelectedSegmentIndex:0];
    [self callwebServicewithDays:1];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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
    if ([self.tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableview setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableview setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return reportArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    LeadGenrationTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[LeadGenrationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:identifier];
    }
    
    NSDictionary *dictTemp=[reportArray objectAtIndex:indexPath.row];
    
    NSString *time=[NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"time"]];
    NSString *Name=[NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"Name"]];
    NSString *Phone=[NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"Phone"]];
    NSString *Email=[NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"Email"]];
    
    
    [cell.labelDate setText:time];
    [cell.labelName setText:Name];
    [cell.labelPhone setText:Phone];
    [cell.labelEmail setText:Email];


    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

#pragma mark- -WebSeviceCalling-
-(void)callwebServicewithDays:(int)days
{
    [reportArray removeAllObjects];
    [HUDManager showHUDWithText:PleaseWait];
    NSString *userId=[UserInformation sharedInstance].userId;
    NSString *token=[UserInformation sharedInstance].token;
    
    [[WebServiceHandler webServiceHandler] getLeadGenrationQueriesWithUserID:userId withDays:days withToken:token completionHandlerSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSXMLParser *parser =  responseObject;
        NSDictionary *dict=[[XMLDictionaryParser sharedInstance] dictionaryWithParser:parser];
        NSDictionary *soapBody=[dict valueForKey:@"soap:Body"];
        NSDictionary *resultDict1=[soapBody valueForKey:@"GetQuoteReportResponse"];
        NSDictionary *resultDict2=[resultDict1 valueForKey:@"GetQuoteReportResult"];
        NSDictionary *reportDict=[resultDict2 valueForKey:@"QuoteReport"];
        if([[reportDict valueForKey:@"QuoteReport"] isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *temp=[reportDict valueForKey:@"QuoteReport"];
            if(reportArray==nil) reportArray=[[NSMutableArray alloc] init];
            [reportArray addObject:temp];
        }else
        {
            reportArray=[reportDict valueForKey:@"QuoteReport"];
        }
        
        
        [self.tableview reloadData];
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
