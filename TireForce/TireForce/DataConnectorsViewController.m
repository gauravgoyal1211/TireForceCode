//
//  EditDataConnectorsViewController.m
//  TireForce
//
//  Created by CANOPUS5 on 16/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import "DataConnectorsViewController.h"
#import "DataConnnectorCell.h"
#import "NonEditTableViewCell.h"
#import "WebServiceHandler.h"
#import "HUDManager.h"
#import "UserInformation.h"
#import "AddSupplierViewController.h"
#import "XMLDictionary.h"

@interface DataConnectorsViewController () {
    NSMutableArray *arrayInfo;
    NSMutableArray *supplierArray;
    NSMutableArray *AvailableSuppliers;
    NSMutableDictionary *reversedictForAvailableSuppliers;
    NSMutableDictionary *dictForAvailableSuppliersInDataConnectorsOnly;
    BOOL needToUpdateNow;
}

@end

@implementation DataConnectorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    needToUpdateNow=NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title=@"Suppliers";
    arrayInfo=[[NSMutableArray alloc] initWithObjects:@"123",@"123",@"123",@"123",nil];
    UIBarButtonItem *editbutton=[[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStyleDone target:self action:@selector(EditTable:)];
    [self.navigationItem setLeftBarButtonItem:editbutton];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(AddUser:)]];
    [self callWebService];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    if(needToUpdateNow==YES)
    {
        needToUpdateNow=NO;
        [self callWebService];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- -TableViewDelegateDatasource-
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.editing)
    {
        return 180;
    }else
    {
        return 74;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count=(int)[supplierArray count];
    return count;
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
    static NSString *identifier=@"cell";
    
    if(self.editing==NO)
    {
        static NSString *identi = @"nonEditCell";
        NonEditTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identi];
        if (cell == nil)
        {
            cell = [[NonEditTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:identi];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        NSDictionary *temp=[supplierArray objectAtIndex:indexPath.row];
        
        NSString *suplierId=[temp valueForKey:@"supplierid"];
        NSString *supplierName=[NSString stringWithFormat:@"%@",[dictForAvailableSuppliersInDataConnectorsOnly valueForKey:suplierId]];
        cell.labelSupplierName.text=supplierName;
        
        NSString *userName=[NSString stringWithFormat:@"%@",[temp valueForKey:@"User"]];
        cell.labelUserName.text=userName;
        
        return cell;
        
        
        return nil;
    }else
    {
        NSLog(@"%ld",(long)indexPath.row);
        DataConnnectorCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            cell = [[DataConnnectorCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:identifier];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell.textFieldSupplierName setItemList:[dictForAvailableSuppliersInDataConnectorsOnly allValues]];
        
        // Supplier Name
        NSDictionary *temp=[supplierArray objectAtIndex:indexPath.row];
        NSString *suplierId=[temp valueForKey:@"supplierid"];
        NSString *supplierName=[NSString stringWithFormat:@"%@",[dictForAvailableSuppliersInDataConnectorsOnly valueForKey:suplierId]];
        cell.textFieldSupplierName.text=supplierName;
        cell.ButtonSave.tag=indexPath.row;
        
        // User Name
        NSString *userName = [NSString stringWithFormat:@"%@",[temp valueForKey:@"User"]];
        cell.textFieldUserName.text=userName;
        
        //            NSString *password=[NSString stringWithFormat:@"%@",[temp valueForKey:@"pass"]];
        cell.textFieldPassword.text=@"...";
        
        NSInteger val=[[temp valueForKey:@"active"] integerValue];
        cell.buttonToActiveState.tag=val;
        
        BOOL isActive=[[temp valueForKey:@"active"] boolValue];
        if(isActive==YES)
        {
            [cell.buttonToActiveState setBackgroundImage:[UIImage imageNamed:@"checkGray"] forState:UIControlStateNormal];
        }else
            [cell.buttonToActiveState setBackgroundImage:nil forState:UIControlStateNormal];
        
        [cell.buttonTest addTarget:self action:@selector(testAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.buttonTest.tag = indexPath.row;
        
        return cell;
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // No editing style if not editing or the index path is nil.
    if (self.editing == NO)
    {
        return UITableViewCellEditingStyleNone;
    }
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [HUDManager showHUDWithText:PleaseWait];
        NSDictionary *temp=[supplierArray objectAtIndex:indexPath.row];
        NSString *userId=[UserInformation sharedInstance].userId;
        NSString *token=[UserInformation sharedInstance].token;
        NSString *ID=[NSString stringWithFormat:@"%@",[temp valueForKey:@"ID"]];
        NSDictionary *dict=@{@"userid":userId,@"token":token,@"ID":ID};
        
        [[WebServiceHandler webServiceHandler] deleteSupplier:dict completionHandlerSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            [HUDManager hideHUD];
            NSIndexPath *deletedIndexPath=[NSIndexPath indexPathForRow:indexPath.row inSection:0];
            NSLog(@"%ld",(long)deletedIndexPath.row);
            [supplierArray removeObjectAtIndex:deletedIndexPath.row];
            [self.tableview deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        } completionHandlerFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [HUDManager hideHUD];
        }];
        
    }
}

#pragma mark- -BarButtonStyleAction-
-(void)EditTable:(id)sender
{
    if(self.editing)
    {
        [super setEditing:NO animated:NO];
        [self.tableview setEditing:NO animated:NO];
        [self.tableview reloadData];
        [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStyleDone];
        [self.navigationItem.leftBarButtonItem setTitle:@"Edit"];
        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleDone];
    }else
    {
        [super setEditing:YES animated:YES];
        [self.tableview setEditing:YES animated:YES];
        [self.tableview reloadData];
        [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStyleDone];
        [self.navigationItem.leftBarButtonItem setTitle:@"Done"];
    }
}

-(void)AddUser:(id)sender
{
    AddSupplierViewController *addSupplier =  [self.storyboard instantiateViewControllerWithIdentifier:@"addSupplier"];
    addSupplier.dictForSupplierAvailable=reversedictForAvailableSuppliers;
    addSupplier.delegate=self;
    [self.navigationController pushViewController:addSupplier animated:YES];
}

- (void)testAction:(UIButton *)sender
{
    NSDictionary *selectedSupplierInfo = (NSDictionary*)[supplierArray objectAtIndex:sender.tag];
    NSString *userid      =   [NSString stringWithFormat:@"%@",selectedSupplierInfo[@"ID"]];
    NSString *User        =   [NSString stringWithFormat:@"%@",selectedSupplierInfo[@"User"]];
    NSString *pass        =   [NSString stringWithFormat:@"%@",selectedSupplierInfo[@"pass"]];

    NSString *supplierid  =   [NSString stringWithFormat:@"%@",selectedSupplierInfo[@"supplierid"]];
    NSString *token       =   [UserInformation sharedInstance].token;
    
    NSDictionary *paramsDic =@{
                               @"userid":userid,
                               @"User":User,
                               @"pass":pass,
                               @"supplierid":supplierid,
                               @"token":token
                               };
    
    [HUDManager showHUDWithText:PleaseWait];
    
    [[WebServiceHandler webServiceHandler] checkConnection:paramsDic completionHandlerSuccess:^(AFHTTPRequestOperation *operation,  NSDictionary* responseObject) {
        [HUDManager hideHUD];
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            NSString* messageStr ;
            
            if ([responseObject[@"CheckConnectionResult"] boolValue])
            {
                 messageStr = @"valid Supplier.";
            }
            else
            {
             messageStr = @"Invalid Supplier.";
            }
            
            [[[UIAlertView alloc] initWithTitle:@"Message" message:messageStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        });
        
        
    } completionHandlerFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUDManager hideHUD];
            
            [[[UIAlertView alloc] initWithTitle:@"Message" message:@"There is some server error, please try later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        });
    }];
    
}

#pragma mark- -CheckMarkButtonAction-
- (IBAction)checkMarkAction:(UIButton *)sender
{
    if(sender.tag==0)
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"checkGray"] forState:UIControlStateNormal];
        sender.tag=1;
    }
    else
    {
        [sender setBackgroundImage:nil forState:UIControlStateNormal];
        sender.tag=0;
    }
}
- (IBAction)saveButtonAction:(UIButton *)sender {
    
    @try {
        NSDictionary *dict=[supplierArray objectAtIndex:sender.tag];
        CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableview];
        NSIndexPath *indexPath = [self.tableview indexPathForRowAtPoint:buttonPosition];
        DataConnnectorCell *cell=(DataConnnectorCell *)[self.tableview cellForRowAtIndexPath:indexPath];
        NSLog(@"%ld",(long)cell.buttonToActiveState.tag);
        NSString *ID=[NSString stringWithFormat:@"%@",[dict valueForKey:@"ID"]];
        NSString *user=[NSString stringWithFormat:@"%@",cell.textFieldUserName.text];
        NSString *supplierid=[NSString stringWithFormat:@"%@",[reversedictForAvailableSuppliers valueForKey:cell.textFieldSupplierName.text]];
        int val=(int)cell.buttonToActiveState.tag;
        BOOL active=(BOOL)val;
        NSDictionary *dictNew=@{
                                @"userid":[UserInformation sharedInstance].userId,
                                @"token":[UserInformation sharedInstance].token,
                                @"User":user,
                                @"pass":@"123",
                                @"ID":ID,
                                @"supplierid":supplierid,
                                @"active":(active)?@"true":@"false"
                                };
        [HUDManager showHUDWithText:PleaseWait];
        [[WebServiceHandler webServiceHandler] updateSupplier:dictNew completionHandlerSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Information Saved Successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            NSError *error = nil;
            NSString *jsonString = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"<string xmlns=\"http://tempuri.org/\">" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"</string>" withString:@""];
            NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:kNilOptions
                                                                           error:&error];
            NSLog(@"%@",jsonResponse);
            [self callWebService];
            [HUDManager hideHUD];
        } completionHandlerFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [HUDManager hideHUD];
        }];
    }
    @catch (NSException *exception) {
        
        
    }
    @finally {
        
    }
}

#pragma mark- -AddSupplierDelegateMethode-
-(void)needToUpdate
{
    needToUpdateNow=YES;
}

#pragma mark- -WebserviceCalling-
-(void)callWebService
{
    NSString *userId=[UserInformation sharedInstance].userId;
    NSString *token=[UserInformation sharedInstance].token;
    NSDictionary *dict=@{@"userid":userId,@"token":token};
    
    [HUDManager showHUDWithText:PleaseWait];
    [[WebServiceHandler webServiceHandler] getDataConnectorSuppliers:dict completionHandlerSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        //        NSDictionary *dict= [[[XMLDictionaryParser sharedInstance] dictionaryWithData:responseObject] valueForKey:@"__text"];
        //        NSData *data = [dict.description dataUsingEncoding:NSUTF8StringEncoding];
        //        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
        //                                                                     options:kNilOptions
        //                                                                       error:&error];
        
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
        reversedictForAvailableSuppliers =[[NSMutableDictionary alloc] init];
        dictForAvailableSuppliersInDataConnectorsOnly =[[NSMutableDictionary alloc] init];
        for (NSDictionary *dict in AvailableSuppliers) {
            NSString *value=[dict valueForKey:@"Value"];
            NSString *name=[dict valueForKey:@"Name"];
            [reversedictForAvailableSuppliers setValue:value forKey:name];
            [dictForAvailableSuppliersInDataConnectorsOnly setValue:name forKey:value];
        }
        [self.tableview reloadData];
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
@end
