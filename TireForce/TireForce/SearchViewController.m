//
//  SearchViewController.m
//  TireForce
//
//  Created by CANOPUS4 on 11/03/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchResultViewController.h"
#import "UserInformation.h"
#import "HUDManager.h"
#import "WebServiceHandler.h"
#import "XMLDictionary.h"

@interface SearchViewController ()
{
    NSMutableArray *supplierArray;
    NSMutableArray *AvailableSuppliers;
    NSMutableArray *arrayJsonData;
    NSMutableDictionary *dictForAvailableSuppliersName;
    SearchResultViewController *SearchResult;
}

@property (weak, nonatomic) IBOutlet UITextField *TxtSize;
@property (weak, nonatomic) IBOutlet UITextField *TxtQuickSize;
@property (weak, nonatomic) IBOutlet UITextField *TxtManufacturer;


@end

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollViewSearchViewController.contentInset=UIEdgeInsetsMake(0, 0, -180, 0);
    [[_ButtonSearch layer] setMasksToBounds:YES];
    [[_ButtonSearch layer] setCornerRadius:4.0];
    
    [self callWebServiceForName];
    // Do any additional setup after loading the view.
}




#pragma mark- -webservice Calling-
-(void)webSeviceCallingForSearchTire
{
    
    NSDictionary *dictSearchTire=@{
                            @"userid":[UserInformation sharedInstance].userId,
                            @"token":[UserInformation sharedInstance].token,
                            @"Item":@"",
                            @"Size":_TxtSize.text,
                            @"Model":@"",
                            @"Type":@"",
                            @"Description":@"",
                            @"QuickSize":_TxtQuickSize.text,
                            @"Manufacturer":_TxtManufacturer.text,
                            @"WinterTires":@"INCLUDE",
                            @"Onstock":@"false",
                            @"IsShopingCart":@"false"
                            };
    [HUDManager showHUDWithText:PleaseWait];
    
   [ [WebServiceHandler webServiceHandler]SearchTire:dictSearchTire completionHandlerSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSDictionary *dict1= [[XMLDictionaryParser sharedInstance] dictionaryWithData:responseObject];
        NSLog(@"%@",dict1);
        
        NSDictionary *TiresDiactionary=[dict1 valueForKey:@"Tires"];

        if(TiresDiactionary!=nil)
        {
            
            arrayJsonData =[[TiresDiactionary valueForKey:@"Tire"] mutableCopy];
            
            
            SearchResult=[self.storyboard instantiateViewControllerWithIdentifier:@"SearchRNav"];
            SearchResult.dataArr=arrayJsonData;
        
            SearchResult.SupplierNameDict=dictForAvailableSuppliersName;
            
            SearchResult.SupplierjsonDict=TiresDiactionary;
            
           // NSLog(@"%@",SearchResult.SupplierjsonDict);
            [self.navigationController pushViewController:SearchResult animated:YES];
        }else
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"No result found please enter valid size" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            [_TxtQuickSize setText:@""];
            [_TxtSize setText:@""];
        }
        [HUDManager hideHUD];
    } completionHandlerFailure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please contact to administrator." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
  
        [HUDManager hideHUD];
    }];
}


//Web Services For Getting  Supplier_Name


-(void)callWebServiceForName
{
    NSString *userId=[UserInformation sharedInstance].userId;
    NSString *token=[UserInformation sharedInstance].token;
    NSDictionary *dict=@{@"userid":userId,@"token":token};
    
   
    [[WebServiceHandler webServiceHandler] getDataConnectorSuppliers:dict completionHandlerSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        
        
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"<string xmlns=\"http://tempuri.org/\">" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"</string>" withString:@""];
        NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:&error];
        supplierArray=[[jsonResponse valueForKey:@"suppliers"] mutableCopy];
        AvailableSuppliers=[[jsonResponse valueForKey:@"AvailableSuppliers"] mutableCopy];
        
        dictForAvailableSuppliersName =[[NSMutableDictionary alloc] init];
        for (NSDictionary *dict in AvailableSuppliers) {
            NSString *value=[dict valueForKey:@"Value"];
            NSString *name=[dict valueForKey:@"Name"];
            
            [dictForAvailableSuppliersName setValue:name forKey:value];
        }
        

    } completionHandlerFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onSearch:(id)sender
{
    if(_TxtSize.text.length==0 && _TxtQuickSize.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter size" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }else
    {
        [self webSeviceCallingForSearchTire];
    }
 
    
}
- (IBAction)onHideKB:(id)sender
{
    [self resignFirstResponder];
}




@end
