//
//  WebServiceHandler.h
//  TireForce
//
//  Created by CANOPUS5 on 12/02/15.
//  Copyright (c) 2015 CANOPUS5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceConstants.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"

typedef void (^CompletionBlockSuccess)(AFHTTPRequestOperation *operation,id responseObject);
typedef void(^CompletionBlockFailure)(AFHTTPRequestOperation *operation,NSError *error);

@interface WebServiceHandler : NSObject<NSXMLParserDelegate>
+(WebServiceHandler*)webServiceHandler;

//Methodes
-(void)loginWithParameter: (NSDictionary  *)parameters completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure;

-(void)getTireQueriesWithUserID:(NSString *)uid withDays:(int)days withToken:(NSString *)token completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure;
-(void)getLeadGenrationQueriesWithUserID:(NSString *)uid withDays:(int)days withToken:(NSString *)token completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure;
-(void)getUserInfoWithParameter:(NSDictionary *)parameters completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure;
-(void)SetRunValueInAppSettingWithParameter:(NSDictionary *)parameters completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure;

-(void)getTirePriceWith:(NSDictionary *)parameters completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure;

-(void)newGetTirePriceWith:(NSDictionary *)parameters completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure;

-(void)updateTirePrice:(NSDictionary *)parameters completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure;

-(void)deletePart:(NSDictionary *)parameters completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure;

-(void)addPart:(NSDictionary *)parameters completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure;
-(void)getDataConnectorSuppliers:(NSDictionary *)parameters completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure;
-(void)addSupplier:(NSDictionary *)parameters completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure;
-(void)updateSupplier:(NSDictionary *)parameters completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure;
-(void)deleteSupplier:(NSDictionary *)parameters completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure;
-(void)changePassword:(NSDictionary *)parameters completionHandlerSuccess:(CompletionBlockSuccess)completionHandlerSuccess completionHandlerFailure:(CompletionBlockFailure)completionHandlerFailure;

@end
