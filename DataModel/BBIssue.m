//
//  BBIssue.m
//  BitBucketSDK
//
//  Created by Joshka on 29/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import "BBIssue.h"
#import "BBUser.h"
#import "BBRepository.h"
#import "BBMetadata.h"


@implementation BBIssue

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
    id status_ = [dic objectForKey:@"status"];
    if ([status_ isKindOfClass:[NSString class]])
    {
        self.status = status_;
    }
    
    id priority_ = [dic objectForKey:@"priority"];
    if ([priority_ isKindOfClass:[NSString class]])
    {
        self.priority = priority_;
    }
    
    id title_ = [dic objectForKey:@"title"];
    if ([title_ isKindOfClass:[NSString class]])
    {
        self.title = title_;
    }
    
    id reportedBy_ = [dic objectForKey:@"reported_by"];
    if ([reportedBy_ isKindOfClass:[NSDictionary class]])
    {
        BBUser *user = [[BBUser alloc] initWithJSONDictionary:reportedBy_];
        self.reporteBy = user;
    }
    
    id utcLastUpdated_ = [dic objectForKey:@"utc_last_updated"];
    if ([utcLastUpdated_ isKindOfClass:[NSString class]])
    {
        self.utcLastUpdated = utcLastUpdated_;
    }
    
    id comment_count_ = [dic objectForKey:@"comment_count"];
    self.commentCount = comment_count_;
    
    id metadata_ = [dic objectForKey:@"metadata"];
    if ([metadata_ isKindOfClass:[NSDictionary class]])
    {
        BBMetadata *metadata = [[BBMetadata alloc] initWithJSONDictionary:reportedBy_];
        self.metadata = metadata;
    }
    
    id content_ = [dic objectForKey:@"content"];
    if ([content_ isKindOfClass:[NSString class]])
    {
        self.content = content_;
    }
    
    id createdOn_ = [dic objectForKey:@"created_on"];
    if ([createdOn_ isKindOfClass:[NSString class]])
    {
        self.createdOn = createdOn_;
    }
    
    id localId_ = [dic objectForKey:@"local_id"];
    self.localId = localId_;
    
    id followerCount_ = [dic objectForKey:@"follower_count"];
    self.followerCount = followerCount_;
    
    id utcCreatedOn_ = [dic objectForKey:@"utc_created_on"];
    if ([utcCreatedOn_ isKindOfClass:[NSString class]])
    {
        self.utcCreatedOn = utcCreatedOn_;
    }
    
    id resourceURI_ = [dic objectForKey:@"resource_uri"];
    if ([resourceURI_ isKindOfClass:[NSString class]])
    {
        self.resourceURI = resourceURI_;
    }
    
    id isSpam_ = [dic objectForKey:@"is_spam"];
    self.isSpam = [isSpam_ boolValue];
}


-(NSString*)description
{
    NSMutableString *descriptionUser = [NSMutableString stringWithFormat:@"\nstatus: %@\n", self.status];
    [descriptionUser appendFormat:@"priority: %@\n", self.priority];
    [descriptionUser appendFormat:@"title: %@\n", self.title];
    [descriptionUser appendFormat:@"reported_by: %@\n", self.reporteBy];
    [descriptionUser appendFormat:@"utc_last_updated: %@\n", self.utcLastUpdated];
    [descriptionUser appendFormat:@"comment_count: %@\n", self.commentCount];
    [descriptionUser appendFormat:@"metadata: %@\n", self.metadata];
    [descriptionUser appendFormat:@"content: %@\n", self.content];
    [descriptionUser appendFormat:@"created_on: %@\n", self.createdOn];
    [descriptionUser appendFormat:@"local_id: %@\n", self.localId];
    [descriptionUser appendFormat:@"follower_count: %@\n", self.followerCount];
    [descriptionUser appendFormat:@"resource_uri: %@\n", self.resourceURI];
    [descriptionUser appendFormat:@"is_spam: %@\n", self.isSpam ? @"YES" : @"NO"];
    
    return descriptionUser;
}

@end
