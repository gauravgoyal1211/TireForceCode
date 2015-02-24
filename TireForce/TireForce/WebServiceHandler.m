//
//  WebServiceHandler.m
//  TireForce
//
//  Created by CANOPUS5 on 12/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import "WebServiceHandler.h"
#import "XMLDictionary.h"
@implementation WebServiceHandler
- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

+(WebServiceHandler*)webServiceHandler
{
    static WebServiceHandler *sharedHandler;
    if (sharedHandler == nil)
    {
        sharedHandler = [[WebServiceHandler alloc] init];
    }
    
    return sharedHandler;
}

-(void)loginWithParameter:(NSDictionary *)parameters completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure
{
    NSString *name=[parameters valueForKey:@"UserLogin"];
    NSString *password=[parameters valueForKey:@"Password"];
    NSString *token=[parameters valueForKey:@"token"];
    
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" "<soap:Body>\n"
                             "<Login xmlns=\"http://tempuri.org/\">\n"
                             "<UserLogin>%@</UserLogin>\n"
                             "<Password>%@</Password>\n"
                             "<IsMh5>%d</IsMh5>\n"
                             "<token>%@</token>\n"
                             "</Login>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",name, password, NO, token];
//    http://54.68.159.18/UserControl.asmx?op=Login
    NSURL *url = [NSURL URLWithString:@"http://54.68.159.18/UserControl.asmx?op=Login"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu",  [soapMessage length]];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/Login" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
       dispatch_async(dispatch_get_main_queue(), ^{
            completionHandlerSuccess(operation,responseObject);
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandlerFailure(operation,error);
        });
    }];
    [[NSOperationQueue mainQueue] addOperation:operation];
}

-(void)getTireQueriesWithUserID:(NSString *)uid withDays:(int)days withToken:(NSString *)token completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure
{
    {
        NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                                 "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" "<soap:Body>\n"
                                 "<GetSizeReport xmlns=\"http://tempuri.org/\">\n"
                                 "<UserID>%@</UserID>\n"
                                 "<BackDays>%d</BackDays>\n"
                                 "<token>%@</token>\n"
                                 "</GetSizeReport>\n"
                                 "</soap:Body>\n"
                                 "</soap:Envelope>\n",uid, days, token];
        //    http://54.68.159.18/UserControl.asmx?op=Login
        NSURL *url = [NSURL URLWithString:@"http://54.68.159.18/ReportData.asmx?op=GetSizeReport"];
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
        NSString *msgLength = [NSString stringWithFormat:@"%lu",  [soapMessage length]];
        [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [theRequest addValue: @"http://tempuri.org/GetSizeReport" forHTTPHeaderField:@"SOAPAction"];
        [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
        [theRequest setHTTPMethod:@"POST"];
        [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
        operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandlerSuccess(operation,responseObject);
            });
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandlerFailure(operation,error);
            });
        }];
        [[NSOperationQueue mainQueue] addOperation:operation];
    }
}
-(void)getLeadGenrationQueriesWithUserID:(NSString *)uid withDays:(int)days withToken:(NSString *)token completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure
{
    {
        NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                                 "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" "<soap:Body>\n"
                                 "<GetQuoteReport xmlns=\"http://tempuri.org/\">\n"
                                 "<UserID>%@</UserID>\n"
                                 "<BackDays>%d</BackDays>\n"
                                 "<token>%@</token>\n"
                                 "</GetQuoteReport>\n"
                                 "</soap:Body>\n"
                                 "</soap:Envelope>\n",uid, days, token];
        //    http://54.68.159.18/UserControl.asmx?op=Login
        NSURL *url = [NSURL URLWithString:@"http://54.68.159.18/ReportData.asmx?op=GetQuoteReport"];
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
        NSString *msgLength = [NSString stringWithFormat:@"%lu",  [soapMessage length]];
        [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [theRequest addValue: @"http://tempuri.org/GetQuoteReport" forHTTPHeaderField:@"SOAPAction"];
        [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
        [theRequest setHTTPMethod:@"POST"];
        [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
        operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandlerSuccess(operation,responseObject);
            });
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandlerFailure(operation,error);
            });
        }];
        [[NSOperationQueue mainQueue] addOperation:operation];
    }
}

-(void)getUserInfoWithParameter:(NSDictionary *)parameters completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure
{
    {
        NSString *uid=[parameters valueForKey:@"UserId"];
        NSString *token=[parameters valueForKey:@"token"];
        NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                                 "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" "<soap:Body>\n"
                                 "<GetUserInfo xmlns=\"http://tempuri.org/\">\n"
                                 "<UserId>%@</UserId>\n"
                                 "<token>%@</token>\n"
                                 "</GetUserInfo>\n"
                                 "</soap:Body>\n"
                                 "</soap:Envelope>\n",uid,token];
        //    http://54.68.159.18/UserControl.asmx?op=Login
        NSURL *url = [NSURL URLWithString:@"http://54.68.159.18/UserControl.asmx?op=GetUserInfo"];
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
        NSString *msgLength = [NSString stringWithFormat:@"%lu",  [soapMessage length]];
        [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [theRequest addValue: @"http://tempuri.org/GetUserInfo" forHTTPHeaderField:@"SOAPAction"];
        [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
        [theRequest setHTTPMethod:@"POST"];
        [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
        operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandlerSuccess(operation,responseObject);
            });
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandlerFailure(operation,error);
            });
        }];
        [[NSOperationQueue mainQueue] addOperation:operation];
    }
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSString *urlString=@"http://54.68.159.18//UserControl.asmx/GetUserInfo";
//    [manager GET:urlString parameters:parameters
//          success:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         dispatch_async(dispatch_get_main_queue(), ^{
//             completionHandlerSuccess(operation,responseObject);
//         });
//     }
//          failure:
//     ^(AFHTTPRequestOperation *operation, NSError *error) {
//         NSLog(@"Error: %@", error);
//         
//         dispatch_async(dispatch_get_main_queue(), ^{
//             completionHandlerFailure(operation,error);
//         });
//         
//     }];
//
}
-(void)SetRunValueInAppSettingWithParameter:(NSDictionary *)parameters completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure
{
    {
        NSString *uid=[parameters valueForKey:@"UserId"];
        NSString *token=[parameters valueForKey:@"token"];
        int RunValue=[[parameters valueForKey:@"RunFrom"] intValue];
        NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                                 "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" "<soap:Body>\n"
                                 "<SetRunFrom xmlns=\"http://tempuri.org/\">\n"
                                 "<UserId>%@</UserId>\n"
                                 "<RunFrom>%d</RunFrom>\n"
                                 "<token>%@</token>\n"
                                 "</SetRunFrom>\n"
                                 "</soap:Body>\n"
                                 "</soap:Envelope>\n",uid,RunValue,token];
        //    http://54.68.159.18/UserControl.asmx?op=Login
        NSURL *url = [NSURL URLWithString:@"http://54.68.159.18/UserControl.asmx?op=SetRunFrom"];
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
        NSString *msgLength = [NSString stringWithFormat:@"%lu",  [soapMessage length]];
        [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [theRequest addValue: @"http://tempuri.org/SetRunFrom" forHTTPHeaderField:@"SOAPAction"];
        [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
        [theRequest setHTTPMethod:@"POST"];
        [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
        operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandlerSuccess(operation,responseObject);
            });
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandlerFailure(operation,error);
            });
        }];
        [[NSOperationQueue mainQueue] addOperation:operation];
    }
}

-(void)getTirePriceWith:(NSDictionary *)parameters completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [manager POST:@"http://54.68.159.18/GetTirePrice.asmx/GetPricingModule" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {

        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandlerSuccess(operation,responseObject);
        });

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandlerFailure(operation,error);
        });

    }];
}

-(void)newGetTirePriceWith:(NSDictionary *)parameters completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure
{
    {
        
        NSString *uid=@"005G00000036ej6IAA";
        NSString *token=@"Cms@SF1324DSAfBaFaFH";
        NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                                 "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" "<soap:Body>\n"
                                 "<GetPricingModule xmlns=\"http://tempuri.org/\">\n"
                                 "<userid>%@</userid>\n"
                                 "<token>%@</token>\n"
                                 "</GetPricingModule>\n"
                                 "</soap:Body>\n"
                                 "</soap:Envelope>\n",uid,token];

        NSURL *url = [NSURL URLWithString:@"http://54.68.159.18/GetTirePrice.asmx?op=GetPricingModule"];
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
        NSString *msgLength = [NSString stringWithFormat:@"%lu",  [soapMessage length]];
        [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [theRequest addValue: @"http://tempuri.org/GetPricingModule" forHTTPHeaderField:@"SOAPAction"];
        [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
        [theRequest setHTTPMethod:@"POST"];
        [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:theRequest];
        operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandlerSuccess(operation,responseObject);
            });
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandlerFailure(operation,error);
            });
        }];
        [[NSOperationQueue mainQueue] addOperation:operation];
    }

}
-(void)updateTirePrice:(NSDictionary *)parameters completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [manager POST:@"http://54.68.159.18/GetTirePrice.asmx/UpsertBulkCostJson" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandlerSuccess(operation,responseObject);
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandlerFailure(operation,error);
        });
        
    }];
}


-(void)deletePart:(NSDictionary *)parameters completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [manager POST:@"http://54.68.159.18/GetTirePrice.asmx/DeleteCustom" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandlerSuccess(operation,responseObject);
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandlerFailure(operation,error);
        });
        
    }];
}
-(void)addPart:(NSDictionary *)parameters completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [manager POST:@"http://54.68.159.18/GetTirePrice.asmx/UpsertCustom" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandlerSuccess(operation,responseObject);
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandlerFailure(operation,error);
        });
        
    }];
}
-(void)getDataConnectorSuppliers:(NSDictionary *)parameters completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [manager POST:@"http://54.68.159.18/PartnerCoasterAccount.asmx/GetSuppliersWithAvailableOptionsjson" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandlerSuccess(operation,responseObject);
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandlerFailure(operation,error);
        });
        
    }];

}
-(void)addSupplier:(NSDictionary *)parameters completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [manager POST:@"http://54.68.159.18/PartnerCoasterAccount.asmx/InsertSupplier" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandlerSuccess(operation,responseObject);
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandlerFailure(operation,error);
        });
        
    }];
    
}
-(void)updateSupplier:(NSDictionary *)parameters completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [manager POST:@"http://54.68.159.18/PartnerCoasterAccount.asmx/UpdateSupplier" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandlerSuccess(operation,responseObject);
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandlerFailure(operation,error);
        });
        
    }];
    
}
-(void)deleteSupplier:(NSDictionary *)parameters completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [manager POST:@"http://54.68.159.18/PartnerCoasterAccount.asmx/DeleteSupplier" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandlerSuccess(operation,responseObject);
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandlerFailure(operation,error);
        });
        
    }];
    
}
-(void)changePassword:(NSDictionary *)parameters completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [manager POST:@"http://54.68.159.18/UserControl.asmx/ChangePassword" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandlerSuccess(operation,responseObject);
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandlerFailure(operation,error);
        });
        
    }];
    
}
@end
