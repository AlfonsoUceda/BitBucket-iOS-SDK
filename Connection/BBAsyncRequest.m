//
//  BBAsyncRequest.m
//  BitBucketSDK
//
//  Created by Joshka on 24/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import "BBAsyncRequest.h"
#import "NSData+Additions.h"

@interface BBAsyncRequest ()
@property (nonatomic, strong) NSMutableData *mutableData;
@property (nonatomic, strong) BBCompletionBlock completionBlock;
@property (nonatomic, strong) BBErrorBlock errorBlock;
@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSMutableURLRequest *request;
@end

@implementation BBAsyncRequest

+(id)request:(NSString *)stringURL dictionary:(NSDictionary*)dictionary completionBlock:(BBCompletionBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    return [[self alloc] initWithRequest:stringURL dictionary:dictionary completionBlock:completionBlock errorBlock:errorBlock];
}

-(id)initWithRequest:(NSString *)stringURL dictionary:(NSDictionary*)dictionary completionBlock:(BBCompletionBlock)completionBlock errorBlock:(BBErrorBlock)errorBlock
{
    if (self = [super init]) {
        self.mutableData = [[NSMutableData alloc] init];
        self.completionBlock = completionBlock;
        self.errorBlock = errorBlock;
        self.httpVerb = GET;
        
        if (nil != dictionary)
        {
            self.user = [dictionary objectForKey:kUserCredential];
            self.password = [dictionary objectForKey:kPasswordCredential];
            
            if ([dictionary objectForKey:kHTTPVerb])
            {
                self.httpVerb = [self stringToHTTPVerb:[dictionary objectForKey:kHTTPVerb]];
            }
        }
        
        NSURL *url = [NSURL URLWithString:stringURL];
        self.request = [NSMutableURLRequest requestWithURL:url];
        self.request.HTTPMethod = [self httpVerbToString];
        self.request.HTTPBody = [self createParams:[dictionary objectForKey:kParams]];
        
        NSString *authStr = [NSString stringWithFormat:@"%@:%@", self.user, self.password];
        NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
        NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64Encoding]];
        [self.request setValue:authValue forHTTPHeaderField:@"Authorization"];
        
        [NSURLConnection connectionWithRequest:self.request delegate:self];
    }
    
    return self;
}

#pragma mark - NSURLConnection Delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
    NSLog(@"%d", httpResponse.statusCode);
    [self.mutableData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.mutableData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.completionBlock(self.mutableData);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.errorBlock(error);
}

//- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
//{
//    if ([challenge previousFailureCount] > 1)
//    {
//        NSDictionary *dictionary = @{ kError : @"Credenciales incorrectas"};
//        NSError *error = [[NSError alloc] initWithDomain:@"com.JoshkaSoft.BB" code:-1 userInfo:dictionary];
//        self.errorBlock(error);
//    }
//    else
//    {
//        NSURLCredential *credentials = [[NSURLCredential alloc] initWithUser:self.user password:self.password persistence:NSURLCredentialPersistenceForSession];
//        [[challenge sender] useCredential:credentials forAuthenticationChallenge:challenge];
//    }
//}

#pragma mark - Private

- (NSString*)httpVerbToString
{
    NSString *verb = nil;
    
    switch (self.httpVerb) {
        case GET:
            verb = @"GET";
            break;
            
        case POST:
            verb = @"POST";
            break;
            
        case PUT:
            verb = @"PUT";
            break;
            
        case DELETE:
            verb = @"DELETE";
            break;
            
        default:
            break;
    }
    
    return verb;
}

- (HTTP_VERB)stringToHTTPVerb:(NSString*)string
{
    HTTP_VERB verb;
    
    if ([string isEqualToString:@"GET"])
    {
        verb = GET;
    }
    else if ([string isEqualToString:@"POST"])
    {
        verb = POST;
    }
    else if ([string isEqualToString:@"PUT"])
    {
        verb = PUT;
    }
    else if ([string isEqualToString:@"DELETE"])
    {
        verb = DELETE;
    }
    
    return verb;
}

- (NSData*)createParams:(NSDictionary*)params
{
    NSData *data = nil;
    
    if (nil != params)
    {
        __block NSMutableString *string = [NSMutableString string];
        [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            string = (NSMutableString*)[string stringByAppendingFormat:@"%@=%@&", key, obj];
        }];
        
        string = (NSMutableString*)[string substringToIndex:[string length] -1];
        
        NSLog(@"%@",string);
        
        data = [NSData dataWithData:[string dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    return data;
}


@end
