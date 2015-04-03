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

#import "TireDetailViewController.h"
#import <MessageUI/MessageUI.h>

@interface SearchResultDetailViewController ()<UIActionSheetDelegate, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>
{
    NSMutableArray *arrPrice;
    NSMutableDictionary *checkDict;
    NSString *PriceStr;
    NSString *Availabilitystr;
    CGFloat AvailabilityCG;
    
}

@end

@implementation SearchResultDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title=@"Tire Details";

    checkDict = [[NSMutableDictionary alloc] init];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
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

// here overwrite the setter method
// NOTE:- do not use self.SupplierDataArr in this setter method

-(void)setSupplierDataArr:(NSMutableArray *)SupplierDataArr
{
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"Price" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    NSArray *sortedArray = [SupplierDataArr sortedArrayUsingDescriptors:sortDescriptors];
    
    _SupplierDataArr = [[NSMutableArray alloc] initWithArray:sortedArray];
}

-(void)rightBarButtonItemHandler
{
    // configure the action sheet
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Open In Pos" delegate:self                                                     cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil                                                     otherButtonTitles:@"Email Specs & Price", @"SMS Specs & Price", @"Email Specs Only", @"SMS Specs Only", nil];
    
    [actionSheet showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
}

#pragma UIActionSheet Delegate Methods

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"From clickedButtonAtIndex- %@", [actionSheet buttonTitleAtIndex:buttonIndex]);
    
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if (![buttonTitle isEqualToString:@"Cancel"])
    {
        if (checkDict.count>0)
        {
            NSMutableString * messageBody = [NSMutableString new];
            
            if ([buttonTitle isEqualToString:@"Email Specs & Price"])
            {
                for (NSString*Key in checkDict)
                {
                   NSDictionary *tireInfoDict =  [_SupplierDataArr objectAtIndex:Key.integerValue];
                    [messageBody appendFormat:@"Tire: %@ %@\n",tireInfoDict[@"Manufacturer"],tireInfoDict[@"Model"]];
                    [messageBody appendFormat:@"Link: http://54.68.159.18/TirePreview.ashx?pcode=%@&Mid=%@&thumb=0\n",tireInfoDict[@"Item"],tireInfoDict[@"TireLibMakeId"]];
                    
                    // for hyperlink
                    // NSString * hyperlink = [NSString stringWithFormat:@"http://54.68.159.18/TirePreview.ashx?pcode=%@&Mid=%@&thumb=0",tireInfoDict[@"Item"],tireInfoDict[@"TireLibMakeId"]];
                    // [messageBody appendFormat:@"Link: <a href=\"%@\">%@</a><br>",hyperlink,hyperlink];
                    
                    [messageBody appendFormat:@"Price: $%@\n\n",tireInfoDict[@"Price"]];
                }
                
                [self showEmailWithMessageBody:messageBody];
            }
            else if ([buttonTitle isEqualToString:@"Email Specs Only"])
            {
                for (NSString*Key in checkDict)
                {
                    NSDictionary *tireInfoDict =  [_SupplierDataArr objectAtIndex:Key.integerValue];
                    [messageBody appendFormat:@"Tire: %@ %@\n",tireInfoDict[@"Manufacturer"],tireInfoDict[@"Model"]];
                    [messageBody appendFormat:@"Link: http://54.68.159.18/TirePreview.ashx?pcode=%@&Mid=%@&thumb=0\n\n",tireInfoDict[@"Item"],tireInfoDict[@"TireLibMakeId"]];
                }
                
                [self showEmailWithMessageBody:messageBody];
            }
            else if ([buttonTitle isEqualToString:@"SMS Specs & Price"])
            {
                for (NSString*Key in checkDict)
                {
                    NSDictionary *tireInfoDict =  [_SupplierDataArr objectAtIndex:Key.integerValue];
                    [messageBody appendFormat:@"Tire: %@ %@\n",tireInfoDict[@"Manufacturer"],tireInfoDict[@"Model"]];
                    [messageBody appendFormat:@"Link: http://54.68.159.18/TirePreview.ashx?pcode=%@&Mid=%@&thumb=0\n",tireInfoDict[@"Item"],tireInfoDict[@"TireLibMakeId"]];
                    [messageBody appendFormat:@"Price: $%@\n\n",tireInfoDict[@"Price"]];
                }

                [self showSMSWithSMSBody:messageBody];
            }
            else if ([buttonTitle isEqualToString:@"SMS Specs Only"])
            {
                for (NSString*Key in checkDict)
                {
                    NSDictionary *tireInfoDict =  [_SupplierDataArr objectAtIndex:Key.integerValue];
                    [messageBody appendFormat:@"Tire: %@ %@\n",tireInfoDict[@"Manufacturer"],tireInfoDict[@"Model"]];
                    [messageBody appendFormat:@"Link: http://54.68.159.18/TirePreview.ashx?pcode=%@&Mid=%@&thumb=0\n\n",tireInfoDict[@"Item"],tireInfoDict[@"TireLibMakeId"]];
                }

                [self showSMSWithSMSBody:messageBody];
            }
        }
        else
        {
            [[[UIAlertView alloc] initWithTitle:@"Message" message:@"Please Select At Least One Tire." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }
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
        //commented because of updation
//      Availabilitystr =[NSString stringWithFormat:@"(%0.0f in Stock)",AvailabilityCG];
        Availabilitystr =[NSString stringWithFormat:@"(avail=%0.0f)",AvailabilityCG];
        
        // NSLog(@"%@",Availabilitystr);
        
        cell.Availability.text = Availabilitystr;
        
        // cell.Availability.text=[dict valueForKey:@"Availability"];
        
        if ([arrPrice count]>indexPath.row)
            
            cell.Price.text = [arrPrice objectAtIndex:indexPath.row];
        else
            cell.Price.text=@"Waiting For Price";
    }
    
    // to maintaiin the check or uncheck image on cheched button
    cell.btnForOnCheck.tag=indexPath.row;
    [cell.btnForOnCheck addTarget:self action:@selector(OnCheckButton:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([[checkDict valueForKey:@(indexPath.row).description] boolValue])
    {
        [cell.btnForOnCheck setBackgroundImage:[UIImage imageNamed:@"check-y"] forState:UIControlStateNormal];
    }
    else
    {
        [cell.btnForOnCheck setBackgroundImage:[UIImage imageNamed:@"uncheck-y"] forState:UIControlStateNormal];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TireDetailViewController *aTireDetailViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"TireDetailViewController"];
    
    NSDictionary *dict =[_SupplierDataArr objectAtIndex:indexPath.row];

    [aTireDetailViewController setSelectedSearchResultDict:dict];
    [self.navigationController pushViewController:aTireDetailViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webSeviceCallingForPrice
{
    for (NSInteger i=0; i<_SupplierDataArr.count; i++)
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
    if ([[checkDict valueForKey:@(sender.tag).description] boolValue])
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"uncheck-y"] forState:UIControlStateNormal];
        [checkDict removeObjectForKey:@(sender.tag).description];
    }
    else
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"check-y"] forState:UIControlStateNormal];
        [checkDict setObject:@YES forKey:@(sender.tag).description];
    }
}

- (void)showSMSWithSMSBody:(NSString*)smsBody
{
    
    NSLog(@"smsBody %@",smsBody);
    
    if(![MFMessageComposeViewController canSendText])
    {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;

    [messageController setBody:smsBody];
    
//  Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}

- (void)showEmailWithMessageBody:(NSString*)messageBody
{
    
    NSLog(@"messageBody %@",messageBody);

    if ([MFMailComposeViewController canSendMail])
    {
        // Email Subject
        NSString *emailTitle = @"Tireforce Quote";
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Email Not Available" message:@"Your device doesn't support to use built-in email. Please setup Mail account in  device Settings" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}


- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Mail" message:@"Mail saved: you saved the email message in the drafts folder." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }break;
        case MFMailComposeResultSent:{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Mail" message:@"Mail sent: your email message have been sent." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }break;
        case MFMailComposeResultFailed:
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Mail" message:@"Mail sent Failed: there is an error in email message sending." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }break;
        default:{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Mail" message:@"Mail not sent!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
