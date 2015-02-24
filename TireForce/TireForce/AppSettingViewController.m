//
//  AppSettingViewController.m
//  TireForce
//
//  Created by CANOPUS5 on 13/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import "AppSettingViewController.h"
#import "AppSettingTableViewCell.h"
#import "AppSettingDetailViewController.h"
#import "WebServiceHandler.h"
#import "HUDManager.h"
#import "XMLDictionary.h"
#import "UserInformation.h"
@interface AppSettingViewController ()
{
    NSMutableArray *switchArray;
    NSInteger buttonSelectedTag;
    UISwitch *switchSelected;
    
}
@end

@implementation AppSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Setup";
    switchArray=[[NSMutableArray alloc] init];
    [self callWebServiceForGetUserInfo];
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
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    AppSettingTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[AppSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                 reuseIdentifier:identifier];
    }

    if(indexPath.row==0)
    {
        cell.labelTitle.text=@"Quote-Only Mode (tires)";
        cell.switchForSetting.tag=1;
        cell.buttonInformation.tag=5;
    }
    else if(indexPath.row==1)
    {
        cell.labelTitle.text=@"Quote-Only Mode (tires & wheels)";
        cell.switchForSetting.tag=2;
        cell.buttonInformation.tag=6;
    }
    else if(indexPath.row==2)
    {
        cell.labelTitle.text=@"Live Quote";
        cell.switchForSetting.tag=3;
        cell.buttonInformation.tag=7;

    }
    else if(indexPath.row==3)
    {
        cell.labelTitle.text=@"Transactional Mode (tires)";
        cell.switchForSetting.tag=4;
        cell.buttonInformation.tag=8;
    }
    
    [cell.switchForSetting addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
    if(![switchArray containsObject:cell.switchForSetting])
    {
        [switchArray addObject:cell.switchForSetting];
    }
    cell.selectionStyle=UITableViewCellSeparatorStyleNone;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}


#pragma mark- -WebSeviceCalling-
-(void)callwebServicewithRunValue:(NSInteger)runValue
{
//    runValue
    [HUDManager showHUDWithText:PleaseWait];
    NSDictionary *dict=@{@"UserId": [UserInformation sharedInstance].userId,
                         @"RunFrom":@(runValue),
                         @"token": [UserInformation sharedInstance].token
                         };

    [[WebServiceHandler webServiceHandler] SetRunValueInAppSettingWithParameter:dict completionHandlerSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSXMLParser *parser =  responseObject;
        NSDictionary *dict=[[XMLDictionaryParser sharedInstance] dictionaryWithParser:parser];
        NSDictionary *soapBody=[dict valueForKey:@"soap:Body"];
        NSDictionary *resultDict1=[soapBody valueForKey:@"SetRunFromResponse"];
        NSDictionary *resultDict2=[resultDict1 valueForKey:@"SetRunFromResult"];
        NSString  *success=[resultDict2 valueForKey:@"Success"];
        
        if([success isEqualToString:@"true"])
        {
            [self performActionAfterButtonSeletion:switchSelected];
        }
        else
        {
            switchSelected=nil;
        }
        [HUDManager hideHUD];
    } completionHandlerFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
                [HUDManager hideHUD];
    }];
}

-(void)callWebServiceForGetUserInfo
{
    [HUDManager showHUDWithText:PleaseWait];
    
    NSDictionary *dict=@{@"UserId": [UserInformation sharedInstance].userId,
                             @"token": [UserInformation sharedInstance].token
                              };

    [[WebServiceHandler webServiceHandler] getUserInfoWithParameter:dict completionHandlerSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSXMLParser *parser =  responseObject;
        NSDictionary *dict=[[XMLDictionaryParser sharedInstance] dictionaryWithParser:parser];
        NSDictionary *soapBody=[dict valueForKey:@"soap:Body"];
        NSDictionary *resultDict1=[soapBody valueForKey:@"GetUserInfoResponse"];
        NSDictionary *resultDict2=[resultDict1 valueForKey:@"GetUserInfoResult"];
        int  val=[[resultDict2 valueForKey:@"RunFrom"] intValue];
        UISwitch *swtch;
        if(val==1)
        {
          swtch=(UISwitch *)[self.view viewWithTag:1];
        }else if(val==2)
        {
            swtch=(UISwitch *)[self.view viewWithTag:2];
        }else if(val==3)
        {
            swtch=(UISwitch *)[self.view viewWithTag:3];
        }else
        {
            swtch=(UISwitch *)[self.view viewWithTag:4];
        }
        [swtch setOn:YES];
        [self performActionAfterButtonSeletion:swtch];
        [HUDManager hideHUD];
        
    } completionHandlerFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [HUDManager hideHUD];
        
    }];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark- -ButtonAction-
-(void)switchAction:(UISwitch *)switchs
{
    
    switchSelected=switchs;
    if([switchs isOn])
    {
        [switchSelected setOn:YES];
    }else
    {
        [switchSelected setOn:NO];
    }
        [self callwebServicewithRunValue:switchs.tag];
}
- (IBAction)informationClicked:(UIButton *)sender {
    buttonSelectedTag=sender.tag;
//    [self performSegueWithIdentifier:@"detail" sender:nil];
    AppSettingDetailViewController *appDetail =  [self.storyboard instantiateViewControllerWithIdentifier:@"appSettingDetail"];
    appDetail.buttonIndex=buttonSelectedTag;
    [self.navigationController pushViewController:appDetail animated:YES];

}

-(void)performActionAfterButtonSeletion:(UISwitch *)switchs
{
    if([switchs isOn]){
        NSLog(@"Switch is ON");
        NSMutableArray *tempArr=[[NSMutableArray alloc] initWithArray:switchArray];
        [tempArr removeObject:switchs];
        for (UISwitch *swtch in tempArr) {
            [swtch setOn:NO animated:YES];
        }
    } else{
        NSLog(@"Switch is OFF");
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

}
@end
