//
//  BBAsyncRequest.h
//  BitBucketSDK
//
//  Created by Joshka on 24/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBBlocks.h"

#define kUserCredential @"userCredential"
#define kPasswordCredential @"passwordCredential"
#define kError @"errorCredentials"
#define kHTTPVerb @"httpVerb"
#define kParams @"params"

typedef enum{
    GET,
    POST,
    PUT,
    DELETE
}HTTP_VERB;

@interface BBAsyncRequest : NSObject

@property (nonatomic, assign) HTTP_VERB httpVerb;

+(id)request:(NSString*)stringURL dictionary:(NSDictionary*)dictionary completionBlock:(BBCompletionBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock;
-(id)initWithRequest:(NSString*)stringURL dictionary:(NSDictionary*)dictionary completionBlock:(BBCompletionBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock;


@end
