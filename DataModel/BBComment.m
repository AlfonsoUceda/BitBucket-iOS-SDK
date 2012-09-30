//
//  BBComment.m
//  BitBucketSDK
//
//  Created by Joshka on 30/09/12.
//  Copyright (c) 2012 Alfonso Uceda Pompa. All rights reserved.
//

#import "BBComment.h"
#import "BBUser.h"

@implementation BBComment

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
    id content_ = [dic objectForKey:@"content"];
    if ([content_ isKindOfClass:[NSString class]])
    {
        self.content = content_;
    }
    
    id authorInfo_ = [dic objectForKey:@"author_info"];
    if ([authorInfo_ isKindOfClass:[NSDictionary class]])
    {
        BBUser *user = [[BBUser alloc] initWithJSONDictionary:authorInfo_];
        self.authorInfo = user;
    }
    
    id commentId_ = [dic objectForKey:@"comment_id"];
    self.commentId = commentId_;
    
    id utcUpdatedOn_ = [dic objectForKey:@"utc_updated_on"];
    if ([utcUpdatedOn_ isKindOfClass:[NSString class]])
    {
        self.utcUpdatedOn = utcUpdatedOn_;
    }
    
    id utcCreatedOn_ = [dic objectForKey:@"utc_created_on"];
    if ([utcCreatedOn_ isKindOfClass:[NSString class]])
    {
        self.utcCreatedOn = utcCreatedOn_;
    }
    
    id isSpam_ = [dic objectForKey:@"is_spam"];
    self.isSpam = [isSpam_ boolValue];
    
}


-(NSString*)description
{
    NSMutableString *descriptionUser = [NSMutableString stringWithFormat:@"\ncontent: %@\n", self.content];
    [descriptionUser appendFormat:@"author_info: %@\n", self.authorInfo];
    [descriptionUser appendFormat:@"comment_id: %@\n", self.commentId];
    [descriptionUser appendFormat:@"utc_updated_on: %@\n", self.utcUpdatedOn];
    [descriptionUser appendFormat:@"utc_created_on: %@\n", self.utcCreatedOn];
    [descriptionUser appendFormat:@"is_spam: %@\n", self.isSpam ? @"YES" : @"NO"];
    
    return descriptionUser;
}

@end
