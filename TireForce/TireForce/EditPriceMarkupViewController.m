//
//  EditPriceMarkupViewController.m
//  TireForce
//
//  Created by CANOPUS5 on 18/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import "EditPriceMarkupViewController.h"
#import "WebServiceHandler.h"
#import "HUDManager.h"
#import "XMLDictionary.h"
#import "UserInformation.h"
extern bool needUpdates;
@interface EditPriceMarkupViewController ()

@end

@implementation EditPriceMarkupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_labelPriceHeader setText:_lableString];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAction:)];
    NSDictionary *dict=[[_arrayForCostJson objectAtIndex:_seletedIndex] mutableCopy];
   BOOL byPercent=[[dict valueForKey:@"byPercent"] boolValue];
    NSString *costVal=[[dict valueForKey:@"Amount"] stringValue];
    NSString *percentValue=[[dict valueForKey:@"Percent"] stringValue];
    
    [_textFieldForDollar setText:costVal];
    [_textFieldForPercentage setText:percentValue];
    
    if(byPercent==YES)
    {
        [self switchActionForPercent:_switchForPercentage];
        
    }else
    {
        [self switchActionForDollar:_switchForDollar];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- switchAction-
- (IBAction)switchActionForPercent:(id)sender {
    needUpdates=YES;
    if([sender isOn])
    {
        [_textFieldForDollar setEnabled:NO];
        [_textFieldForPercentage setEnabled:YES];
        [_switchForDollar setOn:NO animated:YES];
    }else
    {
        [_textFieldForPercentage setEnabled:NO];
        [_switchForDollar setOn:YES animated:YES];

    }
}
- (IBAction)switchActionForDollar:(id)sender {
    needUpdates=YES;
    if([sender isOn])
    {
        [_textFieldForPercentage setEnabled:NO];
        [_textFieldForDollar setEnabled:YES];
        [_switchForPercentage setOn:NO animated:YES];
    }else
    {
        [_textFieldForDollar setEnabled:NO];
        [_switchForPercentage setOn:YES animated:YES];
    }
}
#pragma mark- -ButtonAction-
-(void)saveAction:(id)sender
{
    NSMutableDictionary *updateDict=[[_arrayForCostJson objectAtIndex:_seletedIndex] mutableCopy];
   
    NSString *cost=[NSString stringWithFormat:@"%@",_textFieldForDollar.text];
    NSNumber *costVal=[NSNumber numberWithInt:[cost intValue]];
 
    NSString *percent=[NSString stringWithFormat:@"%@",_textFieldForPercentage.text];
    NSNumber *percenValue=[NSNumber numberWithInt:[percent intValue]];

    BOOL percentSwitchState=[_switchForPercentage isOn];
    if(percentSwitchState==YES)
    {
        [updateDict setValue:@(YES) forKey:@"byPercent"];
    }else
        [updateDict setValue:@(NO) forKey:@"byPercent"];
    
    
    [updateDict setValue:costVal forKey:@"Amount"];
    [updateDict setValue:percenValue forKey:@"Percent"];
    [_arrayForCostJson replaceObjectAtIndex:_seletedIndex withObject:updateDict];

    [self webServiceCalling];
}

#pragma mark- -WebService Calling-
-(void)webServiceCalling
{
    [HUDManager showHUDWithText:PleaseWait];
    
    NSString *userId=[UserInformation sharedInstance].userId;
    NSString *token=[UserInformation sharedInstance].token;
    NSString *ParentId=_parentID;
   
    NSData *data = [NSJSONSerialization dataWithJSONObject:_arrayForCostJson
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:nil];
   NSString *CostJson = [[NSString alloc] initWithData:data
                                              encoding:NSUTF8StringEncoding];
    NSDictionary *dict=@{@"userid":userId,@"token":token,@"ParentId":ParentId,@"CostJson":CostJson};
 [[WebServiceHandler webServiceHandler] updateTirePrice:dict completionHandlerSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
     NSError *error = nil;
     NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
     jsonString = [jsonString stringByReplacingOccurrencesOfString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>" withString:@""];
     jsonString = [jsonString stringByReplacingOccurrencesOfString:@"<string xmlns=\"http://tempuri.org/\">" withString:@""];
     jsonString = [jsonString stringByReplacingOccurrencesOfString:@"</string>" withString:@""];
     NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
     NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:kNilOptions
                                                                    error:&error];

     BOOL successH=[[jsonResponse valueForKey:@"success"] boolValue];
     if(successH==YES)
     {
         [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Information Updated" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
     }
     
     
     [HUDManager hideHUD];
    } completionHandlerFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [HUDManager hideHUD];
    }];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [textField setKeyboardType:UIKeyboardTypeDecimalPad];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
