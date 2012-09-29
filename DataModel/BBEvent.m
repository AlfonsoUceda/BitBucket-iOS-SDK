//
//  BBEvent.m
//  BitBucketSDK
//
//  Created by Joshka on 29/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import "BBEvent.h"
#import "BBRepository.h"
#import "BBUser.h"

@implementation BBEvent

-(id)initWithJSONDictionary:(NSDictionary *)dic
{
    if (self = [super init])
    {
        [self parseJSONDictionary:dic];
    }
    
    return self;
}

#pragma mark -- Private methods

-(void)parseJSONDictionary:(NSDictionary *)dic
{
    id node_ = [dic objectForKey:@"node"];
    if ([node_ isKindOfClass:[NSString class]])
    {
        self.node = node_;
    }
    
    id description_ = [dic objectForKey:@"description"];
    if ([description_ isKindOfClass:[NSString class]])
    {
        self.description = description_;
    }
    
    id repository_ = [dic objectForKey:@"repository"];
    if ([repository_ isKindOfClass:[NSDictionary class]])
    {
        BBRepository *repository = [[BBRepository alloc] initWithJSONDictionary:repository_];
        self.repository = repository;
    }
    
    id createdOn_ = [dic objectForKey:@"created_on"];
    if ([createdOn_ isKindOfClass:[NSString class]])
    {
        self.createdOn = createdOn_;
    }
    
    id user_ = [dic objectForKey:@"user"];
    if ([user_ isKindOfClass:[NSDictionary class]])
    {
        BBUser *user = [[BBUser alloc] initWithJSONDictionary:user_];
        self.user = user;
    }
    
    id utcCreatedOn_ = [dic objectForKey:@"utc_created_on"];
    if ([utcCreatedOn_ isKindOfClass:[NSString class]])
    {
        self.utcCreatedOn = utcCreatedOn_;
    }
    
    id event_ = [dic objectForKey:@"event"];
    if ([event_ isKindOfClass:[NSString class]])
    {
        self.event = event_;
    }
}

-(NSString*)description
{
    NSMutableString *descriptionUser = [NSMutableString stringWithFormat:@"\nnode: %@\n", self.node];
    [descriptionUser appendFormat:@"description: %@\n", self.description];
    [descriptionUser appendFormat:@"repository: %@\n", self.repository];
    [descriptionUser appendFormat:@"created_on: %@\n", self.createdOn];
    [descriptionUser appendFormat:@"user: %@\n", self.user];
    [descriptionUser appendFormat:@"utc_created_on: %@\n", self.utcCreatedOn];
    [descriptionUser appendFormat:@"event: %@\n", self.event];
    
    return descriptionUser;
}

@end
